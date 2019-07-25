#!/bin/sh

#########################################################################################
# Eightsquare Pvt. Ltd its affiliates. All rights reserved.
# File          : MongoDbBackup.ksh
# Purpose       : To take a backup files for MongoDB
# Usage         : ./MongoDbBackup.ksh
# Created By    : Devesh Kumar Shrivastav
# Created Date  : April 30, 2019
# Purpose       : UNIX Backup the files
# Revision      : 1.0
#########################################################################################

################BOF This is part of the MongoDbBackup#################

# To Create a FileName
today=`date +MongoDbFullBackUP_%d_%b_%Y`

# Path for the file will be created
backup_dir=/home/BackUpMongoDB
backup_log=/home/MongoDbBackup_Log

# To Create a Date Specific Folder
mkdir -p ${backup_dir}/${today}/dump

# To Take a Backup (Without Server Authentications)
#mongodump --out ${backup_dir}/${today}/dump/ >> /home/MongoDbBackup_Log/${today}.log 2>&1

# To Take a Backup
mongodump --host 127.0.0.1 --port 27017 -u admin -p Admin@P@55w0rd --authenticationDatabase admin --out ${backup_dir}/${today}/dump/ >> /home/MongoDbBackup_Log/${today}.log 2>&1

# To Enter source location
cd $backup_dir

# To specify the directory
file_name="MongoDbFullBackUP_"

# To Remove 15 Days older backup
for files in $(find -type d -mtime +15 | grep $file_name);
do
sudo rm -rf "$files";
done

# To Enter source location
cd $backup_log

# To Remove 15 Days older backup logs
for files in $(find -type f -mtime +15 | grep $file_name);
do
  sudo rm -rf "$files";
done

################EOF This is part of the MongoDbBackup#################
