-- Step 1. Stop MongoDB
[root@localhost ~]# systemctl stop mongod

-- Step 2. Remove Packages.
[root@localhost ~]# yum erase $(rpm -qa | grep mongodb-org)

-- Step 3. Remove Data Directories.
[root@localhost ~]# rm -rf /var/log/mongodb
[root@localhost ~]# rm -rf /var/lib/mongo
[root@localhost ~]# rm -rf /etc/yum.repos.d/mongodb.repo

-- Step 4.Remove SSL Files If Set
[root@localhost ~]# rm -rf /etc/ssl/certs/mongodb*
[root@localhost ~]# rm -rf /etc/mongod.conf.rpmsave