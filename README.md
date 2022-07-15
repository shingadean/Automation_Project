# Automation_Project
There is script file named automation which basically install apache service and checks if its not running then makes the tar of access.log and error.log from /var/log/apache2/ folder 
and uploads it to s3 bucket upgrade-amits
CRON job runs everyday to create the log file
