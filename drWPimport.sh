#!/bin/bash

#	Intended to import a WordPress instance from one server to another e.g. Production -> Development
#
#	This script imports another WordPress instance (archived sourceFiles.tgz and database)
#	from another server into the target server.
#
#	It is assumed that a current WordPress instance is already installed on the target server and
#	will be dateTime renamed and its wp-config copied into the new instance

#	Get wp-config values: $WP_path, $WP_conf, $WP_db, $WP_user, $WP_pass, $redisPw
	source ~/drWPscripts/getWPconfig.sh

#	Get system hostname
	targetDomain=`hostname`

#	Ask user to enter FQDN being imported from
	read -p "Please enter the FQDN you are importing FROM e.g. www.domain.uk.com"$'\n\n' sourceDomain

#	Warn user that the following serttings will be used
	echo -e "\nThank you!\nThe following settings will now be used to import your WP instance from '$sourceDomain' to '$targetDomain':\n"
	echo "WP_path:	$WP_path"
	echo "WP_conf:	$WP_conf"
	echo ""
	echo "WP_db:		$WP_db"
	echo "WP_user:	$WP_user"
	echo "WP_pass:	$WP_pass"
	echo "redisPw:	$redisPw"
	echo ""

#	Ask user if above are correct
	read -p "Are you 100% sure that ALL of the above settings are correct for the import [y|n] " -n 1 REPLY

#	Check answer
if [[ "$REPLY" != [Yy]* ]] ; then
	echo -e "\nPlease correct any discrepancies before running this script again."
	return 1
fi

#	Now check that JUST one copy of the source tgz and sql files are in this directory
	numTGZ=`ls *.tgz | wc -l`
	numSQL=`ls *.sql | wc -l`

if [[ $numTGZ != 1 ]] ; then
	echo -e "\nPlease ensure ONLY the singular imported tgz file is in this directory!"
	echo "Delete or move any duplicate tgz files."
	return 1
fi

if [[ $numSQL != 1 ]] ; then
	echo -e "\nPlease ensure ONLY the singular imported sql file is in this directory!"
	echo "Delete or move any duplicate sql files."
	return 1
fi

#	All good, only one copy of the source tgz and sql files are in this directory. Carry on...

#	Let the user know
	echo -e "\nPlease wait for ~ 2 - 3 minutes for this script to complete"

#	Copy source files for reference
	cp *.tgz wip.tgz

#	Set dateTime
	dateTime=$(date +%Y%m%d%H%M%S)

#	Move current wp dir to timestamped
	mv $WP_path $WP_path-$dateTime

#	Extract copied source file to target path
	tar xf wip.tgz -C /

#	Copy over wp-config from previous version
	cp $WP_path-$dateTime/wp-config.php $WP_conf

#	Ensure ownership is correct
	chown -R www-data:www-data $WP_path
	
#	Copy source db for reference
	cp *.sql wip.sql

#	Replace db encoding - need to fix this on main instance
	sed -i 's/utf8mb4_0900_ai_ci/utf8mb4_unicode_ci/g' wip.sql

#	Replace source domain with target domain in db
	sed -i "s/$sourceDomain/$targetDomain/g" wip.sql

#	Import source db into target
	mysql -u $WP_user -p$WP_pass $WP_db < wip.sql 2>/dev/null

#	Remove nginx cache contents
	rm -rf /var/www/cache/*

#	Flush redis cache
	redis-cli -a $redisPw FLUSHALL

#	Restart services
	systemctl restart mysql

	if [ `which nginx` ] ; then
		systemctl restart nginx
	else
		systemctl restart apache2
	fi
	systemctl restart redis-server
