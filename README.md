**_drWPscripts_**

A bunch of bash scripts to backup, recover and import WP  
  
getWPconfig.sh - Gets the configuration variables from the installed WP instance of wp-config.php  
  
showWPconfig.sh - Shows the required wp-config.php settings  
  
drWPbup.sh - This is moved into /etc/cron.daily to automate the daily backUp, on a rolling 10 day basis  
  
recovery.sh - Enables recovery from the automated backUps (above)  
  
drWPimport.sh - Provides an import capability to import WP from one server to another  
  
  
Usage:  
wget https://github.com/derrickr/drWPscripts/blob/master/drWPscriptsInstall.sh && drWPscriptsInstall.sh
