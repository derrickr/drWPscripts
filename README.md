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
  
1. source showWPconfig.sh
   This will display the current WP instance config variables required for backup/restore.
  
2. source drWPrecovery.sh
   This will open a dialog box showing the available backups to restore from.
  
3. source drWPimport.sh
   This will import a backup pair (.tgz & .sql files) into your target domain.
   Ensure you upload your source backup pair before execution.
