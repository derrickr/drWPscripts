**_drWPscripts_**

A bunch of bash scripts to backup, recover and import WP  
  
getWPconfig.sh - Gets the configuration variables from the installed WP instance of wp-config.php  
  
showWPconfig.sh - Shows the required wp-config.php settings  
  
drWPbup.sh - This is moved into /etc/cron.daily to automate the daily backUp, on a rolling 10 day basis  
  
drWPrecovery.sh - Enables recovery from the automated backUps (above)  
  
drWPimport.sh - Provides an import capability to import WP from one server to another  
  
  
Install:  
  
wget -O drWPscriptsInstall.sh https://github.com/derrickr/drWPscripts/blob/master/drWPscriptsInstall.sh?raw=true && source drWPscriptsInstall.sh
  
  
Usage:
  
1. Display the current WP instance config variables required for backup/restore:  
   source showWPconfig.sh  
     
2. Dialog box showing the available backups to restore from:  
   source drWPrecovery.sh  
  
3. Import your uploaded backup pair (.tgz & .sql files) into your target domain:  
   source drWPimport.sh  
