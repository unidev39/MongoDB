--Step 1 – Add MongoDB Yum Repository

[root@localhost ~]# vi /etc/yum.repos.d/mongodb.repo
/*
[MongoDB]
name=MongoDB Repository
baseurl=http://repo.mongodb.org/yum/redhat/$releasever/mongodb-org/4.0/x86_64/
gpgcheck=0
enabled=1
*/

--Step 2 – Install MongoDB Server
[root@localhost ~]# yum install mongodb-org

--Step 3 – Start MongoDB Service
[root@localhost ~]# systemctl enable mongod
[root@localhost ~]# systemctl start mongod
[root@localhost ~]# systemctl status mongod

--Configure MongoDB to autostart on system boot.
[root@localhost ~]# chkconfig mongod on
/*
Backup Config file
*/

-- Step 4
[root@centosmn etc]# cp -r /etc/mongod.conf /etc/mongod_bak.conf