--Reference : https://tecadmin.net/backup-and-restore-mongodb-database/
-- To Backup, Restore and Migrate MongoDB Database

#1. Backup MongoDB Database (mongodump)

There are various options to take backups of mongodb database. Use mongodump command to take 
all databases backup or a single database backup of backup of single collection.
Backup Single Database

Use this command to take backup of a single database (named mydb) only. 
Backup will be created in /BackUpMongoDB/db/ directory.

[root@localhost home]# mkdir -p /home/BackUpMongoDB/dump
[root@localhost home]# chmod -R 777 BackUpMongoDB/
[root@localhost home]# cd /home/BackUpMongoDB/dump
[root@localhost dump]# pwd
/*
/home/BackUpMongoDB/dump
*/
[root@localhost /]# mongo
> show dbs
/*
admin   0.000GB
config  0.000GB
local   0.000GB
*/

> use mydb
/*
switched to db mydb
*/

> db.createCollection("test")
/*
{ "ok" : 1 }
*/
> db.test.insert({c1:"a",c2:"b"})
/*
WriteResult({ "nInserted" : 1 })
*/
> show collections
/*
test
*/
> show dbs
/*
admin   0.000GB
config  0.000GB
local   0.000GB
mydb    0.000GB
*/

/*
–db – database name to backup
–out – database backup location. This will create folder with database name.
You can specify host, port, username and password for remote databases connections backups like below.
$ mongodump --host 10.0.1.7 --port 27017 --username admin --password somepassword --db mydb --out /backup/db/
*/

-- Backup Specific MongoDB Database at specific location (mongodump)
[root@localhost /]# mongodump --db mydb --out /home/BackUpMongoDB/dump/
/*
2019-04-30T04:32:33.621+0545    writing mydb.test to
2019-04-30T04:32:33.625+0545    done dumping mydb.test (1 document)
*/

[root@localhost dump]# pwd
/*
/home/BackUpMongoDB/dump
*/
[root@localhost dump]# ls
/*
mydb
*/
[root@localhost dump]# cd mydb/
[root@localhost mydb]# ls
/*
test.bson  test.metadata.json
*/
[root@localhost /]#mongo

> show dbs
/*
admin   0.000GB
config  0.000GB
local   0.000GB
mydb    0.000GB
*/
> use mydb
/*
switched to db mydb
*/
> db
/*
mydb
*/
> db.dropDatabase()
/*
{ "dropped" : "mydb", "ok" : 1 }
*/
> show dbs
/*
admin   0.000GB
config  0.000GB
local   0.000GB
*/

-- Backup all MongoDB Database at specific location (mongodump)
[root@localhost /]# mongodump --out /home/BackUpMongoDB/dump/
/*
2019-04-30T20:36:53.832+0545    writing admin.system.users to
2019-04-30T20:36:53.833+0545    done dumping admin.system.users (1 document)
2019-04-30T20:36:53.833+0545    writing admin.system.version to
2019-04-30T20:36:53.833+0545    done dumping admin.system.version (2 documents)
2019-04-30T20:36:53.833+0545    writing mydb.test to
2019-04-30T20:36:53.834+0545    done dumping mydb.test (1 document)
*/

[root@localhost dump]# ls
/*
admin  mydb
*/
[root@localhost dump]# cd admin/
[root@localhost admin]# ls
/*
system.users.bson           system.version.bson
system.users.metadata.json  system.version.metadata.json
*/
[root@localhost admin]#

-- Backup Specific MongoDB Database and Specific collection at specific location (mongodump)
[root@localhost BackUpMongoDB]# mongodump --collection test --db mydb --out /home/BackUpMongoDB/dump/
/*
2019-04-30T20:48:32.965+0545    writing mydb.test to
2019-04-30T20:48:32.966+0545    done dumping mydb.test (1 document)
*/

#2. Restore specific MongoDB Database with mongorestore

[root@localhost dump]# mongorestore --db mydb /home/BackUpMongoDB/dump/mydb
/*
2019-04-30T04:55:37.426+0545    the --db and --collection args should only be used when restoring from a BSON file. Other uses are deprecated and will not exist in the future; use --nsInclude instead
2019-04-30T04:55:37.426+0545    building a list of collections to restore from /home/BackUpMongoDB/dump/mydb dir
2019-04-30T04:55:37.427+0545    reading metadata for mydb.test from /home/BackUpMongoDB/dump/mydb/test.metadata.json
2019-04-30T04:55:37.461+0545    restoring mydb.test from /home/BackUpMongoDB/dump/mydb/test.bson
2019-04-30T04:55:37.470+0545    no indexes to restore
2019-04-30T04:55:37.470+0545    finished restoring mydb.test (1 document)
2019-04-30T04:55:37.470+0545    done
*/

–drop – Will remove database if already exist.

#2.1 Restore all MongoDB Database with mongorestore
[root@localhost BackUpMongoDB]# mongorestore
/*
2019-04-30T20:40:52.838+0545    using default 'dump' directory
2019-04-30T20:40:52.838+0545    preparing collections to restore from
2019-04-30T20:40:52.840+0545    reading metadata for mydb.test from dump/mydb/test.metadata.json
2019-04-30T20:40:52.847+0545    restoring mydb.test from dump/mydb/test.bson
2019-04-30T20:40:52.848+0545    no indexes to restore
2019-04-30T20:40:52.848+0545    finished restoring mydb.test (1 document)
2019-04-30T20:40:52.848+0545    restoring users from dump/admin/system.users.bson
2019-04-30T20:40:52.868+0545    done
*/

You can simply move backup files to remote server and run the same command there to restore backups.
#3. MongoDB Backup Shell Script

#!/bin/sh

# To Create a FileName
today=`date +MongoDbFullBackUP_%d_%b_%Y`
# Path for the file will be created
backup_dir=/home/BackUpMongoDB
# To Create a Date Specific Folder 
mkdir -p ${backup_dir}/${today}/dump
# To Take a Backup
mongodump --out ${backup_dir}/${today}/dump/

-- To Sechedule the job every day at 6PM
0 18 * * * * /home/MongoDbBackup_Script/MongoDbBackup.ksh >> /home/MongoDbBackup_Log/MongoDbBackup_log.txt


