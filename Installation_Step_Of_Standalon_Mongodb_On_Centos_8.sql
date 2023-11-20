--------------------------------------------------------------------------
----------------------------root/P@ssw0rd---------------------------------
--------------------------------------------------------------------------
-- 1 Node on VM
[root@mongodb ~]# df -Th
/*
Filesystem                  Type      Size  Used Avail Use% Mounted on
devtmpfs                    devtmpfs  844M     0  844M   0% /dev
tmpfs                       tmpfs     874M     0  874M   0% /dev/shm
tmpfs                       tmpfs     874M  9.5M  865M   2% /run
tmpfs                       tmpfs     874M     0  874M   0% /sys/fs/cgroup
/dev/mapper/cs_mongodb-root xfs        30G  500M   30G   2% /
/dev/mapper/cs_mongodb-usr  xfs        10G  7.9G  2.2G  79% /usr
/dev/mapper/cs_mongodb-tmp  xfs        10G  104M  9.9G   2% /tmp
/dev/mapper/cs_mongodb-data xfs        16G  147M   16G   1% /data
/dev/mapper/cs_mongodb-home xfs        10G  104M  9.9G   2% /home
/dev/sda1                   xfs      1014M  278M  737M  28% /boot
/dev/mapper/cs_mongodb-var  xfs        10G  543M  9.5G   6% /var
tmpfs                       tmpfs     175M   24K  175M   1% /run/user/0
/dev/sr0                    iso9660    12G   12G     0 100% /run/media/root/CentOS-Stream-8-BaseOS-x86_64
*/

-- 1 Node on VM
[root@mongodb ~]# cat /etc/os-release
/* 
NAME="CentOS Stream"
VERSION="8"
ID="centos"
ID_LIKE="rhel fedora"
VERSION_ID="8"
PLATFORM_ID="platform:el8"
PRETTY_NAME="CentOS Stream 8"
ANSI_COLOR="0;31"
CPE_NAME="cpe:/o:centos:centos:8"
HOME_URL="https://centos.org/"
BUG_REPORT_URL="https://bugzilla.redhat.com/"
REDHAT_SUPPORT_PRODUCT="Red Hat Enterprise Linux 8"
REDHAT_SUPPORT_PRODUCT_VERSION="CentOS Stream"
*/

-- Step 1 -->> On Node 1
[root@mongodb ~]# vi /etc/hosts
/*
127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
::1         localhost localhost.localdomain localhost6 localhost6.localdomain6

# Public
192.168.56.148 mongodb.deveshnepal.org.np mongodb
*/

-- Step 2 -->> On Node 1
-- Disable secure linux by editing the "/etc/selinux/config" file, making sure the SELINUX flag is set as follows.
[root@mongodb ~]# vi /etc/selinux/config
/*
# This file controls the state of SELinux on the system.
# SELINUX= can take one of these three values:
#     enforcing - SELinux security policy is enforced.
#     permissive - SELinux prints warnings instead of enforcing.
#     disabled - No SELinux policy is loaded.
#SELINUX=enforcing
SELINUX=disabled
# SELINUXTYPE= can take one of these three values:
#     targeted - Targeted processes are protected,
#     minimum - Modification of targeted policy. Only selected processes are protected. 
#     mls - Multi Level Security protection.
SELINUXTYPE=targeted
*/

-- Step 3 -->> On Node 1
[root@mongodb ~]# vi /etc/sysconfig/network
/*
NETWORKING=yes
HOSTNAME=mongodb.deveshnepal.org.np
*/

-- Step 4 -->> On Node 1
[root@mongodb ~]# nmtui
--OR--
[root@mongodb ~]# vi /etc/sysconfig/network-scripts/ifcfg-ens33
/*
TYPE=Ethernet
BOOTPROTO=static
DEFROUTE=yes
NAME=ens33
DEVICE=ens33
ONBOOT=yes
IPADDR=192.168.56.148
NETMASK=255.255.255.0
GATEWAY=192.168.56.2
DNS1=192.168.56.2
DNS2=8.8.8.8
*/

-- Step 5 -->> On Node 1
[root@mongodb ~]# systemctl restart network-online.target

-- Step 6 -->> On Node 1
[root@mongodb ~]# cat /etc/hostname
/*
mongodb.deveshnepal.org.np
*/

-- Step 6.1 -->> On Node 1
[root@mongodb ~]# hostnamectl | grep hostname
/*
 Static hostname: mongodb.deveshnepal.org.np
*/

-- Step 6.2 -->> On Node 1
[root@mongodb ~]# hostnamectl --static
/*
mongodb.deveshnepal.org.np
*/

-- Step 6.3 -->> On Node 1
[root@mongodb ~]# hostnamectl
/*
   Static hostname: mongodb.deveshnepal.org.np
         Icon name: computer-vm
           Chassis: vm
        Machine ID: cbaf309dd0cb4d9dbfdb4688b4515eb6
           Boot ID: 5bea36340170496384da9f241d63faef
    Virtualization: vmware
  Operating System: CentOS Stream 8
       CPE OS Name: cpe:/o:centos:centos:8
            Kernel: Linux 4.18.0-500.el8.x86_64
      Architecture: x86-64
*/

-- Step 7 -->> On Node 1
[root@mongodb ~]# systemctl stop firewalld
[root@mongodb ~]# systemctl disable firewalld
/*
Removed "/etc/systemd/system/multi-user.target.wants/firewalld.service".
Removed "/etc/systemd/system/dbus-org.fedoraproject.FirewallD1.service".
*/

-- Step 8 -->> On Node 1
[root@mongodb ~]# iptables -F
[root@mongodb ~]# iptables -X
[root@mongodb ~]# iptables -t nat -F
[root@mongodb ~]# iptables -t nat -X
[root@mongodb ~]# iptables -t mangle -F
[root@mongodb ~]# iptables -t mangle -X
[root@mongodb ~]# iptables -P INPUT ACCEPT
[root@mongodb ~]# iptables -P FORWARD ACCEPT
[root@mongodb ~]# iptables -P OUTPUT ACCEPT
[root@mongodb ~]# iptables -L -nv
/*
Chain INPUT (policy ACCEPT 13 packets, 1372 bytes)
 pkts bytes target     prot opt in     out     source               destination

Chain FORWARD (policy ACCEPT 0 packets, 0 bytes)
 pkts bytes target     prot opt in     out     source               destination

Chain OUTPUT (policy ACCEPT 4 packets, 468 bytes)
 pkts bytes target     prot opt in     out     source               destination
*/

-- Step 9 -->> On Node 1
--To Remove virbr0 and lxcbr0 Network Interfac
[root@mongodb ~]# systemctl stop libvirtd.service
[root@mongodb ~]# systemctl disable libvirtd.service
[root@mongodb ~]# virsh net-list
[root@mongodb ~]# virsh net-destroy default

-- Step 10 -->> On Node 1
[root@mongodb ~]# ifconfig
/*
ens33: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 192.168.56.148  netmask 255.255.255.0  broadcast 192.168.56.255
        inet6 fe80::20c:29ff:fecf:788  prefixlen 64  scopeid 0x20<link>
        ether 00:0c:29:cf:07:88  txqueuelen 1000  (Ethernet)
        RX packets 62  bytes 22625 (22.0 KiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 104  bytes 12065 (11.7 KiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
        inet 127.0.0.1  netmask 255.0.0.0
        inet6 ::1  prefixlen 128  scopeid 0x10<host>
        loop  txqueuelen 1000  (Local Loopback)
        RX packets 16  bytes 960 (960.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 16  bytes 960 (960.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
*/


-- Step 11 -->> On Node 1
[root@mongodb ~]# init 6

-- Step 12 -->> On Node 1
[root@mongodb ~]# firewall-cmd --list-all
/*
FirewallD is not running
*/

-- Step 13 -->> On Node 1
[root@mongodb ~]# systemctl status firewalld
/*
● firewalld.service - firewalld - dynamic firewall daemon
   Loaded: loaded (/usr/lib/systemd/system/firewalld.service; disabled; vendor preset: enabled)
   Active: inactive (dead)
     Docs: man:firewalld(1)
*/

-- Step 14 -->> On Node 1
[root@mongodb ~]# cd /run/media/root/CentOS-Stream-8-BaseOS-x86_64/AppStream/Packages
[root@mongodb ~]# yum -y update

-- Step 15 -->> On Node 1
[root@mongodb ~]# usermod -aG wheel mongodb
[root@mongodb ~]# usermod -aG root mongodb

-- Step 16 -->> On Node 1
[root@mongodb ~]# cd /etc/yum.repos.d/
[root@mongodb yum.repos.d]# ll
/*
-rw-r--r--. 1 root root  713 Mar 28  2022 CentOS-Stream-AppStream.repo
-rw-r--r--. 1 root root  698 Mar 28  2022 CentOS-Stream-BaseOS.repo
-rw-r--r--. 1 root root  316 Mar 28  2022 CentOS-Stream-Debuginfo.repo
-rw-r--r--. 1 root root  744 Mar 28  2022 CentOS-Stream-Extras-common.repo
-rw-r--r--. 1 root root  700 Mar 28  2022 CentOS-Stream-Extras.repo
-rw-r--r--. 1 root root  734 Mar 28  2022 CentOS-Stream-HighAvailability.repo
-rw-r--r--. 1 root root  696 Mar 28  2022 CentOS-Stream-Media.repo
-rw-r--r--. 1 root root  683 Mar 28  2022 CentOS-Stream-NFV.repo
-rw-r--r--. 1 root root  718 Mar 28  2022 CentOS-Stream-PowerTools.repo
-rw-r--r--. 1 root root  690 Mar 28  2022 CentOS-Stream-RealTime.repo
-rw-r--r--. 1 root root  748 Mar 28  2022 CentOS-Stream-ResilientStorage.repo
-rw-r--r--. 1 root root 1771 Mar 28  2022 CentOS-Stream-Sources.repo
*/

-- Step 17 -->> On Node 1
[root@mongodb yum.repos.d]# vi /etc/yum.repos.d/mongodb-org.repo
/*
[mongodb-org-7.0]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/8/mongodb-org/7.0/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-7.0.asc
*/ 

-- Step 18 -->> On Node 1
[root@mongodb yum.repos.d]# ll | grep mongo
/*
-rw-r--r--  1 root root  200 Nov  7 15:30 mongodb-org.repo
*/
[root@mongodb yum.repos.d]# yum repolist
/*
repo id                                                                           repo name
appstream                                                                         CentOS Stream 8 - AppStream
baseos                                                                            CentOS Stream 8 - BaseOS
extras                                                                            CentOS Stream 8 - Extras
extras-common                                                                     CentOS Stream 8 - Extras common packages
mongodb-org-7.0                                                                   MongoDB Repository
*/

-- Step 19 -->> On Node 1
[root@mongodb ~]# yum install -y mongodb-org
/*
MongoDB Repository                                                                                                                                            12 kB/s |  16 kB     00:01
Dependencies resolved.
=============================================================================================================================================================================================
 Package                                                      Architecture                       Version                                   Repository                                   Size
=============================================================================================================================================================================================
Installing:
 mongodb-org                                                  x86_64                             7.0.2-1.el8                               mongodb-org-7.0                             9.5 k
Installing dependencies:
 mongodb-database-tools                                       x86_64                             100.9.0-1                                 mongodb-org-7.0                              52 M
 mongodb-mongosh                                              x86_64                             2.0.2-1.el8                               mongodb-org-7.0                              50 M
 mongodb-org-database                                         x86_64                             7.0.2-1.el8                               mongodb-org-7.0                             9.6 k
 mongodb-org-database-tools-extra                             x86_64                             7.0.2-1.el8                               mongodb-org-7.0                              15 k
 mongodb-org-mongos                                           x86_64                             7.0.2-1.el8                               mongodb-org-7.0                              25 M
 mongodb-org-server                                           x86_64                             7.0.2-1.el8                               mongodb-org-7.0                              36 M
 mongodb-org-tools                                            x86_64                             7.0.2-1.el8                               mongodb-org-7.0                             9.5 k

Transaction Summary
=============================================================================================================================================================================================
Install  8 Packages

Total download size: 163 M
Installed size: 623 M
Downloading Packages:
(1/8): mongodb-org-7.0.2-1.el8.x86_64.rpm                                                                                                                     22 kB/s | 9.5 kB     00:00
(2/8): mongodb-org-database-7.0.2-1.el8.x86_64.rpm                                                                                                            36 kB/s | 9.6 kB     00:00
(3/8): mongodb-org-database-tools-extra-7.0.2-1.el8.x86_64.rpm                                                                                                24 kB/s |  15 kB     00:00
(4/8): mongodb-org-mongos-7.0.2-1.el8.x86_64.rpm                                                                                                             1.6 MB/s |  25 MB     00:15
(5/8): mongodb-database-tools-100.9.0.x86_64.rpm                                                                                                             2.9 MB/s |  52 MB     00:18
(6/8): mongodb-org-tools-7.0.2-1.el8.x86_64.rpm                                                                                                               34 kB/s | 9.5 kB     00:00
(7/8): mongodb-mongosh-2.0.2.x86_64.rpm                                                                                                                      2.4 MB/s |  50 MB     00:20
(8/8): mongodb-org-server-7.0.2-1.el8.x86_64.rpm                                                                                                             4.3 MB/s |  36 MB     00:08
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Total                                                                                                                                                        6.5 MB/s | 163 MB     00:25
MongoDB Repository                                                                                                                                           674  B/s | 1.6 kB     00:02
Importing GPG key 0x1785BA38:
 Userid     : "MongoDB 7.0 Release Signing Key <packaging@mongodb.com>"
 Fingerprint: E588 3020 1F7D D82C D808 AA84 160D 26BB 1785 BA38
 From       : https://www.mongodb.org/static/pgp/server-7.0.asc
Key imported successfully
Running transaction check
Transaction check succeeded.
Running transaction test
Transaction test succeeded.
Running transaction
  Preparing        :                                                                                                                                                                     1/1
  Installing       : mongodb-org-database-tools-extra-7.0.2-1.el8.x86_64                                                                                                                 1/8
  Running scriptlet: mongodb-org-server-7.0.2-1.el8.x86_64                                                                                                                               2/8
  Installing       : mongodb-org-server-7.0.2-1.el8.x86_64                                                                                                                               2/8
  Running scriptlet: mongodb-org-server-7.0.2-1.el8.x86_64                                                                                                                               2/8
Created symlink /etc/systemd/system/multi-user.target.wants/mongod.service → /usr/lib/systemd/system/mongod.service.

  Installing       : mongodb-org-mongos-7.0.2-1.el8.x86_64                                                                                                                               3/8
  Installing       : mongodb-org-database-7.0.2-1.el8.x86_64                                                                                                                             4/8
  Installing       : mongodb-mongosh-2.0.2-1.el8.x86_64                                                                                                                                  5/8
  Running scriptlet: mongodb-database-tools-100.9.0-1.x86_64                                                                                                                             6/8
  Installing       : mongodb-database-tools-100.9.0-1.x86_64                                                                                                                             6/8
  Running scriptlet: mongodb-database-tools-100.9.0-1.x86_64                                                                                                                             6/8
  Installing       : mongodb-org-tools-7.0.2-1.el8.x86_64                                                                                                                                7/8
  Installing       : mongodb-org-7.0.2-1.el8.x86_64                                                                                                                                      8/8
  Running scriptlet: mongodb-org-7.0.2-1.el8.x86_64                                                                                                                                      8/8
/sbin/ldconfig: /usr/lib64/llvm15/lib/libclang.so.15 is not a symbolic link


  Verifying        : mongodb-database-tools-100.9.0-1.x86_64                                                                                                                             1/8
  Verifying        : mongodb-mongosh-2.0.2-1.el8.x86_64                                                                                                                                  2/8
  Verifying        : mongodb-org-7.0.2-1.el8.x86_64                                                                                                                                      3/8
  Verifying        : mongodb-org-database-7.0.2-1.el8.x86_64                                                                                                                             4/8
  Verifying        : mongodb-org-database-tools-extra-7.0.2-1.el8.x86_64                                                                                                                 5/8
  Verifying        : mongodb-org-mongos-7.0.2-1.el8.x86_64                                                                                                                               6/8
  Verifying        : mongodb-org-server-7.0.2-1.el8.x86_64                                                                                                                               7/8
  Verifying        : mongodb-org-tools-7.0.2-1.el8.x86_64                                                                                                                                8/8

Installed:
  mongodb-database-tools-100.9.0-1.x86_64                  mongodb-mongosh-2.0.2-1.el8.x86_64         mongodb-org-7.0.2-1.el8.x86_64             mongodb-org-database-7.0.2-1.el8.x86_64
  mongodb-org-database-tools-extra-7.0.2-1.el8.x86_64      mongodb-org-mongos-7.0.2-1.el8.x86_64      mongodb-org-server-7.0.2-1.el8.x86_64      mongodb-org-tools-7.0.2-1.el8.x86_64

Complete!
*/

-- Step 20 -->> On Node 1
[root@mongodb ~]# ll /var/lib/ | grep mongo
/*
drwxr-xr-x   2 mongod         mongod            6 Oct  6 01:52 mongo
*/

-- Step 21 -->> On Node 1 (Create a MongoDB Data and Log directory)
[root@mongodb ~]# mkdir -p /data/mongodb
[root@mongodb ~]# mkdir -p /data/log
[root@mongodb ~]# chown -R mongod:mongod /data/
[root@mongodb ~]# chown -R mongod:mongod /data
[root@mongodb ~]# chmod -R 777 /data/
[root@mongodb ~]# chmod -R 777 /data
[root@mongodb ~]# ll / | grep data
/*
drwxrwxrwx.   3 mongod mongod    21 Nov  7 13:36 data
*/

-- Step 22 -->> On Node 1
[root@mongodb ~]# ll /data/
/*
drwxrwxrwx 2 mongod mongod 6 Nov  7 13:41 log
drwxrwxrwx 2 mongod mongod 6 Nov  7 13:36 mongodb
*/

-- Step 23 -->> On Node 1
[root@mongodb ~]# cp -r /etc/mongod.conf /etc/mongod.conf.backup
[root@mongodb ~]# ll /etc/mongod*
/*
-rw-r--r-- 1 root root 721 Oct  6 01:52 /etc/mongod.conf
-rw-r--r-- 1 root root 721 Nov  7 15:33 /etc/mongod.conf.backup
*/

-- Step 24 -->> On Node 1
[root@mongodb ~]# vi /etc/mongod.conf
/*
# mongod.conf

# for documentation of all options, see:
#   http://docs.mongodb.org/manual/reference/configuration-options/

# where to write logging data.
systemLog:
  destination: file
  logAppend: true
  path: /data/log/mongod.log

# Where and how to store data.
storage:
  dbPath: /data/mongodb

# how the process runs
processManagement:
  timeZoneInfo: /usr/share/zoneinfo

# network interfaces
net:
  port: 27017
  bindIp: 127.0.0.1,192.168.56.148  # Enter 0.0.0.0,:: to bind to all IPv4 and IPv6 addresses or, alternatively, use the net.bindIpAll setting.


#security:

#operationProfiling:

#replication:

#sharding:

## Enterprise-Only Options

#auditLog:
*/

-- Step 25 -->> On Node 1 (Tuning For MongoDB)
[root@mongodb ~]# vi /etc/mongod.conf
/*
# network interfaces
net:
  port: 27017
  bindIp: 127.0.0.1,192.168.56.148
  maxIncomingConnections: 999999
*/

-- Step 25.1 -->> On Node 1
[root@mongodb ~]# ulimit -a
/*
core file size          (blocks, -c) 0
data seg size           (kbytes, -d) unlimited
scheduling priority             (-e) 0
file size               (blocks, -f) unlimited
pending signals                 (-i) 6750
max locked memory       (kbytes, -l) 64
max memory size         (kbytes, -m) unlimited
open files                      (-n) 1024
pipe size            (512 bytes, -p) 8
POSIX message queues     (bytes, -q) 819200
real-time priority              (-r) 0
stack size              (kbytes, -s) 8192
cpu time               (seconds, -t) unlimited
max user processes              (-u) 6750
virtual memory          (kbytes, -v) unlimited
file locks                      (-x) unlimi
*/

-- Step 25.2 -->> On Node 1
[root@mongodb ~]# ulimit -n 64000
[root@mongodb ~]# ulimit -a
/*
core file size          (blocks, -c) 0
data seg size           (kbytes, -d) unlimited
scheduling priority             (-e) 0
file size               (blocks, -f) unlimited
pending signals                 (-i) 6750
max locked memory       (kbytes, -l) 64
max memory size         (kbytes, -m) unlimited
open files                      (-n) 64000
pipe size            (512 bytes, -p) 8
POSIX message queues     (bytes, -q) 819200
real-time priority              (-r) 0
stack size              (kbytes, -s) 8192
cpu time               (seconds, -t) unlimited
max user processes              (-u) 6750
virtual memory          (kbytes, -v) unlimited
file locks                      (-x) unlimited
*/

-- Step 25.3 -->> On Node 1
[root@mongodb ~]# cat /etc/group | grep mongo
/*
root:x:0:mongodb
wheel:x:10:mongodb
mongodb:x:1000:
mongod:x:969:
*/

-- Step 25.4 -->> On Node 1
[root@mongodb ~]# echo "mongod           soft    nofile          9999999" | tee -a /etc/security/limits.conf
[root@mongodb ~]# echo "mongod           hard    nofile          9999999" | tee -a /etc/security/limits.conf
[root@mongodb ~]# echo "mongod           soft    nproc           9999999" | tee -a /etc/security/limits.conf
[root@mongodb ~]# echo "mongod           hard    nproc           9999999" | tee -a /etc/security/limits.conf
[root@mongodb ~]# echo "mongod           soft    stack           9999999" | tee -a /etc/security/limits.conf
[root@mongodb ~]# echo "mongod           hard    stack           9999999" | tee -a /etc/security/limits.conf
[root@mongodb ~]# echo 9999999 > /proc/sys/vm/max_map_count
[root@mongodb ~]# echo "vm.max_map_count=9999999" | tee -a /etc/sysctl.conf
[root@mongodb ~]# echo 1024 65530 > /proc/sys/net/ipv4/ip_local_port_range
[root@mongodb ~]# echo "net.ipv4.ip_local_port_range = 1024 65530" | tee -a /etc/sysctl.conf

-- Step 25.5 -->> On Node 1
[root@mongodb ~]# systemctl enable mongod --now
[root@mongodb ~]# systemctl start mongod
[root@mongodb ~]# systemctl status mongod
/*
● mongod.service - MongoDB Database Server
   Loaded: loaded (/usr/lib/systemd/system/mongod.service; enabled; vendor preset: disabled)
   Active: active (running) since Tue 2023-11-07 17:04:06 +0545; 10s ago
     Docs: https://docs.mongodb.org/manual
 Main PID: 6575 (mongod)
   Memory: 172.3M
   CGroup: /system.slice/mongod.service
           └─6575 /usr/bin/mongod -f /etc/mongod.conf

Nov 07 17:04:06 mongodb.deveshnepal.org.np systemd[1]: mongod.service: Succeeded.
Nov 07 17:04:06 mongodb.deveshnepal.org.np systemd[1]: Stopped MongoDB Database Server.
Nov 07 17:04:06 mongodb.deveshnepal.org.np systemd[1]: Started MongoDB Database Server.
Nov 07 17:04:06 mongodb.deveshnepal.org.np mongod[6575]: {"t":{"$date":"2023-11-07T11:19:06.088Z"},"s":"I",  "c":"CONTROL",  "id":7484500, "ctx":"main","msg":"Environment variable MONGODB_CON>
*/

-- Step 26 -->> On Node 1
[root@mongodb ~]# mongosh
/*
Current Mongosh Log ID: 654a1d7a758de2b5c1ee51b9
Connecting to:          mongodb://127.0.0.1:27017/?directConnection=true&serverSelectionTimeoutMS=2000&appName=mongosh+2.0.2
Using MongoDB:          7.0.2
Using Mongosh:          2.0.2

For mongosh info see: https://docs.mongodb.com/mongodb-shell/


To help improve our products, anonymous usage data is collected and sent to MongoDB periodically (https://www.mongodb.com/legal/privacy-policy).
You can opt-out by running the disableTelemetry() command.

------
   The server generated these startup warnings when booting
   2023-11-07T17:04:06.974+05:45: Access control is not enabled for the database. Read and write access to data and configuration is unrestricted
   2023-11-07T17:04:06.974+05:45: /sys/kernel/mm/transparent_hugepage/enabled is 'always'. We suggest setting it to 'never'
------

test> db.version()
7.0.2
test> show databases;
admin   40.00 KiB
config  12.00 KiB
local   72.00 KiB
test> quit()
*/

-- Step 27 -->> On Node 1
[root@mongodb ~]# systemctl stop mongod

-- Step 28 -->> On Node 1
[root@mongodb ~]# which mongosh
/*
/usr/bin/mongosh
*/

-- Step 28.1 -->> On Node 1 (After MongoDB Version 4.4 the "mongo" shell is not avilable)
[root@mongodb ~]# cd /usr/bin/
[root@mongodb bin]# ll | grep mongo
/*
-rwxr-xr-x  1 root root    181975272 Oct 31 05:37 mongod
-rwxr-xr-x  1 root root     16188168 Nov  9 00:51 mongodump
-rwxr-xr-x  1 root root     15879296 Nov  9 00:51 mongoexport
-rwxr-xr-x  1 root root     16727968 Nov  9 00:51 mongofiles
-rwxr-xr-x  1 root root     16130728 Nov  9 00:51 mongoimport
-rwxr-xr-x  1 root root     16519168 Nov  9 00:51 mongorestore
-rwxr-xr-x  1 root root    129588096 Oct 31 05:37 mongos
-rwxr-xr-x  1 root root    106614784 Oct 14 18:09 mongosh
-rwxr-xr-x  1 root root     15748432 Nov  9 00:51 mongostat
-rwxr-xr-x  1 root root     15319736 Nov  9 00:51 mongotop
*/

-- Step 28.2 -->> On Node 1
[root@mongodb bin]# cp mongosh mongo
[root@mongodb bin]# ll | grep mongo
/*
-rwxr-xr-x  1 root root    106614784 Nov 14 15:22 mongo
-rwxr-xr-x  1 root root    181975272 Oct 31 05:37 mongod
-rwxr-xr-x  1 root root     16188168 Nov  9 00:51 mongodump
-rwxr-xr-x  1 root root     15879296 Nov  9 00:51 mongoexport
-rwxr-xr-x  1 root root     16727968 Nov  9 00:51 mongofiles
-rwxr-xr-x  1 root root     16130728 Nov  9 00:51 mongoimport
-rwxr-xr-x  1 root root     16519168 Nov  9 00:51 mongorestore
-rwxr-xr-x  1 root root    129588096 Oct 31 05:37 mongos
-rwxr-xr-x  1 root root    106614784 Oct 14 18:09 mongosh
-rwxr-xr-x  1 root root     15748432 Nov  9 00:51 mongostat
-rwxr-xr-x  1 root root     15319736 Nov  9 00:51 mongotop
*/

-- Step 28.3 -->> On Node 1
[root@mongodb ~]# systemctl start mongod
[root@mongodb bin]# systemctl status mongod
/*
● mongod.service - MongoDB Database Server
   Loaded: loaded (/usr/lib/systemd/system/mongod.service; enabled; vendor preset: disabled)
   Active: active (running) since Tue 2023-11-07 17:17:52 +0545; 2min 18s ago
     Docs: https://docs.mongodb.org/manual
 Main PID: 7290 (mongod)
   Memory: 179.9M
   CGroup: /system.slice/mongod.service
           └─7290 /usr/bin/mongod -f /etc/mongod.conf

Nov 07 17:17:52 mongodb.deveshnepal.org.np systemd[1]: Started MongoDB Database Server.
Nov 07 17:17:52 mongodb.deveshnepal.org.np mongod[7290]: {"t":{"$date":"2023-11-07T11:32:52.094Z"},"s":"I",  "c":"CONTROL",  "id":7484500, "ctx":"main","msg":"Environment variable MONGODB_CON>
*/

-- Step 29 -->> On Node 1
[root@mongodb ~]# mongosh
/*
Current Mongosh Log ID: 654a211b80e53c4c33d7322e
Connecting to:    mongodb://127.0.0.1:27017/?directConnection=true&serverSelectionTimeoutMS=2000&appName=mongosh+2.0.2
Using MongoDB:    7.0.2
Using Mongosh:    2.0.2

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

------
   The server generated these startup warnings when booting
   2023-11-07T17:17:52.857+05:45: Access control is not enabled for the database. Read and write access to data and configuration is unrestricted
   2023-11-07T17:17:52.857+05:45: /sys/kernel/mm/transparent_hugepage/enabled is 'always'. We suggest setting it to 'never'
------

test> db.version()
7.0.2
test> show databases;
admin   40.00 KiB
config  12.00 KiB
local   72.00 KiB
test> quit()
*/

-- Step 30 -->> On Node 1
[root@mongodb ~]# mongo
/*
Current Mongosh Log ID: 654a2134c8d13fba128d4e93
Connecting to:    mongodb://127.0.0.1:27017/?directConnection=true&serverSelectionTimeoutMS=2000&appName=mongosh+2.0.2
Using MongoDB:    7.0.2
Using Mongosh:    2.0.2

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

------
   The server generated these startup warnings when booting
   2023-11-07T17:17:52.857+05:45: Access control is not enabled for the database. Read and write access to data and configuration is unrestricted
   2023-11-07T17:17:52.857+05:45: /sys/kernel/mm/transparent_hugepage/enabled is 'always'. We suggest setting it to 'never'
------

test> db.version()
7.0.2
test> show databases;
admin   40.00 KiB
config  12.00 KiB
local   72.00 KiB
test> quit()
*/

-- Step 31 -->> On Node 1 (Fixing The MongoDB Warnings - /sys/kernel/mm/transparent_hugepage/enabled is 'always'. We suggest setting it to 'never')
[root@mongodb ~]# vi /etc/systemd/system/disable-mogodb-warnig.service
/*
[Unit]
Description=Disable Transparent Huge Pages (THP)
[Service]
Type=simple
ExecStart=/bin/sh -c "echo 'never' > /sys/kernel/mm/transparent_hugepage/enabled && echo 'never' > /sys/kernel/mm/transparent_hugepage/defrag"
[Install]
WantedBy=multi-user.target
*/

-- Step 31.1 -->> On Node 1
[root@mongodb ~]# systemctl daemon-reload
-- Step 31.2 -->> On Node 1
[root@mongodb ~]# systemctl start disable-mogodb-warnig.service
-- Step 31.3 -->> On Node 1
[root@mongodb ~]# systemctl enable disable-mogodb-warnig.service
/*
Created symlink /etc/systemd/system/multi-user.target.wants/disable-mogodb-warnig.service → /etc/systemd/system/disable-mogodb-warnig.service.
*/

-- Step 31.4 -->> On Node 1
[root@mongodb ~]# systemctl restart mongod
-- Step 31.5 -->> On Node 1
[root@mongodb ~]# systemctl status mongod
/*
● mongod.service - MongoDB Database Server
   Loaded: loaded (/usr/lib/systemd/system/mongod.service; enabled; vendor preset: disabled)
   Active: active (running) since Tue 2023-11-14 16:28:15 +0545; 4s ago
     Docs: https://docs.mongodb.org/manual
 Main PID: 5135 (mongod)
   Memory: 169.0M
   CGroup: /system.slice/mongod.service
           └─5135 /usr/bin/mongod -f /etc/mongod.conf

Nov 14 16:28:15 mongodb.deveshnepal.org.np systemd[1]: mongod.service: Succeeded.
Nov 14 16:28:15 mongodb.deveshnepal.org.np systemd[1]: Stopped MongoDB Database Server.
Nov 14 16:28:15 mongodb.deveshnepal.org.np systemd[1]: Started MongoDB Database Server.
Nov 14 16:28:15 mongodb.deveshnepal.org.np mongod[5135]: {"t":{"$date":"2023-11-14T10:43:15.781Z"},"s":"I",  "c":"CONTROL",  "id":7484500, "ctx":"main","msg":"Environment variable MONGODB_CON>
*/

-- Step 32 -->> On Node 1
[mongodb@mongodb ~]$ mongo
/*
Current Mongosh Log ID: 654b52fe4a30e1ccdf4e1f55
Connecting to:          mongodb://127.0.0.1:27017/?directConnection=true&serverSelectionTimeoutMS=2000&appName=mongosh+2.0.2
Using MongoDB:          7.0.2
Using Mongosh:          2.0.2

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

------
   The server generated these startup warnings when booting
   2023-11-08T14:38:40.274+05:45: Access control is not enabled for the database. Read and write access to data and configuration is unrestricted
------

test> show databases
admin   40.00 KiB
config  72.00 KiB
local   72.00 KiB

test> use admin
switched to db admin

admin> db
admin

admin> db.getUsers()
{ users: [], ok: 1 }

admin> db.createUser(
... {
... user:"admin",
... pwd:"P#ssw0rD",
... roles:[{role:"root",db:"admin"}]
... }
... )
{ ok: 1 }

admin> db.getUsers()
{
  users: [
    {
      _id: 'admin.admin',
      userId: new UUID("89b7f0a0-6ddb-4a87-a144-530a5b1cfd7b"),
      user: 'admin',
      db: 'admin',
      roles: [ { role: 'root', db: 'admin' } ],
      mechanisms: [ 'SCRAM-SHA-1', 'SCRAM-SHA-256' ]
    }
  ],
  ok: 1
}

admin> db.auth('admin','P#ssw0rd');
{ ok: 1 }


admin> use devesh
switched to db devesh

devesh> db
devesh

devesh> db.createCollection('tbl_devesh')
{ ok: 1 }

devesh> show collections
tbl_devesh

devesh> db.getCollectionNames()
[ 'tbl_devesh' ]


devesh> db.createUser(
... {
... user:"devesh",
... pwd:"deveshP#ssw0rD",
... roles:["readWrite"]
... }
... )
{ ok: 1 }

devesh> db.auth('devesh','deveshP#ssw0rD')
{ ok: 1 }

devesh> db.getUsers()
{
  users: [
    {
      _id: 'devesh.devesh',
      userId: new UUID("a3c9a0b2-c534-40a7-98f6-5505eb2e0076"),
      user: 'devesh',
      db: 'devesh',
      roles: [ { role: 'readWrite', db: 'devesh' } ],
      mechanisms: [ 'SCRAM-SHA-1', 'SCRAM-SHA-256' ]
    }
  ],
  ok: 1
}

devesh> quit()
*/

-- Step 33 -->> On Node 1
[root@mongodb ~]# systemctl stop mongod

-- Step 34 -->> On Node 1 (Access control is enabled for the database)
[root@mongodb ~]# vi /etc/mongod.conf
/*
#security:
security.authorization: enabled
*/

-- Step 35 -->> On Node 1
[root@mongodb ~]# systemctl start mongod

-- Step 36 -->> On Node 1
[root@mongodb ~]# systemctl status mongod
/*
● mongod.service - MongoDB Database Server
   Loaded: loaded (/usr/lib/systemd/system/mongod.service; enabled; vendor preset: disabled)
   Active: active (running) since Wed 2023-11-08 15:27:35 +0545; 4s ago
     Docs: https://docs.mongodb.org/manual
 Main PID: 7458 (mongod)
   Memory: 176.2M
   CGroup: /system.slice/mongod.service
           └─7458 /usr/bin/mongod -f /etc/mongod.conf

Nov 08 15:27:35 mongodb.deveshnepal.org.np systemd[1]: Started MongoDB Database Server.
Nov 08 15:27:35 mongodb.deveshnepal.org.np mongod[7458]: {"t":{"$date":"2023-11-08T09:42:35.745Z"},"s":"I",  "c":"CONTROL",  "id":7484500, "ctx":"main","msg":"Environment variable MONGODB_CON>
*/

-- Step 37 -->> On Node 1
[mongodb@mongodb ~]# mongo
/*
Current Mongosh Log ID: 655352806cea21fd0d73be3a
Connecting to:          mongodb://127.0.0.1:27017/?directConnection=true&serverSelectionTimeoutMS=2000&appName=mongosh+2.0.2
Using MongoDB:          7.0.3
Using Mongosh:          2.0.2

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

test> show dbs
MongoServerError: Command listDatabases requires authentication
test> exit
*/

-- Step 38 -->> On Node 1
[mongodb@mongodb ~]$ mongo --host 127.0.0.1 --port 27017 -u admin -p P#ssw0rD --authenticationDatabase admin
/*
Current Mongosh Log ID: 654b58a162f8a3c0b95c2286
Connecting to:          mongodb://<credentials>@127.0.0.1:27017/?directConnection=true&serverSelectionTimeoutMS=2000&authSource=admin&appName=mongosh+2.0.2
Using MongoDB:          7.0.2
Using Mongosh:          2.0.2

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

test> show dbs
admin   180.00 KiB
devesh       8.00 KiB
config   72.00 KiB
local    72.00 KiB
test> exit
*/

-- Step 39 -->> On Node 1
[mongodb@mongodb ~]$ mongo --host 192.168.56.148  --port 27017 -u admin -p P#ssw0rD --authenticationDatabase admin
/*
Current Mongosh Log ID: 654b5905878d7249b51fc64f
Connecting to:          mongodb://<credentials>@192.168.56.148:27017/?directConnection=true&authSource=admin&appName=mongosh+2.0.2
Using MongoDB:          7.0.2
Using Mongosh:          2.0.2

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

test> db.version()
7.0.2
test> show databases
admin   180.00 KiB
devesh       8.00 KiB
config   72.00 KiB
local    72.00 KiB
test> show dbs
admin   180.00 KiB
devesh       8.00 KiB
config   72.00 KiB
local    72.00 KiB
test> quit()
*/

-- Step 40 -->> On Node 1
[mongodb@mongodb ~]$ mongosh --host 192.168.56.148  --port 27017 -u admin -p P#ssw0rD --authenticationDatabase admin
/*
Current Mongosh Log ID: 654b594975260c1926b5c5da
Connecting to:          mongodb://<credentials>@192.168.56.148:27017/?directConnection=true&authSource=admin&appName=mongosh+2.0.2
Using MongoDB:          7.0.2
Using Mongosh:          2.0.2

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

test> show dbs
admin   180.00 KiB
devesh       8.00 KiB
config   72.00 KiB
local    72.00 KiB
test> exit
*/

-- Step 41 -->> On Node 1
[mongodb@mongodb ~]$ mongosh --host 127.0.0.1  --port 27017 -u admin -p P#ssw0rD --authenticationDatabase admin
/*
Current Mongosh Log ID: 654b595fead379a2ce95b5d2
Connecting to:          mongodb://<credentials>@127.0.0.1:27017/?directConnection=true&serverSelectionTimeoutMS=2000&authSource=admin&appName=mongosh+2.0.2
Using MongoDB:          7.0.2
Using Mongosh:          2.0.2

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

test> show databases
admin   180.00 KiB
devesh       8.00 KiB
config   72.00 KiB
local    72.00 KiB
test> quit()
*/

-- Step 42 -->> On Node 1
[mongodb@mongodb ~]$ mongo --host 192.168.56.148  --port 27017 -u devesh -p deveshP#ssw0rD --authenticationDatabase devesh
/*
Current Mongosh Log ID: 654b59a9f49bfdd2b3ca29dd
Connecting to:          mongodb://<credentials>@192.168.56.148:27017/?directConnection=true&authSource=devesh&appName=mongosh+2.0.2
Using MongoDB:          7.0.2
Using Mongosh:          2.0.2

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

test> show dbs
devesh  8.00 KiB

test> use devesh
switched to db devesh

devesh> db.getCollectionNames()
[ 'tbl_devesh' ]

devesh> show collections
tbl_devesh

devesh> show databases
devesh  8.00 KiB

devesh> quit()
*/

-- Step 43 -->> On Node 1
[mongodb@mongodb ~]$ mkdir -p /data/backup/dump

-- Step 44 -->> On Node 1
[mongodb@mongodb ~]$ mongodump --host 127.0.0.1 --port 27017 -u admin -p P#ssw0rD --authenticationDatabase admin --out /data/backup/dump/ >> /data/backup/backup.log 2>&1

-- Step 45 -->> On Node 1
[mongodb@mongodb ~]$ ll /data/backup/dump
/*
drwxrwxr-x 2 mongodb mongodb 128 Nov  8 15:44 admin
drwxrwxr-x 2 mongodb mongodb  55 Nov  8 15:44 devesh
*/

-- Step 46 -->> On Node 1
[mongodb@mongodb ~]$ cat /data/backup/backup.log
/*
2023-11-08T15:44:34.185+0545    writing admin.system.users to /data/backup/dump/admin/system.users.bson
2023-11-08T15:44:34.186+0545    done dumping admin.system.users (2 documents)
2023-11-08T15:44:34.187+0545    writing admin.system.version to /data/backup/dump/admin/system.version.bson
2023-11-08T15:44:34.187+0545    done dumping admin.system.version (2 documents)
2023-11-08T15:44:34.188+0545    writing devesh.tbl_devesh to /data/backup/dump/devesh/tbl_devesh.bson
2023-11-08T15:44:34.190+0545    done dumping devesh.tbl_devesh (0 documents)
*/

-- Step 47 -->> On Node 1
[mongodb@mongodb ~]$ mongo --host 192.168.56.148  --port 27017 -u admin -p P#ssw0rD --authenticationDatabase admin
/*
Current Mongosh Log ID: 654b5c90a58e6d4cf8aa8a1b
Connecting to:          mongodb://<credentials>@192.168.56.148:27017/?directConnection=true&authSource=admin&appName=mongosh+2.0.2
Using MongoDB:          7.0.2
Using Mongosh:          2.0.2

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

test> show dbs
admin   180.00 KiB
devesh       8.00 KiB
config   72.00 KiB
local    72.00 KiB

test> use devesh
switched to db devesh

devesh> db
devesh

devesh> db.dropDatabase()
{ ok: 1, dropped: 'devesh' }

devesh> show dbs
admin   180.00 KiB
config   72.00 KiB
local    72.00 KiB

devesh> use admin
switched to db admin

admin> show dbs
admin   180.00 KiB
config   72.00 KiB
local    72.00 KiB

admin> quit()
*/

-- Step 48 -->> On Node 1
[mongodb@mongodb ~]$ mongorestore --host 192.168.56.148  --port 27017 -u devesh -p deveshP#ssw0rD --authenticationDatabase devesh --db devesh /data/backup/dump/devesh/
/*
2023-11-08T15:53:12.070+0545    The --db and --collection flags are deprecated for this use-case; please use --nsInclude instead, i.e. with --nsInclude=${DATABASE}.${COLLECTION}
2023-11-08T15:53:12.070+0545    building a list of collections to restore from /data/backup/dump/devesh dir
2023-11-08T15:53:12.070+0545    reading metadata for devesh.tbl_devesh from /data/backup/dump/devesh/tbl_devesh.metadata.json
2023-11-08T15:53:12.076+0545    restoring devesh.tbl_devesh from /data/backup/dump/devesh/tbl_devesh.bson
2023-11-08T15:53:12.089+0545    finished restoring devesh.tbl_devesh (0 documents, 0 failures)
2023-11-08T15:53:12.089+0545    no indexes to restore for collection devesh.tbl_devesh
2023-11-08T15:53:12.089+0545    0 document(s) restored successfully. 0 document(s) failed to restore.
*/

-- Step 49 -->> On Node 1
[mongodb@mongodb ~]$ mongo --host 192.168.56.148  --port 27017 -u admin -p P#ssw0rD --authenticationDatabase admin
/*
Current Mongosh Log ID: 654b5e69cbca249071d9ab5f
Connecting to:          mongodb://<credentials>@192.168.56.148:27017/?directConnection=true&authSource=admin&appName=mongosh+2.0.2
Using MongoDB:          7.0.2
Using Mongosh:          2.0.2

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

test> show dbs
admin   180.00 KiB
devesh       8.00 KiB
config  108.00 KiB
local    72.00 KiB

test> use devesh
switched to db devesh

devesh> db
devesh

devesh> db.getUsers()
{
  users: [
    {
      _id: 'devesh.devesh',
      userId: new UUID("a3c9a0b2-c534-40a7-98f6-5505eb2e0076"),
      user: 'devesh',
      db: 'devesh',
      roles: [ { role: 'readWrite', db: 'devesh' } ],
      mechanisms: [ 'SCRAM-SHA-1', 'SCRAM-SHA-256' ]
    }
  ],
  ok: 1
}

devesh> db.getCollectionNames()
[ 'tbl_devesh' ]

devesh> show collections
tbl_devesh

devesh> quit()
*/

-- Step 50 -->> On Node 1
[mongodb@mongodb ~]$ mongorestore --host 192.168.56.148  --port 27017 -u devesh -p deveshP#ssw0rD --authenticationDatabase devesh --db devesh --drop /data/backup/dump/devesh/
/*
2023-11-08T15:59:56.410+0545    The --db and --collection flags are deprecated for this use-case; please use --nsInclude instead, i.e. with --nsInclude=${DATABASE}.${COLLECTION}
2023-11-08T15:59:56.410+0545    building a list of collections to restore from /data/backup/dump/devesh dir
2023-11-08T15:59:56.410+0545    reading metadata for devesh.tbl_devesh from /data/backup/dump/devesh/tbl_devesh.metadata.json
2023-11-08T15:59:56.411+0545    dropping collection devesh.tbl_devesh before restoring
2023-11-08T15:59:56.419+0545    restoring devesh.tbl_devesh from /data/backup/dump/devesh/tbl_devesh.bson
2023-11-08T15:59:56.430+0545    finished restoring devesh.tbl_devesh (0 documents, 0 failures)
2023-11-08T15:59:56.430+0545    no indexes to restore for collection devesh.tbl_devesh
2023-11-08T15:59:56.430+0545    0 document(s) restored successfully. 0 document(s) failed to restore.
*/

-- Step 51 -->> On Node 1
[mongodb@mongodb ~]$ mongo --host 192.168.56.148  --port 27017 -u admin -p P#ssw0rD --authenticationDatabase admin
/*
Current Mongosh Log ID: 654b5fc45f61ae72aa4c1ae8
Connecting to:          mongodb://<credentials>@192.168.56.148:27017/?directConnection=true&authSource=admin&appName=mongosh+2.0.2
Using MongoDB:          7.0.2
Using Mongosh:          2.0.2

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

test> show dbs
admin   180.00 KiB
devesh       8.00 KiB
config  108.00 KiB
local    72.00 KiB

test> use devesh
switched to db devesh

devesh> db
devesh

devesh> db.getUsers()
{
  users: [
    {
      _id: 'devesh.devesh',
      userId: new UUID("a3c9a0b2-c534-40a7-98f6-5505eb2e0076"),
      user: 'devesh',
      db: 'devesh',
      roles: [ { role: 'readWrite', db: 'devesh' } ],
      mechanisms: [ 'SCRAM-SHA-1', 'SCRAM-SHA-256' ]
    }
  ],
  ok: 1
}

devesh> db.getCollectionNames()
[ 'tbl_devesh' ]

devesh> quit()
*/

--To Create an environmental file
/*
mongodb@mongodb:~$ cat $HOME/.ra.env
FILENAME="$HOME/.CONTAIN.txt"
mongodb@mongodb:~$ cat $HOME/.CONTAIN.txt
DbFullBackUP
DbFullBackUP_Log
/backup/MongoDBFullBackup
/backup/MongoDBFullBackup_Log
127.0.0.1
27017
admin
AdMiNmoNg0@P@55w0rD
*/

--To Create a backup
/*
#!/bin/sh

. $HOME/.ra.env
#########################################################################################
# Credit Information Bureau Nepal Limited its affiliates. All rights reserved.
# File          : MongoDbFullBackup.sh
# Purpose       : To take a Full backup files for MongoDB
# Usage         : ./MongoDbFullBackup.sh
# Created By    : Devesh Kumar Shrivastav
# Created Date  : July 28, 2022
# Purpose       : UNIX Backup the files
# Revision      : 1.0
#########################################################################################

########################BOF This is part of the MongoDbFullBackup########################

# Collect the Informatios From File
for f in $FILENAME
do
  g_1=`sed -n '1p' $f`
  g_2=`sed -n '2p' $f`
  g_3=`sed -n '3p' $f`
  g_4=`sed -n '4p' $f`
  g_5=`sed -n '5p' $f`
  g_6=`sed -n '6p' $f`
  g_7=`sed -n '7p' $f`
  g_8=`sed -n '8p' $f`
done

# Load the Informations for the relevant varibals
backup_file=`date +${g_1}_%d_%b_%Y`      DbFullBackUP
backup_l_file=`date +${g_2}_%d_%b_%Y`    DbFullBackUP_Log
backup_dir=${g_3}                        /backup/MongoDBFullBackup
backup_l_dir=${g_4}                      /backup/MongoDBFullBackup_Log
hosts=${g_5}                             127.0.0.1
ports=${g_6}                             27017
users=${g_7}                             admin
password=${g_8}                          AdMiNmoNg0@P@55w0rD

# To Create a Date Specific Folder
mkdir -p ${backup_dir}/${backup_file}/dump
mkdir -p ${backup_l_dir}/${backup_l_file}

# To Take a Backup
mongodump --host ${hosts} --port ${ports} -u ${users} -p ${password} --authenticationDatabase ${users} --out ${backup_dir}/${backup_file}/dump/ >> ${backup_l_dir}/${backup_l_file}/${backup_l_file}.log 2>&1

exit;

########################EOF This is part of the MongoDbFullBackup########################

#mongodump --host 127.0.0.1 --port 27017 -u admin -p ${password} --authenticationDatabase ${users} --out ${backup_dir}/${backup_file}/dump/ >> ${backup_l_dir}/${backup_l_file}/${backup_l_file}.log 2>&1
#mongodump --host 127.0.0.1 --port 27017 --out backup/dump
*/