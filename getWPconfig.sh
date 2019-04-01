#!/bin/bash

#	Set path
	WP_path="/var/www/html"

#	Get WP config values
	WP_conf="$WP_path/wp-config.php"
	WP_db=`cat $WP_conf | grep DB_NAME | cut -d \' -f 4`
	WP_user=`cat $WP_conf | grep DB_USER | cut -d \' -f 4`
	WP_pass=`cat $WP_conf | grep DB_PASSWORD | cut -d \' -f 4`
	redisPw=`cat $WP_conf | grep WP_REDIS_PASSWORD | cut -d \' -f 4`

#	Set dateHost value
	dateHost="$(date +%Y%m%d%H%M%S)-$HOSTNAME"
