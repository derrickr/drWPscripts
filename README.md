# drWPscripts
#
A bunch of bash scripts to backup WP
#
getWPconfig.sh gets the configuration variables from the installed WP instance of wp-config.php
#
showWPconfig.sh does what it says
#
drWPbup.sh is moved into /etc/cron.daily to automate the daily backUp, on a rolling 10 day basis
#
recovery.sh enables recovery from the automated backUps (above)
#
drWPimport.sh provides an import capability to import WP from one server to another
