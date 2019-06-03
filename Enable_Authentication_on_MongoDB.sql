-- Steps to Create and Drop Users in MongoDB
[root@localhost /]# mongo
> show dbs
/*
admin    0.000GB
config   0.000GB
local    0.000GB
*/

> use admin
/*
switched to db admin
*/
-- To create user with admin privileges in your MongoDB server.
> db.createUser(
...      {
...        user:"admin",
...        pwd:"Admin@P@55w0rd",
...        roles:[{role:"root",db:"admin"}]
...      }
... )
/*
Successfully added user: {
        "user" : "admin",
        "roles" : [
                {
                        "role" : "root",
                        "db" : "admin"
                }
        ]
}
*/

> db.getUsers()
/*
[
        {
                "_id" : "admin.admin",
                "userId" : UUID("fb8f44e9-54b9-4dcc-b08f-27d3537311e5"),
                "user" : "admin",
                "db" : "admin",
                "roles" : [
                        {
                                "role" : "root",
                                "db" : "admin"
                        }
                ],
                "mechanisms" : [
                        "SCRAM-SHA-1",
                        "SCRAM-SHA-256"
                ]
        }
]
*/
> db.auth('admin','Admin@P@55w0rd')
/*
1
*/

--To Add User for Database
/*
To create database specific users, that user will have access to that database only.
You can also specify access level for that user on database.
For example we are creating a user account with read write access on mydb database.
*/

> use chatbox
/*
switched to db mydb
*/

> db.createCollection("test")
/*
{ "ok" : 1 }
*/

> db.createUser(
...     {
...       user: "chatbox",
...       pwd:  "Ch@tB0x@P@55w0rd",
...       roles: ["readWrite"]
...     }
...  )
/*
Successfully added user: { "user" : "mongodbuser", "roles" : [ "readWrite" ] }
*/

> db.auth('chatbox','Ch@tB0x@P@55w0rd')
/*
1
*/

> db.getUsers()
/*
[
        {
                "_id" : "chatbox.chatbox",
                "userId" : UUID("9136a557-1271-44ee-bd67-b8c4ec0daa48"),
                "user" : "chatbox",
                "db" : "chatbox",
                "roles" : [
                        {
                                "role" : "readWrite",
                                "db" : "chatbox"
                        }
                ],
                "mechanisms" : [
                        "SCRAM-SHA-1",
                        "SCRAM-SHA-256"
                ]
        }
]
*/

> exit
/*
bye
*/

[root@localhost ~]# systemctl stop mongod
[root@localhost ~]# vi /etc/mongod.conf
/*
#security:
security.authorization: enabled
*/
[root@localhost ~]# systemctl start mongod
[root@localhost ~]# systemctl status mongod
sudo service mongodb restart
/*
? mongod.service - MongoDB Database Server
   Loaded: loaded (/usr/lib/systemd/system/mongod.service; enabled; vendor preset: disabled)
   Active: active (running) since Thu 2019-05-09 22:46:23 +0545; 7s ago
     Docs: https://docs.mongodb.org/manual
  Process: 12579 ExecStart=/usr/bin/mongod $OPTIONS (code=exited, status=0/SUCCESS)
  Process: 12577 ExecStartPre=/usr/bin/chmod 0755 /var/run/mongodb (code=exited, status=0/SUCCESS)
  Process: 12575 ExecStartPre=/usr/bin/chown mongod:mongod /var/run/mongodb (code=exited, status=0/SUCCESS)
  Process: 12574 ExecStartPre=/usr/bin/mkdir -p /var/run/mongodb (code=exited, status=0/SUCCESS)
 Main PID: 12582 (mongod)
   CGroup: /system.slice/mongod.service
           +-12582 /usr/bin/mongod -f /etc/mongod.conf

May 09 22:46:22 localhost.localdomain systemd[1]: Starting MongoDB Database Server...
May 09 22:46:22 localhost.localdomain mongod[12579]: about to fork child process, waiting until server is ready for connections.
May 09 22:46:22 localhost.localdomain mongod[12579]: forked process: 12582
May 09 22:46:23 localhost.localdomain systemd[1]: Started MongoDB Database Server.
*/
[root@localhost ~]#mongo --host 127.0.0.1 --port 27017 -u admin -p Admin@P@55w0rd
--or
[root@localhost ~]#mongo --host 127.0.0.1 --port 27017 -u admin -p Admin@P@55w0rd --authenticationDatabase admin
[root@localhost ~]#mongo --host 127.0.0.1 --port 27017 -u chatbox -p Ch@tB0x@P@55w0rd --authenticationDatabase chatbox

--Backup
[root@localhost ~]# mkdir -p /home/BackUpMongoDB/MongoFullBackup/dump/
[root@localhost ~]# mongodump --host 127.0.0.1 --port 27017 -u admin -p Admin@P@55w0rd --authenticationDatabase admin --out /home/BackUpMongoDB/MongoFullBackup/dump/
--Restore
--FullBackupRestore
[root@localhost ~]#mongorestore --host 127.0.0.1:27017 -u admin -p Admin@P@55w0rd --authenticationDatabase admin /home/BackUpMongoDB/MongoFullBackup/dump/
--ParticularBackupRestore
[root@localhost ~]#mongorestore --host 127.0.0.1:27017 -u admin -p Admin@P@55w0rd --authenticationDatabase admin -d chatbox /home/BackUpMongoDB/MongoFullBackup/dump/chatbox
