#!/bin/bash

#	Get the wp-config values
	source getWPconfig.sh

#	Display the wp-config values
	echo "WP_path:	$WP_path"
	echo "WP_conf:	$WP_conf"
	echo "WP_db:		$WP_db"
	echo "WP_user:	$WP_user"
	echo "WP_pass:	$WP_pass"
	echo "redisPw:	$redisPw"
	echo "dateHost:	$dateHost"
