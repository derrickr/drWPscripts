#!/bin/bash

#	set char set for dialog box
	export NCURSES_NO_UTF8_ACS=1

#	Get wp-config values: $WP_path, $WP_conf, $WP_db, $WP_user, $WP_pass, $redisPw
	source ~/drWPscripts/getWPconfig.sh

#	Set char set for dialog box
	export NCURSES_NO_UTF8_ACS=1

#	Clear screen
	clear

#	Get files
	myFiles=`ls /archive`;

#	Declare array for files
	declare -a myArr=()

#	Strip just the date in format: YYYYMMDDHH
	for value in ${myFiles[*]}
	do
		myArr+=("${value:0:10}")
	done

#	Create uniq set of dates from array myArr above
	uniq=( $(printf '%s\n' "${myArr[@]}" | sort -u) )

#	Display dialog box so user can select desired restore point
	CHOSEN_DATE=$(dialog --title "WARNING!!! THIS WILL MOVE YOUR WEB DIRECTORY AND DATABASE" --menu "Please select your backup set to restore:" 20 78 11 `i=1; for value in ${uniq[*]}; do echo $value $(( i++ )) ; done` 3>&1 1>&2 2>&3)
	exitstatus=$?

#	Clear screen
	clear

#	Make sure the program exited with no errors
if [ $exitstatus = 0 ]; then

#	Set the database and files to restore based on chosen date
	theDB=`ls /archive/${CHOSEN_DATE}*.sql | tail -n 1`;
	theFiles=`ls /archive/${CHOSEN_DATE}*.tgz | tail -n 1`;

	echo "Your selected database and files from $CHOSEN_DATE are now being restored."
	echo ""
	echo "This process will take approximately 2 to 3 minutes."
	echo ""

#	Rename the live directory, so the restore can take it's place
	mv $WP_path $WP_path-$(date +%Y%m%d%H%M%S)
	
#	Restore files from selected archive
	tar xf $theFiles -C /

#	Ensure ownership is correct
	chown -R www-data:www-data $WP_path

#	Restore selected $WP_db
	mysql -u $WP_user -p$WP_pass $WP_db < $theDB 2>/dev/null
	
#	Remove cache nginx cache contents
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

	echo "Your files and database have been restored to $CHOSEN_DATE"
	echo ""

else
	clear
	echo "Cancelled"
fi
