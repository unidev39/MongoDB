-- Steps to Create and Drop Users in MongoDB
[root@localhost /]# mongo
> show dbs
/*
admin   0.000GB
config  0.000GB
local   0.000GB
*/

> use admin
/*
switched to db admin
*/
-- To create user with admin privileges in your MongoDB server.
> db.createUser(
...      {
...        user:"adminuser",
...        pwd:"adminuser",
...        roles:[{role:"root",db:"admin"}]
...      }
... )
/*
Successfully added user: {
        "user" : "adminuser",
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
                "_id" : "admin.adminuser",
                "userId" : UUID("cbec3b17-f876-4f63-8350-809b54e69d13"),
                "user" : "adminuser",
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

> exit
/*
bye
*/

-- To connect with above credentials through command line.
[root@localhost /]# mongo -u adminuser -p  --authenticationDatabase admin

> show dbs
/*
admin      0.000GB
config     0.000GB
local      0.000GB
*/

> db.getUsers()
[ ]
>

--To Add User for Database
/*
To create database specific users, that user will have access to that database only.
You can also specify access level for that user on database.
For example we are creating a user account with read write access on mydb database.
*/

> use mydb
/*
switched to db mydb
*/

> db.createUser(
...     {
...       user: "mydbuser",
...       pwd: "mydbuser",
...       roles: ["readWrite"]
...     }
...  )
/*
Successfully added user: { "user" : "mydbuser", "roles" : [ "readWrite" ] }
*/

> db.auth('mydbuser','mydbuser')
/*
1
*/

> db.test.insert({c1:"test"})
/*
WriteResult({ "nInserted" : 1 })
*/

> show dbs
/*
admin      0.000GB
config     0.000GB
local      0.000GB
mydb       0.000GB
*/

> db.getUsers()
/*
[
        {
                "_id" : "mydb.mydbuser",
                "userId" : UUID("0219ccb6-6a78-4eae-93b4-420ee253ac65"),
                "user" : "mydbuser",
                "db" : "mydb",
                "roles" : [
                        {
                                "role" : "readWrite",
                                "db" : "mydb"
                        }
                ],
                "mechanisms" : [
                        "SCRAM-SHA-1",
                        "SCRAM-SHA-256"
                ]
        }
]
*/

> db.dropUser('mydbuser')
/*
true
*/


--------------------------------------
--Enable_Authentication_on_MongoDB with admin user
[root@localhost ~]#mongo --ssl --sslCAFile /etc/ssl/mongossl/cert.pem --sslPEMKeyFile /etc/ssl/mongossl/mongodb.pem --host localhost_ssl --port 27017 -u admin -p Admin@P@55w0rd --authenticationDatabase admin
> use admin
> db.createUser(
         {
           user:"User",
           pwd:"User@P@55w0rd",
           roles:[{role:"readWrite",db:"mydb"}]
         }
    )

--Enable_Authentication_on_MongoDB with User of databasde mydb
[root@localhost ~]#mongo --ssl --sslCAFile /etc/ssl/mongossl/cert.pem --sslPEMKeyFile /etc/ssl/mongossl/mongodb.pem --host localhost_ssl --port 27017 -u User -p User@P@55w0rd --authenticationDatabase admin


--Enable_Authentication_on_MongoDB with admin user
[root@localhost ~]#mongo --ssl --sslCAFile /etc/ssl/mongossl/cert.pem --sslPEMKeyFile /etc/ssl/mongossl/mongodb.pem --host localhost_ssl --port 27017 -u admin -p Admin@P@55w0rd --authenticationDatabase admin

> use admin
> db.createUser(
         {
           user:"User1",
           pwd:"User1@P@55w0rd",
           roles:[
                  {role:"readWrite",db:"mydb"},
                  {role:"readWrite",db:"chatbox"}
                 ]
         }
    )
--Enable_Authentication_on_MongoDB with User user1
[root@localhost ~]#mongo --ssl --sslCAFile /etc/ssl/mongossl/cert.pem --sslPEMKeyFile /etc/ssl/mongossl/mongodb.pem --host localhost_ssl --port 27017 -u User1 -p User1@P@55w0rd --authenticationDatabase admin

