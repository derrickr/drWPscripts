#!/bin/bash

#	Check if target directory exists
if [ ! -d ~/drWPscripts/archive ] ; then

#	Create dir for scripts
	mkdir -p ~/drWPscripts/archive
fi

#	Tar current drWpscripts contents into archive
	tar czf ~/drWPscripts/archive/drWPscripts-$(date +%Y%m%d%H%M%S).tgz ~/drWPscripts 2>/dev/null

#	Clean up target
	rm -rf ~/drWPscripts/
	
#	change dir
	cd ~/drWPscripts/

#	wget the drWPscripts from github
#	wget https://github.com/derrickr/drWPscripts/archive/master.zip
	wget https://github.com/derrickr/drWPscripts/blob/master/getWPconfig.sh
	wget https://github.com/derrickr/drWPscripts/blob/master/showWPconfig.sh
	wget https://github.com/derrickr/drWPscripts/blob/master/drWPbup
	wget https://github.com/derrickr/drWPscripts/blob/master/drWPrecovery.sh
	wget https://github.com/derrickr/drWPscripts/blob/master/drWPimport.sh

#	Make them all exectuable
	chmod 500 ~/drWPscripts/

#	Move backup script into daily cron
	mv ~/drWPscripts/bup /etc/cron.daily/bup
