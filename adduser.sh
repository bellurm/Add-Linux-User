#! /bin/bash

function warning() {
	warning="\n\n*****WARNING*****\nYou have to enter the username you just entered in the 'Full Name []:' field.\n
	You can leave the remaining fields blank.\n
	Transactions will start within 45 seconds.\n"
	
	warnReboot="\n\n*****WARNING*****\nOnce the processes are complete, you have to reboot your device.\n
	To log in again, you will need the new username and password you entered in the application.\n"
	
	echo -e $warning
	echo -e $warnReboot
}

if [ $(whoami) != "root" ]
then
	echo -e "Please, you have to be 'root' with 'sudo su' commmand.\n"
	echo -e "Don't worry. We will give to your user a 'root' permission. We can't do this without 'root'.\n"
else
	read -p "New user: " newUser
	
	echo -e >> /etc/sudoers "$newUser	ALL=(ALL:ALL) ALL"
	echo -e "Done.\n"
	
	warning
	
	sleep 45
	
	sudo adduser $newUser
	
	echo -e "\nYou should reboot your machine with 'reboot' command."
fi
