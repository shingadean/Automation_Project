name="amit"
timestamp=$(date '+%d%m%Y-%H%M%S')
s3_bucket="upgrad-amits"
echo "##################Update Packages###################"
sudo apt -y install
echo "#################Package Update Completed###########"
dpkg -s apache2

if [ $? -ne 0 ]
then
	echo "#####Installing Packages#######"
	sudo apt install apache2
	echo "#####Package Installed#########"
else
	echo "######Package already installed########"
fi
active=$(systemctl status apache2 | grep active | awk '{print $2}')
check_enabled_apache() {
	enabled=$(systemctl is -enabled apache2 | grep "enabled")
	if [[ enabled=${enabled} ]]
	then
		echo "##################################################APACHE SERVER ENABLED################################################"
	else
		echo "##################################################ENABLING APACHE SERVER###############################################"
		systemctl enable apache2
		echo "##################################################APACHE SERVER ENABLED################################################"
	fi
}
if [[ active=${active} ]]
then
	echo "##############################################################APACHE SERVER ACTIVE##############################################"
else
	echo "##############################################################STARTING APACHE SERVER############################################"
	sudo service apache2 start
	echo "##############################################################APACHE SERVER ACTIVE##############################################"
	check_enabled_apache;
fi

echo "#####################################################################CREATING TAR FILE###################################################"
tar -cvf /tmp/${name}-httpd-logs-${timestamp}.tar /var/log/apache2/*.log

dpkg -s awscli
if [ $? -eq 0 ]
then 
	    echo "#########################################################CLI ALREADY INSTALLED################################################"
    else 
	        echo "#####################################################INSTALLING CLIE####################################################"
		    sudo apt install awscli 
	 fi


echo "#####################################################################COPY ARCHIVE TO BUCKET###############################################"
aws s3 \
	cp /tmp/${name}-httpd-logs-${timestamp}.tar \
	s3://${s3_bucket}/${name}-httpd-logs-${timestamp}.tar

docroot="/var/www/html"
if [ ! -f ${docroot}/inventory.html ];
then
	        echo "###################################################INVENTORY FILE IS NOT AVAILABLE, CREATING A INVENTORY FILE #######################################"
		        echo -e 'Log Type\t-\tTime Created\t-\tType\t-\tSize' >${docroot}/inventory.html
			        echo "#################################################INVENTORY FILE CREATED############################################"
				    fi

				    cronfile=/etc/cron.d/automation
				    if [[ ! -f ${cronfile} ]]
				    then
					            echo "#########################################CRON FILE IS NOT AVAILABLE#####################"
						             echo " * * * * * root/Automation_Project/Automation.sh" >> ${cronfile}
							              echo "#####################################CRON FILE CREATED#################################"
								       else
									                echo "######################################CRON FILE ALREADY CREATED################################"
											 fi

					
