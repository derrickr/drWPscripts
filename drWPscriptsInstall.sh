#!/bin/bash

#	Check if target directory exists
if [ ! -d ~/drWPscripts/archive ] ; then

#	Create dir for scripts
	mkdir -p ~/drWPscripts/archive
fi

#	Tar current drWpscripts contents into archive
	tar --exclude='~/drWPscripts/archive' -czf ~/drWPscripts/archive/drWPscripts-$(date +%Y%m%d%H%M%S).tgz ~/drWPscripts/*.* 2>/dev/null

#	Clean up target
	rm -rf ~/drWPscripts/*.*
	
#	change dir
	cd ~/drWPscripts/

#	wget the drWPscripts from github
#	wget https://github.com/derrickr/drWPscripts/archive/master.zip
	wget -O getWPconfig.sh https://github.com/derrickr/drWPscripts/blob/master/getWPconfig.sh?raw=true
	wget -O showWPconfig.sh https://github.com/derrickr/drWPscripts/blob/master/showWPconfig.sh?raw=true
	wget -O drWPbup https://github.com/derrickr/drWPscripts/blob/master/drWPbup?raw=true
	wget -O drWPrecovery.sh https://github.com/derrickr/drWPscripts/blob/master/drWPrecovery.sh?raw=true
	wget -O drWPimport.sh https://github.com/derrickr/drWPscripts/blob/master/drWPimport.sh?raw=true

#	Make them all exectuable
	chmod 500 ~/drWPscripts/*

#	Move backup script into daily cron
	mv ~/drWPscripts/drWPbup /etc/cron.daily/drWPbup
