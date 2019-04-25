--Install MongoDB On Windows
--Verification of Windows
C:\>wmic os get osarchitecture
OSArchitecture
64-bit
C:\>


-- To Start/Stop the MongoDB Enterprise Edition using CommandPrompt.
net start MongoDB
net stop MongoDB
-- To Start/Stop MongoDB Enterprise Edition using Windows Service
To stop/pause the MongoDB service, use the Services console:
From the Services console, locate the MongoDB service.
Right-click on the MongoDB service and click Stop (or Pause or start).

-- To Set Path
"C:\Program Files\MongoDB\Server\4.0\bin\mongo.exe" --dbpath "C:\data" 

-- To Connect to the MongoDB server.
"C:\Program Files\MongoDB\Server\4.0\bin\mongo.exe"

-- To MangoDB Help
>db.help()

-- To Find the number of Database
>show dbs

-- To Find the specific database
>db

-- To Find MongoDB Statistics -- use <<database_name>>
>db.stats()

-- To Create Database
Syntax: use <<DATABASE_NAME>>

> use Mongodb_1
switched to db Mongodb_1

-- To check the currently created database
> db
Mongodb_1

-- To show the database using "show dbs" command
> show dbs
admin   0.000GB
config  0.000GB
local   0.000GB

-- Need to insert at least one/more document into it.
> db.table_1.insert({"col_1":"Devesh Kumar Shrivastav"})
WriteResult({ "nInserted" : 1 })

> db.table_1.aggregate([{$count: "Count"}])
{ "Count" : 1 }

> db.table_1.insert({"col_1":"Suman Pantha"})
WriteResult({ "nInserted" : 1 })

> db.table_1.aggregate([{$count: "Count"}])
{ "Count" : 2 }

> show dbs
Mongodb_1  0.000GB
admin      0.000GB
config     0.000GB
local      0.000GB

-- To Copy Database
>db.copyDatabase("Mongodb_1","Mongodb")

> show dbs
/*
Mongodb    0.000GB
Mongodb_1  0.000GB
admin      0.000GB
config     0.000GB
local      0.000GB
*/

-- To Select Newly Created Database (Mongodb_1)
>use Mongodb
/*
switched to db Mongodb
*/

-- To Drop Database
> db.dropDatabase()
/*
{ "dropped" : "Mongodb", "ok" : 1 }
*/

> show dbs
/*
Mongodb_1  0.000GB
admin      0.000GB
config     0.000GB
local      0.000GB
*/

-- To Backup Database
Create Backup and dump location using Administartor privilage <<LOCATION>>

*This command will backup all collection of specified database.
mongodump --out <<LOCATION>>  --db <<DB_NAME>>
C:\>mongodump --out "C:\MongoDB_Backup\dump"  --db Mongodb_1
/*
2019-04-23T16:33:52.333+0545    writing Mongodb_1.table_1 to
2019-04-23T16:33:52.333+0545    writing Mongodb_1.post_data to
2019-04-23T16:33:52.335+0545    writing Mongodb_1.table_2 to
2019-04-23T16:33:52.335+0545    done dumping Mongodb_1.table_1 (6 documents)
2019-04-23T16:33:52.343+0545    done dumping Mongodb_1.post_data (2 documents)
2019-04-23T16:33:52.343+0545    done dumping Mongodb_1.table_2 (0 documents)
*/
 
*This command will backup only specified collection of specified database.
mongodump --out <<LOCATION>> --collection <<COLLECTION_NAME>> --db <<DB_NAME>>
C:\>mongodump --out "C:\MongoDB_Backup\dump\dump" --collection table_1 --db Mongodb_1
/*
2019-04-23T16:38:05.175+0545    writing Mongodb_1.table_1 to
2019-04-23T16:38:05.177+0545    done dumping Mongodb_1.table_1 (6 documents)
*/

--To Restore Database 
*Go to the DB Backup Folder and run the command for All Database 
C:\>cd MongoDB_Backup

C:\MongoDB_Backup>mongorestore
/*
2019-04-23T16:40:37.811+0545    using default 'dump' directory
2019-04-23T16:40:37.813+0545    preparing collections to restore from
2019-04-23T16:40:37.815+0545    don't know what to do with subdirectory "dump\Mongodb_1", skipping...
2019-04-23T16:40:37.822+0545    reading metadata for Mongodb_1.post_data from dump\Mongodb_1\post_data.metadata.json
2019-04-23T16:40:37.823+0545    reading metadata for Mongodb_1.table_2 from dump\Mongodb_1\table_2.metadata.json
2019-04-23T16:40:37.823+0545    reading metadata for Mongodb_1.table_1 from dump\Mongodb_1\table_1.metadata.json
2019-04-23T16:40:37.839+0545    restoring Mongodb_1.post_data from dump\Mongodb_1\post_data.bson
2019-04-23T16:40:37.842+0545    no indexes to restore
2019-04-23T16:40:37.843+0545    finished restoring Mongodb_1.post_data (2 documents)
2019-04-23T16:40:38.860+0545    restoring Mongodb_1.table_2 from dump\Mongodb_1\table_2.bson
2019-04-23T16:40:38.862+0545    no indexes to restore
2019-04-23T16:40:38.868+0545    finished restoring Mongodb_1.table_2 (0 documents)
2019-04-23T16:40:38.886+0545    restoring Mongodb_1.table_1 from dump\Mongodb_1\table_1.bson
2019-04-23T16:40:38.899+0545    no indexes to restore
2019-04-23T16:40:38.899+0545    finished restoring Mongodb_1.table_1 (6 documents)
2019-04-23T16:40:38.900+0545    done
*/

*To restore a single database you need to provide the path of the dump directory as part of the mongorestore command line.
C:\>cd "C:\MongoDB_Backup\dump"

C:\MongoDB_Backup\dump>mongorestore --db Mongodb_1 "C:\MongoDB_Backup\dump\Mongodb_1"
/*
2019-04-23T16:42:28.654+0545    the --db and --collection args should only be used when restoring from a BSON file. Other uses are deprecated and will not exist in the future; use --nsInclude instead
2019-04-23T16:42:28.658+0545    building a list of collections to restore from C:\MongoDB_Backup\dump\Mongodb_1 dir
2019-04-23T16:42:28.661+0545    reading metadata for Mongodb_1.post_data from C:\MongoDB_Backup\dump\Mongodb_1\post_data.metadata.json
2019-04-23T16:42:28.661+0545    reading metadata for Mongodb_1.table_1 from C:\MongoDB_Backup\dump\Mongodb_1\table_1.metadata.json
2019-04-23T16:42:28.662+0545    reading metadata for Mongodb_1.table_2 from C:\MongoDB_Backup\dump\Mongodb_1\table_2.metadata.json
2019-04-23T16:42:28.677+0545    restoring Mongodb_1.table_1 from C:\MongoDB_Backup\dump\Mongodb_1\table_1.bson
2019-04-23T16:42:28.677+0545    no indexes to restore
2019-04-23T16:42:28.677+0545    finished restoring Mongodb_1.table_1 (6 documents)
2019-04-23T16:42:29.685+0545    restoring Mongodb_1.post_data from C:\MongoDB_Backup\dump\Mongodb_1\post_data.bson
2019-04-23T16:42:29.698+0545    no indexes to restore
2019-04-23T16:42:29.698+0545    finished restoring Mongodb_1.post_data (2 documents)
2019-04-23T16:42:29.699+0545    restoring Mongodb_1.table_2 from C:\MongoDB_Backup\dump\Mongodb_1\table_2.bson
2019-04-23T16:42:29.707+0545    no indexes to restore
2019-04-23T16:42:29.707+0545    finished restoring Mongodb_1.table_2 (0 documents)
2019-04-23T16:42:29.709+0545    done
*/

*Restore the <<DATABASE_NAME>> database to a new database called <<DATABASE_NAME_NEW>>
C:\MongoDB_Backup\dump>cd dump

C:\MongoDB_Backup\dump\dump>mongorestore --db Mongodb_3 "C:\MongoDB_Backup\dump\dump\Mongodb_1"
/*
2019-04-23T16:44:42.802+0545    the --db and --collection args should only be used when restoring from a BSON file. Other uses are deprecated and will not exist in the future; use --nsInclude instead
2019-04-23T16:44:42.803+0545    building a list of collections to restore from C:\MongoDB_Backup\dump\dump\Mongodb_1 dir
2019-04-23T16:44:42.804+0545    reading metadata for Mongodb_3.table_1 from C:\MongoDB_Backup\dump\dump\Mongodb_1\table_1.metadata.json
2019-04-23T16:44:42.821+0545    restoring Mongodb_3.table_1 from C:\MongoDB_Backup\dump\dump\Mongodb_1\table_1.bson
2019-04-23T16:44:42.823+0545    no indexes to restore
2019-04-23T16:44:42.823+0545    finished restoring Mongodb_3.table_1 (6 documents)
2019-04-23T16:44:42.823+0545    done
*/

-- To Rename the existing Database
*Step - 1 (Verification the database)
> show dbs
/*
Mongodb_1  0.000GB
admin      0.000GB
config     0.000GB
local      0.000GB
*/
*Step - 2 (Copy The Database)
> db.copyDatabase("Mongodb_1","Mongodb_2")
> db.copyDatabase("Mongodb_1","Mongodb")
> db.copyDatabase("Mongodb_1","Mongodb_3")

*Step - 3 (Re-Verification of database)
> show dbs
/*
Mongodb    0.000GB
Mongodb_1  0.000GB
Mongodb_2  0.000GB
admin      0.000GB
config     0.000GB
local      0.000GB
*/
*Step - 4 (Re-Verification of database)
> db
/*
Mogodb
*/
*Step -5 (Switch to Droping Database)
> use Mongodb_3
/*
switched to db Mongodb
*/
*Step -6 (Drop the Database)
> db.dropDatabase()
/*
{ "dropped" : "Mongodb_3", "ok" : 1 }
*/


