#!/bin/bash
clear
#set -e
#set -x
dbchange_path ()
{
clear
echo " "
echo " ##################### WELCOME TO MYSQL OR MARIADB DIRECTORY PATH CHANGING PROCESS ##################### "
echo " "
echo " "
read -p "Enter 'y' without quotes to start the directory changing process or 'n' without quotes to exit the setup: (y/n) " chg
echo " "
echo " "
if [ -z $chg ] 
then
echo " "
echo " "
echo " !!!!!!!!!!!! ALERT !!!!!!!! THE VALUE SHOULD NOT BE EMPTY YOU NEED TO ENTER THE VALUES TO PROCEED FURTHER PROCESS !!!!!!! "
echo " "
echo " "
sleep 6
clear
dbchange_path
echo " "
echo " "
else
echo " "
fi
if [ "$chg" = "y" ] || [ "$chg" = "Y" ]
then 
echo " "
echo " "
echo " ########### WELCOME TO MYSQL OR MARIADB CHANGING PATH DIRECTORY ########## "
echo " "
echo " "
clear
echo " ################ CHECKING WITH THE  DATABASE SERVICES PLEASE WAIT ############### "
echo " "
echo " "
dab=`netstat -nltp | grep 3306 | awk {'print $6'}`
echo " "
if [ "LISTEN" = "$dab" ]
then
sleep 5
echo " "
echo " "
echo "MYSQL OR MARIADB DATABASE SERVER INSTALLED AND RUNNING IN YOUR MACHINE ..."
sleep 4
echo " "
echo " "
echo " "
echo " ################ STOPPING DATABASES SERVICES PLEASE WAIT ##################### "
echo " "
echo " "
systemctl stop mysqld && systemctl stop mysql && systemctl stop mariadb
echo " "
echo " "
else
echo " "
echo " "
echo " !!!!!!! ALERT !!!!!!!! MYSQL OR MARIADB DATABASE SERVICES ARE IN DOWN STATE !!!!!!!!!!! :("
echo " "
echo " "
sleep 4
fi
clear
echo " ############# CHECKING WITH THE DATA MOUNT DIRECTORY ############# "
echo " "
echo " "
if [ -d "/data" ]
then 
echo " "
echo " ################# /DATA DIRECTORY IS EXISTED ############### "
echo " "
echo " "
sleep 4
else
echo " "
echo " "
echo " !!!!!!!!!!!!!!!! /DATA DIRECTORY NOT EXISTED !!!!!!!!!!!!!!!!! "
echo " "
echo " "
echo " !!!!!!!!!!!!!!!!! SETUP WILL BE ABORTED !!!!!!!!!!!!!!!!!!!!!!! "
echo " "
echo " "
exit
fi
clear
echo " "
echo " ################# COPYING MYSQL OR MARIADB RESOURCES TO /DATA DIRECTORY PLEASE WAIT ############### "
sleep 3
echo " "
yum install rsync -y 
sleep 3
echo " "
echo " "
ins=`yum list installed | grep rsync | awk {'print $1'}`
echo " "
echo " "
clear
echo "$ins PACKAGE HAS BEEN INSTALLED SUCCESSFULLY IN YOUR MACHINE"
echo " "
echo " "
rsync -av /var/lib/mysql /data/
echo " "
echo " "
clear
if [ -d "/data/mysql" ]
then 
echo " "
echo " "
echo " ##################### MYSQL OR MARIADB DIRECTORY COPIED SUCCESSFULLY IN /DATA DIRECTORY :) #################### "
echo " "
echo " "
else
echo " "
echo " !!!!!!!!!!!!!!!!!!!!! THERE IS NO MYSQL OR MARIADB DIRECTORY EXISTED IN /DATA FOLDER :( !!!!!!!!!!!!!!!!!!!!!!!!! "
echo " "
echo " "
echo " "
echo " !!!!!!!!!!!!!!!!!!!! SETUP WILL BE ABORTED PLEASE TRY AGAIN LATER !!!!!!!!!!!!!!! "
exit
fi
clear
echo " ############### CONFIGURATION CHANGES IN /etc/my.cnf FILE PLEASE WAIT ###############
echo " "
echo " "
sleep 3
sed -i "s@^\(datadir\s*=\s*\).*\$@\1/data/mysql@" /etc/my.cnf
sleep 3
sed -i "s@^\(datadir\s*=\s*\).*\$@\1/data/mysql@" /usr/my.cnf
echo " "
echo " "
sleep 4
clear
echo " ############### STARTING MYSQL OR MARIADB SERVICES PLEASE WAIT #################### "
echo " "
echo " "
setenforce 0 && systemctl restart mysqld && systemctl restart mysql && systemctl restart mariadb
echo " "
echo " "
clear
echo " ################ CHECKING WITH THE DATABASE SERVICES PLEASE WAIT ############### "
echo " "
echo " "
db=`netstat -nltp | grep 3306 | awk {'print $6'}`
echo " "
if [ "LISTEN" = "$db" ]
then
sleep 5
echo " "
echo " "
echo "MYSQL OR MARIADB DATABASE SERVER RUNNING IN YOUR MACHINE ..."
sleep 4
echo " "
else
clear
echo " "
echo " "
echo " !!!!!!! ALERT !!!!!!!! MYSQL OR MARIADB DATABASE SERVICES ARE IN DOWN STATE !!!!!!!!!!! :("
echo " "
echo " "
sleep 4
fi
elif [ "$chg" = "n" ] || [ "$chg" = "N" ]
then 
echo " "
echo " "
echo " !!!!!!!!!!!!!!!!!! PATH DIRECTORY SETUP WILL BE ABORTED !!!!!!!!!!!!!!! "
echo " "
echo " "
echo " !!!!!!!!!!!!!!!!! SETUP WILL BE ABORTED !!!!!!!!!!!!!!!!! "
exit
else
echo " "
fi
}
mysql_connection ()
{
clear
echo " "
echo " ############## WELCOME TO MYSQL OR MARIADB CONNECTION STATUS ############## "
echo " "
echo " "
read -p "Enter the host ip address of the machine : " ip
echo " "
echo " "
read -p "Enter the username of root Ex:(root) : " us
echo " "
echo " "
read -p "Enter the password of root : " pass
echo " "
echo " "
if [ -z $ip ] && [ -z $us ] && [ -z $pass ]
then
echo " "
echo " "
echo " !!!!!!!!!!!! ALERT !!!!!!!! THE VALUE SHOULD NOT BE EMPTY YOU NEED TO ENTER THE VALUES TO PROCEED FURTHER PROCESS !!!!!!! "
echo " "
echo " "
sleep 6
clear
mysql_connection
else
echo " "
fi 
sleep 5
clear
echo " ######### CHECKING WITH CONNECTION STATUS ########## "
echo " "
echo " "
mysql -u$us -p$pass -e exit 
dbstatus=`echo $?`
if [ $dbstatus = 0 ]
then 
echo " "
echo " "
echo " "
echo " ########### CONNECTION SUCCESSFULL ########### "
sleep 7
else
echo " "
echo " "
echo " "
echo " !!!!!!!!!! ALERT !!!!!!!!!!! CONNECTION FAILED PLEASE CHECK YOUR CREDENTIALS AND TRY AGAIN !!!!!!!!!"
sleep 7
mysql_connection
fi
}
create_database ()
{
echo " "
echo " "
clear
echo " ################### WELCOME TO DATABASE CREATION PROCESS ################### "
echo " "
echo " "
read -p "Enter the ip address of the mysql or maraidab host machine: " dbip
echo " "
echo " "
read -p "Ente the username of root Ex:(root): " dbur
echo " "
echo " "
read -p "Enter the password of root: " dbpas
echo " "
echo " "
read -p "Enter the database name: " dbna
echo " "
echo " "
read -p "Enter the dbuser which you have created in database Ex:(Flodata or Rise): " dbus
echo " "
echo " "
if [ -z $dbip ] && [ -z $dbur ] && [ -z $dbpas ] && [ -z $dbna ] && [ -z $dbus ]
then
echo " "
echo " "
echo " !!!!!!!!!!!! ALERT !!!!!!!! THE VALUE SHOULD NOT BE EMPTY YOU NEED TO ENTER THE VALUES TO PROCEED FURTHER PROCESS !!!!!!! "
echo " "
echo " "
sleep 6
clear
create_database
else
echo " "
fi 
clear
echo " "
read -p "Do you want to confirm with the above detials(y/n):  " con
echo " "
echo " "
if [ -z $con ] 
then
echo " "
echo " "
echo " !!!!!!!!!!!! ALERT !!!!!!!! THE VALUE SHOULD NOT BE EMPTY YOU NEED TO ENTER THE VALUES TO PROCEED FURTHER PROCESS !!!!!!! "
echo " "
echo " "
clear
create_database
sleep 6
else
echo " "
fi
clear
echo " "
echo " "
if [ "$con" = "y" ] || [ "$con" = "Y" ]
then 
echo " "
echo " "
echo "Connecting to the mysql or mariadb host please wait ........."
echo " "
echo " "
sleep 5
mysql -u $dbur -p$dbpas <<EOF
create database $dbna;
GRANT ALL PRIVILEGES ON $dbna.* TO '$cu'@'localhost';
GRANT ALL PRIVILEGES ON $dbna.* TO '$cu'@'%';
FLUSH PRIVILEGES;
EOF
echo " "
echo " "
sleep 4
elif [ "$con" = "n" ] || [ "$con" = "N" ]
then 
echo " "
echo " "
create_database
clear
else 
echo " "
echo " "
fi
}
validate_root ()
{
echo " "
echo " "
clear
echo " ################ ENTER THE ROOT USER DETAILS FOR THE CONNECTION ##################### "
echo " "
echo " "
echo " "
read -p "Enter the mysql or mariadb ip address of the machine (Ex: 10.10.10.1 or 10.10.10.2): " usc
echo " "
echo " "
read -p "Enter the username (Ex: root): " ucr
echo " "
echo " "
read -p "Enter the password : " pr
echo " "
echo " "
if [ -z $usc ] && [ -z $ucr ] && [ -z $pr ]
then
echo " "
echo " "
echo " !!!!!!!!!!!! ALERT !!!!!!!! THE VALUE SHOULD NOT BE EMPTY YOU NEED TO ENTER THE VALUES TO PROCEED FURTHER PROCESS !!!!!!! "
echo " "
echo " "
sleep 5
clear
validate_root
else
echo " "
fi
clear
echo " "
echo " "
}
validate_user ()
{
clear
echo " "
echo " "
echo " ################# WELCOME TO USER CREATION PROCESS ############### "
echo " "
echo " "
read -p "Enter the username you want to create in mysql or mariadb database (Ex: flodata or rise): " cu
echo " "
echo " "
read -p "Enter the password for the user: " up
echo " "
echo " "
if [ -z $cu ] && [ -z $up ]
then
echo " "
echo " "
echo " !!!!!!!!!!!! ALERT !!!!!!!! THE VALUE SHOULD NOT BE EMPTY YOU NEED TO ENTER THE VALUES TO PROCEED FURTHER PROCESS !!!!!!! "
echo " "
echo " "
sleep 5
clear
validate_user
else
echo " "
fi
clear
echo " "
echo " "
}
db_maildetails ()
{
clear
echo " "
echo " ########### WELCOME TO MAIL SETUP PROCESS ################ "
echo " "
echo " "
yum install mutt -y 
echo " "
echo " "
sleep 5
clear
echo " "
echo " "
echo " ############# ENTER THE MYSQL OR MARIADB DETAILS ############## "
echo " "
echo " "
echo " ############# BECAREFUL WHILE YOU ENTER THE DETAILS ############## "
echo " "
echo " "
read -p "ENTER THE MYSQL OR MARIADB IP ADDRESS DETAILS Ex:(Ip Address Of Your Server):  " ip
echo " "
read -p "ENTER THE MYSQL OR MARIADB ROOT USERNAME Ex:(root): " us
echo " "
read -p "ENTER THE MYSQL OR MARIADB ROOT PASSWORD : " pa
echo " "
read -p "ENTER THE MYSQL OR MARIADB USERNAME WHICH YOU HAVE CREATED IN DATABASE EX:(flodata or rise) : " eu
echo " "
read -p "ENTER THE MYSQL OR MARIADB USER PASSWORD : " ep
echo " "
echo " "
echo " "
if [ -z $ip ] && [ -z $us ] && [ -z $pa ] && [ -z $eu ] && [ -z $ep ] 
then
echo " "
echo " "
echo " !!!!!!!!!!!! ALERT !!!!!!!! THE VALUE SHOULD NOT BE EMPTY YOU NEED TO ENTER THE VALUES TO PROCEED FURTHER PROCESS !!!!!!! "
echo " "
echo " "
sleep 6
clear
db_maildetails
echo " "
echo " "
else
echo " "
fi
read -p "The above values which you have enter is true or false (t/f): " val
echo " "
echo " "
if [ -z $val ]  
then
echo " "
echo " "
echo " !!!!!!!!!!!! ALERT !!!!!!!! THE VALUE SHOULD NOT BE EMPTY YOU NEED TO ENTER THE VALUES TO PROCEED FURTHER PROCESS !!!!!!! "
echo " "
echo " "
clear
db_maildetails
echo " "
else
echo " "
fi
clear
echo " "
echo " "
echo " "
if [ "$val" = "t" ] || [ "$val" = "T" ]
then
sleep 5 
echo " "
echo " ################### MYSQL DETAILS #################### " >> /mnt/mysqllogin.txt
echo " "
echo " "
echo "IP ADDRESS : $ip" >> /mnt/mysqllogin.txt
echo " "
echo "MYSQL ROOT USERNAME : $us" >> /mnt/mysqllogin.txt
echo " "
echo "MYSQL ROOT PASSWORD : $pa" >> /mnt/mysqllogin.txt
echo " "
echo " ################# MYSQL  USER DETAILS ################### " >> /mnt/mysqllogin.txt
echo " "
echo "MYSQL USERNAME : $eu" >> /mnt/mysqllogin.txt 
echo " "
echo "MYSQL PASSWORD : $ep" >> /mnt/mysqllogin.txt
echo " "
echo " "
elif [ "$val" = "f" ] || [ "$val" = "F" ]
then 
echo " "
echo " "
db_maildetails
echo " "
echo " "
echo " "
echo " ################### MYSQL DETAILS #################### " >> /mnt/mysqllogin.txt
echo " "
echo " "
echo "IP ADDRESS : $ip" >> /mnt/mysqllogin.txt
echo " "
echo "MYSQL ROOT USERNAME : $us" >> /mnt/mysqllogin.txt
echo " "
echo "MYSQL ROOT PASSWORD : $pa" >> /mnt/mysqllogin.txt
echo " "
echo " ################# MYSQL USER DETAILS ################### " >> /mnt/mysqllogin.txt
echo " "
echo "MYSQL USERNAME : $eu" >> /mnt/mysqllogin.txt
echo " "
echo "MYSQL PASSWORD : $ep" >> /mnt/mysqllogin.txt
echo " "
echo " "
else 
echo " "
echo " "
fi
#read -t 10 -n 1 -s -r -p "Press any key to continue the setup process or wait for 10 seconds for further process..."
echo " "
echo " "
echo " ########## SEDING MAIL PLEASE WAIT  ############ "
echo " "
echo " "
hos=`hostname`
echo " "
echo " "
yum install mailx -y
echo " "
echo " "
sleep 3
clear
ma=`yum list installed | grep mailx | awk '{print $1}'`
echo " "
echo " "
echo "$ma PAKAGE INSTALLED SUCCESSFULLY"
sleep 4
echo "MYSQL LOGIN CREDENTIALS HOSTNAME : $hos" | mailx -s "MYSQL LOGIN DETAILS INSTACNE : $hos" itsupport@forsysinc.com < /mnt/mysqllogin.txt
#mutt -s "MYSQL LOGIN CREDENTIALS HOSTNAME : $hos" -i /mnt/mysqllogin.txt -a /mnt/mysqllogin.txt  itsupport@forsysinc.com -c murali.jampana@forsysinc.com
}
mardb_maildetails ()
{
clear
echo " "
echo " ########### WELCOME TO MAIL SETUP PROCESS ################ "
echo " "
echo " "
yum install mutt -y 
echo " "
echo " "
sleep 5
clear
echo " "
echo " "
echo " ############# ENTER THE MYSQL OR MARIADB DETAILS ############## "
echo " "
echo " "
echo " ############# BECAREFUL WHILE YOU ENTER THE DETAILS ############## "
echo " "
echo " "
read -p "ENTER THE MYSQL OR MARIADB IP ADDRESS DETAILS Ex:(Ip Address Of Your Server):  " ip
echo " "
read -p "ENTER THE MYSQL OR MARIADB ROOT USERNAME Ex:(root): " us
echo " "
read -p "ENTER THE MYSQL OR MARIADB ROOT PASSWORD : " pa
echo " "
read -p "ENTER THE MYSQL OR MARIADB USERNAME WHICH YOU HAVE CREATED IN DATABASE EX:(flodata or rise) : " eu
echo " "
read -p "ENTER THE MYSQL OR MARIADB USER PASSWORD : " ep
echo " "
echo " "
echo " "
read -p "The above values which you have enter is true or false (t/f): " val
echo " "
echo " "
#read -t 10 -n 1 -s -r -p "Press any key to continue the setup process or wait for 10 seconds for further process..."
echo " "
echo " "
echo " "
if [ "$val" = "t" ] || [ "$val" = "T" ]
then
sleep 5 
echo " "
echo " ################### MARIADB DETAILS #################### " >> /mnt/mariadblogin.txt
echo " "
echo " "
echo "IP ADDRESS : $ip" >> /mnt/mariadblogin.txt
echo " "
echo "MARIADB ROOT USERNAME : $us" >> /mnt/mariadblogin.txt
echo " "
echo "MARIADB ROOT PASSWORD : $pa" >> /mnt/mariadblogin.txt
echo " "
echo " ################# MARIADB USER DETAILS ################### " >> /mnt/mariadblogin.txt
echo " "
echo "MARIADB USERNAME : $eu" >> /mnt/mariadblogin.txt 
echo " "
echo "MARIADB PASSWORD : $ep" >> /mnt/mariadblogin.txt
echo " "
echo " "
elif [ "$val" = "f" ] || [ "$val" = "F" ]
then 
echo " "
echo " "
mardb_maildetails
echo " "
echo " "
echo " "
echo " ################### MARIADB DETAILS #################### " >> /mnt/mariadblogin.txt
echo " "
echo " "
echo "IP ADDRESS : $ip" >> /mnt/mariadblogin.txt
echo " "
echo "MARIADB ROOT USERNAME : $us" >> /mnt/mariadblogin.txt
echo " "
echo "MARIADB ROOT PASSWORD : $pa" >> /mnt/mariadblogin.txt
echo " "
echo " ################# MARIADB USER DETAILS ################### " >> /mnt/mariadblogin.txt
echo " "
echo "MARIADB USERNAME : $eu" >> /mnt/mariadblogin.txt
echo " "
echo "MARIADB PASSWORD : $ep" >> /mnt/mariadblogin.txt
echo " "
echo " "
else 
echo " "
echo " "
fi
echo " "
echo " "
echo " ########## SENDING MAIL PLEASE WAIT  ############ "
echo " "
echo " "
hos=`hostname`
echo " "
echo " "
yum install mailx -y
echo " "
echo " "
sleep 3
clear
ma=`yum list installed | grep mailx | awk '{print $1}'`
echo " "
echo " "
echo "$ma PAKAGE INSTALLED SUCCESSFULLY"
sleep 4
echo "MARIADB LOGIN CREDENTIALS HOSTNAME : $hos" | mailx -s "MARIADB LOGIN DETAILS INSTACNE : $hos" itsupport@forsysinc.com < /mnt/mariadblogin.txt
#mutt -s "MYSQL LOGIN CREDENTIALS HOSTNAME : $hos" -i /mnt/mysqllogin.txt -a /mnt/mysqllogin.txt  itsupport@forsysinc.com -c murali.jampana@forsysinc.com
}
check_internet ()
{
echo " "
echo " "
echo " ########### CHECKING WITH THE INTERNET CONNECTIVITY ############ "
echo " "
echo " "
ping -c5 google.com > /dev/null
echo " "
if [ $? -eq  1 ]
then
echo "CHECK WITH THE INTERNET THERE IS NO RESPONSE FROM GOOGLE SERVER !!!!!!!!!!! SCRIPT WILL BE ABORTED :("
exit1
else
echo " "
echo " "
echo "YOU ARE CONNECTED TO INTERNET :)"
echo " "
echo " "
sleep 5
echo " "
echo " "
echo " "
fi
use=`whoami`
if [ "$use" = "root" ]
then
echo " ######### YOU ARE RUNNING WITH THE ROOT USER ############## "
echo " "
echo " "
echo "CREATING TEMP FILE PLEASE WAIT"
echo " "
echo " "
#exit 1
else
echo " "
echo " "
sleep 4
echo "ALERT !!!!!!! YOU NEED TO BE ROOT TO RUN THE SCRIPT OR YOU CAN RUN THE SCRIPT WITH SUDO PRIVILEGIES EX: sudo bash prerequisites.sh"
exit 1
fi
}
check_mariadb ()
{
read -p  "Enter 'y' without quotes to start MARIADB setup OR 'n' without quotes exit the setup ? (y/n): " mari
echo " "
echo " "
if [ "$mari" = "y" ] || [ "$mari" = "Y" ]
then 
clear
echo " ############### STARTING MARIADB SETUP PLEASE WAIT ################### "
echo " "
echo " "
echo " ############### FOLLOW THE INSTRUCTIONS CAREFULLY ################ "
echo " "
sleep 4
echo " "
echo " "
echo "YOU NEED TO PRESS "Y" OPTION ONLY FOR ROOT PASSWORD & RELOAD PRIVILEGES OPTION ONLY"
echo " "
echo " "
echo " "
echo " ############ PRESS ENTER WHEN THE SETUP ASK ROOT PASSWORD FOR THE FIRST TIME ################ "
echo " "
echo " "
echo " "
sleep 6
read -p "Press [Enter] Key To Start The Process ...."
echo " "
echo " "
clear
sleep 5
echo " "
echo " "
echo " ############ STARTING THE SETUP PLEASE WAIT ################### "
echo " "
echo " "
sleep 2
echo "!!!!!!!!!!!!!!!!!! PRESS ENTER WHEN THE SETUP ASK ROOT PASSWORD FOR THE FIRST TIME !!!!!!!!!!!!!!!!!!!!!"
echo " "
echo " "
sleep 2
echo " !!!!!!!!!!!!! BE CAREFULL WHEN YOU SET THE ROOT PASSWORD !!!!!!!!!!!!!!!!"
echo " "
echo " "
sleep 2
echo " "
echo " "
echo " ################ YOU NEED TO PRESS "Y" OPTION ONLY FOR ROOT PASSWORD & RELOAD PRIVILEGES OPTION ONLY ################## "
echo " "
echo " "
sleep 2
mysql_secure_installation
echo " "
echo " "
echo "RESTARTING THE MARIADB SERVER PLEASE WAIT"
echo " "
systemctl restart mariadb
echo " "
echo " "
sleep 8
clear
echo " ################ CHECKING WITH THE  DATABASE SERVICES PLEASE WAIT ############### "
echo " "
echo " "
dab=`netstat -nltp | grep 3306 | awk {'print $6'}`
echo " "
if [ "LISTEN" = "$dab" ]
then
sleep 5
echo " "
echo " "
echo "MARIADB DATABASE SERVER INSTALLED AND RUNNING IN YOUR MACHINE ..."
sleep 8
echo " "
echo " "
else
echo " "
echo " "
echo " !!!!!!! ALERT !!!!!!!! MARIADB SERVICE IS IN DOWN STATE !!!!!!!!!!! :("
echo " "
echo " "
sleep 4
echo " "
echo " !!!!!!!!!! SETUP WILL BE ABORTED !!!!!!!!!! "
exit
fi
sleep 8
elif [ "$mari" = "n" ] || [ "$mari" = "N" ]
then 
echo " "
echo "YOU HAVE ENTER EXIT OPTION"
sleep 3
echo " "
echo " "
echo "SETUP WILL BE ARORTED"
echo " "
echo " "
echo "THANKS FOR USING THE SCRIPT FOR ANY UPDATES OR QUERIES YOU MAY REACH devops@forysinc.com STAY TUNED MORE UPDATES ............"
exit
else 
echo " "
fi
}
check_mysql ()
{
read -p  "Enter 'y' without quotes to start MYSQL setup OR 'n' without quotes exit the setup ? (y/n): " myq
echo " "
echo " "
echo " "
echo " "
if [ -z $myq ] 
then
echo " "
echo " "
echo " !!!!!!!!!!!! ALERT !!!!!!!! THE VALUE SHOULD NOT BE EMPTY YOU NEED TO ENTER THE VALUES TO PROCEED FURTHER PROCESS !!!!!!! "
echo " "
echo " "
sleep 6
clear
check_mysql
echo " "
echo " "
else
echo " "
fi
clear
echo " "
echo " "
if [ "$myq" = "y" ] || [ "$myq" = "Y" ]
then 
clear
echo " ############### STARTING MYSQL SETUP PLEASE WAIT ################### "
echo " "
echo " "
echo " ############### FOLLOW THE INSTRUCTIONS CAREFULLY ################ "
echo " "
sleep 4
echo " "
echo " "
echo "YOU NEED TO PRESS "Y" OPTION ONLY FOR ROOT PASSWORD & RELOAD PRIVILEGES OPTION ONLY"
echo " "
echo " "
echo " "
echo " ############ PRESS ENTER WHEN THE SETUP ASK ROOT PASSWORD FOR THE FIRST TIME ################ "
echo " "
echo " "
echo " "
sleep 6
read -p "Press [Enter] Key To Start The Process ....."
echo " "
echo " "
clear
sleep 5
echo " "
echo " "
echo " ############ STARTING THE SETUP PLEASE WAIT ################### "
echo " "
echo " "
sleep 2
echo "!!!!!!!!!!!!!!!!!! PRESS ENTER WHEN THE SETUP ASK ROOT PASSWORD FOR THE FIRST TIME !!!!!!!!!!!!!!!!!!!!!"
echo " "
echo " "
sleep 2
echo " !!!!!!!!!!!!! BE CAREFULL WEHN YOU SET THE ROOT PASSWORD !!!!!!!!!!!!!!!!"
echo " "
echo " "
sleep 2
echo " "
echo " "
echo " ################ YOU NEED TO PRESS "Y" OPTION ONLY FOR ROOT PASSWORD & RELOAD PRIVILEGES OPTION ONLY ################## "
echo " "
echo " "
sleep 2
mysql_secure_installation
echo " "
echo " "
echo "RESTARTING THE MYSQL SERVER PLEASE WAIT"
echo " "
systemctl restart mysqld
echo " "
echo " "
sleep 8
clear
echo " ################ CHECKING WITH THE  DATABASE SERVICES PLEASE WAIT ############### "
echo " "
echo " "
dab=`netstat -nltp | grep 3306 | awk {'print $6'}`
echo " "
if [ "LISTEN" = "$dab" ]
then
sleep 5
echo " "
echo " "
echo "MYSQL DATABASE SERVER INSTALLED AND RUNNING IN YOUR MACHINE ..."
sleep 5
echo " "
echo " "
else
echo " "
echo " "
echo " !!!!!!!!!!!!!!! ALERT !!!!!!!!!!!! MYSQL SERVICE IS IN DOWN STATE !!!!!!!!!!!!!! :("
echo " "
echo " "
echo " !!!!!!!!!!!!!!!! SETUP WILL BE ABORTED !!!!!!!!!!!!! "
sleep 5
echo " "
echo " "
exit
fi
elif [ "$myq" = "n" ] || [ "$myq" = "N" ]
then 
echo " "
echo "YOU HAVE ENTER EXIT OPTION"
sleep 3
echo " "
echo " "
echo "SETUP WILL BE ARORTED"
echo " "
echo " "
echo "THANKS FOR USING THE SCRIPT FOR ANY UPDATES OR QUERIES YOU MAY REACH devops@forysinc.com STAY TUNED MORE UPDATES ............"
exit
else 
echo " "
fi
}
db_usercreate ()
{
read -p "Do you want to create mysql or mariadb user in your database (Ex:Rise or Flodata) y/n: " usr
echo " "
echo " "
echo " "
echo " "
if [ -z $usr ] 
then
echo " "
echo " "
echo " !!!!!!!!!!!! ALERT !!!!!!!! THE VALUE SHOULD NOT BE EMPTY YOU NEED TO ENTER THE VALUES TO PROCEED FURTHER PROCESS !!!!!!! "
echo " "
echo " "
sleep 6
clear
db_usercreate
echo " "
echo " "
else
echo " "
fi
if [ "$usr" = "y" ] || [ "$usr" = "Y" ]
then 
echo " "
echo " "
mysql_connection
clear
validate_root
clear
validate_user
clear
echo " "
clear
echo " "
elif [ "$usr" = "n" ] || [ "$usr" = "N" ]
then 
echo " "
echo " "
sleep 4
echo "YOU HAVE CHOOSEN NO OPTION"
echo " "
echo " "
echo "USER CREATION SETUP WILL BE ABORTED"
echo " "
sleep 4
echo " "
else 
echo " "
echo " "
fi
read -p "Do you want to confirm with the above detials(y/n):  " conf
echo " "
echo " "
if [ -z $conf ] 
then
echo " "
echo " "
echo " !!!!!!!!!!!! ALERT !!!!!!!! THE VALUE SHOULD NOT BE EMPTY YOU NEED TO ENTER THE VALUES TO PROCEED FURTHER PROCESS !!!!!!! "
echo " "
echo " "
sleep 6
clear
validate_root
echo " "
echo " "
else
echo " "
fi
clear
echo " "
echo " "
if [ "$conf" = "y" ] || [ "$conf" = "Y" ]
then 
echo " "
echo " "
echo "Connecting to the mysql host please wait ........."
echo " "
echo " "
sleep 5
mysql -u $ucr -p$pr <<EOF
create user '$cu'@'localhost' identified by '$up';
create user '$cu'@'%' identified by '$up';
GRANT ALL PRIVILEGES ON * . * TO '$cu'@'localhost';
GRANT ALL PRIVILEGES ON * . * TO '$cu'@'%';
grant all privileges on *.* to 'root'@'%' with grant option;
grant all privileges on *.* to 'root'@'localhost' with grant option;
FLUSH PRIVILEGES;
EOF
echo " "
echo " "
sleep 3
clear
create_database
sleep 4
elif [ "$conf" = "n" ] || [ "$conf" = "N" ]
then 
echo " "
echo " "
clear
db_usercreate
clear
else 
echo " "
echo " "
fi
}
clear
echo " "
echo " "
echo " ################## WELCOME TO DATABASE INSTALLATION PART ################ "
echo " "
echo " "
cd /mnt && touch mysqllogin.txt && touch mariadblogin.txt
echo " "
echo " "
check_internet
clear
echo " "
echo "Welcome to Mariadb or  Mysql database installation ....."
echo " "
echo " "
echo "Checking with the existing database application..........."
echo " "
echo " "
dab=`netstat -nltp | grep 3306 | awk {'print $6'}`
echo " "
if [ "LISTEN" = "$dab" ]
then
sleep 5
echo "MYSQL (OR) MARIADB  DATABASE HAS BEEN ALREADY INSTALLED AND RUNNING IN YOUR MACHINE ..."
sleep 10
echo " "
echo " "
else
echo "THERE IS NO EXISTING INSTALLATION FOUND IN THE MACHINE ......."
fi
echo " "
echo " "
clear
echo " "
clear
read -p  "Enter 'my' without quotes to install Mysql OR 'mar' without quotes to install Mariadb OR 'e' to exit the installation (my/mar/e): " res
echo " "
echo " "
echo " "
clear
if [ "$res" = "e" ] || [ "$res" = "E" ]
then
echo " "
echo " "
echo " !!!!!!!!!! YOU HAVE CHOOSEN EXIT OPTION !!!!!!!!! "
echo " "
echo " "
echo "!!!!!!!!! INSTALLATION WILL BE ABORTED !!!!!!!!!!"
echo " "
echo " "
sleep 5
exit
else
echo " "
echo " "
echo " "
sleep 3
echo " "
echo " "
fi
clear
if [ "$res" = "my" ] || [ "$res" = "MY" ]
then 
clear
echo " "
echo " ############### WELCOME TO MYSQL INSTALLATION PROCESS ############### "
echo " "
echo " "
sleep 5
echo " "
yum install wget -y 
echo " "
echo " "
echo "INSTALLING MYSQL PLEASE WAIT"
sleep 3
echo " "
echo " "
clear
echo " ################ DONWLOADING MYSQL PACKAGE PLEASE WAIT ################### "
echo " "
echo " "
cd /opt && wget http://repo.mysql.com/yum/mysql-5.6-community/el/7/x86_64/mysql-community-release-el7-5.noarch.rpm
echo " "
echo " "
sleep 4
clear
echo " ############## INSTALLING MYSQL PACKAGE PLEASE WAIT ############### "
echo " "
echo " "
cd /opt && yum localinstall mysql-community-release-el7-5.noarch.rpm -y
echo " "
echo " "
echo " "
clear
yum install mysql-server -y 
echo " "
echo " "
echo " "
sleep 4
systemctl enable mysqld && systemctl start mysqld
echo " "
echo " "
sleep 3
echo " "
my=`mysql --version | awk {'print $5'}`
echo " "
echo " "
sleep 4
clear
echo " "
echo " "
sleep 4
clear
echo " "
echo " "
echo " ############# $my MYSQL VERSION HAS BEEN INSTALLED SUCCSSFULLY IN YOUR MACHINE ############### "
echo " "
echo " "
sleep 4
clear
echo " #################### WELCOME TO MYSQL SETUP PLEASE FOLLOW THE INSTUCTIONS CAREFULLY ####################### "
echo " "
echo " "
sleep 2
echo " !!!!!!!!!!!!! BE CAREFULL WEHN YOU SET THE ROOT PASSWORD !!!!!!!!!!!!!!!!"
echo " "
sleep 8
echo " "
echo " "
echo " "
clear
check_mysql 
sleep 5
clear
echo " "
echo " "
db_usercreate
echo " "
echo " "
db_maildetails
echo " "
echo " "
clear
dbchange_path
clear
echo " "
echo " "
echo " ################## THANKS FOR JOINING MYSQL INSTALLATAION JOURNEY HAVE A GOOD DAY ################# "
sleep 8
echo " "
echo " "
elif [ "$res" = " " ] || [ "$res" = " " ]
then
echo " "
else
echo " "
fi 
if [ "$res" = "mar" ] || [ "$res" = "mar" ]
then 
clear
echo " "
echo " ############### WELCOME TO MARIADB INSTALLATION PROCESS ############### "
echo " "
echo " "
sleep 5
echo " "
yum install wget epel-release -y 
echo " "
echo " "
echo "INSTALLING MARIADB PLEASE WAIT"
sleep 3
echo " "
echo " "
clear
echo " "
echo " "
echo " ################ INSTALLING MARIADB PACKAGE PLEASE WAIT ################ "
echo " "
echo " "
yum install mariadb-server -y 
echo " "
echo " "
sleep 4
clear
systemctl enable mariadb && systemctl start mariadb
echo " "
echo " "
sleep 3
echo " "
mar=`mariadb --version | awk {'print $5'}`
echo " "
echo " "
sleep 4
clear
echo " "
echo " "
sleep 4
clear
echo " "
echo " "
echo " ############# $mar MARIADB VERSION HAS BEEN INSTALLED SUCCSSFULLY IN YOUR MACHINE ############### "
echo " "
echo " "
sleep 4
clear
echo " #################### WELCOME TO MARIADB SETUP PLEASE FOLLOW THE INSTUCTIONS CAREFULLY ####################### "
echo " "
echo " "
sleep 2
echo " !!!!!!!!!!!!! BE CAREFULL WEHN YOU SET THE ROOT PASSWORD !!!!!!!!!!!!!!!!"
echo " "
sleep 8
echo " "
echo " "
echo " "
clear
check_mariadb 
sleep 5
clear
echo " "
echo " "
db_usercreate
echo " "
echo " "
mardb_maildetails
echo " "
echo " "
clear
dbchange_path
clear
echo " "
echo " "
echo " ################## THANKS FOR JOINING MYSQL INSTALLATAION JOURNEY HAVE A GOOD DAY ################# "
sleep 8
echo " "
echo " "
elif [ "$res" = " " ] || [ "$res" = " " ]
then
echo " "
else
echo " "
fi 
