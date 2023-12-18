#!/bin/bash

if [[ "$1" != "-n" ]]; then #if not already in bg
    nohup "$0" -n &	#make ./backup.sh to bg
    exit $?
fi

cb_backup_dir=~/backup/cb	#path to cb folder
ib_backup_dir=~/backup/ib	#path to ib folder

mkdir -p $ib_backup_dir	#make ib dir
mkdir -p $cb_backup_dir	#make cb dir

cb_backup_no=20000	#initial number for cb
ib_backup_no=10000	#initial number for ib

cb_backup_file=cb$cb_backup_no.tar	#name for cb backup file "cb+number of cb"
ib_backup_file=ib$ib_backup_no.tar	#name for ib backup

while [ true ];	#infi loop
do
	# Complete Backup
	cb_backup_file=cb$cb_backup_no.tar	#update tar file name for cb backup
	find /home/$USER -name '*.txt' | tar -cf $cb_backup_dir/$cb_backup_file -T -	#tar all txt files found in /home/username
	echo $(date) $cb_backup_file was created >> ~/backup/backup.log		#update backup log
	cb_backup_no=$(($cb_backup_no+1))	#inc cb backup no

	sleep 120

	#incremental backup 1
	new_files=$(find /home/$USER -name '*.txt' -newer $cb_backup_dir/$cb_backup_file) #1st ib check for new files with cb tar file

	if [ -z $new_files ]; then	#if no new files
		echo $(date) No changes-Incremental backup was not created >> ~/backup/backup.log	#update backup log	
	else	#if there are any new files
		ib_backup_file=ib$ib_backup_no.tar	#update ib back up file name
		find /home/$USER -name '*.txt' | tar -cf $ib_backup_dir/$ib_backup_file -T -	#create an ib tar file
		echo $(date) $ib_backup_file was created >> ~/backup/backup.log	#update backup log
		ib_backup_no=$(($ib_backup_no+1))	#update back up no
	fi
	
	sleep 120

	#incremental backup 2
	if [ $ib_backup_no -eq 10000 ]; then	#not a single ib has been created
		new_files=$(find /home/$USER -name '*.txt' -newer $cb_backup_dir/$cb_backup_file)	#check for new files with cb tar file
	else	#there has been atleast one ib
		new_files=$(find /home/$USER -name '*.txt' -newer $ib_backup_dir/$ib_backup_file)	#check for new files with ib tar file
	fi
	#Explaination for above if condition:
	#If there havent been any ib till now because no updates have occure in txt files compare with the cb tar
	#else, there have been ib then compare with ib tar
	#So basically untill atleat one ib has occured ib compares with cb tar file, as requirements say to check with the previous ib
	#but if ib was not done only then checking with cb, same for ib3
	if [ -z $new_files ]; then	#if no new files
		echo $(date) No changes-Incremental backup was not created >> ~/backup/backup.log	#update backup log	
	else
		ib_backup_file=ib$ib_backup_no.tar	#update ib back up file name
		find /home/$USER -name '*.txt' | tar -cf $ib_backup_dir/$ib_backup_file -T -	#create an ib tar file
		echo $(date) $ib_backup_file was created >> ~/backup/backup.log	#update backup log
		ib_backup_no=$(($ib_backup_no+1))	#update back up no
	fi

	sleep 120

	#incremental backup 3
	if [ $ib_backup_no -eq 10000 ]; then	#not a single ib has been created
		new_files=$(find /home/$USER -name '*.txt' -newer $cb_backup_dir/$cb_backup_file)	#check for new files with cb tar file
	else	#there has been atleast on ib
		new_files=$(find /home/$USER -name '*.txt' -newer $ib_backup_dir/$ib_backup_file)	#check for new files with ib tar file
	fi
	if [ -z $new_files ]; then	#if no new files
		echo $(date) No changes-Incremental backup was not created >> ~/backup/backup.log	#update backup log	
	else
		ib_backup_file=ib$ib_backup_no.tar	#update ib back up file name
		find /home/$USER -name '*.txt' | tar -cf $ib_backup_dir/$ib_backup_file -T -	#create an ib tar file
		echo $(date) $ib_backup_file was created >> ~/backup/backup.log	#update backup log
		ib_backup_no=$(($ib_backup_no+1))	#update back up no
	fi
	sleep 120
done
