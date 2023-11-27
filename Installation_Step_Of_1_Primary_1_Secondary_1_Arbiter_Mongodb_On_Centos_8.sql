--MongoDB Cluster Setup Centos
--In some circumstances (such as you have a primary and a secondary 
--but cost constraints prohibit adding another secondary), you may 
--choose to add a mongod instance to a replica set as an arbiter. 
--An arbiter participates in elections but does not hold data (i.e. does not provide data redundancy). 
--For more information on arbiters, see Replica Set Arbiter.

--An arbiter will always be an arbiter whereas a primary may step down and become a secondary 
--and a secondary may become the primary during an election.
--------------------------------------------------------------------------
----------------------------root/P@ssw0rd---------------------------------
--------------------------------------------------------------------------
-- 1 All Nodes
[root@mongodb_1_p/mongodb_1_s/mongodb_1_a ~]# df -Th
/*
Filesystem                  Type      Size  Used Avail Use% Mounted on
devtmpfs                    devtmpfs  844M     0  844M   0% /dev
tmpfs                       tmpfs     874M     0  874M   0% /dev/shm
tmpfs                       tmpfs     874M  9.5M  864M   2% /run
tmpfs                       tmpfs     874M     0  874M   0% /sys/fs/cgroup
/dev/mapper/cs_mongodb-root xfs        30G  708M   30G   3% /
/dev/mapper/cs_mongodb-usr  xfs        10G  8.0G  2.1G  80% /usr
/dev/mapper/cs_mongodb-data xfs        16G  147M   16G   1% /data
/dev/mapper/cs_mongodb-var  xfs        10G  879M  9.2G   9% /var
/dev/mapper/cs_mongodb-tmp  xfs        10G  104M  9.9G   2% /tmp
/dev/mapper/cs_mongodb-home xfs        10G  119M  9.9G   2% /home
/dev/sda1                   xfs      1014M  459M  556M  46% /boot
tmpfs                       tmpfs     175M   24K  175M   1% /run/user/0
/dev/sr0                    iso9660    12G   12G     0 100% /run/media/root/CentOS-Stream-8-BaseOS-x86_64
*/

-- 1 All Nodes
[root@mongodb_1_p/mongodb_1_s/mongodb_1_a ~]# cat /etc/os-release
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

-- Step 1 -->> On All Nodes
[root@mongodb_1_p/mongodb_1_s/mongodb_1_a ~]# vi /etc/hosts
/*
127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
::1         localhost localhost.localdomain localhost6 localhost6.localdomain6

# Public
192.168.56.149 mongodb_1_p.unidev39.org.np mongodb_1_p
192.168.56.150 mongodb_1_s.unidev39.org.np mongodb_1_s
192.168.56.151 mongodb_1_a.unidev39.org.np mongodb_1_a
*/

-- Step 2 -->> On All Nodes
-- Disable secure linux by editing the "/etc/selinux/config" file, making sure the SELINUX flag is set as follows.
[root@mongodb_1_p/mongodb_1_s/mongodb_1_a ~]# vi /etc/selinux/config
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
[root@mongodb_1_p ~]# vi /etc/sysconfig/network
/*
NETWORKING=yes
HOSTNAME=mongodb_1_p.unidev39.org.np
*/

-- Step 3.1 -->> On Node 2
[root@mongodb_1_s ~]# vi /etc/sysconfig/network
/*
# Created by anaconda
NETWORKING=yes
HOSTNAME=mongodb_1_s.unidev39.org.np
*/

-- Step 3.2 -->> On Node 3
[root@mongodb_1_a ~]# vi /etc/sysconfig/network
/*
# Created by anaconda
NETWORKING=yes
HOSTNAME=mongodb_1_a.unidev39.org.np
*/

-- Step 4 -->> On Node 1
[root@mongodb_1_p ~]# nmtui
--OR--
-- Step 4 -->> On Node 1
[root@mongodb_1_p ~]# vi /etc/sysconfig/network-scripts/ifcfg-ens33
/*
TYPE=Ethernet
BOOTPROTO=static
DEFROUTE=yes
NAME=ens33
DEVICE=ens33
ONBOOT=yes
IPADDR=192.168.56.149
NETMASK=255.255.255.0
GATEWAY=192.168.56.2
DNS1=192.168.56.2
DNS2=8.8.8.8
*/

-- Step 4.1 -->> On Node 2
[root@mongodb_1_s ~]# nmtui
--OR--
-- Step 4.1 -->> On Node 2
[root@mongodb_1_s ~]# vi /etc/sysconfig/network-scripts/ifcfg-ens33
/*
TYPE=Ethernet
BOOTPROTO=static
DEFROUTE=yes
NAME=ens33
DEVICE=ens33
ONBOOT=yes
IPADDR=192.168.56.150
NETMASK=255.255.255.0
GATEWAY=192.168.56.2
DNS1=192.168.56.2
DNS2=8.8.8.8
*/

-- Step 4.2 -->> On Node 3
[root@mongodb_1_a ~]# nmtui
--OR--
-- Step 4.2 -->> On Node 3
[root@mongodb_1_a ~]# vi /etc/sysconfig/network-scripts/ifcfg-ens33
/*
TYPE=Ethernet
BOOTPROTO=static
DEFROUTE=yes
NAME=ens33
DEVICE=ens33
ONBOOT=yes
IPADDR=192.168.56.151
NETMASK=255.255.255.0
GATEWAY=192.168.56.2
DNS1=192.168.56.2
DNS2=8.8.8.8
*/

-- Step 5 -->> On All Nodes
[root@mongodb_1_p/mongodb_1_s/mongodb_1_a ~]# systemctl restart network-online.target

-- Step 6.0 -->> On Node 1
[root@mongodb_1_p ~]# hostnamectl set-hostname mongodb_1_p.unidev39.org.np

-- Step 6.1 -->> On Node 1
[root@mongodb_1_p ~]# cat /etc/hostname
/*
mongodb_1_p.unidev39.org.np
*/

-- Step 6.2 -->> On Node 1
[root@mongodb_1_p ~]# hostnamectl | grep hostname
/*
  Static hostname: mongodb_1_p.unidev39.org.np
*/

-- Step 6.3 -->> On Node 1
[root@mongodb_1_p ~]# hostnamectl --static
/*
mongodb_1_p.unidev39.org.np
*/

-- Step 6.4 -->> On Node 1
[root@mongodb_1_p ~]# hostnamectl
/*
   Static hostname: mongodb_1_p.unidev39.org.np
         Icon name: computer-vm
           Chassis: vm
        Machine ID: cbaf309dd0cb4d9dbfdb4688b4515eb6
           Boot ID: 4eb4444d7692409380b85705a7c04faf
    Virtualization: vmware
  Operating System: CentOS Stream 8
       CPE OS Name: cpe:/o:centos:centos:8
            Kernel: Linux 4.18.0-521.el8.x86_64
      Architecture: x86-64
*/

-- Step 6.0.1 -->> On Node 2
[root@mongodb_1_s ~]# hostnamectl set-hostname mongodb_1_s.unidev39.org.np

-- Step 6.1.1 -->> On Node 2
[root@mongodb_1_s ~]# cat /etc/hostname
/*
mongodb_1_s.unidev39.org.np
*/

-- Step 6.2.1 -->> On Node 2
[root@mongodb_1_s ~]# hostnamectl | grep hostname
/*
  Static hostname: mongodb_1_s.unidev39.org.np
*/

-- Step 6.3.1 -->> On Node 2
[root@mongodb_1_s ~]# hostnamectl --static
/*
mongodb_1_s.unidev39.org.np
*/

-- Step 6.4.1 -->> On Node 2
[root@mongodb_1_s ~]# hostnamectl
/*
   Static hostname: mongodb_1_s.unidev39.org.np
         Icon name: computer-vm
           Chassis: vm
        Machine ID: cbaf309dd0cb4d9dbfdb4688b4515eb6
           Boot ID: 18941e8354814a42809885940b69c39f
    Virtualization: vmware
  Operating System: CentOS Stream 8
       CPE OS Name: cpe:/o:centos:centos:8
            Kernel: Linux 4.18.0-521.el8.x86_64
      Architecture: x86-64
*/

-- Step 6.0.2 -->> On Node 3
[root@mongodb_1_a ~]# hostnamectl set-hostname mongodb_1_a.unidev39.org.np

-- Step 6.1.2 -->> On Node 3
[root@mongodb_1_a ~]# cat /etc/hostname
/*
mongodb_1_a.unidev39.org.np
*/

-- Step 6.2.2 -->> On Node 3
[root@mongodb_1_a ~]# hostnamectl | grep hostname
/*
  Static hostname: mongodb_1_a.unidev39.org.np
*/

-- Step 6.3.2 -->> On Node 3
[root@mongodb_1_a ~]# hostnamectl --static
/*
mongodb_1_a.unidev39.org.np
*/

-- Step 6.4.2 -->> On Node 3
[root@mongodb_1_a ~]# hostnamectl
/*
   Static hostname: mongodb_1_a.unidev39.org.np
         Icon name: computer-vm
           Chassis: vm
        Machine ID: cbaf309dd0cb4d9dbfdb4688b4515eb6
           Boot ID: 8561bcdad66049868cc9fc33bed22c46
    Virtualization: vmware
  Operating System: CentOS Stream 8
       CPE OS Name: cpe:/o:centos:centos:8
            Kernel: Linux 4.18.0-521.el8.x86_64
      Architecture: x86-64
*/

-- Step 7 -->> On All Nodes
[root@mongodb_1_p/mongodb_1_s/mongodb_1_a ~]# systemctl stop firewalld
[root@mongodb_1_p/mongodb_1_s/mongodb_1_a ~]# systemctl disable firewalld
/*
Removed "/etc/systemd/system/multi-user.target.wants/firewalld.service".
Removed "/etc/systemd/system/dbus-org.fedoraproject.FirewallD1.service".
*/

-- Step 8 -->> On All Nodes
[root@mongodb_1_p/mongodb_1_s/mongodb_1_a ~]# iptables -F
[root@mongodb_1_p/mongodb_1_s/mongodb_1_a ~]# iptables -X
[root@mongodb_1_p/mongodb_1_s/mongodb_1_a ~]# iptables -t nat -F
[root@mongodb_1_p/mongodb_1_s/mongodb_1_a ~]# iptables -t nat -X
[root@mongodb_1_p/mongodb_1_s/mongodb_1_a ~]# iptables -t mangle -F
[root@mongodb_1_p/mongodb_1_s/mongodb_1_a ~]# iptables -t mangle -X
[root@mongodb_1_p/mongodb_1_s/mongodb_1_a ~]# iptables -P INPUT ACCEPT
[root@mongodb_1_p/mongodb_1_s/mongodb_1_a ~]# iptables -P FORWARD ACCEPT
[root@mongodb_1_p/mongodb_1_s/mongodb_1_a ~]# iptables -P OUTPUT ACCEPT
[root@mongodb_1_p/mongodb_1_s/mongodb_1_a ~]# iptables -L -nv
/*
Chain INPUT (policy ACCEPT 13 packets, 1372 bytes)
 pkts bytes target     prot opt in     out     source               destination

Chain FORWARD (policy ACCEPT 0 packets, 0 bytes)
 pkts bytes target     prot opt in     out     source               destination

Chain OUTPUT (policy ACCEPT 4 packets, 468 bytes)
 pkts bytes target     prot opt in     out     source               destination
*/

-- Step 9 -->> On All Nodes
--To Remove virbr0 and lxcbr0 Network Interfac
[root@mongodb_1_p/mongodb_1_s/mongodb_1_a ~]# systemctl stop libvirtd.service
[root@mongodb_1_p/mongodb_1_s/mongodb_1_a ~]# systemctl disable libvirtd.service
[root@mongodb_1_p/mongodb_1_s/mongodb_1_a ~]# virsh net-list
[root@mongodb_1_p/mongodb_1_s/mongodb_1_a ~]# virsh net-destroy default

-- Step 10 -->> On Node 1
[root@mongodb_1_p ~]# ifconfig
/*
ens33: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 192.168.56.149  netmask 255.255.255.0  broadcast 192.168.56.255
        inet6 fe80::20c:29ff:fe2b:ff7f  prefixlen 64  scopeid 0x20<link>
        ether 00:0c:29:2b:ff:7f  txqueuelen 1000  (Ethernet)
        RX packets 64395  bytes 96348225 (91.8 MiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 14175  bytes 890624 (869.7 KiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
        inet 127.0.0.1  netmask 255.0.0.0
        inet6 ::1  prefixlen 128  scopeid 0x10<host>
        loop  txqueuelen 1000  (Local Loopback)
        RX packets 182  bytes 11064 (10.8 KiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 182  bytes 11064 (10.8 KiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
*/

-- Step 10.1 -->> On Node 2
[root@mongodb_1_s ~]# ifconfig
/*
ens33: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 192.168.56.150  netmask 255.255.255.0  broadcast 192.168.56.255
        inet6 fe80::20c:29ff:fef1:517d  prefixlen 64  scopeid 0x20<link>
        ether 00:0c:29:f1:51:7d  txqueuelen 1000  (Ethernet)
        RX packets 64268  bytes 96335515 (91.8 MiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 13706  bytes 859792 (839.6 KiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
        inet 127.0.0.1  netmask 255.0.0.0
        inet6 ::1  prefixlen 128  scopeid 0x10<host>
        loop  txqueuelen 1000  (Local Loopback)
        RX packets 136  bytes 8256 (8.0 KiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 136  bytes 8256 (8.0 KiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
*/

-- Step 10.2 -->> On Node 3
[root@mongodb_1_a ~]# ifconfig
/*
ens33: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 192.168.56.151  netmask 255.255.255.0  broadcast 192.168.56.255
        inet6 fe80::20c:29ff:fed9:6249  prefixlen 64  scopeid 0x20<link>
        ether 00:0c:29:d9:62:49  txqueuelen 1000  (Ethernet)
        RX packets 62986  bytes 94503952 (90.1 MiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 13662  bytes 855758 (835.7 KiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
        inet 127.0.0.1  netmask 255.0.0.0
        inet6 ::1  prefixlen 128  scopeid 0x10<host>
        loop  txqueuelen 1000  (Local Loopback)
        RX packets 120  bytes 7444 (7.2 KiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 120  bytes 7444 (7.2 KiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
*/

-- Step 11 -->> On All Nodes
[root@mongodb_1_p/mongodb_1_s/mongodb_1_a ~]# init 6

-- Step 12 -->> On All Nodes
[root@mongodb_1_p/mongodb_1_s/mongodb_1_a ~]# firewall-cmd --list-all
/*
FirewallD is not running
*/

-- Step 13 -->> On All Nodes
[root@mongodb_1_p/mongodb_1_s/mongodb_1_a ~]# systemctl status firewalld
/*
● firewalld.service - firewalld - dynamic firewall daemon
   Loaded: loaded (/usr/lib/systemd/system/firewalld.service; disabled; vendor preset: enabled)
   Active: inactive (dead)
     Docs: man:firewalld(1)
*/

-- Step 14 -->> On All Nodes
[root@mongodb_1_p/mongodb_1_s/mongodb_1_a ~]# cd /run/media/root/CentOS-Stream-8-BaseOS-x86_64/AppStream/Packages
[root@mongodb_1_p/mongodb_1_s/mongodb_1_a ~]# yum -y update

-- Step 15 -->> On All Nodes
[root@mongodb_1_p/mongodb_1_s/mongodb_1_a ~]# usermod -aG wheel mongodb
[root@mongodb_1_p/mongodb_1_s/mongodb_1_a ~]# usermod -aG root mongodb

-- Step 16 -->> On All Nodes
[root@mongodb_1_p/mongodb_1_s/mongodb_1_a ~]# cd /etc/yum.repos.d/
[root@mongodb_1_p/mongodb_1_s/mongodb_1_a yum.repos.d]# ll
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

-- Step 17 -->> On All Nodes
[root@mongodb_1_p/mongodb_1_s/mongodb_1_a yum.repos.d]# vi /etc/yum.repos.d/mongodb-org.repo
/*
[mongodb-org-7.0]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/8/mongodb-org/7.0/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-7.0.asc
*/ 

-- Step 18 -->> On All Nodes
[root@mongodb_1_p/mongodb_1_s/mongodb_1_a yum.repos.d]# ll | grep mongo
/*
-rw-r--r--  1 root root  190 Nov 17 11:20 mongodb-org.repo
*/
[root@mongodb_1_p/mongodb_1_s/mongodb_1_a yum.repos.d]# yum repolist
/*
repo id                                                                           repo name
appstream                                                                         CentOS Stream 8 - AppStream
baseos                                                                            CentOS Stream 8 - BaseOS
extras                                                                            CentOS Stream 8 - Extras
extras-common                                                                     CentOS Stream 8 - Extras common packages
mongodb-org-7.0                                                                   MongoDB Repository
*/

-- Step 19 -->> On All Nodes
[root@mongodb_1_p/mongodb_1_s/mongodb_1_a ~]# yum install -y mongodb-org
/*
MongoDB Repository                                                                                                                                            11 kB/s |  18 kB     00:01
Last metadata expiration check: 0:00:01 ago on Sat 17 Nov 2023 02:11:13 PM +0545.
Dependencies resolved.
=============================================================================================================================================================================================
 Package                                                      Architecture                       Version                                   Repository                                   Size
=============================================================================================================================================================================================
Installing:
 mongodb-org                                                  x86_64                             7.0.3-1.el8                               mongodb-org-7.0                             9.5 k
Installing dependencies:
 mongodb-database-tools                                       x86_64                             100.9.3-1                                 mongodb-org-7.0                              52 M
 mongodb-mongosh                                              x86_64                             2.0.2-1.el8                               mongodb-org-7.0                              50 M
 mongodb-org-database                                         x86_64                             7.0.3-1.el8                               mongodb-org-7.0                             9.6 k
 mongodb-org-database-tools-extra                             x86_64                             7.0.3-1.el8                               mongodb-org-7.0                              15 k
 mongodb-org-mongos                                           x86_64                             7.0.3-1.el8                               mongodb-org-7.0                              25 M
 mongodb-org-server                                           x86_64                             7.0.3-1.el8                               mongodb-org-7.0                              36 M
 mongodb-org-tools                                            x86_64                             7.0.3-1.el8                               mongodb-org-7.0                             9.5 k

Transaction Summary
=============================================================================================================================================================================================
Install  8 Packages

Total download size: 164 M
Installed size: 624 M
Downloading Packages:
(1/8): mongodb-org-7.0.3-1.el8.x86_64.rpm                                                                                                                     23 kB/s | 9.5 kB     00:00
(2/8): mongodb-org-database-7.0.3-1.el8.x86_64.rpm                                                                                                            27 kB/s | 9.6 kB     00:00
(3/8): mongodb-org-database-tools-extra-7.0.3-1.el8.x86_64.rpm                                                                                                30 kB/s |  15 kB     00:00
(4/8): mongodb-org-mongos-7.0.3-1.el8.x86_64.rpm                                                                                                             3.2 MB/s |  25 MB     00:07
(5/8): mongodb-mongosh-2.0.2.x86_64.rpm                                                                                                                      4.5 MB/s |  50 MB     00:10
(6/8): mongodb-org-tools-7.0.3-1.el8.x86_64.rpm                                                                                                               34 kB/s | 9.5 kB     00:00
(7/8): mongodb-database-tools-100.9.3.x86_64.rpm                                                                                                             3.9 MB/s |  52 MB     00:13
(8/8): mongodb-org-server-7.0.3-1.el8.x86_64.rpm                                                                                                             5.5 MB/s |  36 MB     00:06
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Total                                                                                                                                                         10 MB/s | 164 MB     00:15
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
  Installing       : mongodb-org-database-tools-extra-7.0.3-1.el8.x86_64                                                                                                                 1/8
  Running scriptlet: mongodb-org-server-7.0.3-1.el8.x86_64                                                                                                                               2/8
  Installing       : mongodb-org-server-7.0.3-1.el8.x86_64                                                                                                                               2/8
  Running scriptlet: mongodb-org-server-7.0.3-1.el8.x86_64                                                                                                                               2/8
Created symlink /etc/systemd/system/multi-user.target.wants/mongod.service → /usr/lib/systemd/system/mongod.service.

  Installing       : mongodb-org-mongos-7.0.3-1.el8.x86_64                                                                                                                               3/8
  Installing       : mongodb-org-database-7.0.3-1.el8.x86_64                                                                                                                             4/8
  Installing       : mongodb-mongosh-2.0.2-1.el8.x86_64                                                                                                                                  5/8
  Running scriptlet: mongodb-database-tools-100.9.3-1.x86_64                                                                                                                             6/8
  Installing       : mongodb-database-tools-100.9.3-1.x86_64                                                                                                                             6/8
  Running scriptlet: mongodb-database-tools-100.9.3-1.x86_64                                                                                                                             6/8
  Installing       : mongodb-org-tools-7.0.3-1.el8.x86_64                                                                                                                                7/8
  Installing       : mongodb-org-7.0.3-1.el8.x86_64                                                                                                                                      8/8
  Running scriptlet: mongodb-org-7.0.3-1.el8.x86_64                                                                                                                                      8/8
  Verifying        : mongodb-database-tools-100.9.3-1.x86_64                                                                                                                             1/8
  Verifying        : mongodb-mongosh-2.0.2-1.el8.x86_64                                                                                                                                  2/8
  Verifying        : mongodb-org-7.0.3-1.el8.x86_64                                                                                                                                      3/8
  Verifying        : mongodb-org-database-7.0.3-1.el8.x86_64                                                                                                                             4/8
  Verifying        : mongodb-org-database-tools-extra-7.0.3-1.el8.x86_64                                                                                                                 5/8
  Verifying        : mongodb-org-mongos-7.0.3-1.el8.x86_64                                                                                                                               6/8
  Verifying        : mongodb-org-server-7.0.3-1.el8.x86_64                                                                                                                               7/8
  Verifying        : mongodb-org-tools-7.0.3-1.el8.x86_64                                                                                                                                8/8

Installed:
  mongodb-database-tools-100.9.3-1.x86_64                  mongodb-mongosh-2.0.2-1.el8.x86_64         mongodb-org-7.0.3-1.el8.x86_64             mongodb-org-database-7.0.3-1.el8.x86_64
  mongodb-org-database-tools-extra-7.0.3-1.el8.x86_64      mongodb-org-mongos-7.0.3-1.el8.x86_64      mongodb-org-server-7.0.3-1.el8.x86_64      mongodb-org-tools-7.0.3-1.el8.x86_64

Complete!
*/

-- Step 20 -->> On All Nodes
[root@mongodb_1_p/mongodb_1_s/mongodb_1_a ~]# ll /var/lib/ | grep mongo
/*
drwxr-xr-x   2 mongod         mongod            6 Oct  6 01:52 mongo
*/

-- Step 21 -->> On All Nodes (Create a MongoDB Data and Log directory)
[root@mongodb_1_p/mongodb_1_s/mongodb_1_a ~]# mkdir -p /data/mongodb
[root@mongodb_1_p/mongodb_1_s/mongodb_1_a ~]# mkdir -p /data/log
[root@mongodb_1_p/mongodb_1_s/mongodb_1_a ~]# chown -R mongod:mongod /data/
[root@mongodb_1_p/mongodb_1_s/mongodb_1_a ~]# chown -R mongod:mongod /data
[root@mongodb_1_p/mongodb_1_s/mongodb_1_a ~]# chmod -R 777 /data/
[root@mongodb_1_p/mongodb_1_s/mongodb_1_a ~]# chmod -R 777 /data
[root@mongodb_1_p/mongodb_1_s/mongodb_1_a ~]# ll / | grep data
/*
drwxrwxrwx.   4 mongod mongod    32 Nov 17 11:27 data
*/

-- Step 22 -->> On All Nodes
[root@mongodb_1_p/mongodb_1_s/mongodb_1_a ~]# ll /data/
/*
drwxrwxrwx 2 mongod mongod 6 Nov 17 11:27 log
drwxrwxrwx 2 mongod mongod 6 Nov 17 11:27 mongodb
*/

-- Step 23 -->> On All Nodes
[root@mongodb_1_p/mongodb_1_s/mongodb_1_a ~]# cp -r /etc/mongod.conf /etc/mongod.conf.backup
[root@mongodb_1_p/mongodb_1_s/mongodb_1_a ~]# ll /etc/mongod*
/*
-rw-r--r-- 1 root root 658 Oct 31 05:37 /etc/mongod.conf
-rw-r--r-- 1 root root 658 Nov 17 11:28 /etc/mongod.conf.backup
*/

-- Step 24 -->> On All Nodes
[root@mongodb_1_p/mongodb_1_s/mongodb_1_a ~]# vi /etc/mongod.conf
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
  bindIp: 127.0.0.1  # Enter 0.0.0.0,:: to bind to all IPv4 and IPv6 addresses or, alternatively, use the net.bindIpAll setting.
#security:

#operationProfiling:

#replication:

#sharding:

## Enterprise-Only Options

#auditLog:
*/

-- Step 25 -->> On All Nodes (Tuning For MongoDB)
-- Step 25.1 -->> On Node 1
[root@mongodb_1_p ~]# vi /etc/mongod.conf
/*
# network interfaces
net:
  port: 27017
  bindIp: 127.0.0.1,192.168.56.149
  maxIncomingConnections: 999999
*/

-- Step 25.2 -->> On Node 2
[root@mongodb_1_s ~]# vi /etc/mongod.conf
/*
# network interfaces
net:
  port: 27017
  bindIp: 127.0.0.1,192.168.56.150
  maxIncomingConnections: 999999
*/

-- Step 25.3 -->> On Node 3
[root@mongodb_1_a ~]# vi /etc/mongod.conf
/*
# network interfaces
net:
  port: 27017
  bindIp: 127.0.0.1,192.168.56.151
  maxIncomingConnections: 999999
*/

-- Step 25.1 -->> On All Nodes
[root@mongodb_1_p/mongodb_1_s/mongodb_1_a ~]# ulimit -a
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

-- Step 25.2 -->> On All Nodes
[root@mongodb_1_p/mongodb_1_s/mongodb_1_a ~]# ulimit -n 64000
[root@mongodb_1_p/mongodb_1_s/mongodb_1_a ~]# ulimit -a
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

-- Step 25.3 -->> On All Nodes
[root@mongodb_1_p/mongodb_1_s/mongodb_1_a ~]# cat /etc/group | grep mongo
/*
root:x:0:mongodb
wheel:x:10:mongodb
mongodb:x:1000:
mongod:x:969:
*/

-- Step 25.4 -->> On All Nodes
[root@mongodb_1_p/mongodb_1_s/mongodb_1_a ~]# echo "mongod           soft    nofile          9999999" | tee -a /etc/security/limits.conf
[root@mongodb_1_p/mongodb_1_s/mongodb_1_a ~]# echo "mongod           hard    nofile          9999999" | tee -a /etc/security/limits.conf
[root@mongodb_1_p/mongodb_1_s/mongodb_1_a ~]# echo "mongod           soft    nproc           9999999" | tee -a /etc/security/limits.conf
[root@mongodb_1_p/mongodb_1_s/mongodb_1_a ~]# echo "mongod           hard    nproc           9999999" | tee -a /etc/security/limits.conf
[root@mongodb_1_p/mongodb_1_s/mongodb_1_a ~]# echo "mongod           soft    stack           9999999" | tee -a /etc/security/limits.conf
[root@mongodb_1_p/mongodb_1_s/mongodb_1_a ~]# echo "mongod           hard    stack           9999999" | tee -a /etc/security/limits.conf
[root@mongodb_1_p/mongodb_1_s/mongodb_1_a ~]# echo 9999999 > /proc/sys/vm/max_map_count
[root@mongodb_1_p/mongodb_1_s/mongodb_1_a ~]# echo "vm.max_map_count=9999999" | tee -a /etc/sysctl.conf
[root@mongodb_1_p/mongodb_1_s/mongodb_1_a ~]# echo 1024 65530 > /proc/sys/net/ipv4/ip_local_port_range
[root@mongodb_1_p/mongodb_1_s/mongodb_1_a ~]# echo "net.ipv4.ip_local_port_range = 1024 65530" | tee -a /etc/sysctl.conf

-- Step 25.5 -->> On All Nodes
[root@mongodb_1_p/mongodb_1_s/mongodb_1_a ~]# systemctl enable mongod --now
[root@mongodb_1_p/mongodb_1_s/mongodb_1_a ~]# systemctl start mongod
[root@mongodb_1_p/mongodb_1_s/mongodb_1_a ~]# systemctl status mongod
/*
● mongod.service - MongoDB Database Server
   Loaded: loaded (/usr/lib/systemd/system/mongod.service; enabled; vendor preset: disabled)
   Active: active (running) since Fri 2023-11-17 11:40:33 +0545; 8s ago
     Docs: https://docs.mongodb.org/manual
 Main PID: 8386 (mongod)
   Memory: 177.5M
   CGroup: /system.slice/mongod.service
           └─8386 /usr/bin/mongod -f /etc/mongod.conf

Nov 17 11:40:33 mongodb_1_p.unidev39.org.np systemd[1]: Started MongoDB Database Server.
Nov 17 11:40:33 mongodb_1_p.unidev39.org.np mongod[8386]: {"t":{"$date":"2023-11-17T05:55:3>
*/

-- Step 26 -->> On All Nodes
[root@mongodb_1_p/mongodb_1_s/mongodb_1_a ~]# mongosh
/*
Current Mongosh Log ID: 6556ffd93f1a3a26e1051529
Connecting to:          mongodb://127.0.0.1:27017/?directConnection=true&serverSelectionTimeoutMS=2000&appName=mongosh+2.0.2
Using MongoDB:          7.0.3
Using Mongosh:          2.0.2

For mongosh info see: https://docs.mongodb.com/mongodb-shell/


To help improve our products, anonymous usage data is collected and sent to MongoDB periodically (https://www.mongodb.com/legal/privacy-policy).
You can opt-out by running the disableTelemetry() command.

------
   The server generated these startup warnings when booting
   2023-11-17T11:38:02.017+05:45: Access control is not enabled for the database. Read and write access to data and configuration is unrestricted
   2023-11-17T11:38:02.017+05:45: /sys/kernel/mm/transparent_hugepage/enabled is 'always'. We suggest setting it to 'never'
------

test> db.version()
7.0.3

test> show databases;
admin   40.00 KiB
config  12.00 KiB
local   72.00 KiB

test> quit()
*/

-- Step 27 -->> On All Nodes
[root@mongodb_1_p/mongodb_1_s/mongodb_1_a ~]# systemctl stop mongod

-- Step 28 -->> On All Nodes
[root@mongodb_1_p/mongodb_1_s/mongodb_1_a ~]# which mongosh
/*
/usr/bin/mongosh
*/

-- Step 28.1 -->> On All Nodes (After MongoDB Version 4.4 the "mongo" shell is not avilable)
[root@mongodb_1_p/mongodb_1_s/mongodb_1_a ~]# cd /usr/bin/
[root@mongodb_1_p/mongodb_1_s/mongodb_1_a bin]# ll | grep mongo
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

-- Step 28.2 -->> On All Nodes
[root@mongodb_1_p/mongodb_1_s/mongodb_1_a bin]# cp mongosh mongo
[root@mongodb_1_p/mongodb_1_s/mongodb_1_a bin]# ll | grep mongo
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

-- Step 28.3 -->> On All Nodes
[root@mongodb_1_p/mongodb_1_s/mongodb_1_a ~]# systemctl start mongod
[root@mongodb_1_p/mongodb_1_s/mongodb_1_a ~]# systemctl status mongod
/*
● mongod.service - MongoDB Database Server
   Loaded: loaded (/usr/lib/systemd/system/mongod.service; enabled; vendor preset: disabled)
   Active: active (running) since Fri 2023-11-17 11:40:35 +0545; 8s ago
     Docs: https://docs.mongodb.org/manual
 Main PID: 8212 (mongod)
   Memory: 177.5M
   CGroup: /system.slice/mongod.service
           └─8212 /usr/bin/mongod -f /etc/mongod.conf

Nov 17 11:40:35 mongodb_1_a.unidev39.org.np systemd[1]: Started MongoDB Database Server.
Nov 17 11:40:35 mongodb_1_a.unidev39.org.np mongod[8212]: {"t":{"$date":"2023-11-17T05:55:35>
*/

-- Step 29 -->> On All Nodes
[root@mongodb_1_p/mongodb_1_s/mongodb_1_a ~]# mongosh
/*
Current Mongosh Log ID: 655700df884f7bd65d3a0433
Connecting to:          mongodb://127.0.0.1:27017/?directConnection=true&serverSelectionTimeoutMS=2000&appName=mongosh+2.0.2
Using MongoDB:          7.0.3
Using Mongosh:          2.0.2

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

------
   The server generated these startup warnings when booting
   2023-11-17T11:40:34.600+05:45: Access control is not enabled for the database. Read and write access to data and configuration is unrestricted
   2023-11-17T11:40:34.600+05:45: /sys/kernel/mm/transparent_hugepage/enabled is 'always'. We suggest setting it to 'never'
------

test> db.version()
7.0.3

test> show databases;
admin   40.00 KiB
config  12.00 KiB
local   72.00 KiB

test> quit()
*/

-- Step 30 -->> On All Nodes
[root@mongodb_1_p/mongodb_1_s/mongodb_1_a ~]# mongo
/*
Current Mongosh Log ID: 6557012f743e323962d1867b
Connecting to:          mongodb://127.0.0.1:27017/?directConnection=true&serverSelectionTimeoutMS=2000&appName=mongosh+2.0.2
Using MongoDB:          7.0.3
Using Mongosh:          2.0.2

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

------
   The server generated these startup warnings when booting
   2023-11-17T11:40:34.600+05:45: Access control is not enabled for the database. Read and write access to data and configuration is unrestricted
   2023-11-17T11:40:34.600+05:45: /sys/kernel/mm/transparent_hugepage/enabled is 'always'. We suggest setting it to 'never'
------

test> db.version()
7.0.3

test> show databases;
admin   40.00 KiB
config  12.00 KiB
local   72.00 KiB

test> quit()
*/

-- Step 31 -->> On All Nodes (Fixing The MongoDB Warnings - /sys/kernel/mm/transparent_hugepage/enabled is 'always'. We suggest setting it to 'never')
[root@mongodb_1_p/mongodb_1_s/mongodb_1_a ~]# vi /etc/systemd/system/disable-mogodb-warnig.service
/*
[Unit]
Description=Disable Transparent Huge Pages (THP)
[Service]
Type=simple
ExecStart=/bin/sh -c "echo 'never' > /sys/kernel/mm/transparent_hugepage/enabled && echo 'never' > /sys/kernel/mm/transparent_hugepage/defrag"
[Install]
WantedBy=multi-user.target
*/

-- Step 31.1 -->> On All Nodes
[root@mongodb_1_p/mongodb_1_s/mongodb_1_a ~]# systemctl daemon-reload
-- Step 31.2 -->> On All Nodes
[root@mongodb_1_p/mongodb_1_s/mongodb_1_a ~]# systemctl start disable-mogodb-warnig.service
-- Step 31.3 -->> On All Nodes
[root@mongodb_1_p/mongodb_1_s/mongodb_1_a ~]# systemctl enable disable-mogodb-warnig.service
/*
Created symlink /etc/systemd/system/multi-user.target.wants/disable-mogodb-warnig.service → /etc/systemd/system/disable-mogodb-warnig.service.
*/

-- Step 31.4 -->> On All Nodes
[root@mongodb_1_p/mongodb_1_s/mongodb_1_a ~]# systemctl restart mongod
-- Step 31.5 -->> On All Nodes
[root@mongodb_1_p/mongodb_1_s/mongodb_1_a ~]# systemctl status mongod
/*
● mongod.service - MongoDB Database Server
   Loaded: loaded (/usr/lib/systemd/system/mongod.service; enabled; vendor preset: disabled)
   Active: active (running) since Fri 2023-11-17 11:46:51 +0545; 6s ago
     Docs: https://docs.mongodb.org/manual
 Main PID: 8743 (mongod)
   Memory: 169.1M
   CGroup: /system.slice/mongod.service
           └─8743 /usr/bin/mongod -f /etc/mongod.conf

Nov 17 11:46:51 mongodb_1_p.unidev39.org.np systemd[1]: mongod.service: Succeeded.
Nov 17 11:46:51 mongodb_1_p.unidev39.org.np systemd[1]: Stopped MongoDB Database Server.
Nov 17 11:46:51 mongodb_1_p.unidev39.org.np systemd[1]: Started MongoDB Database Server.
Nov 17 11:46:51 mongodb_1_p.unidev39.org.np mongod[8743]: {"t":{"$date":"2023-11-17T06:01:5>
*/

-- Step 32 -->> On All Nodes
[root@mongodb_1_p/mongodb_1_s/mongodb_1_a ~]# mongo
/*
Current Mongosh Log ID: 655701fe4bf000d721766f2c
Connecting to:          mongodb://127.0.0.1:27017/?directConnection=true&serverSelectionTimeoutMS=2000&appName=mongosh+2.0.2
Using MongoDB:          7.0.3
Using Mongosh:          2.0.2

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

------
   The server generated these startup warnings when booting
   2023-11-17T11:46:52.301+05:45: Access control is not enabled for the database. Read and write access to data and configuration is unrestricted
------

test> db.version()
7.0.3

test> show dbs
admin   40.00 KiB
config  12.00 KiB
local   72.00 KiB

test> exit;
*/

-- Step 33 -->> On All Nodes
[root@mongodb_1_p/mongodb_1_s/mongodb_1_a ~]# mongosh
/*
Current Mongosh Log ID: 655702726dbd54b1d20baf48
Connecting to:          mongodb://127.0.0.1:27017/?directConnection=true&serverSelectionTimeoutMS=2000&appName=mongosh+2.0.2
Using MongoDB:          7.0.3
Using Mongosh:          2.0.2

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

------
   The server generated these startup warnings when booting
   2023-11-17T11:46:52.301+05:45: Access control is not enabled for the database. Read and write access to data and configuration is unrestricted
------

test> db.version()
7.0.3

test> show dbs
admin   40.00 KiB
config  12.00 KiB
local   72.00 KiB

test> exit;
*/

-- Step 34 -->> On Node 1
[root@mongodb_1_p ~]# mongo
/*
Current Mongosh Log ID: 65570b8e205ce127c794792b
Connecting to:          mongodb://127.0.0.1:27017/?directConnection=true&serverSelectionTimeoutMS=2000&appName=mongosh+2.0.2
Using MongoDB:          7.0.3
Using Mongosh:          2.0.2

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

test> db.version()
7.0.3

test> show dbs
admin   40.00 KiB
config  60.00 KiB
local   72.00 KiB

test> use admin
switched to db admin

admin> db
admin

admin> db.createUser(
... {
...     user: "admin",
...     pwd: "P#ssw0rd",
...     roles: [
...         {
...             role: "userAdminAnyDatabase",
...             db: "admin"
...         },
...         {
...             role: "clusterAdmin",
...              db: "admin"
...         },
...         {
...             role: "root",
...             db: "admin"
...         }
...     ]
... })
{ ok: 1 }

admin> db.getUsers()
{
  users: [
    {
      _id: 'admin.admin',
      userId: new UUID("21fa2e6f-189e-44d5-8aca-20e6b445f0ed"),
      user: 'admin',
      db: 'admin',
      roles: [
        { role: 'clusterAdmin', db: 'admin' },
        { role: 'root', db: 'admin' },
        { role: 'userAdminAnyDatabase', db: 'admin' }
      ],
      mechanisms: [ 'SCRAM-SHA-1', 'SCRAM-SHA-256' ]
    }
  ],
  ok: 1
}

admin> db.auth('admin','P#ssw0rd');
{ ok: 1 }

admin> quit()
*/

-- Step 35 -->> On Node 1
[root@mongodb_1_p ~]# systemctl stop mongod

-- Step 36 -->> On Node 1 (Access control is enabled for the database)
[root@mongodb_1_p ~]# vi /etc/mongod.conf
/*
#security:
security:
 authorization: enabled
*/

-- Step 37 -->> On Node 1
[root@mongodb_1_p ~]# systemctl start mongod

-- Step 38 -->> On Node 1
[root@mongodb_1_p ~]# systemctl status mongod
/*
● mongod.service - MongoDB Database Server
   Loaded: loaded (/usr/lib/systemd/system/mongod.service; enabled; vendor preset: disabled)
   Active: active (running) since Fri 2023-11-17 15:17:56 +0545; 6s ago
     Docs: https://docs.mongodb.org/manual
 Main PID: 5516 (mongod)
   Memory: 172.4M
   CGroup: /system.slice/mongod.service
           └─5516 /usr/bin/mongod -f /etc/mongod.conf

Nov 17 15:17:56 mongodb_1_p.unidev39.org.np systemd[1]: Started MongoDB Database Server.
Nov 17 15:17:56 mongodb_1_p.unidev39.org.np mongod[5516]: {"t":{"$date":"2023-11-17T09:32:56>
*/

-- Step 39 -->> On Node 1
[mongodb@mongodb_1_p ~]# mongo
/*
Current Mongosh Log ID: 65570d11755bcb351db72e22
Connecting to:          mongodb://127.0.0.1:27017/?directConnection=true&serverSelectionTimeoutMS=2000&appName=mongosh+2.0.2
Using MongoDB:          7.0.3
Using Mongosh:          2.0.2

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

test> db.version()
7.0.3

test> show dbs
MongoServerError: Command listDatabases requires authentication

test> quit()
*/

-- Step 40 -->> On Node 1
[mongodb@mongodb_1_p ~]$ mongo --host 127.0.0.1 --port 27017 -u admin -p P#ssw0rd --authenticationDatabase admin
/*
Current Mongosh Log ID: 65570d4c1e0a8f9a74de2ede
Connecting to:          mongodb://<credentials>@127.0.0.1:27017/?directConnection=true&serverSelectionTimeoutMS=2000&authSource=admin&appName=mongosh+2.0.2
Using MongoDB:          7.0.3
Using Mongosh:          2.0.2

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

test> show dbs
admin   132.00 KiB
config  108.00 KiB
local    72.00 KiB

test> exit
*/

-- Step 41 -->> On Node 1
[mongodb@mongodb_1_p ~]$ mongo --host 192.168.56.149  --port 27017 -u admin -p P#ssw0rd --authenticationDatabase admin
/*
Current Mongosh Log ID: 65570d5b44d95851aa3a7826
Connecting to:          mongodb://<credentials>@192.168.56.149:27017/?directConnection=true&authSource=admin&appName=mongosh+2.0.2
Using MongoDB:          7.0.3
Using Mongosh:          2.0.2

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

test> show dbs
admin   132.00 KiB
config  108.00 KiB
local    72.00 KiB

test> use admin
switched to db admin

admin> db
admin

admin> db.getUsers()
{
  users: [
    {
      _id: 'admin.admin',
      userId: new UUID("21fa2e6f-189e-44d5-8aca-20e6b445f0ed"),
      user: 'admin',
      db: 'admin',
      roles: [
        { role: 'clusterAdmin', db: 'admin' },
        { role: 'root', db: 'admin' },
        { role: 'userAdminAnyDatabase', db: 'admin' }
      ],
      mechanisms: [ 'SCRAM-SHA-1', 'SCRAM-SHA-256' ]
    }
  ],
  ok: 1
}

admin> quit()
*/

-- Step 42 -->> On Node 2
[root@mongodb_1_s ~]# systemctl stop mongod

-- Step 43 -->> On Node 2 (Access control is enabled for the database)
[root@mongodb_1_s ~]# vi /etc/mongod.conf
/*
#security:
security:
 authorization: enabled
*/

-- Step 44 -->> On Node 2
[root@mongodb_1_s ~]# systemctl start mongod

-- Step 45 -->> On Node 2
[root@mongodb_1_s ~]# systemctl status mongod
/*
● mongod.service - MongoDB Database Server
   Loaded: loaded (/usr/lib/systemd/system/mongod.service; enabled; vendor preset: disabled)
   Active: active (running) since Fri 2023-11-17 12:39:01 +0545; 17s ago
     Docs: https://docs.mongodb.org/manual
 Main PID: 5529 (mongod)
   Memory: 169.3M
   CGroup: /system.slice/mongod.service
           └─5529 /usr/bin/mongod -f /etc/mongod.conf

Nov 17 12:39:01 mongodb_1_s.unidev39.org.np systemd[1]: Started MongoDB Database Server.
Nov 17 12:39:01 mongodb_1_s.unidev39.org.np mongod[5529]: {"t":{"$date":"2023-11-17T06:54:01.162Z">
*/

-- Step 46 -->> On Node 3
[root@mongodb_1_a ~]# systemctl stop mongod

-- Step 47 -->> On Node 3 (Access control is enabled for the database)
[root@mongodb_1_a ~]# vi /etc/mongod.conf
/*
#security:
security:
 authorization: enabled
*/

-- Step 48 -->> On Node 3
[root@mongodb_1_a ~]# systemctl start mongod

-- Step 49 -->> On Node 3
[root@mongodb_1_a ~]# systemctl status mongod
/*
● mongod.service - MongoDB Database Server
   Loaded: loaded (/usr/lib/systemd/system/mongod.service; enabled; vendor preset: disabled)
   Active: active (running) since Fri 2023-11-17 12:41:44 +0545; 4s ago
     Docs: https://docs.mongodb.org/manual
 Main PID: 5590 (mongod)
   Memory: 168.9M
   CGroup: /system.slice/mongod.service
           └─5590 /usr/bin/mongod -f /etc/mongod.conf

Nov 17 12:41:44 mongodb_1_a.unidev39.org.np systemd[1]: Started MongoDB Database Server.
Nov 17 12:41:44 mongodb_1_a.unidev39.org.np mongod[5590]: {"t":{"$date":"2023-11-17T06:56:44.803Z">
*/

-- Step 50 -->> On All Nodes (Replication Configuration)
[root@mongodb_1_p/mongodb_1_s/mongodb_1_a ~] vi /etc/mongod.conf
/*
#replication:
replication:
 replSetName: rs0
*/

-- Step 51 -->> On Node 1 
[root@mongodb_1_p ~]# cd /data/mongodb/

-- Step 51.1 -->> On Node 1
[root@mongodb_1_p mongodb]# ll
/*
-rw------- 1 mongod mongod 20480 Nov 17 12:46 collection-0--3359960474700053076.wt
-rw------- 1 mongod mongod 36864 Nov 17 12:51 collection-0--5365481942499444889.wt
-rw------- 1 mongod mongod 36864 Nov 17 12:52 collection-2--5365481942499444889.wt
-rw------- 1 mongod mongod 36864 Nov 17 12:33 collection-4--5365481942499444889.wt
drwx------ 2 mongod mongod  4096 Nov 17 12:53 diagnostic.data
-rw------- 1 mongod mongod 20480 Nov 17 12:33 index-1--3359960474700053076.wt
-rw------- 1 mongod mongod 36864 Nov 17 12:51 index-1--5365481942499444889.wt
-rw------- 1 mongod mongod 20480 Nov 17 12:46 index-2--3359960474700053076.wt
-rw------- 1 mongod mongod 36864 Nov 17 12:52 index-3--5365481942499444889.wt
-rw------- 1 mongod mongod 36864 Nov 17 12:46 index-5--5365481942499444889.wt
-rw------- 1 mongod mongod 36864 Nov 17 12:52 index-6--5365481942499444889.wt
drwx------ 2 mongod mongod   110 Nov 17 12:51 journal
-rw------- 1 mongod mongod 36864 Nov 17 12:51 _mdb_catalog.wt
-rw------- 1 mongod mongod     5 Nov 17 12:51 mongod.lock
-rw------- 1 mongod mongod 36864 Nov 17 12:52 sizeStorer.wt
-rw------- 1 mongod mongod   114 Nov 17 11:38 storage.bson
-rw------- 1 mongod mongod    50 Nov 17 11:38 WiredTiger
-rw------- 1 mongod mongod  4096 Nov 17 12:51 WiredTigerHS.wt
-rw------- 1 mongod mongod    21 Nov 17 11:38 WiredTiger.lock
-rw------- 1 mongod mongod  1470 Nov 17 12:52 WiredTiger.turtle
-rw------- 1 mongod mongod 77824 Nov 17 12:52 WiredTiger.wt
*/

-- Step 51.2 -->> On Node 1
[root@mongodb_1_p mongodb]# openssl rand -base64 756 > keyfile
-- Step 51.3 -->> On Node 1
[root@mongodb_1_p mongodb]# chmod 400 keyfile
-- Step 51.4 -->> On Node 1
[root@mongodb_1_p mongodb]# chown mongod:mongod keyfile
-- Step 51.5 -->> On Node 1
[root@mongodb_1_p mongodb]# ll
/*
-rw------- 1 mongod mongod 20480 Nov 17 12:46 collection-0--3359960474700053076.wt
-rw------- 1 mongod mongod 36864 Nov 17 12:51 collection-0--5365481942499444889.wt
-rw------- 1 mongod mongod 36864 Nov 17 12:52 collection-2--5365481942499444889.wt
-rw------- 1 mongod mongod 36864 Nov 17 12:33 collection-4--5365481942499444889.wt
drwx------ 2 mongod mongod  4096 Nov 17 12:55 diagnostic.data
-rw------- 1 mongod mongod 20480 Nov 17 12:33 index-1--3359960474700053076.wt
-rw------- 1 mongod mongod 36864 Nov 17 12:51 index-1--5365481942499444889.wt
-rw------- 1 mongod mongod 20480 Nov 17 12:46 index-2--3359960474700053076.wt
-rw------- 1 mongod mongod 36864 Nov 17 12:52 index-3--5365481942499444889.wt
-rw------- 1 mongod mongod 36864 Nov 17 12:46 index-5--5365481942499444889.wt
-rw------- 1 mongod mongod 36864 Nov 17 12:52 index-6--5365481942499444889.wt
drwx------ 2 mongod mongod   110 Nov 17 12:51 journal
-r-------- 1 mongod mongod  1024 Nov 17 12:54 keyfile
-rw------- 1 mongod mongod 36864 Nov 17 12:51 _mdb_catalog.wt
-rw------- 1 mongod mongod     5 Nov 17 12:51 mongod.lock
-rw------- 1 mongod mongod 36864 Nov 17 12:52 sizeStorer.wt
-rw------- 1 mongod mongod   114 Nov 17 11:38 storage.bson
-rw------- 1 mongod mongod    50 Nov 17 11:38 WiredTiger
-rw------- 1 mongod mongod  4096 Nov 17 12:51 WiredTigerHS.wt
-rw------- 1 mongod mongod    21 Nov 17 11:38 WiredTiger.lock
-rw------- 1 mongod mongod  1470 Nov 17 12:54 WiredTiger.turtle
-rw------- 1 mongod mongod 77824 Nov 17 12:54 WiredTiger.wt
*/

-- Step 51.6 -->> On Node 1
[root@mongodb_1_p mongodb]# ll | grep keyfile
/*
-r-------- 1 mongod mongod  1024 Nov 17 12:54 keyfile
*/

-- Step 51.7 -->> On Node 1
[root@mongodb_1_p mongodb]# scp -r keyfile root@mongodb_1_s:/data/mongodb
/*
The authenticity of host 'mongodb_1_s (192.168.56.150)' can't be established.
ECDSA key fingerprint is SHA256:8LSecKw8+L5LHTrspajxlzJvHbKd6BttSMepKXCBTvw.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added 'mongodb_1_s,192.168.56.150' (ECDSA) to the list of known hosts.
root@mongodb_1_s's password:
keyfile                                                   100% 1024   740.1KB/s   00:00
*/

-- Step 51.8 -->> On Node 1
[root@mongodb_1_p mongodb]# scp -r keyfile root@mongodb_1_a:/data/mongodb
/*
The authenticity of host 'mongodb_1_a (192.168.56.151)' can't be established.
ECDSA key fingerprint is SHA256:8LSecKw8+L5LHTrspajxlzJvHbKd6BttSMepKXCBTvw.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added 'mongodb_1_a,192.168.56.151' (ECDSA) to the list of known hosts.
root@mongodb_1_a's password:
keyfile                                                   100% 1024   504.1KB/s   00:00
*/

-- Step 51.9 -->> On Node 2
[root@mongodb_1_s ~]# cd /data/mongodb/
-- Step 51.10 -->> On Node 2
[root@mongodb_1_s mongodb]# ll | grep keyfile
/*
-r-------- 1 root   root    1024 Nov 17 12:57 keyfile
*/

-- Step 51.11 -->> On Node 2
[root@mongodb_1_s mongodb]# chmod 400 keyfile
-- Step 51.12 -->> On Node 2
[root@mongodb_1_s mongodb]# chown mongod:mongod keyfile
-- Step 51.13 -->> On Node 2
[root@mongodb_1_s mongodb]# ll | grep keyfile
/*
-r-------- 1 mongod mongod  1024 Nov 17 12:57 keyfile
*/

-- Step 51.14 -->> On Node 3
[root@mongodb_1_a ~]# cd /data/mongodb/
-- Step 51.15 -->> On Node 3
[root@mongodb_1_a mongodb]# ll | grep keyfile
/*
-r-------- 1 root   root    1024 Nov 17 12:58 keyfile
*/

-- Step 51.16 -->> On Node 3
[root@mongodb_1_a mongodb]# chmod 400 keyfile
-- Step 51.17 -->> On Node 3
[root@mongodb_1_a mongodb]# chown mongod:mongod keyfile
-- Step 51.18 -->> On Node 3
[root@mongodb_1_a mongodb]# ll | grep keyfile
/*
-r-------- 1 mongod mongod  1024 Nov 17 12:58 keyfile
*/

-- Step 51.19 -->> On All Nodes
[root@mongodb_1_p/mongodb_1_s/mongodb_1_a ~]#
/*
#security:
security:
 authorization: enabled
 keyFile: /data/mongodb/keyfile
*/

-- Step 51.20 -->> On All Nodes
[root@mongodb_1_p/mongodb_1_s/mongodb_1_a ~]# systemctl restart mongod
-- Step 51.20 -->> On All Nodes
[root@mongodb_1_p/mongodb_1_s/mongodb_1_a ~]# systemctl status mongod
/*
● mongod.service - MongoDB Database Server
   Loaded: loaded (/usr/lib/systemd/system/mongod.service; enabled; vendor preset: disabled)
   Active: active (running) since Fri 2023-11-17 13:07:58 +0545; 7s ago
     Docs: https://docs.mongodb.org/manual
 Main PID: 7454 (mongod)
   Memory: 179.6M
   CGroup: /system.slice/mongod.service
           └─7454 /usr/bin/mongod -f /etc/mongod.conf

Nov 17 13:07:58 mongodb_1_p.unidev39.org.np systemd[1]: mongod.service: Succeeded.
Nov 17 13:07:58 mongodb_1_p.unidev39.org.np systemd[1]: Stopped MongoDB Database Server.
Nov 17 13:07:58 mongodb_1_p.unidev39.org.np systemd[1]: Started MongoDB Database Server.
Nov 17 13:07:59 mongodb_1_p.unidev39.org.np mongod[7454]: {"t":{"$date":"2023-11-17T07:22:5>
*/

-- Step 52 -->> On Node 1
[root@mongodb_1_p ~]# mongo --host 192.168.56.149  --port 27017 -u admin -p P#ssw0rd --authenticationDatabase admin
/*
Current Mongosh Log ID: 65571633b28e9d0277f8de6f
Connecting to:          mongodb://<credentials>@192.168.56.149:27017/?directConnection=true&authSource=admin&appName=mongosh+2.0.2
Using MongoDB:          7.0.3
Using Mongosh:          2.0.2

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

test> use admin
switched to db admin

admin> db
admin

admin> db.auth('admin','P#ssw0rd');
{ ok: 1 }

admin> rs.initiate(
...    {
...       _id: "rs0",
...       version: 1,
...       members: [
...          { _id: 0, host : "mongodb_1_p:27017" }
...       ]
...    }
... )
{ ok: 1 }

rs0 [direct: other] admin> 

rs0 [direct: primary] admin> rs.add("mongodb_1_s:27017");
{
  ok: 1,
  '$clusterTime': {
    clusterTime: Timestamp({ t: 1700206291, i: 1 }),
    signature: {
      hash: Binary.createFromBase64("GM/FMfjNTwOd+EhQwKfGPz39tXQ=", 0),
      keyId: Long("7302330360463884295")
    }
  },
  operationTime: Timestamp({ t: 1700206291, i: 1 })
}

rs0 [direct: primary] admin> quit()
*/

-- Step 53 -->> On Node 1
[root@mongodb_1_p ~]# mongo --port 27017 -u admin -p P#ssw0rd --authenticationDatabase admin
/*
Current Mongosh Log ID: 655717579e3d48904753b894
Connecting to:          mongodb://<credentials>@127.0.0.1:27017/?directConnection=true&serverSelectionTimeoutMS=2000&authSource=admin&appName=mongosh+2.0.2
Using MongoDB:          7.0.3
Using Mongosh:          2.0.2

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

rs0 [direct: primary] test> use admin
switched to db admin

rs0 [direct: primary] admin> show dbs
admin   172.00 KiB
config  176.00 KiB
local   436.00 KiB

rs0 [direct: primary] admin> db.version()
7.0.3

rs0 [direct: primary] admin> rs.status()
{
  set: 'rs0',
  date: ISODate("2023-11-17T07:34:42.045Z"),
  myState: 1,
  term: Long("1"),
  syncSourceHost: '',
  syncSourceId: -1,
  heartbeatIntervalMillis: Long("2000"),
  majorityVoteCount: 2,
  writeMajorityCount: 2,
  votingMembersCount: 2,
  writableVotingMembersCount: 2,
  optimes: {
    lastCommittedOpTime: { ts: Timestamp({ t: 1700206478, i: 1 }), t: Long("1") },
    lastCommittedWallTime: ISODate("2023-11-17T07:34:38.271Z"),
    readConcernMajorityOpTime: { ts: Timestamp({ t: 1700206478, i: 1 }), t: Long("1") },
    appliedOpTime: { ts: Timestamp({ t: 1700206478, i: 1 }), t: Long("1") },
    durableOpTime: { ts: Timestamp({ t: 1700206478, i: 1 }), t: Long("1") },
    lastAppliedWallTime: ISODate("2023-11-17T07:34:38.271Z"),
    lastDurableWallTime: ISODate("2023-11-17T07:34:38.271Z")
  },
  lastStableRecoveryTimestamp: Timestamp({ t: 1700206448, i: 1 }),
  electionCandidateMetrics: {
    lastElectionReason: 'electionTimeout',
    lastElectionDate: ISODate("2023-11-17T07:31:18.200Z"),
    electionTerm: Long("1"),
    lastCommittedOpTimeAtElection: { ts: Timestamp({ t: 1700206278, i: 1 }), t: Long("-1") },
    lastSeenOpTimeAtElection: { ts: Timestamp({ t: 1700206278, i: 1 }), t: Long("-1") },
    numVotesNeeded: 1,
    priorityAtElection: 1,
    electionTimeoutMillis: Long("10000"),
    newTermStartDate: ISODate("2023-11-17T07:31:18.223Z"),
    wMajorityWriteAvailabilityDate: ISODate("2023-11-17T07:31:18.238Z")
  },
  members: [
    {
      _id: 0,
      name: 'mongodb_1_p:27017',
      health: 1,
      state: 1,
      stateStr: 'PRIMARY',
      uptime: 703,
      optime: { ts: Timestamp({ t: 1700206478, i: 1 }), t: Long("1") },
      optimeDate: ISODate("2023-11-17T07:34:38.000Z"),
      lastAppliedWallTime: ISODate("2023-11-17T07:34:38.271Z"),
      lastDurableWallTime: ISODate("2023-11-17T07:34:38.271Z"),
      syncSourceHost: '',
      syncSourceId: -1,
      infoMessage: '',
      electionTime: Timestamp({ t: 1700206278, i: 2 }),
      electionDate: ISODate("2023-11-17T07:31:18.000Z"),
      configVersion: 3,
      configTerm: 1,
      self: true,
      lastHeartbeatMessage: ''
    },
    {
      _id: 1,
      name: 'mongodb_1_s:27017',
      health: 1,
      state: 2,
      stateStr: 'SECONDARY',
      uptime: 190,
      optime: { ts: Timestamp({ t: 1700206478, i: 1 }), t: Long("1") },
      optimeDurable: { ts: Timestamp({ t: 1700206478, i: 1 }), t: Long("1") },
      optimeDate: ISODate("2023-11-17T07:34:38.000Z"),
      optimeDurableDate: ISODate("2023-11-17T07:34:38.000Z"),
      lastAppliedWallTime: ISODate("2023-11-17T07:34:38.271Z"),
      lastDurableWallTime: ISODate("2023-11-17T07:34:38.271Z"),
      lastHeartbeat: ISODate("2023-11-17T07:34:41.674Z"),
      lastHeartbeatRecv: ISODate("2023-11-17T07:34:41.674Z"),
      pingMs: Long("0"),
      lastHeartbeatMessage: '',
      syncSourceHost: 'mongodb_1_p:27017',
      syncSourceId: 0,
      infoMessage: '',
      configVersion: 3,
      configTerm: 1
    }
  ],
  ok: 1,
  '$clusterTime': {
    clusterTime: Timestamp({ t: 1700206478, i: 1 }),
    signature: {
      hash: Binary.createFromBase64("8+HciG766XDnWAhPUhj/f9J3p+o=", 0),
      keyId: Long("7302330360463884295")
    }
  },
  operationTime: Timestamp({ t: 1700206478, i: 1 })
}

rs0 [direct: primary] admin> quit()
*/

-- Step 54 -->> On Node 1
[root@mongodb_1_p ~]# mongo --port 27017 -u admin -p P#ssw0rd --authenticationDatabase admin
/*
Current Mongosh Log ID: 6557183d025ae33eacf6f298
Connecting to:          mongodb://<credentials>@127.0.0.1:27017/?directConnection=true&serverSelectionTimeoutMS=2000&authSource=admin&appName=mongosh+2.0.2
Using MongoDB:          7.0.3
Using Mongosh:          2.0.2

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

rs0 [direct: primary] test> db.version()
7.0.3

rs0 [direct: primary] test> show dbs
admin   172.00 KiB
config  176.00 KiB
local   436.00 KiB

rs0 [direct: primary] test> use admin
switched to db admin

rs0 [direct: primary] admin> db
admin

rs0 [direct: primary] admin> db.getUsers()
{
  users: [
    {
      _id: 'admin.admin',
      userId: new UUID("21fa2e6f-189e-44d5-8aca-20e6b445f0ed"),
      user: 'admin',
      db: 'admin',
      roles: [
        { role: 'clusterAdmin', db: 'admin' },
        { role: 'root', db: 'admin' },
        { role: 'userAdminAnyDatabase', db: 'admin' }
      ],
      mechanisms: [ 'SCRAM-SHA-1', 'SCRAM-SHA-256' ]
    }
  ],
  ok: 1,
  '$clusterTime': {
    clusterTime: Timestamp({ t: 1700206680, i: 5 }),
    signature: {
      hash: Binary.createFromBase64("33dUsO8IUu5SCdzHXaIflF4aMlc=", 0),
      keyId: Long("7302330360463884295")
    }
  },
  operationTime: Timestamp({ t: 1700206680, i: 5 })
}

rs0 [direct: primary] admin> rs.addArb("mongodb_1_a:27017");
MongoServerError: Reconfig attempted to install a config that would change the implicit default write concern. Use the setDefaultRWConcern command to set a cluster-wide write concern and try the reconfig again.

-- To fix the above issue (MongoServerError: Reconfig attempted to install a config that would change the implicit default write concern. Use the setDefaultRWConcern command to set a cluster-wide write concern and try the reconfig again.)

rs0 [direct: primary] admin> db.adminCommand({
... setDefaultRWConcern: 1,
... defaultWriteConcern: { w: 1 }
... })
{
  defaultReadConcern: { level: 'local' },
  defaultWriteConcern: { w: 1, wtimeout: 0 },
  updateOpTime: Timestamp({ t: 1700206838, i: 1 }),
  updateWallClockTime: ISODate("2023-11-17T07:40:45.565Z"),
  defaultWriteConcernSource: 'global',
  defaultReadConcernSource: 'implicit',
  localUpdateWallClockTime: ISODate("2023-11-17T07:40:45.575Z"),
  ok: 1,
  '$clusterTime': {
    clusterTime: Timestamp({ t: 1700206845, i: 2 }),
    signature: {
      hash: Binary.createFromBase64("Czv/EZGdmquFvm+M2GsVCK8ejrw=", 0),
      keyId: Long("7302330360463884295")
    }
  },
  operationTime: Timestamp({ t: 1700206845, i: 2 })
}

rs0 [direct: primary] admin>  rs.addArb("mongodb_1_a:27017");
{
  ok: 1,
  '$clusterTime': {
    clusterTime: Timestamp({ t: 1700206854, i: 1 }),
    signature: {
      hash: Binary.createFromBase64("Wy1AQVV27M6peuioxaMtn9nwqMM=", 0),
      keyId: Long("7302330360463884295")
    }
  },
  operationTime: Timestamp({ t: 1700206854, i: 1 })
}

rs0 [direct: primary] admin> rs.status()
{
  set: 'rs0',
  date: ISODate("2023-11-17T07:41:30.157Z"),
  myState: 1,
  term: Long("1"),
  syncSourceHost: '',
  syncSourceId: -1,
  heartbeatIntervalMillis: Long("2000"),
  majorityVoteCount: 2,
  writeMajorityCount: 2,
  votingMembersCount: 3,
  writableVotingMembersCount: 2,
  optimes: {
    lastCommittedOpTime: { ts: Timestamp({ t: 1700206888, i: 1 }), t: Long("1") },
    lastCommittedWallTime: ISODate("2023-11-17T07:41:28.350Z"),
    readConcernMajorityOpTime: { ts: Timestamp({ t: 1700206888, i: 1 }), t: Long("1") },
    appliedOpTime: { ts: Timestamp({ t: 1700206888, i: 1 }), t: Long("1") },
    durableOpTime: { ts: Timestamp({ t: 1700206888, i: 1 }), t: Long("1") },
    lastAppliedWallTime: ISODate("2023-11-17T07:41:28.350Z"),
    lastDurableWallTime: ISODate("2023-11-17T07:41:28.350Z")
  },
  lastStableRecoveryTimestamp: Timestamp({ t: 1700206868, i: 1 }),
  electionCandidateMetrics: {
    lastElectionReason: 'electionTimeout',
    lastElectionDate: ISODate("2023-11-17T07:31:18.200Z"),
    electionTerm: Long("1"),
    lastCommittedOpTimeAtElection: { ts: Timestamp({ t: 1700206278, i: 1 }), t: Long("-1") },
    lastSeenOpTimeAtElection: { ts: Timestamp({ t: 1700206278, i: 1 }), t: Long("-1") },
    numVotesNeeded: 1,
    priorityAtElection: 1,
    electionTimeoutMillis: Long("10000"),
    newTermStartDate: ISODate("2023-11-17T07:31:18.223Z"),
    wMajorityWriteAvailabilityDate: ISODate("2023-11-17T07:31:18.238Z")
  },
  members: [
    {
      _id: 0,
      name: 'mongodb_1_p:27017',
      health: 1,
      state: 1,
      stateStr: 'PRIMARY',
      uptime: 1111,
      optime: { ts: Timestamp({ t: 1700206888, i: 1 }), t: Long("1") },
      optimeDate: ISODate("2023-11-17T07:41:28.000Z"),
      lastAppliedWallTime: ISODate("2023-11-17T07:41:28.350Z"),
      lastDurableWallTime: ISODate("2023-11-17T07:41:28.350Z"),
      syncSourceHost: '',
      syncSourceId: -1,
      infoMessage: '',
      electionTime: Timestamp({ t: 1700206278, i: 2 }),
      electionDate: ISODate("2023-11-17T07:31:18.000Z"),
      configVersion: 4,
      configTerm: 1,
      self: true,
      lastHeartbeatMessage: ''
    },
    {
      _id: 1,
      name: 'mongodb_1_s:27017',
      health: 1,
      state: 2,
      stateStr: 'SECONDARY',
      uptime: 598,
      optime: { ts: Timestamp({ t: 1700206888, i: 1 }), t: Long("1") },
      optimeDurable: { ts: Timestamp({ t: 1700206888, i: 1 }), t: Long("1") },
      optimeDate: ISODate("2023-11-17T07:41:28.000Z"),
      optimeDurableDate: ISODate("2023-11-17T07:41:28.000Z"),
      lastAppliedWallTime: ISODate("2023-11-17T07:41:28.350Z"),
      lastDurableWallTime: ISODate("2023-11-17T07:41:28.350Z"),
      lastHeartbeat: ISODate("2023-11-17T07:41:28.958Z"),
      lastHeartbeatRecv: ISODate("2023-11-17T07:41:28.953Z"),
      pingMs: Long("0"),
      lastHeartbeatMessage: '',
      syncSourceHost: 'mongodb_1_p:27017',
      syncSourceId: 0,
      infoMessage: '',
      configVersion: 4,
      configTerm: 1
    },
    {
      _id: 2,
      name: 'mongodb_1_a:27017',
      health: 1,
      state: 7,
      stateStr: 'ARBITER',
      uptime: 35,
      lastHeartbeat: ISODate("2023-11-17T07:41:29.059Z"),
      lastHeartbeatRecv: ISODate("2023-11-17T07:41:29.058Z"),
      pingMs: Long("0"),
      lastHeartbeatMessage: '',
      syncSourceHost: '',
      syncSourceId: -1,
      infoMessage: '',
      configVersion: 4,
      configTerm: 1
    }
  ],
  ok: 1,
  '$clusterTime': {
    clusterTime: Timestamp({ t: 1700206888, i: 1 }),
    signature: {
      hash: Binary.createFromBase64("t+gatS3EMxzVYQPAA68sIBfza3M=", 0),
      keyId: Long("7302330360463884295")
    }
  },
  operationTime: Timestamp({ t: 1700206888, i: 1 })
}

rs0 [direct: primary] admin> show dbs
admin   172.00 KiB
config  252.00 KiB
local   436.00 KiB

rs0 [direct: primary] admin> quit()
*/

-- Step 55 -->> On Node 1
[root@mongodb_1_p ~]# mongo --port 27017 -u admin -p P#ssw0rd --authenticationDatabase admin
/*
Current Mongosh Log ID: 655719c0b64ca26f04b85741
Connecting to:          mongodb://<credentials>@127.0.0.1:27017/?directConnection=true&serverSelectionTimeoutMS=2000&authSource=admin&appName=mongosh+2.0.2
Using MongoDB:          7.0.3
Using Mongosh:          2.0.2

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

rs0 [direct: primary] test> show dbs
admin   172.00 KiB
config  252.00 KiB
local   436.00 KiB

rs0 [direct: primary] test> use admin
switched to db admin

rs0 [direct: primary] admin> rs.conf()
{
  _id: 'rs0',
  version: 4,
  term: 1,
  members: [
    {
      _id: 0,
      host: 'mongodb_1_p:27017',
      arbiterOnly: false,
      buildIndexes: true,
      hidden: false,
      priority: 1,
      tags: {},
      secondaryDelaySecs: Long("0"),
      votes: 1
    },
    {
      _id: 1,
      host: 'mongodb_1_s:27017',
      arbiterOnly: false,
      buildIndexes: true,
      hidden: false,
      priority: 1,
      tags: {},
      secondaryDelaySecs: Long("0"),
      votes: 1
    },
    {
      _id: 2,
      host: 'mongodb_1_a:27017',
      arbiterOnly: true,
      buildIndexes: true,
      hidden: false,
      priority: 0,
      tags: {},
      secondaryDelaySecs: Long("0"),
      votes: 1
    }
  ],
  protocolVersion: Long("1"),
  writeConcernMajorityJournalDefault: true,
  settings: {
    chainingAllowed: true,
    heartbeatIntervalMillis: 2000,
    heartbeatTimeoutSecs: 10,
    electionTimeoutMillis: 10000,
    catchUpTimeoutMillis: -1,
    catchUpTakeoverDelayMillis: 30000,
    getLastErrorModes: {},
    getLastErrorDefaults: { w: 1, wtimeout: 0 },
    replicaSetId: ObjectId("655716c6483b31f1877793b9")
  }
}

rs0 [direct: primary] admin> rs.isMaster()
{
  topologyVersion: {
    processId: ObjectId("655714d3483b31f1877792e9"),
    counter: Long("9")
  },
  hosts: [ 'mongodb_1_p:27017', 'mongodb_1_s:27017' ],
  arbiters: [ 'mongodb_1_a:27017' ],
  setName: 'rs0',
  setVersion: 4,
  ismaster: true,
  secondary: false,
  primary: 'mongodb_1_p:27017',
  me: 'mongodb_1_p:27017',
  electionId: ObjectId("7fffffff0000000000000001"),
  lastWrite: {
    opTime: { ts: Timestamp({ t: 1700207128, i: 1 }), t: Long("1") },
    lastWriteDate: ISODate("2023-11-17T07:45:28.000Z"),
    majorityOpTime: { ts: Timestamp({ t: 1700207128, i: 1 }), t: Long("1") },
    majorityWriteDate: ISODate("2023-11-17T07:45:28.000Z")
  },
  maxBsonObjectSize: 16777216,
  maxMessageSizeBytes: 48000000,
  maxWriteBatchSize: 100000,
  localTime: ISODate("2023-11-17T07:45:31.536Z"),
  logicalSessionTimeoutMinutes: 30,
  connectionId: 64,
  minWireVersion: 0,
  maxWireVersion: 21,
  readOnly: false,
  ok: 1,
  '$clusterTime': {
    clusterTime: Timestamp({ t: 1700207128, i: 1 }),
    signature: {
      hash: Binary.createFromBase64("I+2Ni9RbbQntEe2n9iki82oZYTo=", 0),
      keyId: Long("7302330360463884295")
    }
  },
  operationTime: Timestamp({ t: 1700207128, i: 1 }),
  isWritablePrimary: true
}

-- Step A - To make it High Primary Always (By chaging the priority => 10)

rs0 [direct: primary] admin> cfg = rs.conf()
{
  _id: 'rs0',
  version: 4,
  term: 1,
  members: [
    {
      _id: 0,
      host: 'mongodb_1_p:27017',
      arbiterOnly: false,
      buildIndexes: true,
      hidden: false,
      priority: 1,
      tags: {},
      secondaryDelaySecs: Long("0"),
      votes: 1
    },
    {
      _id: 1,
      host: 'mongodb_1_s:27017',
      arbiterOnly: false,
      buildIndexes: true,
      hidden: false,
      priority: 1,
      tags: {},
      secondaryDelaySecs: Long("0"),
      votes: 1
    },
    {
      _id: 2,
      host: 'mongodb_1_a:27017',
      arbiterOnly: true,
      buildIndexes: true,
      hidden: false,
      priority: 0,
      tags: {},
      secondaryDelaySecs: Long("0"),
      votes: 1
    }
  ],
  protocolVersion: Long("1"),
  writeConcernMajorityJournalDefault: true,
  settings: {
    chainingAllowed: true,
    heartbeatIntervalMillis: 2000,
    heartbeatTimeoutSecs: 10,
    electionTimeoutMillis: 10000,
    catchUpTimeoutMillis: -1,
    catchUpTakeoverDelayMillis: 30000,
    getLastErrorModes: {},
    getLastErrorDefaults: { w: 1, wtimeout: 0 },
    replicaSetId: ObjectId("6557358cbc98f429c9f90944")
  }
}

-- Step B - To make it High Primary Always (By chaging the priority => 10)

rs0 [direct: primary] admin> cfg.members[0].priority = 10
10
rs0 [direct: primary] admin> rs.reconfig(cfg)
{
  ok: 1,
  '$clusterTime': {
    clusterTime: Timestamp({ t: 1700214347, i: 1 }),
    signature: {
      hash: Binary.createFromBase64("cPTBpcJgHDqT+J9HSQ/7kqEh8As=", 0),
      keyId: Long("7302364196216242183")
    }
  },
  operationTime: Timestamp({ t: 1700214347, i: 1 })
}

-- Step C - To make it High Primary Always (By chaging the priority => 10)

rs0 [direct: primary] admin> rs.conf()
{
  _id: 'rs0',
  version: 5,
  term: 1,
  members: [
    {
      _id: 0,
      host: 'mongodb_1_p:27017',
      arbiterOnly: false,
      buildIndexes: true,
      hidden: false,
      priority: 10,
      tags: {},
      secondaryDelaySecs: Long("0"),
      votes: 1
    },
    {
      _id: 1,
      host: 'mongodb_1_s:27017',
      arbiterOnly: false,
      buildIndexes: true,
      hidden: false,
      priority: 1,
      tags: {},
      secondaryDelaySecs: Long("0"),
      votes: 1
    },
    {
      _id: 2,
      host: 'mongodb_1_a:27017',
      arbiterOnly: true,
      buildIndexes: true,
      hidden: false,
      priority: 0,
      tags: {},
      secondaryDelaySecs: Long("0"),
      votes: 1
    }
  ],
  protocolVersion: Long("1"),
  writeConcernMajorityJournalDefault: true,
  settings: {
    chainingAllowed: true,
    heartbeatIntervalMillis: 2000,
    heartbeatTimeoutSecs: 10,
    electionTimeoutMillis: 10000,
    catchUpTimeoutMillis: -1,
    catchUpTakeoverDelayMillis: 30000,
    getLastErrorModes: {},
    getLastErrorDefaults: { w: 1, wtimeout: 0 },
    replicaSetId: ObjectId("6557358cbc98f429c9f90944")
  }
}

rs0 [direct: primary] admin> rs.isMaster()
{
  topologyVersion: {
    processId: ObjectId("65573529bc98f429c9f908e7"),
    counter: Long("10")
  },
  hosts: [ 'mongodb_1_p:27017', 'mongodb_1_s:27017' ],
  arbiters: [ 'mongodb_1_a:27017' ],
  setName: 'rs0',
  setVersion: 5,
  ismaster: true,
  secondary: false,
  primary: 'mongodb_1_p:27017',
  me: 'mongodb_1_p:27017',
  electionId: ObjectId("7fffffff0000000000000001"),
  lastWrite: {
    opTime: { ts: Timestamp({ t: 1700214446, i: 1 }), t: Long("1") },
    lastWriteDate: ISODate("2023-11-17T09:47:26.000Z"),
    majorityOpTime: { ts: Timestamp({ t: 1700214446, i: 1 }), t: Long("1") },
    majorityWriteDate: ISODate("2023-11-17T09:47:26.000Z")
  },
  maxBsonObjectSize: 16777216,
  maxMessageSizeBytes: 48000000,
  maxWriteBatchSize: 100000,
  localTime: ISODate("2023-11-17T09:47:31.425Z"),
  logicalSessionTimeoutMinutes: 30,
  connectionId: 12,
  minWireVersion: 0,
  maxWireVersion: 21,
  readOnly: false,
  ok: 1,
  '$clusterTime': {
    clusterTime: Timestamp({ t: 1700214446, i: 1 }),
    signature: {
      hash: Binary.createFromBase64("30UMXYZnkOmde44/Ige8cxIYZ7Q=", 0),
      keyId: Long("7302364196216242183")
    }
  },
  operationTime: Timestamp({ t: 1700214446, i: 1 }),
  isWritablePrimary: true
}

rs0 [direct: primary] admin> quit()
*/

-- Step 55 -->> On Node 2
[root@mongodb_1_s ~]# mongo --port 27017 -u admin -p P#ssw0rd --authenticationDatabase admin
/*
Current Mongosh Log ID: 65571a7618fed27256048af8
Connecting to:          mongodb://<credentials>@127.0.0.1:27017/?directConnection=true&serverSelectionTimeoutMS=2000&authSource=admin&appName=mongosh+2.0.2
Using MongoDB:          7.0.3
Using Mongosh:          2.0.2

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

rs0 [direct: secondary] test> show dbs
admin   140.00 KiB
config  316.00 KiB
local   436.00 KiB

rs0 [direct: secondary] test> use admin
switched to db admin

rs0 [direct: secondary] test> rs.isMaster()
{
  topologyVersion: {
    processId: ObjectId("6557352af2f69dcdf0d6dcce"),
    counter: Long("6")
  },
  hosts: [ 'mongodb_1_p:27017', 'mongodb_1_s:27017' ],
  arbiters: [ 'mongodb_1_a:27017' ],
  setName: 'rs0',
  setVersion: 5,
  ismaster: false,
  secondary: true,
  primary: 'mongodb_1_p:27017',
  me: 'mongodb_1_s:27017',
  lastWrite: {
    opTime: { ts: Timestamp({ t: 1700214606, i: 1 }), t: Long("1") },
    lastWriteDate: ISODate("2023-11-17T09:50:06.000Z"),
    majorityOpTime: { ts: Timestamp({ t: 1700214606, i: 1 }), t: Long("1") },
    majorityWriteDate: ISODate("2023-11-17T09:50:06.000Z")
  },
  maxBsonObjectSize: 16777216,
  maxMessageSizeBytes: 48000000,
  maxWriteBatchSize: 100000,
  localTime: ISODate("2023-11-17T09:50:08.451Z"),
  logicalSessionTimeoutMinutes: 30,
  connectionId: 26,
  minWireVersion: 0,
  maxWireVersion: 21,
  readOnly: false,
  ok: 1,
  '$clusterTime': {
    clusterTime: Timestamp({ t: 1700214606, i: 1 }),
    signature: {
      hash: Binary.createFromBase64("XR+Gt5mSx9kOORJ7tDBUGJVpcPk=", 0),
      keyId: Long("7302364196216242183")
    }
  },
  operationTime: Timestamp({ t: 1700214606, i: 1 }),
  isWritablePrimary: false
}

rs0 [direct: secondary] test> rs.status()
{
  set: 'rs0',
  date: ISODate("2023-11-17T09:50:26.649Z"),
  myState: 2,
  term: Long("1"),
  syncSourceHost: 'mongodb_1_p:27017',
  syncSourceId: 0,
  heartbeatIntervalMillis: Long("2000"),
  majorityVoteCount: 2,
  writeMajorityCount: 2,
  votingMembersCount: 3,
  writableVotingMembersCount: 2,
  optimes: {
    lastCommittedOpTime: { ts: Timestamp({ t: 1700214616, i: 1 }), t: Long("1") },
    lastCommittedWallTime: ISODate("2023-11-17T09:50:16.883Z"),
    readConcernMajorityOpTime: { ts: Timestamp({ t: 1700214616, i: 1 }), t: Long("1") },
    appliedOpTime: { ts: Timestamp({ t: 1700214616, i: 1 }), t: Long("1") },
    durableOpTime: { ts: Timestamp({ t: 1700214616, i: 1 }), t: Long("1") },
    lastAppliedWallTime: ISODate("2023-11-17T09:50:16.883Z"),
    lastDurableWallTime: ISODate("2023-11-17T09:50:16.883Z")
  },
  lastStableRecoveryTimestamp: Timestamp({ t: 1700214616, i: 1 }),
  members: [
    {
      _id: 0,
      name: 'mongodb_1_p:27017',
      health: 1,
      state: 1,
      stateStr: 'PRIMARY',
      uptime: 429,
      optime: { ts: Timestamp({ t: 1700214616, i: 1 }), t: Long("1") },
      optimeDurable: { ts: Timestamp({ t: 1700214616, i: 1 }), t: Long("1") },
      optimeDate: ISODate("2023-11-17T09:50:16.000Z"),
      optimeDurableDate: ISODate("2023-11-17T09:50:16.000Z"),
      lastAppliedWallTime: ISODate("2023-11-17T09:50:16.883Z"),
      lastDurableWallTime: ISODate("2023-11-17T09:50:16.883Z"),
      lastHeartbeat: ISODate("2023-11-17T09:50:25.765Z"),
      lastHeartbeatRecv: ISODate("2023-11-17T09:50:25.762Z"),
      pingMs: Long("0"),
      lastHeartbeatMessage: '',
      syncSourceHost: '',
      syncSourceId: -1,
      infoMessage: '',
      electionTime: Timestamp({ t: 1700214156, i: 2 }),
      electionDate: ISODate("2023-11-17T09:42:36.000Z"),
      configVersion: 5,
      configTerm: 1
    },
    {
      _id: 1,
      name: 'mongodb_1_s:27017',
      health: 1,
      state: 2,
      stateStr: 'SECONDARY',
      uptime: 568,
      optime: { ts: Timestamp({ t: 1700214616, i: 1 }), t: Long("1") },
      optimeDate: ISODate("2023-11-17T09:50:16.000Z"),
      lastAppliedWallTime: ISODate("2023-11-17T09:50:16.883Z"),
      lastDurableWallTime: ISODate("2023-11-17T09:50:16.883Z"),
      syncSourceHost: 'mongodb_1_p:27017',
      syncSourceId: 0,
      infoMessage: '',
      configVersion: 5,
      configTerm: 1,
      self: true,
      lastHeartbeatMessage: ''
    },
    {
      _id: 2,
      name: 'mongodb_1_a:27017',
      health: 1,
      state: 7,
      stateStr: 'ARBITER',
      uptime: 347,
      lastHeartbeat: ISODate("2023-11-17T09:50:25.764Z"),
      lastHeartbeatRecv: ISODate("2023-11-17T09:50:25.764Z"),
      pingMs: Long("0"),
      lastHeartbeatMessage: '',
      syncSourceHost: '',
      syncSourceId: -1,
      infoMessage: '',
      configVersion: 5,
      configTerm: 1
    }
  ],
  ok: 1,
  '$clusterTime': {
    clusterTime: Timestamp({ t: 1700214616, i: 1 }),
    signature: {
      hash: Binary.createFromBase64("Ee+qmF+ytyt6iGDed70lsoEiG4Q=", 0),
      keyId: Long("7302364196216242183")
    }
  },
  operationTime: Timestamp({ t: 1700214616, i: 1 })
}

rs0 [direct: secondary] test> rs.conf()
{
  _id: 'rs0',
  version: 5,
  term: 1,
  members: [
    {
      _id: 0,
      host: 'mongodb_1_p:27017',
      arbiterOnly: false,
      buildIndexes: true,
      hidden: false,
      priority: 10,
      tags: {},
      secondaryDelaySecs: Long("0"),
      votes: 1
    },
    {
      _id: 1,
      host: 'mongodb_1_s:27017',
      arbiterOnly: false,
      buildIndexes: true,
      hidden: false,
      priority: 1,
      tags: {},
      secondaryDelaySecs: Long("0"),
      votes: 1
    },
    {
      _id: 2,
      host: 'mongodb_1_a:27017',
      arbiterOnly: true,
      buildIndexes: true,
      hidden: false,
      priority: 0,
      tags: {},
      secondaryDelaySecs: Long("0"),
      votes: 1
    }
  ],
  protocolVersion: Long("1"),
  writeConcernMajorityJournalDefault: true,
  settings: {
    chainingAllowed: true,
    heartbeatIntervalMillis: 2000,
    heartbeatTimeoutSecs: 10,
    electionTimeoutMillis: 10000,
    catchUpTimeoutMillis: -1,
    catchUpTakeoverDelayMillis: 30000,
    getLastErrorModes: {},
    getLastErrorDefaults: { w: 1, wtimeout: 0 },
    replicaSetId: ObjectId("6557358cbc98f429c9f90944")
  }
}

rs0 [direct: secondary] admin> quit()
*/

-- Step 56 -->> On Node 3
[root@mongodb_1_a ~]# mongo --port 27017 -u admin -p P#ssw0rd --authenticationDatabase admin
/*
Current Mongosh Log ID: 65571b4f3d6f87a7fc39c22c
Connecting to:          mongodb://<credentials>@127.0.0.1:27017/?directConnection=true&serverSelectionTimeoutMS=2000&authSource=admin&appName=mongosh+2.0.2
Using MongoDB:          7.0.3
Using Mongosh:          2.0.2

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

rs0 [direct: arbiter] test> use admin
switched to db admin

rs0 [direct: arbiter] admin> rs.isMaster()
{
  topologyVersion: {
    processId: ObjectId("6557352bd052da2c00336a13"),
    counter: Long("2")
  },
  hosts: [ 'mongodb_1_p:27017', 'mongodb_1_s:27017' ],
  arbiters: [ 'mongodb_1_a:27017' ],
  setName: 'rs0',
  setVersion: 5,
  ismaster: false,
  secondary: false,
  primary: 'mongodb_1_p:27017',
  arbiterOnly: true,
  me: 'mongodb_1_a:27017',
  lastWrite: {
    opTime: { ts: Timestamp({ t: 1700214726, i: 1 }), t: Long("1") },
    lastWriteDate: ISODate("2023-11-17T09:52:06.000Z"),
    majorityOpTime: { ts: Timestamp({ t: 1700214726, i: 1 }), t: Long("1") },
    majorityWriteDate: ISODate("2023-11-17T09:52:06.000Z")
  },
  maxBsonObjectSize: 16777216,
  maxMessageSizeBytes: 48000000,
  maxWriteBatchSize: 100000,
  localTime: ISODate("2023-11-17T09:52:17.284Z"),
  logicalSessionTimeoutMinutes: 30,
  connectionId: 18,
  minWireVersion: 0,
  maxWireVersion: 21,
  readOnly: false,
  ok: 1,
  isWritablePrimary: false
}

rs0 [direct: arbiter] admin> rs.status()
{
  set: 'rs0',
  date: ISODate("2023-11-17T09:52:46.117Z"),
  myState: 7,
  term: Long("1"),
  syncSourceHost: '',
  syncSourceId: -1,
  heartbeatIntervalMillis: Long("2000"),
  majorityVoteCount: 2,
  writeMajorityCount: 2,
  votingMembersCount: 3,
  writableVotingMembersCount: 2,
  optimes: {
    lastCommittedOpTime: { ts: Timestamp({ t: 1700214756, i: 1 }), t: Long("1") },
    lastCommittedWallTime: ISODate("2023-11-17T09:52:36.915Z"),
    readConcernMajorityOpTime: { ts: Timestamp({ t: 1700214756, i: 1 }), t: Long("1") },
    appliedOpTime: { ts: Timestamp({ t: 1700214756, i: 1 }), t: Long("1") },
    durableOpTime: { ts: Timestamp({ t: 0, i: 0 }), t: Long("-1") },
    lastAppliedWallTime: ISODate("2023-11-17T09:52:36.915Z"),
    lastDurableWallTime: ISODate("1970-01-01T00:00:00.000Z")
  },
  lastStableRecoveryTimestamp: Timestamp({ t: 0, i: 0 }),
  members: [
    {
      _id: 0,
      name: 'mongodb_1_p:27017',
      health: 1,
      state: 1,
      stateStr: 'PRIMARY',
      uptime: 486,
      optime: { ts: Timestamp({ t: 1700214756, i: 1 }), t: Long("1") },
      optimeDurable: { ts: Timestamp({ t: 1700214756, i: 1 }), t: Long("1") },
      optimeDate: ISODate("2023-11-17T09:52:36.000Z"),
      optimeDurableDate: ISODate("2023-11-17T09:52:36.000Z"),
      lastAppliedWallTime: ISODate("2023-11-17T09:52:36.915Z"),
      lastDurableWallTime: ISODate("2023-11-17T09:52:36.915Z"),
      lastHeartbeat: ISODate("2023-11-17T09:52:45.978Z"),
      lastHeartbeatRecv: ISODate("2023-11-17T09:52:45.977Z"),
      pingMs: Long("0"),
      lastHeartbeatMessage: '',
      syncSourceHost: '',
      syncSourceId: -1,
      infoMessage: '',
      electionTime: Timestamp({ t: 1700214156, i: 2 }),
      electionDate: ISODate("2023-11-17T09:42:36.000Z"),
      configVersion: 5,
      configTerm: 1
    },
    {
      _id: 1,
      name: 'mongodb_1_s:27017',
      health: 1,
      state: 2,
      stateStr: 'SECONDARY',
      uptime: 486,
      optime: { ts: Timestamp({ t: 1700214756, i: 1 }), t: Long("1") },
      optimeDurable: { ts: Timestamp({ t: 1700214756, i: 1 }), t: Long("1") },
      optimeDate: ISODate("2023-11-17T09:52:36.000Z"),
      optimeDurableDate: ISODate("2023-11-17T09:52:36.000Z"),
      lastAppliedWallTime: ISODate("2023-11-17T09:52:36.915Z"),
      lastDurableWallTime: ISODate("2023-11-17T09:52:36.915Z"),
      lastHeartbeat: ISODate("2023-11-17T09:52:45.977Z"),
      lastHeartbeatRecv: ISODate("2023-11-17T09:52:45.977Z"),
      pingMs: Long("0"),
      lastHeartbeatMessage: '',
      syncSourceHost: 'mongodb_1_p:27017',
      syncSourceId: 0,
      infoMessage: '',
      configVersion: 5,
      configTerm: 1
    },
    {
      _id: 2,
      name: 'mongodb_1_a:27017',
      health: 1,
      state: 7,
      stateStr: 'ARBITER',
      uptime: 707,
      syncSourceHost: '',
      syncSourceId: -1,
      infoMessage: '',
      configVersion: 5,
      configTerm: 1,
      self: true,
      lastHeartbeatMessage: ''
    }
  ],
  ok: 1
}

rs0 [direct: arbiter] admin> quit()
*/

-- Step 57 -->> On Node 1 (Replication Test)
[root@mongodb_1_p ~]# mongo --host 192.168.56.149  --port 27017 -u admin -p P#ssw0rd --authenticationDatabase admin
/*
Current Mongosh Log ID: 65573946006bdc749b0281cb
Connecting to:          mongodb://<credentials>@192.168.56.149:27017/?directConnection=true&authSource=admin&appName=mongosh+2.0.2
Using MongoDB:          7.0.3
Using Mongosh:          2.0.2

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

rs0 [direct: primary] test> show dbs
admin   172.00 KiB
config  252.00 KiB
local   440.00 KiB

rs0 [direct: primary] test> use admin
switched to db admin

rs0 [direct: primary] admin> db
admin

rs0 [direct: primary] admin> db.getUsers()
{
  users: [
    {
      _id: 'admin.admin',
      userId: new UUID("4b22a368-2470-4858-97b8-12ae39297caa"),
      user: 'admin',
      db: 'admin',
      roles: [
        { role: 'clusterAdmin', db: 'admin' },
        { role: 'userAdminAnyDatabase', db: 'admin' },
        { role: 'root', db: 'admin' }
      ],
      mechanisms: [ 'SCRAM-SHA-1', 'SCRAM-SHA-256' ]
    }
  ],
  ok: 1,
  '$clusterTime': {
    clusterTime: Timestamp({ t: 1700215126, i: 1 }),
    signature: {
      hash: Binary.createFromBase64("q4R0UKaU+kbK/pz7274aM/6i5ec=", 0),
      keyId: Long("7302364196216242183")
    }
  },
  operationTime: Timestamp({ t: 1700215126, i: 1 })
}

rs0 [direct: primary] admin> use devesh
switched to db devesh

rs0 [direct: primary] devesh> db.createUser(
... {
... user:"devesh",
... pwd:"P@ssw0rD",
... roles:["readWrite"]
... }
... )
{
  ok: 1,
  '$clusterTime': {
    clusterTime: Timestamp({ t: 1700215229, i: 1 }),
    signature: {
      hash: Binary.createFromBase64("mG/O25LpW5aQttKubD/ET3JlO+M=", 0),
      keyId: Long("7302364196216242183")
    }
  },
  operationTime: Timestamp({ t: 1700215229, i: 1 })
}

rs0 [direct: primary] devesh> db.auth("devesh","P@ssw0rD")
{ ok: 1 }

rs0 [direct: primary] devesh> db.createCollection('tbl_cib')
{ ok: 1 }

rs0 [direct: primary] devesh> show collections
tbl_cib

rs0 [direct: primary] devesh> db.getCollectionNames()
[ 'tbl_cib' ]

rs0 [direct: primary] admin> exit
*/

-- Step 58 -->> On Node 1 (Replication Test)
[root@mongodb_1_p ~]# mongo --host 192.168.56.149  --port 27017 -u devesh -p P@ssw0rD --authenticationDatabase devesh
/*
Current Mongosh Log ID: 65573c08fb408390d801f598
Connecting to:          mongodb://<credentials>@192.168.56.149:27017/?directConnection=true&authSource=devesh&appName=mongosh+2.0.2
Using MongoDB:          7.0.3
Using Mongosh:          2.0.2

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

rs0 [direct: primary] test> show dbs
devesh  8.00 KiB

rs0 [direct: primary] test> use devesh
switched to db devesh

rs0 [direct: primary] devesh> db.getCollectionNames()
[ 'tbl_cib' ]

rs0 [direct: primary] devesh> exit
*/

-- Step 59 -->> On Node 1 (Replication Test)
[root@mongodb_1_s mongodb]# mongo --port 27017 -u devesh -p P@ssw0rD --authenticationDatabase devesh
/*
Current Mongosh Log ID: 65573e199f3d9443c9914a95
Connecting to:          mongodb://<credentials>@127.0.0.1:27017/?directConnection=true&serverSelectionTimeoutMS=2000&authSource=devesh&appName=mongosh+2.0.2
Using MongoDB:          7.0.3
Using Mongosh:          2.0.2

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

rs0 [direct: secondary] test> show dbs
devesh  8.00 KiB

rs0 [direct: secondary] test> use devesh
switched to db devesh

rs0 [direct: secondary] devesh> db
devesh

rs0 [direct: secondary] devesh> show collections
tbl_cib

rs0 [direct: secondary] devesh> db.getCollectionNames()
MongoServerError: not primary and secondaryOk=false - consider using db.getMongo().setReadPref() or readPreference in the connection string

rs0 [direct: secondary] devesh> quit()
*/

-- Step 60 -->> On Node 1 (Replication Test)
--To Fix the issue (MongoServerError: not primary and secondaryOk=false - consider using db.getMongo().setReadPref())
[root@mongodb_1_s mongodb]# mongo --port 27017 -u admin -p P#ssw0rd --authenticationDatabase admin
/*
Current Mongosh Log ID: 65573f0cd38a67aff4e0d04a
Connecting to:          mongodb://<credentials>@127.0.0.1:27017/?directConnection=true&serverSelectionTimeoutMS=2000&authSource=admin&appName=mongosh+2.0.2
Using MongoDB:          7.0.3
Using Mongosh:          2.0.2

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

rs0 [direct: secondary] test> show dbs
admin   188.00 KiB
config  304.00 KiB
devesh    8.00 KiB
local   444.00 KiB

rs0 [direct: secondary] test> use admin
switched to db admin

rs0 [direct: secondary] admin> db.getMongo().setReadPref("secondaryPreferred")

rs0 [direct: secondary] admin> use devesh
switched to db devesh

rs0 [direct: secondary] devesh> db.getCollectionNames()
[ 'tbl_cib' ]

rs0 [direct: secondary] devesh> db.getUsers()
{
  users: [
    {
      _id: 'devesh.devesh',
      userId: new UUID("8ea6e002-cf5d-4e44-99a7-0bc2edb39177"),
      user: 'devesh',
      db: 'devesh',
      roles: [ { role: 'readWrite', db: 'devesh' } ],
      mechanisms: [ 'SCRAM-SHA-1', 'SCRAM-SHA-256' ]
    }
  ],
  ok: 1,
  '$clusterTime': {
    clusterTime: Timestamp({ t: 1700216627, i: 1 }),
    signature: {
      hash: Binary.createFromBase64("dPZFgjXDeu4krVg2WwrmPWQyUEs=", 0),
      keyId: Long("7302364196216242183")
    }
  },
  operationTime: Timestamp({ t: 1700216627, i: 1 })
}

rs0 [direct: secondary] devesh> db.dropDatabase()
MongoServerError: not primary
*/
