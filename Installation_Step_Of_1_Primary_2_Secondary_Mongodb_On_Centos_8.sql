--------------------------------------------------------------------------
----------------------------root/P@ssw0rd---------------------------------
--------------------------------------------------------------------------
-- 1 All Nodes
[root@mongodb_1_p/mongodb_1_s/mongodb_2_s ~]# df -Th
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
[root@mongodb_1_p/mongodb_1_s/mongodb_2_s ~]# cat /etc/os-release
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
[root@mongodb_1_p/mongodb_1_s/mongodb_2_s ~]# vi /etc/hosts
/*
127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
::1         localhost localhost.localdomain localhost6 localhost6.localdomain6

# Public
192.168.56.149 mongodb_1_p.unidev39.org.np mongodb_1_p
192.168.56.150 mongodb_1_s.unidev39.org.np mongodb_1_s
192.168.56.151 mongodb_2_s.unidev39.org.np mongodb_2_s
*/

-- Step 2 -->> On All Nodes
-- Disable secure linux by editing the "/etc/selinux/config" file, making sure the SELINUX flag is set as follows.
[root@mongodb_1_p/mongodb_1_s/mongodb_2_s ~]# vi /etc/selinux/config
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
[root@mongodb_2_s ~]# vi /etc/sysconfig/network
/*
# Created by anaconda
NETWORKING=yes
HOSTNAME=mongodb_2_s.unidev39.org.np
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
[root@mongodb_2_s ~]# nmtui
--OR--
-- Step 4.2 -->> On Node 3
[root@mongodb_2_s ~]# vi /etc/sysconfig/network-scripts/ifcfg-ens33
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
[root@mongodb_1_p/mongodb_1_s/mongodb_2_s ~]# systemctl restart network-online.target

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
[root@mongodb_2_s ~]# hostnamectl set-hostname mongodb_2_s.unidev39.org.np

-- Step 6.1.2 -->> On Node 3
[root@mongodb_2_s ~]# cat /etc/hostname
/*
mongodb_2_s.unidev39.org.np
*/

-- Step 6.2.2 -->> On Node 3
[root@mongodb_2_s ~]# hostnamectl | grep hostname
/*
  Static hostname: mongodb_2_s.unidev39.org.np
*/

-- Step 6.3.2 -->> On Node 3
[root@mongodb_2_s ~]# hostnamectl --static
/*
mongodb_2_s.unidev39.org.np
*/

-- Step 6.4.2 -->> On Node 3
[root@mongodb_2_s ~]# hostnamectl
/*
   Static hostname: mongodb_2_s.unidev39.org.np
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
[root@mongodb_1_p/mongodb_1_s/mongodb_2_s ~]# systemctl stop firewalld
[root@mongodb_1_p/mongodb_1_s/mongodb_2_s ~]# systemctl disable firewalld
/*
Removed "/etc/systemd/system/multi-user.target.wants/firewalld.service".
Removed "/etc/systemd/system/dbus-org.fedoraproject.FirewallD1.service".
*/

-- Step 8 -->> On All Nodes
[root@mongodb_1_p/mongodb_1_s/mongodb_2_s ~]# iptables -F
[root@mongodb_1_p/mongodb_1_s/mongodb_2_s ~]# iptables -X
[root@mongodb_1_p/mongodb_1_s/mongodb_2_s ~]# iptables -t nat -F
[root@mongodb_1_p/mongodb_1_s/mongodb_2_s ~]# iptables -t nat -X
[root@mongodb_1_p/mongodb_1_s/mongodb_2_s ~]# iptables -t mangle -F
[root@mongodb_1_p/mongodb_1_s/mongodb_2_s ~]# iptables -t mangle -X
[root@mongodb_1_p/mongodb_1_s/mongodb_2_s ~]# iptables -P INPUT ACCEPT
[root@mongodb_1_p/mongodb_1_s/mongodb_2_s ~]# iptables -P FORWARD ACCEPT
[root@mongodb_1_p/mongodb_1_s/mongodb_2_s ~]# iptables -P OUTPUT ACCEPT
[root@mongodb_1_p/mongodb_1_s/mongodb_2_s ~]# iptables -L -nv
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
[root@mongodb_1_p/mongodb_1_s/mongodb_2_s ~]# systemctl stop libvirtd.service
[root@mongodb_1_p/mongodb_1_s/mongodb_2_s ~]# systemctl disable libvirtd.service
[root@mongodb_1_p/mongodb_1_s/mongodb_2_s ~]# virsh net-list
[root@mongodb_1_p/mongodb_1_s/mongodb_2_s ~]# virsh net-destroy default

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
[root@mongodb_2_s ~]# ifconfig
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
[root@mongodb_1_p/mongodb_1_s/mongodb_2_s ~]# init 6

-- Step 12 -->> On All Nodes
[root@mongodb_1_p/mongodb_1_s/mongodb_2_s ~]# firewall-cmd --list-all
/*
FirewallD is not running
*/

-- Step 13 -->> On All Nodes
[root@mongodb_1_p/mongodb_1_s/mongodb_2_s ~]# systemctl status firewalld
/*
● firewalld.service - firewalld - dynamic firewall daemon
   Loaded: loaded (/usr/lib/systemd/system/firewalld.service; disabled; vendor preset: enabled)
   Active: inactive (dead)
     Docs: man:firewalld(1)
*/

-- Step 14 -->> On All Nodes
[root@mongodb_1_p/mongodb_1_s/mongodb_2_s ~]# cd /run/media/root/CentOS-Stream-8-BaseOS-x86_64/AppStream/Packages
[root@mongodb_1_p/mongodb_1_s/mongodb_2_s ~]# yum -y update

-- Step 15 -->> On All Nodes
[root@mongodb_1_p/mongodb_1_s/mongodb_2_s ~]# usermod -aG wheel mongodb
[root@mongodb_1_p/mongodb_1_s/mongodb_2_s ~]# usermod -aG root mongodb

-- Step 16 -->> On All Nodes
[root@mongodb_1_p/mongodb_1_s/mongodb_2_s ~]# cd /etc/yum.repos.d/
[root@mongodb_1_p/mongodb_1_s/mongodb_2_s yum.repos.d]# ll
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
[root@mongodb_1_p/mongodb_1_s/mongodb_2_s yum.repos.d]# vi /etc/yum.repos.d/mongodb-org.repo
/*
[mongodb-org-7.0]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/8/mongodb-org/7.0/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-7.0.asc
*/ 

-- Step 18 -->> On All Nodes
[root@mongodb_1_p/mongodb_1_s/mongodb_2_s yum.repos.d]# ll | grep mongo
/*
-rw-r--r--  1 root root  190 Nov 18 14:10 mongodb-org.repo
*/
[root@mongodb_1_p/mongodb_1_s/mongodb_2_s yum.repos.d]# yum repolist
/*
repo id                                                                           repo name
appstream                                                                         CentOS Stream 8 - AppStream
baseos                                                                            CentOS Stream 8 - BaseOS
extras                                                                            CentOS Stream 8 - Extras
extras-common                                                                     CentOS Stream 8 - Extras common packages
mongodb-org-7.0                                                                   MongoDB Repository
*/

-- Step 19 -->> On All Nodes
[root@mongodb_1_p/mongodb_1_s/mongodb_2_s ~]# yum install -y mongodb-org
/*
MongoDB Repository                                                                                                                                            11 kB/s |  18 kB     00:01
Last metadata expiration check: 0:00:01 ago on Sat 18 Nov 2023 02:11:13 PM +0545.
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
[root@mongodb_1_p/mongodb_1_s/mongodb_2_s ~]# ll /var/lib/ | grep mongo
/*
drwxr-xr-x   2 mongod         mongod            6 Oct  6 01:52 mongo
*/

-- Step 21 -->> On All Nodes (Create a MongoDB Data and Log directory)
[root@mongodb_1_p/mongodb_1_s/mongodb_2_s ~]# mkdir -p /data/mongodb
[root@mongodb_1_p/mongodb_1_s/mongodb_2_s ~]# mkdir -p /data/log
[root@mongodb_1_p/mongodb_1_s/mongodb_2_s ~]# chown -R mongod:mongod /data/
[root@mongodb_1_p/mongodb_1_s/mongodb_2_s ~]# chown -R mongod:mongod /data
[root@mongodb_1_p/mongodb_1_s/mongodb_2_s ~]# chmod -R 777 /data/
[root@mongodb_1_p/mongodb_1_s/mongodb_2_s ~]# chmod -R 777 /data
[root@mongodb_1_p/mongodb_1_s/mongodb_2_s ~]# ll / | grep data
/*
drwxrwxrwx.   4 mongod mongod    32 Nov 18 14:16 data
*/

-- Step 22 -->> On All Nodes
[root@mongodb_1_p/mongodb_1_s/mongodb_2_s ~]# ll /data/
/*
drwxrwxrwx 2 mongod mongod 6 Nov 18 14:16 log
drwxrwxrwx 2 mongod mongod 6 Nov 18 14:16 mongodb
*/

-- Step 23 -->> On All Nodes
[root@mongodb_1_p/mongodb_1_s/mongodb_2_s ~]# cp -r /etc/mongod.conf /etc/mongod.conf.backup
[root@mongodb_1_p/mongodb_1_s/mongodb_2_s ~]# ll /etc/mongod*
/*
-rw-r--r-- 1 root root 658 Oct 31 05:37 /etc/mongod.conf
-rw-r--r-- 1 root root 658 Nov 17 11:28 /etc/mongod.conf.backup
*/

-- Step 24 -->> On All Nodes
[root@mongodb_1_p/mongodb_1_s/mongodb_2_s ~]# vi /etc/mongod.conf
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
[root@mongodb_2_s ~]# vi /etc/mongod.conf
/*
# network interfaces
net:
  port: 27017
  bindIp: 127.0.0.1,192.168.56.151
  maxIncomingConnections: 999999
*/

-- Step 25.1 -->> On All Nodes
[root@mongodb_1_p/mongodb_1_s/mongodb_2_s ~]# ulimit -a
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
[root@mongodb_1_p/mongodb_1_s/mongodb_2_s ~]# ulimit -n 64000
[root@mongodb_1_p/mongodb_1_s/mongodb_2_s ~]# ulimit -a
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
[root@mongodb_1_p/mongodb_1_s/mongodb_2_s ~]# cat /etc/group | grep mongo
/*
root:x:0:mongodb
wheel:x:10:mongodb
mongodb:x:1000:
mongod:x:969:
*/

-- Step 25.4 -->> On All Nodes
[root@mongodb_1_p/mongodb_1_s/mongodb_2_s ~]# echo "mongod           soft    nofile          9999999" | tee -a /etc/security/limits.conf
[root@mongodb_1_p/mongodb_1_s/mongodb_2_s ~]# echo "mongod           hard    nofile          9999999" | tee -a /etc/security/limits.conf
[root@mongodb_1_p/mongodb_1_s/mongodb_2_s ~]# echo "mongod           soft    nproc           9999999" | tee -a /etc/security/limits.conf
[root@mongodb_1_p/mongodb_1_s/mongodb_2_s ~]# echo "mongod           hard    nproc           9999999" | tee -a /etc/security/limits.conf
[root@mongodb_1_p/mongodb_1_s/mongodb_2_s ~]# echo "mongod           soft    stack           9999999" | tee -a /etc/security/limits.conf
[root@mongodb_1_p/mongodb_1_s/mongodb_2_s ~]# echo "mongod           hard    stack           9999999" | tee -a /etc/security/limits.conf
[root@mongodb_1_p/mongodb_1_s/mongodb_2_s ~]# echo 9999999 > /proc/sys/vm/max_map_count
[root@mongodb_1_p/mongodb_1_s/mongodb_2_s ~]# echo "vm.max_map_count=9999999" | tee -a /etc/sysctl.conf
[root@mongodb_1_p/mongodb_1_s/mongodb_2_s ~]# echo 1024 65530 > /proc/sys/net/ipv4/ip_local_port_range
[root@mongodb_1_p/mongodb_1_s/mongodb_2_s ~]# echo "net.ipv4.ip_local_port_range = 1024 65530" | tee -a /etc/sysctl.conf

-- Step 25.5 -->> On All Nodes
[root@mongodb_1_p/mongodb_1_s/mongodb_2_s ~]# systemctl enable mongod --now
[root@mongodb_1_p/mongodb_1_s/mongodb_2_s ~]# systemctl start mongod
[root@mongodb_1_p/mongodb_1_s/mongodb_2_s ~]# systemctl status mongod
/*
● mongod.service - MongoDB Database Server
   Loaded: loaded (/usr/lib/systemd/system/mongod.service; enabled; vendor preset: disabled)
   Active: active (running) since Sat 2023-11-18 14:28:38 +0545; 14s ago
     Docs: https://docs.mongodb.org/manual
 Main PID: 8146 (mongod)
   Memory: 199.1M
   CGroup: /system.slice/mongod.service
           └─8146 /usr/bin/mongod -f /etc/mongod.conf

Nov 18 14:28:38 mongodb_1_p.unidev39.org.np systemd[1]: Started MongoDB Database Server.
Nov 18 14:28:38 mongodb_1_p.unidev39.org.np mongod[8146]: {"t":{"$date":"2023-11-18T08:43:38>
*/

-- Step 26 -->> On All Nodes
[root@mongodb_1_p/mongodb_1_s/mongodb_2_s ~]# mongosh
/*
Current Mongosh Log ID: 65587976e5dd017f3a6336a8
Connecting to:          mongodb://127.0.0.1:27017/?directConnection=true&serverSelectionTimeoutMS=2000&appName=mongosh+2.0.2
Using MongoDB:          7.0.3
Using Mongosh:          2.0.2

For mongosh info see: https://docs.mongodb.com/mongodb-shell/


To help improve our products, anonymous usage data is collected and sent to MongoDB periodically (https://www.mongodb.com/legal/privacy-policy).
You can opt-out by running the disableTelemetry() command.

------
   The server generated these startup warnings when booting
   2023-11-18T14:28:39.568+05:45: Access control is not enabled for the database. Read and write access to data and configuration is unrestricted
   2023-11-18T14:28:39.568+05:45: /sys/kernel/mm/transparent_hugepage/enabled is 'always'. We suggest setting it to 'never'
------

test> db.version()
7.0.3

test> show databases;
admin   40.00 KiB
config  12.00 KiB
local   40.00 KiB

test> quit()
*/

-- Step 27 -->> On All Nodes
[root@mongodb_1_p/mongodb_1_s/mongodb_2_s ~]# systemctl stop mongod

-- Step 28 -->> On All Nodes
[root@mongodb_1_p/mongodb_1_s/mongodb_2_s ~]# which mongosh
/*
/usr/bin/mongosh
*/

-- Step 28.1 -->> On All Nodes (After MongoDB Version 4.4 the "mongo" shell is not avilable)
[root@mongodb_1_p/mongodb_1_s/mongodb_2_s ~]# cd /usr/bin/
[root@mongodb_1_p/mongodb_1_s/mongodb_2_s bin]# ll | grep mongo
/*
-rwxr-xr-x  1 root root    181975272 Oct 31 05:37 mongod
-rwxr-xr-x  1 root root     16188208 Nov 17 23:14 mongodump
-rwxr-xr-x  1 root root     15879336 Nov 17 23:14 mongoexport
-rwxr-xr-x  1 root root     16728016 Nov 17 23:14 mongofiles
-rwxr-xr-x  1 root root     16130752 Nov 17 23:14 mongoimport
-rwxr-xr-x  1 root root     16519184 Nov 17 23:15 mongorestore
-rwxr-xr-x  1 root root    129588096 Oct 31 05:37 mongos
-rwxr-xr-x  1 root root    106614784 Oct 14 18:09 mongosh
-rwxr-xr-x  1 root root     15748480 Nov 17 23:15 mongostat
-rwxr-xr-x  1 root root     15319776 Nov 17 23:15 mongotop
*/

-- Step 28.2 -->> On All Nodes
[root@mongodb_1_p/mongodb_1_s/mongodb_2_s bin]# cp mongosh mongo
[root@mongodb_1_p/mongodb_1_s/mongodb_2_s bin]# ll | grep mongo
/*
-rwxr-xr-x  1 root root    106614784 Nov 18 14:31 mongo
-rwxr-xr-x  1 root root    181975272 Oct 31 05:37 mongod
-rwxr-xr-x  1 root root     16188208 Nov 17 23:14 mongodump
-rwxr-xr-x  1 root root     15879336 Nov 17 23:14 mongoexport
-rwxr-xr-x  1 root root     16728016 Nov 17 23:14 mongofiles
-rwxr-xr-x  1 root root     16130752 Nov 17 23:14 mongoimport
-rwxr-xr-x  1 root root     16519184 Nov 17 23:15 mongorestore
-rwxr-xr-x  1 root root    129588096 Oct 31 05:37 mongos
-rwxr-xr-x  1 root root    106614784 Oct 14 18:09 mongosh
-rwxr-xr-x  1 root root     15748480 Nov 17 23:15 mongostat
-rwxr-xr-x  1 root root     15319776 Nov 17 23:15 mongotop
*/

-- Step 28.3 -->> On All Nodes
[root@mongodb_1_p/mongodb_1_s/mongodb_2_s ~]# systemctl start mongod
[root@mongodb_1_p/mongodb_1_s/mongodb_2_s ~]# systemctl status mongod
/*
● mongod.service - MongoDB Database Server
   Loaded: loaded (/usr/lib/systemd/system/mongod.service; enabled; vendor preset: disabled)
   Active: active (running) since Sat 2023-11-18 14:32:12 +0545; 7s ago
     Docs: https://docs.mongodb.org/manual
 Main PID: 8295 (mongod)
   Memory: 179.9M
   CGroup: /system.slice/mongod.service
           └─8295 /usr/bin/mongod -f /etc/mongod.conf

Nov 18 14:32:12 mongodb_1_p.unidev39.org.np systemd[1]: Started MongoDB Database Server.
Nov 18 14:32:12 mongodb_1_p.unidev39.org.np mongod[8295]: {"t":{"$date":"2023-11-18T08:47:12>
*/

-- Step 29 -->> On All Nodes
[root@mongodb_1_p/mongodb_1_s/mongodb_2_s ~]# mongosh
/*
Current Mongosh Log ID: 65587a33ce57fe360c0b8ec3
Connecting to:          mongodb://127.0.0.1:27017/?directConnection=true&serverSelectionTimeoutMS=2000&appName=mongosh+2.0.2
Using MongoDB:          7.0.3
Using Mongosh:          2.0.2

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

------
   The server generated these startup warnings when booting
   2023-11-18T14:32:13.308+05:45: Access control is not enabled for the database. Read and write access to data and configuration is unrestricted
   2023-11-18T14:32:13.308+05:45: /sys/kernel/mm/transparent_hugepage/enabled is 'always'. We suggest setting it to 'never'
------

test> db.version()
7.0.3

test> show databases
admin   40.00 KiB
config  12.00 KiB
local   72.00 KiB

test> quit()

*/

-- Step 30 -->> On All Nodes
[root@mongodb_1_p/mongodb_1_s/mongodb_2_s ~]# mongo
/*
Current Mongosh Log ID: 65587aaa93ad87aaab3e1b12
Connecting to:          mongodb://127.0.0.1:27017/?directConnection=true&serverSelectionTimeoutMS=2000&appName=mongosh+2.0.2
Using MongoDB:          7.0.3
Using Mongosh:          2.0.2

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

------
   The server generated these startup warnings when booting
   2023-11-18T14:32:13.308+05:45: Access control is not enabled for the database. Read and write access to data and configuration is unrestricted
   2023-11-18T14:32:13.308+05:45: /sys/kernel/mm/transparent_hugepage/enabled is 'always'. We suggest setting it to 'never'
------

test> db.version()
7.0.3

test> show dbs
admin   40.00 KiB
config  12.00 KiB
local   72.00 KiB

test> quit()
*/

-- Step 31 -->> On All Nodes (Fixing The MongoDB Warnings - /sys/kernel/mm/transparent_hugepage/enabled is 'always'. We suggest setting it to 'never')
[root@mongodb_1_p/mongodb_1_s/mongodb_2_s ~]# vi /etc/systemd/system/disable-mogodb-warnig.service
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
[root@mongodb_1_p/mongodb_1_s/mongodb_2_s ~]# systemctl daemon-reload
-- Step 31.2 -->> On All Nodes
[root@mongodb_1_p/mongodb_1_s/mongodb_2_s ~]# systemctl start disable-mogodb-warnig.service
-- Step 31.3 -->> On All Nodes
[root@mongodb_1_p/mongodb_1_s/mongodb_2_s ~]# systemctl enable disable-mogodb-warnig.service
/*
Created symlink /etc/systemd/system/multi-user.target.wants/disable-mogodb-warnig.service → /etc/systemd/system/disable-mogodb-warnig.service.
*/

-- Step 31.4 -->> On All Nodes
[root@mongodb_1_p/mongodb_1_s/mongodb_2_s ~]# systemctl restart mongod
-- Step 31.5 -->> On All Nodes
[root@mongodb_1_p/mongodb_1_s/mongodb_2_s ~]# systemctl status mongod
/*
● mongod.service - MongoDB Database Server
   Loaded: loaded (/usr/lib/systemd/system/mongod.service; enabled; vendor preset: disabled)
   Active: active (running) since Sat 2023-11-18 14:37:34 +0545; 7s ago
     Docs: https://docs.mongodb.org/manual
 Main PID: 8583 (mongod)
   Memory: 169.0M
   CGroup: /system.slice/mongod.service
           └─8583 /usr/bin/mongod -f /etc/mongod.conf

Nov 18 14:37:34 mongodb_1_p.unidev39.org.np systemd[1]: Stopped MongoDB Database Server.
Nov 18 14:37:34 mongodb_1_p.unidev39.org.np systemd[1]: Started MongoDB Database Server.
Nov 18 14:37:34 mongodb_1_p.unidev39.org.np mongod[8583]: {"t":{"$date":"2023-11-18T08:52:34>
*/

-- Step 32 -->> On All Nodes
[root@mongodb_1_p/mongodb_1_s/mongodb_2_s ~]# mongo
/*
Current Mongosh Log ID: 65587b76e361948363ab867f
Connecting to:          mongodb://127.0.0.1:27017/?directConnection=true&serverSelectionTimeoutMS=2000&appName=mongosh+2.0.2
Using MongoDB:          7.0.3
Using Mongosh:          2.0.2

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

------
   The server generated these startup warnings when booting
   2023-11-18T14:37:35.069+05:45: Access control is not enabled for the database. Read and write access to data and configuration is unrestricted
------

test> db.version()
7.0.3

test> show dbs
admin   40.00 KiB
config  12.00 KiB
local   72.00 KiB

test> quit()
*/

-- Step 33 -->> On All Nodes
[root@mongodb_1_p/mongodb_1_s/mongodb_2_s ~]# mongosh
/*
Current Mongosh Log ID: 65587bca2d85139873d68a0b
Connecting to:          mongodb://127.0.0.1:27017/?directConnection=true&serverSelectionTimeoutMS=2000&appName=mongosh+2.0.2
Using MongoDB:          7.0.3
Using Mongosh:          2.0.2

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

------
   The server generated these startup warnings when booting
   2023-11-18T14:37:35.069+05:45: Access control is not enabled for the database. Read and write access to data and configuration is unrestricted
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
      userId: new UUID("2330cdf4-6be9-49f0-bf75-fcc25d693ffc"),
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
   Active: active (running) since Sat 2023-11-18 14:52:25 +0545; 6s ago
     Docs: https://docs.mongodb.org/manual
 Main PID: 8995 (mongod)
   Memory: 169.0M
   CGroup: /system.slice/mongod.service
           └─8995 /usr/bin/mongod -f /etc/mongod.conf

Nov 18 14:52:25 mongodb_1_p.unidev39.org.np systemd[1]: Started MongoDB Database Server.
Nov 18 14:52:25 mongodb_1_p.unidev39.org.np mongod[8995]: {"t":{"$date":"2023-11-18T09:07:25>
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
[mongodb@mongodb_1_p ~]$ mongosh --host 192.168.56.149  --port 27017 -u admin -p P#ssw0rd --authenticationDatabase admin
/*
Current Mongosh Log ID: 65587f19712fa9f5373dba1d
Connecting to:          mongodb://<credentials>@192.168.56.149:27017/?directConnection=true&authSource=admin&appName=mongosh+2.0.2
Using MongoDB:          7.0.3
Using Mongosh:          2.0.2

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

test> show dbs
admin   132.00 KiB
config   12.00 KiB
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
      userId: new UUID("2330cdf4-6be9-49f0-bf75-fcc25d693ffc"),
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
   Active: active (running) since Sat 2023-11-18 14:55:14 +0545; 5s ago
     Docs: https://docs.mongodb.org/manual
 Main PID: 9048 (mongod)
   Memory: 169.0M
   CGroup: /system.slice/mongod.service
           └─9048 /usr/bin/mongod -f /etc/mongod.conf

Nov 18 14:55:14 mongodb_1_s.unidev39.org.np systemd[1]: Started MongoDB Database Server.
Nov 18 14:55:14 mongodb_1_s.unidev39.org.np mongod[9048]: {"t":{"$date":"2023-11-18T09:10:14>
*/

-- Step 46 -->> On Node 3
[root@mongodb_2_s ~]# systemctl stop mongod

-- Step 47 -->> On Node 3 (Access control is enabled for the database)
[root@mongodb_2_s ~]# vi /etc/mongod.conf
/*
#security:
security:
 authorization: enabled
*/

-- Step 48 -->> On Node 3
[root@mongodb_2_s ~]# systemctl start mongod

-- Step 49 -->> On Node 3
[root@mongodb_2_s ~]# systemctl status mongod
/*
● mongod.service - MongoDB Database Server
   Loaded: loaded (/usr/lib/systemd/system/mongod.service; enabled; vendor preset: disabled)
   Active: active (running) since Sat 2023-11-18 14:56:09 +0545; 4s ago
     Docs: https://docs.mongodb.org/manual
 Main PID: 9515 (mongod)
   Memory: 169.0M
   CGroup: /system.slice/mongod.service
           └─9515 /usr/bin/mongod -f /etc/mongod.conf

Nov 18 14:56:09 mongodb_2_s.unidev39.org.np systemd[1]: Started MongoDB Database Server.
Nov 18 14:56:09 mongodb_2_s.unidev39.org.np mongod[9515]: {"t":{"$date":"2023-11-18T09:11:09>
*/

-- Step 50 -->> On All Nodes (Replication Configuration)
[root@mongodb_1_p/mongodb_1_s/mongodb_2_s ~] vi /etc/mongod.conf
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
-rw------- 1 mongod mongod 20480 Nov 18 14:52 collection-0--3784624229060480650.wt
-rw------- 1 mongod mongod 36864 Nov 18 14:52 collection-0-4317638424597763523.wt
-rw------- 1 mongod mongod 36864 Nov 18 14:53 collection-2-4317638424597763523.wt
-rw------- 1 mongod mongod  4096 Nov 18 14:31 collection-4-4317638424597763523.wt
drwx------ 2 mongod mongod   174 Nov 18 14:57 diagnostic.data
-rw------- 1 mongod mongod 20480 Nov 18 14:51 index-1--3784624229060480650.wt
-rw------- 1 mongod mongod 36864 Nov 18 14:52 index-1-4317638424597763523.wt
-rw------- 1 mongod mongod 20480 Nov 18 14:53 index-2--3784624229060480650.wt
-rw------- 1 mongod mongod 36864 Nov 18 14:53 index-3-4317638424597763523.wt
-rw------- 1 mongod mongod  4096 Nov 18 14:57 index-5-4317638424597763523.wt
-rw------- 1 mongod mongod  4096 Nov 18 14:53 index-6-4317638424597763523.wt
drwx------ 2 mongod mongod   110 Nov 18 14:52 journal
-rw------- 1 mongod mongod 36864 Nov 18 14:52 _mdb_catalog.wt
-rw------- 1 mongod mongod     5 Nov 18 14:52 mongod.lock
-rw------- 1 mongod mongod 36864 Nov 18 14:54 sizeStorer.wt
-rw------- 1 mongod mongod   114 Nov 18 14:28 storage.bson
-rw------- 1 mongod mongod    50 Nov 18 14:28 WiredTiger
-rw------- 1 mongod mongod  4096 Nov 18 14:52 WiredTigerHS.wt
-rw------- 1 mongod mongod    21 Nov 18 14:28 WiredTiger.lock
-rw------- 1 mongod mongod  1468 Nov 18 14:57 WiredTiger.turtle
-rw------- 1 mongod mongod 77824 Nov 18 14:57 WiredTiger.wt
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
-rw------- 1 mongod mongod 20480 Nov 18 14:52 collection-0--3784624229060480650.wt
-rw------- 1 mongod mongod 36864 Nov 18 14:52 collection-0-4317638424597763523.wt
-rw------- 1 mongod mongod 36864 Nov 18 14:53 collection-2-4317638424597763523.wt
-rw------- 1 mongod mongod  4096 Nov 18 14:31 collection-4-4317638424597763523.wt
drwx------ 2 mongod mongod  4096 Nov 18 14:58 diagnostic.data
-rw------- 1 mongod mongod 20480 Nov 18 14:51 index-1--3784624229060480650.wt
-rw------- 1 mongod mongod 36864 Nov 18 14:52 index-1-4317638424597763523.wt
-rw------- 1 mongod mongod 20480 Nov 18 14:53 index-2--3784624229060480650.wt
-rw------- 1 mongod mongod 36864 Nov 18 14:53 index-3-4317638424597763523.wt
-rw------- 1 mongod mongod  4096 Nov 18 14:57 index-5-4317638424597763523.wt
-rw------- 1 mongod mongod  4096 Nov 18 14:53 index-6-4317638424597763523.wt
drwx------ 2 mongod mongod   110 Nov 18 14:52 journal
-r-------- 1 mongod mongod  1024 Nov 18 14:57 keyfile
-rw------- 1 mongod mongod 36864 Nov 18 14:52 _mdb_catalog.wt
-rw------- 1 mongod mongod     5 Nov 18 14:52 mongod.lock
-rw------- 1 mongod mongod 36864 Nov 18 14:54 sizeStorer.wt
-rw------- 1 mongod mongod   114 Nov 18 14:28 storage.bson
-rw------- 1 mongod mongod    50 Nov 18 14:28 WiredTiger
-rw------- 1 mongod mongod  4096 Nov 18 14:52 WiredTigerHS.wt
-rw------- 1 mongod mongod    21 Nov 18 14:28 WiredTiger.lock
-rw------- 1 mongod mongod  1468 Nov 18 14:57 WiredTiger.turtle
-rw------- 1 mongod mongod 77824 Nov 18 14:57 WiredTiger.wt
*/

-- Step 51.6 -->> On Node 1
[root@mongodb_1_p mongodb]# ll | grep keyfile
/*
-r-------- 1 mongod mongod  1024 Nov 18 14:57 keyfile
*/

-- Step 51.7 -->> On Node 1
[root@mongodb_1_p mongodb]# scp -r keyfile root@mongodb_1_s:/data/mongodb
/*
The authenticity of host 'mongodb_1_s (192.168.56.150)' can't be established.
ECDSA key fingerprint is SHA256:8LSecKw8+L5LHTrspajxlzJvHbKd6BttSMepKXCBTvw.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added 'mongodb_1_s,192.168.56.150' (ECDSA) to the list of known hosts.
root@mongodb_1_s's password:
keyfile                                                    100% 1024   756.1KB/s   00:00
*/

-- Step 51.8 -->> On Node 1
[root@mongodb_1_p mongodb]# scp -r keyfile root@mongodb_2_s:/data/mongodb
/*
The authenticity of host 'mongodb_2_s (192.168.56.151)' can't be established.
ECDSA key fingerprint is SHA256:8LSecKw8+L5LHTrspajxlzJvHbKd6BttSMepKXCBTvw.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added 'mongodb_2_s,192.168.56.151' (ECDSA) to the list of known hosts.
root@mongodb_2_s's password:
keyfile                                                    100% 1024   789.4KB/s   00:00
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
-r-------- 1 mongod mongod  1024 Nov 18 14:58 keyfile
*/

-- Step 51.14 -->> On Node 3
[root@mongodb_2_s ~]# cd /data/mongodb/
-- Step 51.15 -->> On Node 3
[root@mongodb_2_s mongodb]# ll | grep keyfile
/*
-r-------- 1 mongod mongod  1024 Nov 18 14:58 keyfile
*/

-- Step 51.16 -->> On Node 3
[root@mongodb_2_s mongodb]# chmod 400 keyfile
-- Step 51.17 -->> On Node 3
[root@mongodb_2_s mongodb]# chown mongod:mongod keyfile
-- Step 51.18 -->> On Node 3
[root@mongodb_2_s mongodb]# ll | grep keyfile
/*
-r-------- 1 mongod mongod  1024 Nov 17 12:58 keyfile
*/

-- Step 51.19 -->> On All Nodes
[root@mongodb_1_p/mongodb_1_s/mongodb_2_s ~]# vi /etc/mongod.conf
/*
#security:
security:
 authorization: enabled
 keyFile: /data/mongodb/keyfile
*/

-- Step 51.20 -->> On All Nodes
[root@mongodb_1_p/mongodb_1_s/mongodb_2_s ~]# systemctl restart mongod
-- Step 51.20 -->> On All Nodes
[root@mongodb_1_p/mongodb_1_s/mongodb_2_s ~]# systemctl status mongod
/*
● mongod.service - MongoDB Database Server
   Loaded: loaded (/usr/lib/systemd/system/mongod.service; enabled; vendor preset: disabled)
   Active: active (running) since Sat 2023-11-18 15:03:48 +0545; 1s ago
     Docs: https://docs.mongodb.org/manual
 Main PID: 10015 (mongod)
   Memory: 166.7M
   CGroup: /system.slice/mongod.service
           └─10015 /usr/bin/mongod -f /etc/mongod.conf

Nov 18 15:03:48 mongodb_1_p.unidev39.org.np systemd[1]: Started MongoDB Database Server.
Nov 18 15:03:48 mongodb_1_p.unidev39.org.np mongod[10015]: {"t":{"$date":"2023-11-18T09:18:4>
Nov 18 15:03:48 mongodb_1_p.unidev39.org.np mongod[10015]: {"t":{"$date":"2023-11-18T09:18:4>
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

-- Replication Configuration on Nede 1
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
    clusterTime: Timestamp({ t: 1700299303, i: 1 }),
    signature: {
      hash: Binary.createFromBase64("m3XvsvkH+5NvijJvzW5IFxZC9P8=", 0),
      keyId: Long("7302729826782150663")
    }
  },
  operationTime: Timestamp({ t: 1700299303, i: 1 })
}

rs0 [direct: primary] admin> rs.add("mongodb_2_s:27017");
{
  ok: 1,
  '$clusterTime': {
    clusterTime: Timestamp({ t: 1700299328, i: 1 }),
    signature: {
      hash: Binary.createFromBase64("y8Xifq+9UGNxZGK4mEZgJU6lIts=", 0),
      keyId: Long("7302729826782150663")
    }
  },
  operationTime: Timestamp({ t: 1700299328, i: 1 })
}

rs0 [direct: primary] admin> quit()
*/

-- Step 53 -->> On Node 1
[root@mongodb_1_p ~]# mongo --port 27017 -u admin -p P#ssw0rd --authenticationDatabase admin
/*
Current Mongosh Log ID: 6558827845893bd742a5e3c1
Connecting to:          mongodb://<credentials>@127.0.0.1:27017/?directConnection=true&serverSelectionTimeoutMS=2000&authSource=admin&appName=mongosh+2.0.2
Using MongoDB:          7.0.3
Using Mongosh:          2.0.2

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

rs0 [direct: primary] test> show dbs
admin   172.00 KiB
config  116.00 KiB
local   420.00 KiB

rs0 [direct: primary] test>

rs0 [direct: primary] test> use admin
switched to db admin

rs0 [direct: primary] admin> db.version()
7.0.3

rs0 [direct: primary] admin>

rs0 [direct: primary] admin> rs.status()
{
  set: 'rs0',
  date: ISODate("2023-11-18T09:23:46.401Z"),
  myState: 1,
  term: Long("1"),
  syncSourceHost: '',
  syncSourceId: -1,
  heartbeatIntervalMillis: Long("2000"),
  majorityVoteCount: 2,
  writeMajorityCount: 2,
  votingMembersCount: 3,
  writableVotingMembersCount: 3,
  optimes: {
    lastCommittedOpTime: { ts: Timestamp({ t: 1700299426, i: 1 }), t: Long("1") },
    lastCommittedWallTime: ISODate("2023-11-18T09:23:46.271Z"),
    readConcernMajorityOpTime: { ts: Timestamp({ t: 1700299426, i: 1 }), t: Long("1") },
    appliedOpTime: { ts: Timestamp({ t: 1700299426, i: 1 }), t: Long("1") },
    durableOpTime: { ts: Timestamp({ t: 1700299426, i: 1 }), t: Long("1") },
    lastAppliedWallTime: ISODate("2023-11-18T09:23:46.271Z"),
    lastDurableWallTime: ISODate("2023-11-18T09:23:46.271Z")
  },
  lastStableRecoveryTimestamp: Timestamp({ t: 1700299396, i: 1 }),
  electionCandidateMetrics: {
    lastElectionReason: 'electionTimeout',
    lastElectionDate: ISODate("2023-11-18T09:21:26.220Z"),
    electionTerm: Long("1"),
    lastCommittedOpTimeAtElection: { ts: Timestamp({ t: 1700299286, i: 1 }), t: Long("-1") },
    lastSeenOpTimeAtElection: { ts: Timestamp({ t: 1700299286, i: 1 }), t: Long("-1") },
    numVotesNeeded: 1,
    priorityAtElection: 1,
    electionTimeoutMillis: Long("10000"),
    newTermStartDate: ISODate("2023-11-18T09:21:26.241Z"),
    wMajorityWriteAvailabilityDate: ISODate("2023-11-18T09:21:26.255Z")
  },
  members: [
    {
      _id: 0,
      name: 'mongodb_1_p:27017',
      health: 1,
      state: 1,
      stateStr: 'PRIMARY',
      uptime: 298,
      optime: { ts: Timestamp({ t: 1700299426, i: 1 }), t: Long("1") },
      optimeDate: ISODate("2023-11-18T09:23:46.000Z"),
      lastAppliedWallTime: ISODate("2023-11-18T09:23:46.271Z"),
      lastDurableWallTime: ISODate("2023-11-18T09:23:46.271Z"),
      syncSourceHost: '',
      syncSourceId: -1,
      infoMessage: '',
      electionTime: Timestamp({ t: 1700299286, i: 2 }),
      electionDate: ISODate("2023-11-18T09:21:26.000Z"),
      configVersion: 5,
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
      uptime: 123,
      optime: { ts: Timestamp({ t: 1700299416, i: 1 }), t: Long("1") },
      optimeDurable: { ts: Timestamp({ t: 1700299416, i: 1 }), t: Long("1") },
      optimeDate: ISODate("2023-11-18T09:23:36.000Z"),
      optimeDurableDate: ISODate("2023-11-18T09:23:36.000Z"),
      lastAppliedWallTime: ISODate("2023-11-18T09:23:46.271Z"),
      lastDurableWallTime: ISODate("2023-11-18T09:23:46.271Z"),
      lastHeartbeat: ISODate("2023-11-18T09:23:44.615Z"),
      lastHeartbeatRecv: ISODate("2023-11-18T09:23:44.613Z"),
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
      name: 'mongodb_2_s:27017',
      health: 1,
      state: 2,
      stateStr: 'SECONDARY',
      uptime: 97,
      optime: { ts: Timestamp({ t: 1700299416, i: 1 }), t: Long("1") },
      optimeDurable: { ts: Timestamp({ t: 1700299416, i: 1 }), t: Long("1") },
      optimeDate: ISODate("2023-11-18T09:23:36.000Z"),
      optimeDurableDate: ISODate("2023-11-18T09:23:36.000Z"),
      lastAppliedWallTime: ISODate("2023-11-18T09:23:46.271Z"),
      lastDurableWallTime: ISODate("2023-11-18T09:23:46.271Z"),
      lastHeartbeat: ISODate("2023-11-18T09:23:44.615Z"),
      lastHeartbeatRecv: ISODate("2023-11-18T09:23:45.084Z"),
      pingMs: Long("0"),
      lastHeartbeatMessage: '',
      syncSourceHost: 'mongodb_1_s:27017',
      syncSourceId: 1,
      infoMessage: '',
      configVersion: 5,
      configTerm: 1
    }
  ],
  ok: 1,
  '$clusterTime': {
    clusterTime: Timestamp({ t: 1700299426, i: 1 }),
    signature: {
      hash: Binary.createFromBase64("GKJSeRDT92qiHbe+PNfukT38qNE=", 0),
      keyId: Long("7302729826782150663")
    }
  },
  operationTime: Timestamp({ t: 1700299426, i: 1 })
}

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
      host: 'mongodb_2_s:27017',
      arbiterOnly: false,
      buildIndexes: true,
      hidden: false,
      priority: 1,
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
    replicaSetId: ObjectId("65588216440fe44199dc2548")
  }
}

rs0 [direct: primary] admin> rs.isMaster()
{
  topologyVersion: {
    processId: ObjectId("65588178440fe44199dc24e6"),
    counter: Long("10")
  },
  hosts: [ 'mongodb_1_p:27017', 'mongodb_1_s:27017', 'mongodb_2_s:27017' ],
  setName: 'rs0',
  setVersion: 5,
  ismaster: true,
  secondary: false,
  primary: 'mongodb_1_p:27017',
  me: 'mongodb_1_p:27017',
  electionId: ObjectId("7fffffff0000000000000001"),
  lastWrite: {
    opTime: { ts: Timestamp({ t: 1700299586, i: 1 }), t: Long("1") },
    lastWriteDate: ISODate("2023-11-18T09:26:26.000Z"),
    majorityOpTime: { ts: Timestamp({ t: 1700299586, i: 1 }), t: Long("1") },
    majorityWriteDate: ISODate("2023-11-18T09:26:26.000Z")
  },
  maxBsonObjectSize: 16777216,
  maxMessageSizeBytes: 48000000,
  maxWriteBatchSize: 100000,
  localTime: ISODate("2023-11-18T09:26:31.504Z"),
  logicalSessionTimeoutMinutes: 30,
  connectionId: 31,
  minWireVersion: 0,
  maxWireVersion: 21,
  readOnly: false,
  ok: 1,
  '$clusterTime': {
    clusterTime: Timestamp({ t: 1700299586, i: 1 }),
    signature: {
      hash: Binary.createFromBase64("D4fBZ7z5VvPqQWheB6sJ1h/41ZU=", 0),
      keyId: Long("7302729826782150663")
    }
  },
  operationTime: Timestamp({ t: 1700299586, i: 1 }),
  isWritablePrimary: true
}

rs0 [direct: primary] admin> quit()

*/

-- Step 54 -->> On Node 1
[root@mongodb_1_p ~]# mongo --port 27017 -u admin -p P#ssw0rd --authenticationDatabase admin
/*
Current Mongosh Log ID: 655883efe24c6f8df44fa044
Connecting to:          mongodb://<credentials>@127.0.0.1:27017/?directConnection=true&serverSelectionTimeoutMS=2000&authSource=admin&appName=mongosh+2.0.2
Using MongoDB:          7.0.3
Using Mongosh:          2.0.2

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

rs0 [direct: primary] test> db.version()
7.0.3

rs0 [direct: primary] test> use admin
switched to db admin

rs0 [direct: primary] admin> db.getUsers()
{
  users: [
    {
      _id: 'admin.admin',
      userId: new UUID("2330cdf4-6be9-49f0-bf75-fcc25d693ffc"),
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
    clusterTime: Timestamp({ t: 1700299776, i: 1 }),
    signature: {
      hash: Binary.createFromBase64("6y/CDT/0Ud5dQw4XF5Tm7VzYJHQ=", 0),
      keyId: Long("7302729826782150663")
    }
  },
  operationTime: Timestamp({ t: 1700299776, i: 1 })
}

--To Make default write concern to { w: 1 }
rs0 [direct: primary] admin> db.adminCommand(
... {
...  setDefaultRWConcern: 1,
...  defaultWriteConcern: { w: 1 }
... })
{
  defaultReadConcern: { level: 'local' },
  defaultWriteConcern: { w: 1, wtimeout: 0 },
  updateOpTime: Timestamp({ t: 1700299826, i: 1 }),
  updateWallClockTime: ISODate("2023-11-18T09:30:31.165Z"),
  defaultWriteConcernSource: 'global',
  defaultReadConcernSource: 'implicit',
  localUpdateWallClockTime: ISODate("2023-11-18T09:30:31.171Z"),
  ok: 1,
  '$clusterTime': {
    clusterTime: Timestamp({ t: 1700299831, i: 2 }),
    signature: {
      hash: Binary.createFromBase64("KKDXHNS2uqRNT0HaTtMmrYd/BY4=", 0),
      keyId: Long("7302729826782150663")
    }
  },
  operationTime: Timestamp({ t: 1700299831, i: 2 })
}

rs0 [direct: primary] admin> quit()
*/

-- Step 55 -->> On Node 2
[root@mongodb_1_s ~]# mongo --port 27017 -u admin -p P#ssw0rd --authenticationDatabase admin
/*
Current Mongosh Log ID: 655884f17ceb6096c9290bc1
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

rs0 [direct: secondary] admin> rs.isMaster()
{
  topologyVersion: {
    processId: ObjectId("655881a1eb3dbfada2b5755f"),
    counter: Long("6")
  },
  hosts: [ 'mongodb_1_p:27017', 'mongodb_1_s:27017', 'mongodb_2_s:27017' ],
  setName: 'rs0',
  setVersion: 5,
  ismaster: false,
  secondary: true,
  primary: 'mongodb_1_p:27017',
  me: 'mongodb_1_s:27017',
  lastWrite: {
    opTime: { ts: Timestamp({ t: 1700300046, i: 1 }), t: Long("1") },
    lastWriteDate: ISODate("2023-11-18T09:34:06.000Z"),
    majorityOpTime: { ts: Timestamp({ t: 1700300046, i: 1 }), t: Long("1") },
    majorityWriteDate: ISODate("2023-11-18T09:34:06.000Z")
  },
  maxBsonObjectSize: 16777216,
  maxMessageSizeBytes: 48000000,
  maxWriteBatchSize: 100000,
  localTime: ISODate("2023-11-18T09:34:15.207Z"),
  logicalSessionTimeoutMinutes: 30,
  connectionId: 36,
  minWireVersion: 0,
  maxWireVersion: 21,
  readOnly: false,
  ok: 1,
  '$clusterTime': {
    clusterTime: Timestamp({ t: 1700300046, i: 1 }),
    signature: {
      hash: Binary.createFromBase64("azwGzRe67sGuUa+EIF7Kd8jPLYE=", 0),
      keyId: Long("7302729826782150663")
    }
  },
  operationTime: Timestamp({ t: 1700300046, i: 1 }),
  isWritablePrimary: false
}

rs0 [direct: secondary] admin> rs.status()
{
  set: 'rs0',
  date: ISODate("2023-11-18T09:34:30.621Z"),
  myState: 2,
  term: Long("1"),
  syncSourceHost: 'mongodb_1_p:27017',
  syncSourceId: 0,
  heartbeatIntervalMillis: Long("2000"),
  majorityVoteCount: 2,
  writeMajorityCount: 2,
  votingMembersCount: 3,
  writableVotingMembersCount: 3,
  optimes: {
    lastCommittedOpTime: { ts: Timestamp({ t: 1700300070, i: 4 }), t: Long("1") },
    lastCommittedWallTime: ISODate("2023-11-18T09:34:30.382Z"),
    readConcernMajorityOpTime: { ts: Timestamp({ t: 1700300070, i: 4 }), t: Long("1") },
    appliedOpTime: { ts: Timestamp({ t: 1700300070, i: 4 }), t: Long("1") },
    durableOpTime: { ts: Timestamp({ t: 1700300070, i: 4 }), t: Long("1") },
    lastAppliedWallTime: ISODate("2023-11-18T09:34:30.382Z"),
    lastDurableWallTime: ISODate("2023-11-18T09:34:30.382Z")
  },
  lastStableRecoveryTimestamp: Timestamp({ t: 1700300016, i: 1 }),
  members: [
    {
      _id: 0,
      name: 'mongodb_1_p:27017',
      health: 1,
      state: 1,
      stateStr: 'PRIMARY',
      uptime: 767,
      optime: { ts: Timestamp({ t: 1700300066, i: 1 }), t: Long("1") },
      optimeDurable: { ts: Timestamp({ t: 1700300066, i: 1 }), t: Long("1") },
      optimeDate: ISODate("2023-11-18T09:34:26.000Z"),
      optimeDurableDate: ISODate("2023-11-18T09:34:26.000Z"),
      lastAppliedWallTime: ISODate("2023-11-18T09:34:26.400Z"),
      lastDurableWallTime: ISODate("2023-11-18T09:34:26.400Z"),
      lastHeartbeat: ISODate("2023-11-18T09:34:29.516Z"),
      lastHeartbeatRecv: ISODate("2023-11-18T09:34:29.564Z"),
      pingMs: Long("0"),
      lastHeartbeatMessage: '',
      syncSourceHost: '',
      syncSourceId: -1,
      infoMessage: '',
      electionTime: Timestamp({ t: 1700299286, i: 2 }),
      electionDate: ISODate("2023-11-18T09:21:26.000Z"),
      configVersion: 5,
      configTerm: 1
    },
    {
      _id: 1,
      name: 'mongodb_1_s:27017',
      health: 1,
      state: 2,
      stateStr: 'SECONDARY',
      uptime: 901,
      optime: { ts: Timestamp({ t: 1700300070, i: 4 }), t: Long("1") },
      optimeDate: ISODate("2023-11-18T09:34:30.000Z"),
      lastAppliedWallTime: ISODate("2023-11-18T09:34:30.382Z"),
      lastDurableWallTime: ISODate("2023-11-18T09:34:30.382Z"),
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
      name: 'mongodb_2_s:27017',
      health: 1,
      state: 2,
      stateStr: 'SECONDARY',
      uptime: 742,
      optime: { ts: Timestamp({ t: 1700300066, i: 1 }), t: Long("1") },
      optimeDurable: { ts: Timestamp({ t: 1700300066, i: 1 }), t: Long("1") },
      optimeDate: ISODate("2023-11-18T09:34:26.000Z"),
      optimeDurableDate: ISODate("2023-11-18T09:34:26.000Z"),
      lastAppliedWallTime: ISODate("2023-11-18T09:34:30.382Z"),
      lastDurableWallTime: ISODate("2023-11-18T09:34:30.382Z"),
      lastHeartbeat: ISODate("2023-11-18T09:34:29.359Z"),
      lastHeartbeatRecv: ISODate("2023-11-18T09:34:29.946Z"),
      pingMs: Long("0"),
      lastHeartbeatMessage: '',
      syncSourceHost: 'mongodb_1_s:27017',
      syncSourceId: 1,
      infoMessage: '',
      configVersion: 5,
      configTerm: 1
    }
  ],
  ok: 1,
  '$clusterTime': {
    clusterTime: Timestamp({ t: 1700300070, i: 4 }),
    signature: {
      hash: Binary.createFromBase64("INMXSnV30bgO+tizVoahNTLpNRg=", 0),
      keyId: Long("7302729826782150663")
    }
  },
  operationTime: Timestamp({ t: 1700300070, i: 4 })
}

rs0 [direct: secondary] admin> rs.conf()
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
      host: 'mongodb_2_s:27017',
      arbiterOnly: false,
      buildIndexes: true,
      hidden: false,
      priority: 1,
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
    replicaSetId: ObjectId("65588216440fe44199dc2548")
  }
}

rs0 [direct: secondary] admin> quit()
*/

-- Step 56 -->> On Node 3
[root@mongodb_2_s ~]# mongo --port 27017 -u admin -p P#ssw0rd --authenticationDatabase admin
/*
Current Mongosh Log ID: 655885d410f7d8aafed7c354
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

rs0 [direct: secondary] admin> rs.isMaster()
{
  topologyVersion: {
    processId: ObjectId("655881b9e6abc3bcd0f3a5b6"),
    counter: Long("4")
  },
  hosts: [ 'mongodb_1_p:27017', 'mongodb_1_s:27017', 'mongodb_2_s:27017' ],
  setName: 'rs0',
  setVersion: 5,
  ismaster: false,
  secondary: true,
  primary: 'mongodb_1_p:27017',
  me: 'mongodb_2_s:27017',
  lastWrite: {
    opTime: { ts: Timestamp({ t: 1700300296, i: 1 }), t: Long("1") },
    lastWriteDate: ISODate("2023-11-18T09:38:16.000Z"),
    majorityOpTime: { ts: Timestamp({ t: 1700300296, i: 1 }), t: Long("1") },
    majorityWriteDate: ISODate("2023-11-18T09:38:16.000Z")
  },
  maxBsonObjectSize: 16777216,
  maxMessageSizeBytes: 48000000,
  maxWriteBatchSize: 100000,
  localTime: ISODate("2023-11-18T09:38:18.283Z"),
  logicalSessionTimeoutMinutes: 30,
  connectionId: 31,
  minWireVersion: 0,
  maxWireVersion: 21,
  readOnly: false,
  ok: 1,
  '$clusterTime': {
    clusterTime: Timestamp({ t: 1700300296, i: 1 }),
    signature: {
      hash: Binary.createFromBase64("aoD6PABwXj9HaifDmfM82xIJCMc=", 0),
      keyId: Long("7302729826782150663")
    }
  },
  operationTime: Timestamp({ t: 1700300296, i: 1 }),
  isWritablePrimary: false
}

rs0 [direct: secondary] admin> rs.status()
{
  set: 'rs0',
  date: ISODate("2023-11-18T09:38:24.639Z"),
  myState: 2,
  term: Long("1"),
  syncSourceHost: 'mongodb_1_s:27017',
  syncSourceId: 1,
  heartbeatIntervalMillis: Long("2000"),
  majorityVoteCount: 2,
  writeMajorityCount: 2,
  votingMembersCount: 3,
  writableVotingMembersCount: 3,
  optimes: {
    lastCommittedOpTime: { ts: Timestamp({ t: 1700300296, i: 1 }), t: Long("1") },
    lastCommittedWallTime: ISODate("2023-11-18T09:38:16.447Z"),
    readConcernMajorityOpTime: { ts: Timestamp({ t: 1700300296, i: 1 }), t: Long("1") },
    appliedOpTime: { ts: Timestamp({ t: 1700300296, i: 1 }), t: Long("1") },
    durableOpTime: { ts: Timestamp({ t: 1700300296, i: 1 }), t: Long("1") },
    lastAppliedWallTime: ISODate("2023-11-18T09:38:16.447Z"),
    lastDurableWallTime: ISODate("2023-11-18T09:38:16.447Z")
  },
  lastStableRecoveryTimestamp: Timestamp({ t: 1700300286, i: 1 }),
  members: [
    {
      _id: 0,
      name: 'mongodb_1_p:27017',
      health: 1,
      state: 1,
      stateStr: 'PRIMARY',
      uptime: 976,
      optime: { ts: Timestamp({ t: 1700300296, i: 1 }), t: Long("1") },
      optimeDurable: { ts: Timestamp({ t: 1700300296, i: 1 }), t: Long("1") },
      optimeDate: ISODate("2023-11-18T09:38:16.000Z"),
      optimeDurableDate: ISODate("2023-11-18T09:38:16.000Z"),
      lastAppliedWallTime: ISODate("2023-11-18T09:38:16.447Z"),
      lastDurableWallTime: ISODate("2023-11-18T09:38:16.447Z"),
      lastHeartbeat: ISODate("2023-11-18T09:38:24.277Z"),
      lastHeartbeatRecv: ISODate("2023-11-18T09:38:23.927Z"),
      pingMs: Long("0"),
      lastHeartbeatMessage: '',
      syncSourceHost: '',
      syncSourceId: -1,
      infoMessage: '',
      electionTime: Timestamp({ t: 1700299286, i: 2 }),
      electionDate: ISODate("2023-11-18T09:21:26.000Z"),
      configVersion: 5,
      configTerm: 1
    },
    {
      _id: 1,
      name: 'mongodb_1_s:27017',
      health: 1,
      state: 2,
      stateStr: 'SECONDARY',
      uptime: 976,
      optime: { ts: Timestamp({ t: 1700300296, i: 1 }), t: Long("1") },
      optimeDurable: { ts: Timestamp({ t: 1700300296, i: 1 }), t: Long("1") },
      optimeDate: ISODate("2023-11-18T09:38:16.000Z"),
      optimeDurableDate: ISODate("2023-11-18T09:38:16.000Z"),
      lastAppliedWallTime: ISODate("2023-11-18T09:38:16.447Z"),
      lastDurableWallTime: ISODate("2023-11-18T09:38:16.447Z"),
      lastHeartbeat: ISODate("2023-11-18T09:38:24.277Z"),
      lastHeartbeatRecv: ISODate("2023-11-18T09:38:23.685Z"),
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
      name: 'mongodb_2_s:27017',
      health: 1,
      state: 2,
      stateStr: 'SECONDARY',
      uptime: 1111,
      optime: { ts: Timestamp({ t: 1700300296, i: 1 }), t: Long("1") },
      optimeDate: ISODate("2023-11-18T09:38:16.000Z"),
      lastAppliedWallTime: ISODate("2023-11-18T09:38:16.447Z"),
      lastDurableWallTime: ISODate("2023-11-18T09:38:16.447Z"),
      syncSourceHost: 'mongodb_1_s:27017',
      syncSourceId: 1,
      infoMessage: '',
      configVersion: 5,
      configTerm: 1,
      self: true,
      lastHeartbeatMessage: ''
    }
  ],
  ok: 1,
  '$clusterTime': {
    clusterTime: Timestamp({ t: 1700300296, i: 1 }),
    signature: {
      hash: Binary.createFromBase64("aoD6PABwXj9HaifDmfM82xIJCMc=", 0),
      keyId: Long("7302729826782150663")
    }
  },
  operationTime: Timestamp({ t: 1700300296, i: 1 })
}

rs0 [direct: secondary] admin> rs.conf()
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
      host: 'mongodb_2_s:27017',
      arbiterOnly: false,
      buildIndexes: true,
      hidden: false,
      priority: 1,
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
    replicaSetId: ObjectId("65588216440fe44199dc2548")
  }
}

rs0 [direct: secondary] admin> quit()
*/

-- Fixing the issue "MongoServerError: not primary and secondaryOk=false - consider using db.getMongo().setReadPref() or readPreference in the connection string"
--The error message you are getting means that you are trying to read data from a MongoDB server that is not the primary node of a replica set, 
--and the secondaryOk option is set to false. The secondaryOk option determines whether the server can accept read operations from secondary nodes 
--or not. By default, this option is false, which means that only the primary node can perform read operations.
-- Step 57 -->> On Node 2
[root@mongodb_1_s ~]# mongo --port 27017 -u admin -p P#ssw0rd --authenticationDatabase admin
/*
Current Mongosh Log ID: 6558869228818ca5a773e32d
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

rs0 [direct: secondary] admin> db
admin

rs0 [direct: secondary] admin> db.version()
7.0.3

rs0 [direct: secondary] admin> db.getUsers()
MongoServerError: not primary and secondaryOk=false - consider using db.getMongo().setReadPref() or readPreference in the connection string

rs0 [direct: secondary] admin> db.getMongo().setReadPref("secondaryPreferred")

rs0 [direct: secondary] admin> db.getUsers()
{
  users: [
    {
      _id: 'admin.admin',
      userId: new UUID("2330cdf4-6be9-49f0-bf75-fcc25d693ffc"),
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
    clusterTime: Timestamp({ t: 1700300536, i: 1 }),
    signature: {
      hash: Binary.createFromBase64("cO89xB/me7yM9X0A/WuSn6+SxqY=", 0),
      keyId: Long("7302729826782150663")
    }
  },
  operationTime: Timestamp({ t: 1700300536, i: 1 })
}

rs0 [direct: secondary] admin> quit()
*/

-- Fixing the issue "MongoServerError: not primary and secondaryOk=false - consider using db.getMongo().setReadPref() or readPreference in the connection string"
--The error message you are getting means that you are trying to read data from a MongoDB server that is not the primary node of a replica set, 
--and the secondaryOk option is set to false. The secondaryOk option determines whether the server can accept read operations from secondary nodes 
--or not. By default, this option is false, which means that only the primary node can perform read operations.
-- Step 58 -->> On Node 3
[root@mongodb_2_s ~]# mongo --port 27017 -u admin -p P#ssw0rd --authenticationDatabase admin
/*
Current Mongosh Log ID: 6558870d82aa07880be5f3fe
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

rs0 [direct: secondary] admin> db.version()
7.0.3

rs0 [direct: secondary] admin> db.getUsers()
MongoServerError: not primary and secondaryOk=false - consider using db.getMongo().setReadPref() or readPreference in the connection string

rs0 [direct: secondary] admin> db.getMongo().setReadPref("secondaryPreferred")

rs0 [direct: secondary] admin> db.getUsers()
{
  users: [
    {
      _id: 'admin.admin',
      userId: new UUID("2330cdf4-6be9-49f0-bf75-fcc25d693ffc"),
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
    clusterTime: Timestamp({ t: 1700300576, i: 1 }),
    signature: {
      hash: Binary.createFromBase64("l+A4cDRCZff2Ggma9iHX/9Tz6ns=", 0),
      keyId: Long("7302729826782150663")
    }
  },
  operationTime: Timestamp({ t: 1700300576, i: 1 })
}

rs0 [direct: secondary] admin> quit()
*/

--To set the Priority Lists Of all Mongo Nodes
-- Step 59 -->> On Node 1
[root@mongodb_1_p ~]# mongo --host 192.168.56.149  --port 27017 -u admin -p P#ssw0rd --authenticationDatabase admin
/*
Current Mongosh Log ID: 655888eac2076eaa81a67b82
Connecting to:          mongodb://<credentials>@192.168.56.149:27017/?directConnection=true&authSource=admin&appName=mongosh+2.0.2
Using MongoDB:          7.0.3
Using Mongosh:          2.0.2

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

rs0 [direct: primary] test> show dbs
admin   172.00 KiB
config  224.00 KiB
local   444.00 KiB

rs0 [direct: primary] test> use admin
switched to db admin

rs0 [direct: primary] admin> db.getUsers()
{
  users: [
    {
      _id: 'admin.admin',
      userId: new UUID("2330cdf4-6be9-49f0-bf75-fcc25d693ffc"),
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
    clusterTime: Timestamp({ t: 1700301046, i: 1 }),
    signature: {
      hash: Binary.createFromBase64("bSeauP4Hb8iG5u6/b280vapgtqc=", 0),
      keyId: Long("7302729826782150663")
    }
  },
  operationTime: Timestamp({ t: 1700301046, i: 1 })
}

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
      host: 'mongodb_2_s:27017',
      arbiterOnly: false,
      buildIndexes: true,
      hidden: false,
      priority: 1,
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
    replicaSetId: ObjectId("65588216440fe44199dc2548")
  }
}

rs0 [direct: primary] admin> cfg = rs.conf()
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
      host: 'mongodb_2_s:27017',
      arbiterOnly: false,
      buildIndexes: true,
      hidden: false,
      priority: 1,
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
    replicaSetId: ObjectId("65588216440fe44199dc2548")
  }
}

rs0 [direct: primary] admin> cfg.members[0].priority = 20
20

rs0 [direct: primary] admin> rs.reconfig(cfg)
{
  ok: 1,
  '$clusterTime': {
    clusterTime: Timestamp({ t: 1700301130, i: 1 }),
    signature: {
      hash: Binary.createFromBase64("tKSwch6Z7F6RRSgN62JaMNra54Y=", 0),
      keyId: Long("7302729826782150663")
    }
  },
  operationTime: Timestamp({ t: 1700301130, i: 1 })
}

rs0 [direct: primary] admin> rs.conf()
{
  _id: 'rs0',
  version: 6,
  term: 1,
  members: [
    {
      _id: 0,
      host: 'mongodb_1_p:27017',
      arbiterOnly: false,
      buildIndexes: true,
      hidden: false,
      priority: 20,
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
      host: 'mongodb_2_s:27017',
      arbiterOnly: false,
      buildIndexes: true,
      hidden: false,
      priority: 1,
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
    replicaSetId: ObjectId("65588216440fe44199dc2548")
  }
}

rs0 [direct: primary] admin> cfg = rs.conf()
{
  _id: 'rs0',
  version: 6,
  term: 1,
  members: [
    {
      _id: 0,
      host: 'mongodb_1_p:27017',
      arbiterOnly: false,
      buildIndexes: true,
      hidden: false,
      priority: 20,
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
      host: 'mongodb_2_s:27017',
      arbiterOnly: false,
      buildIndexes: true,
      hidden: false,
      priority: 1,
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
    replicaSetId: ObjectId("65588216440fe44199dc2548")
  }
}

rs0 [direct: primary] admin> cfg.members[1].priority = 10
10

rs0 [direct: primary] admin> rs.reconfig(cfg)
{
  ok: 1,
  '$clusterTime': {
    clusterTime: Timestamp({ t: 1700301173, i: 1 }),
    signature: {
      hash: Binary.createFromBase64("LQ0+T2srdp2p+JRxWKcwJW0hb+g=", 0),
      keyId: Long("7302729826782150663")
    }
  },
  operationTime: Timestamp({ t: 1700301173, i: 1 })
}

rs0 [direct: primary] admin> rs.conf()
{
  _id: 'rs0',
  version: 7,
  term: 1,
  members: [
    {
      _id: 0,
      host: 'mongodb_1_p:27017',
      arbiterOnly: false,
      buildIndexes: true,
      hidden: false,
      priority: 20,
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
      priority: 10,
      tags: {},
      secondaryDelaySecs: Long("0"),
      votes: 1
    },
    {
      _id: 2,
      host: 'mongodb_2_s:27017',
      arbiterOnly: false,
      buildIndexes: true,
      hidden: false,
      priority: 1,
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
    replicaSetId: ObjectId("65588216440fe44199dc2548")
  }
}

rs0 [direct: primary] admin> quit()
*/

-- Step 60 -->> On Node 1 (Replication Test)
[root@mongodb_1_p ~]# mongo --host 192.168.56.149  --port 27017 -u admin -p P#ssw0rd --authenticationDatabase admin
/*
Current Mongosh Log ID: 65588a1295d4c42db6aed482
Connecting to:          mongodb://<credentials>@192.168.56.149:27017/?directConnection=true&authSource=admin&appName=mongosh+2.0.2
Using MongoDB:          7.0.3
Using Mongosh:          2.0.2

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

rs0 [direct: primary] test> show dbs
admin   172.00 KiB
config  224.00 KiB
local   444.00 KiB

rs0 [direct: primary] test> use admin
switched to db admin

rs0 [direct: primary] admin> db
admin

rs0 [direct: primary] admin> db.getUsers()
{
  users: [
    {
      _id: 'admin.admin',
      userId: new UUID("2330cdf4-6be9-49f0-bf75-fcc25d693ffc"),
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
    clusterTime: Timestamp({ t: 1700301356, i: 1 }),
    signature: {
      hash: Binary.createFromBase64("/9i2A+EAsiagnuSEMyJvzJYSn18=", 0),
      keyId: Long("7302729826782150663")
    }
  },
  operationTime: Timestamp({ t: 1700301356, i: 1 })
}

rs0 [direct: primary] admin> use devesh
switched to db devesh

rs0 [direct: primary] devesh> db.createUser(
... {
...  user: "devesh",
...  pwd: "P@ssw0rD",
...  roles: [
...          {
...               role: "readWrite",
...               db: "admin"
...          }
...         ]
... })
{
  ok: 1,
  '$clusterTime': {
    clusterTime: Timestamp({ t: 1700301516, i: 2 }),
    signature: {
      hash: Binary.createFromBase64("QHXxAmpYwxU6G1gi8ZQUs2twI2Y=", 0),
      keyId: Long("7302729826782150663")
    }
  },
  operationTime: Timestamp({ t: 1700301516, i: 2 })
}

rs0 [direct: primary] devesh> db
devesh

rs0 [direct: primary] devesh> db.dropUser("devesh")
{
  ok: 1,
  '$clusterTime': {
    clusterTime: Timestamp({ t: 1700301624, i: 1 }),
    signature: {
      hash: Binary.createFromBase64("KhCyKMBicYDh4Yr9XIAMIWVPLRQ=", 0),
      keyId: Long("7302729826782150663")
    }
  },
  operationTime: Timestamp({ t: 1700301624, i: 1 })
}

rs0 [direct: primary] devesh> db.createUser(
... {
...  user: "devesh",
...  pwd: "P@ssw0rD",
...  roles: [
...          {
...               role: "readWrite",
...               db: "devesh"
...          }
...         ]
... })
{
  ok: 1,
  '$clusterTime': {
    clusterTime: Timestamp({ t: 1700301641, i: 1 }),
    signature: {
      hash: Binary.createFromBase64("wu2w5UDALG+Oo8LuzQLv3os4qE0=", 0),
      keyId: Long("7302729826782150663")
    }
  },
  operationTime: Timestamp({ t: 1700301641, i: 1 })
}

rs0 [direct: primary] devesh> db.auth('devesh','P@ssw0rD')
{ ok: 1 }

rs0 [direct: primary] devesh> db.createCollection('tbl_cib')
{ ok: 1 }

rs0 [direct: primary] devesh> db.tbl_cib.insertOne({name: "Devesh", age: 44})
{
  acknowledged: true,
  insertedId: ObjectId("655afeb629fd4ec33e1d2d1b")
}

rs0 [direct: primary] devesh> db.tbl_cib.insertMany([{name: "Devesh", age: 44}, {name: "Madhu", age: 44}])
{
  acknowledged: true,
  insertedIds: {
    '0': ObjectId("655afec129fd4ec33e1d2d1c"),
    '1': ObjectId("655afec129fd4ec33e1d2d1d")
  }
}

rs0 [direct: primary] devesh> db.tbl_cib.bulkWrite([
... { insertOne : { document : { name: "Devesh", age: 25 } } },
... { updateOne : { filter : { name: "Madhu" }, update : { $set : { age: 40 } } } },
... { deleteOne : { filter : { name: "Manish" } } }
... ])
{
  acknowledged: true,
  insertedCount: 1,
  insertedIds: { '0': ObjectId("655afec829fd4ec33e1d2d1e") },
  matchedCount: 1,
  modifiedCount: 1,
  deletedCount: 0,
  upsertedCount: 0,
  upsertedIds: {}
}

rs0 [direct: primary] devesh> db.tbl_cib.find()
[
  {
    _id: ObjectId("655afeb629fd4ec33e1d2d1b"),
    name: 'Devesh',
    age: 44
  },
  {
    _id: ObjectId("655afec129fd4ec33e1d2d1c"),
    name: 'Devesh',
    age: 44
  },
  { _id: ObjectId("655afec129fd4ec33e1d2d1d"), name: 'Madhu', age: 40 },
  {
    _id: ObjectId("655afec829fd4ec33e1d2d1e"),
    name: 'Devesh',
    age: 25
  }
]

rs0 [direct: primary] devesh> db.tbl_cib.find().pretty()
[
  {
    _id: ObjectId("655afeb629fd4ec33e1d2d1b"),
    name: 'Devesh',
    age: 44
  },
  {
    _id: ObjectId("655afec129fd4ec33e1d2d1c"),
    name: 'Devesh',
    age: 44
  },
  { _id: ObjectId("655afec129fd4ec33e1d2d1d"), name: 'Madhu', age: 40 },
  {
    _id: ObjectId("655afec829fd4ec33e1d2d1e"),
    name: 'Devesh',
    age: 25
  }
]

rs0 [direct: primary] devesh> show collections
tbl_cib

rs0 [direct: primary] devesh> db.getCollectionNames()
[ 'tbl_cib' ]

rs0 [direct: primary] devesh> quit()

*/

-- Step 61 -->> On Node 1 (Replication Test)
[root@mongodb_1_p ~]# mongo --host 192.168.56.150  --port 27017 -u admin -p P#ssw0rd --authenticationDatabase admin
/*
Current Mongosh Log ID: 65588b8206d3ca1d16208211
Connecting to:          mongodb://<credentials>@192.168.56.149:27017/?directConnection=true&authSource=admin&appName=mongosh+2.0.2
Using MongoDB:          7.0.3
Using Mongosh:          2.0.2

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

rs0 [direct: primary] test> show dbs
admin   220.00 KiB
config  228.00 KiB
devesh    8.00 KiB
local   444.00 KiB

rs0 [direct: primary] test> use devesh
switched to db devesh

rs0 [direct: primary] devesh> show dbs
admin   220.00 KiB
config  228.00 KiB
devesh    8.00 KiB
local   444.00 KiB

rs0 [direct: primary] devesh> quit()
*/

-- Step 62 -->> On Node 1 (Replication Test)
[root@mongodb_1_p ~]# mongo --host 192.168.56.149  --port 27017 -u devesh -p P@ssw0rD --authenticationDatabase devesh
/*
Current Mongosh Log ID: 65588d855faf9083232fac3b
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

rs0 [direct: primary] devesh> show collections
tbl_cib

rs0 [direct: primary] devesh> db.tbl_cib.find().pretty()
[
  {
    _id: ObjectId("655afeb629fd4ec33e1d2d1b"),
    name: 'Devesh',
    age: 44
  },
  {
    _id: ObjectId("655afec129fd4ec33e1d2d1c"),
    name: 'Devesh',
    age: 44
  },
  { _id: ObjectId("655afec129fd4ec33e1d2d1d"), name: 'Madhu', age: 40 },
  {
    _id: ObjectId("655afec829fd4ec33e1d2d1e"),
    name: 'Devesh',
    age: 25
  }
]

rs0 [direct: primary] devesh> quit()
*/

-- Step 63 -->> On Node 2 (Replication Test)
[root@mongodb_1_s ~]# mongo --host 192.168.56.150 --port 27017 -u admin -p P#ssw0rd --authenticationDatabase admin
/*
Current Mongosh Log ID: 65588e4026e207a7cf5ab9e4
Connecting to:          mongodb://<credentials>@127.0.0.1:27017/?directConnection=true&serverSelectionTimeoutMS=2000&authSource=admin&appName=mongosh+2.0.2
Using MongoDB:          7.0.3
Using Mongosh:          2.0.2

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

rs0 [direct: secondary] test> show dbs
admin   188.00 KiB
config  316.00 KiB
devesh    8.00 KiB
local   444.00 KiB

rs0 [direct: secondary] test> use devesh
switched to db devesh

rs0 [direct: secondary] devesh> db.getUsers()
MongoServerError: not primary and secondaryOk=false - consider using db.getMongo().setReadPref() or readPreference in the connection string

rs0 [direct: secondary] devesh> db.getMongo().setReadPref("secondaryPreferred")

rs0 [direct: secondary] devesh> db.getUsers()
{
  users: [
    {
      _id: 'devesh.devesh',
      userId: new UUID("4e89d4d4-4ca7-44f1-84ae-6cbc7aa74527"),
      user: 'devesh',
      db: 'devesh',
      roles: [ { role: 'readWrite', db: 'devesh' } ],
      mechanisms: [ 'SCRAM-SHA-1', 'SCRAM-SHA-256' ]
    }
  ],
  ok: 1,
  '$clusterTime': {
    clusterTime: Timestamp({ t: 1700302466, i: 1 }),
    signature: {
      hash: Binary.createFromBase64("gGtkBmvQ4H+yrZObwDAtuzMiHR8=", 0),
      keyId: Long("7302729826782150663")
    }
  },
  operationTime: Timestamp({ t: 1700302466, i: 1 })
}

rs0 [direct: secondary] devesh> show collections
tbl_cib

rs0 [direct: secondary] devesh> db.getCollectionNames()
[ 'tbl_cib' ]

rs0 [direct: secondary] devesh> db.getCollectionNames()
[ 'tbl_cib' ]

rs0 [direct: secondary] devesh> db.tbl_cib.find().pretty()
[
  {
    _id: ObjectId("655afeb629fd4ec33e1d2d1b"),
    name: 'Devesh',
    age: 44
  },
  {
    _id: ObjectId("655afec129fd4ec33e1d2d1c"),
    name: 'Devesh',
    age: 44
  },
  { _id: ObjectId("655afec129fd4ec33e1d2d1d"), name: 'Madhu', age: 40 },
  {
    _id: ObjectId("655afec829fd4ec33e1d2d1e"),
    name: 'Devesh',
    age: 25
  }
]

rs0 [direct: secondary] devesh> quit()
*/

-- Step 64 -->> On Node 2 (Replication Test)
[root@mongodb_1_s ~]#  mongo  --host 192.168.56.150 --port 27017 -u devesh -p P@ssw0rD --authenticationDatabase devesh
/*
Current Mongosh Log ID: 65589044e4e92305110a5e2f
Connecting to:          mongodb://<credentials>@127.0.0.1:27017/?directConnection=true&serverSelectionTimeoutMS=2000&authSource=devesh&appName=mongosh+2.0.2
Using MongoDB:          7.0.3
Using Mongosh:          2.0.2

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

rs0 [direct: secondary] test> show dbs
devesh  8.00 KiB

rs0 [direct: secondary] test> use devesh
switched to db devesh

rs0 [direct: secondary] devesh> show collections
tbl_cib

rs0 [direct: secondary] devesh> db.getCollectionNames()
MongoServerError: not primary and secondaryOk=false - consider using db.getMongo().setReadPref() or readPreference in the connection string

rs0 [direct: secondary] devesh> db.getMongo().setReadPref("secondaryPreferred")

rs0 [direct: secondary] devesh> db.getCollectionNames()
[ 'tbl_cib' ]

rs0 [direct: secondary] devesh> show collections
tbl_cib

rs0 [direct: secondary] devesh> db.tbl_cib.find().pretty()
[
  {
    _id: ObjectId("655afeb629fd4ec33e1d2d1b"),
    name: 'Devesh',
    age: 44
  },
  {
    _id: ObjectId("655afec129fd4ec33e1d2d1c"),
    name: 'Devesh',
    age: 44
  },
  { _id: ObjectId("655afec129fd4ec33e1d2d1d"), name: 'Madhu', age: 40 },
  {
    _id: ObjectId("655afec829fd4ec33e1d2d1e"),
    name: 'Devesh',
    age: 25
  }
]

rs0 [direct: secondary] devesh> quit()
*/

-- Step 65 -->> On Node 2 (Replication Test)
[root@mongodb_2_s ~]# mongo --host 192.168.56.151 --port 27017 -u admin -p P#ssw0rd --authenticationDatabase admin
/*
Current Mongosh Log ID: 6558900f5482cc69c3799c38
Connecting to:          mongodb://<credentials>@127.0.0.1:27017/?directConnection=true&serverSelectionTimeoutMS=2000&authSource=admin&appName=mongosh+2.0.2
Using MongoDB:          7.0.3
Using Mongosh:          2.0.2

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

rs0 [direct: secondary] test> show dbs
admin   188.00 KiB
config  316.00 KiB
devesh    8.00 KiB
local   452.00 KiB

rs0 [direct: secondary] test> use devesh
switched to db devesh

rs0 [direct: secondary] devesh> db
devesh

rs0 [direct: secondary] devesh> show collections
tbl_cib

rs0 [direct: secondary] devesh> show collections
tbl_cib

rs0 [direct: secondary] devesh> db.getCollectionNames()
MongoServerError: not primary and secondaryOk=false - consider using db.getMongo().setReadPref() or readPreference in the connection string

rs0 [direct: secondary] devesh> db.getMongo().setReadPref("secondaryPreferred")

rs0 [direct: secondary] devesh> db.getCollectionNames()
[ 'tbl_cib' ]
rs0 [direct: secondary] devesh> db.tbl_cib.find().pretty()
[
  {
    _id: ObjectId("655afeb629fd4ec33e1d2d1b"),
    name: 'Devesh',
    age: 44
  },
  {
    _id: ObjectId("655afec129fd4ec33e1d2d1c"),
    name: 'Devesh',
    age: 44
  },
  { _id: ObjectId("655afec129fd4ec33e1d2d1d"), name: 'Madhu', age: 40 },
  {
    _id: ObjectId("655afec829fd4ec33e1d2d1e"),
    name: 'Devesh',
    age: 25
  }
]

rs0 [direct: secondary] devesh> db.dropDatabase()
MongoServerError: not primary

rs0 [direct: secondary] devesh> exit
*/

-- Step 66 -->> On Node 1 (Replication Test)
[root@mongodb_1_p ~]# mongo --host 192.168.56.149  --port 27017 -u admin -p P#ssw0rd --authenticationDatabase admin
/*
Current Mongosh Log ID: 65589287cfed5098887a3228
Connecting to:          mongodb://<credentials>@192.168.56.149:27017/?directConnection=true&authSource=admin&appName=mongosh+2.0.2
Using MongoDB:          7.0.3
Using Mongosh:          2.0.2

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

rs0 [direct: primary] test> show dbs
admin   220.00 KiB
config  252.00 KiB
devesh    8.00 KiB
local   452.00 KiB

rs0 [direct: primary] test> use devesh
switched to db devesh

rs0 [direct: primary] devesh> db.dropDatabase()
{ ok: 1, dropped: 'devesh' }

rs0 [direct: primary] devesh> use admin
switched to db admin

rs0 [direct: primary] admin> show dbs
admin   220.00 KiB
config  252.00 KiB
local   452.00 KiB

rs0 [direct: primary] admin> rs.printSecondaryReplicationInfo()
source: mongodb_1_s:27017
{
  syncedTo: 'Wed Nov 22 2023 13:39:32 GMT+0545 (Nepal Time)',
  replLag: '0 secs (0 hrs) behind the primary '
}
---
source: mongodb_2_s:27017
{
  syncedTo: 'Wed Nov 22 2023 13:39:32 GMT+0545 (Nepal Time)',
  replLag: '0 secs (0 hrs) behind the primary '
}

rs0 [direct: primary] admin> quit()
*/

-- Step 67 -->> On Node 2 (Replication Test)
[root@mongodb_1_s ~]# mongo --host 192.168.56.150 --port 27017 -u admin -p P#ssw0rd --authenticationDatabase admin
/*
Current Mongosh Log ID: 6558930d940bfda4e72e643e
Connecting to:          mongodb://<credentials>@192.168.56.150:27017/?directConnection=true&authSource=admin&appName=mongosh+2.0.2
Using MongoDB:          7.0.3
Using Mongosh:          2.0.2

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

rs0 [direct: secondary] test> show dbs
admin   188.00 KiB
config  316.00 KiB
local   452.00 KiB

rs0 [direct: secondary] admin> rs.printSecondaryReplicationInfo()
source: mongodb_1_s:27017
{
  syncedTo: 'Wed Nov 22 2023 13:40:02 GMT+0545 (Nepal Time)',
  replLag: '0 secs (0 hrs) behind the primary '
}
---
source: mongodb_2_s:27017
{
  syncedTo: 'Wed Nov 22 2023 13:40:02 GMT+0545 (Nepal Time)',
  replLag: '0 secs (0 hrs) behind the primary '
}

rs0 [direct: secondary] test> quit()
*/

-- Step 68 -->> On Node 1 (Replication Test)
[root@mongodb_2_s ~]# mongo --host 192.168.56.151 --port 27017 -u admin -p P#ssw0rd --authenticationDatabase admin
/*
Current Mongosh Log ID: 65589337a119aa4d563374fe
Connecting to:          mongodb://<credentials>@192.168.56.151:27017/?directConnection=true&authSource=admin&appName=mongosh+2.0.2
Using MongoDB:          7.0.3
Using Mongosh:          2.0.2

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

rs0 [direct: secondary] test> show dbs
admin   188.00 KiB
config  316.00 KiB
local   452.00 KiB

rs0 [direct: secondary] admin> rs.printSecondaryReplicationInfo()
source: mongodb_1_s:27017
{
  syncedTo: 'Wed Nov 22 2023 13:40:02 GMT+0545 (Nepal Time)',
  replLag: '0 secs (0 hrs) behind the primary '
}
---
source: mongodb_2_s:27017
{
  syncedTo: 'Wed Nov 22 2023 13:40:02 GMT+0545 (Nepal Time)',
  replLag: '0 secs (0 hrs) behind the primary '
}

rs0 [direct: secondary] test> quit()
*/

-- Step 69 -->> On Node 1 (FailOver Test)
[root@mongodb_1_p ~]# systemctl stop mongod

-- Step 70 -->> On Node 2 (FailOver Test)
[root@mongodb_1_s ~]# mongo --host 192.168.56.150 --port 27017 -u admin -p P#ssw0rd --authenticationDatabase admin
/*
Current Mongosh Log ID: 655b19e096bf304a250e2cbf
Connecting to:          mongodb://<credentials>@192.168.56.150:27017/?directConnection=true&authSource=admin&appName=mongosh+2.0.2
Using MongoDB:          7.0.3
Using Mongosh:          2.0.2

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

rs0 [direct: primary] test> use admin
switched to db admin

rs0 [direct: primary] admin> db.version()
7.0.3

rs0 [direct: primary] admin> db.getUsers()
{
  users: [
    {
      _id: 'admin.admin',
      userId: new UUID("b9228be9-e730-4f47-988f-d98e5152b2d4"),
      user: 'admin',
      db: 'admin',
      roles: [
        { role: 'root', db: 'admin' },
        { role: 'userAdminAnyDatabase', db: 'admin' },
        { role: 'clusterAdmin', db: 'admin' }
      ],
      mechanisms: [ 'SCRAM-SHA-1', 'SCRAM-SHA-256' ]
    }
  ],
  ok: 1,
  '$clusterTime': {
    clusterTime: Timestamp({ t: 1700469238, i: 1 }),
    signature: {
      hash: Binary.createFromBase64("JGlDXtAsXTVHQy23Q7fqN8HZiUI=", 0),
      keyId: Long("7303422038071312391")
    }
  },
  operationTime: Timestamp({ t: 1700469238, i: 1 })
}

rs0 [direct: primary] admin> rs.status()
{
  set: 'rs0',
  date: ISODate("2023-11-20T08:35:09.748Z"),
  myState: 1,
  term: Long("2"),
  syncSourceHost: '',
  syncSourceId: -1,
  heartbeatIntervalMillis: Long("2000"),
  majorityVoteCount: 2,
  writeMajorityCount: 2,
  votingMembersCount: 3,
  writableVotingMembersCount: 3,
  optimes: {
    lastCommittedOpTime: { ts: Timestamp({ t: 1700469308, i: 1 }), t: Long("2") },
    lastCommittedWallTime: ISODate("2023-11-20T08:35:08.652Z"),
    readConcernMajorityOpTime: { ts: Timestamp({ t: 1700469308, i: 1 }), t: Long("2") },
    appliedOpTime: { ts: Timestamp({ t: 1700469308, i: 1 }), t: Long("2") },
    durableOpTime: { ts: Timestamp({ t: 1700469308, i: 1 }), t: Long("2") },
    lastAppliedWallTime: ISODate("2023-11-20T08:35:08.652Z"),
    lastDurableWallTime: ISODate("2023-11-20T08:35:08.652Z")
  },
  lastStableRecoveryTimestamp: Timestamp({ t: 1700469258, i: 1 }),
  electionCandidateMetrics: {
    lastElectionReason: 'stepUpRequestSkipDryRun',
    lastElectionDate: ISODate("2023-11-20T08:32:28.612Z"),
    electionTerm: Long("2"),
    lastCommittedOpTimeAtElection: { ts: Timestamp({ t: 1700469146, i: 1 }), t: Long("1") },
    lastSeenOpTimeAtElection: { ts: Timestamp({ t: 1700469146, i: 1 }), t: Long("1") },
    numVotesNeeded: 2,
    priorityAtElection: 10,
    electionTimeoutMillis: Long("10000"),
    priorPrimaryMemberId: 0,
    numCatchUpOps: Long("0"),
    newTermStartDate: ISODate("2023-11-20T08:32:28.623Z"),
    wMajorityWriteAvailabilityDate: ISODate("2023-11-20T08:32:28.649Z")
  },
  members: [
    {
      _id: 0,
      name: 'mongodb_1_p:27017',
      health: 0,
      state: 8,
      stateStr: '(not reachable/healthy)',
      uptime: 0,
      optime: { ts: Timestamp({ t: 0, i: 0 }), t: Long("-1") },
      optimeDurable: { ts: Timestamp({ t: 0, i: 0 }), t: Long("-1") },
      optimeDate: ISODate("1970-01-01T00:00:00.000Z"),
      optimeDurableDate: ISODate("1970-01-01T00:00:00.000Z"),
      lastAppliedWallTime: ISODate("2023-11-20T08:32:38.630Z"),
      lastDurableWallTime: ISODate("2023-11-20T08:32:38.630Z"),
      lastHeartbeat: ISODate("2023-11-20T08:35:08.873Z"),
      lastHeartbeatRecv: ISODate("2023-11-20T08:32:43.146Z"),
      pingMs: Long("0"),
      lastHeartbeatMessage: 'Error connecting to mongodb_1_p:27017 (192.168.56.149:27017) :: caused by :: onInvoke :: caused by :: Connection refused',
      syncSourceHost: '',
      syncSourceId: -1,
      infoMessage: '',
      configVersion: 7,
      configTerm: 2
    },
    {
      _id: 1,
      name: 'mongodb_1_s:27017',
      health: 1,
      state: 1,
      stateStr: 'PRIMARY',
      uptime: 8973,
      optime: { ts: Timestamp({ t: 1700469308, i: 1 }), t: Long("2") },
      optimeDate: ISODate("2023-11-20T08:35:08.000Z"),
      lastAppliedWallTime: ISODate("2023-11-20T08:35:08.652Z"),
      lastDurableWallTime: ISODate("2023-11-20T08:35:08.652Z"),
      syncSourceHost: '',
      syncSourceId: -1,
      infoMessage: '',
      electionTime: Timestamp({ t: 1700469148, i: 1 }),
      electionDate: ISODate("2023-11-20T08:32:28.000Z"),
      configVersion: 7,
      configTerm: 2,
      self: true,
      lastHeartbeatMessage: ''
    },
    {
      _id: 2,
      name: 'mongodb_2_s:27017',
      health: 1,
      state: 2,
      stateStr: 'SECONDARY',
      uptime: 8798,
      optime: { ts: Timestamp({ t: 1700469308, i: 1 }), t: Long("2") },
      optimeDurable: { ts: Timestamp({ t: 1700469308, i: 1 }), t: Long("2") },
      optimeDate: ISODate("2023-11-20T08:35:08.000Z"),
      optimeDurableDate: ISODate("2023-11-20T08:35:08.000Z"),
      lastAppliedWallTime: ISODate("2023-11-20T08:35:08.652Z"),
      lastDurableWallTime: ISODate("2023-11-20T08:35:08.652Z"),
      lastHeartbeat: ISODate("2023-11-20T08:35:08.831Z"),
      lastHeartbeatRecv: ISODate("2023-11-20T08:35:09.304Z"),
      pingMs: Long("0"),
      lastHeartbeatMessage: '',
      syncSourceHost: 'mongodb_1_s:27017',
      syncSourceId: 1,
      infoMessage: '',
      configVersion: 7,
      configTerm: 2
    }
  ],
  ok: 1,
  '$clusterTime': {
    clusterTime: Timestamp({ t: 1700469308, i: 1 }),
    signature: {
      hash: Binary.createFromBase64("DUEo7Ju3n+vxknBxV652FMHjBEQ=", 0),
      keyId: Long("7303422038071312391")
    }
  },
  operationTime: Timestamp({ t: 1700469308, i: 1 })
}

rs0 [direct: primary] admin> rs.isMaster()
{
  topologyVersion: {
    processId: ObjectId("655af7309e3b27fcc40d926e"),
    counter: Long("11")
  },
  hosts: [ 'mongodb_1_p:27017', 'mongodb_1_s:27017', 'mongodb_2_s:27017' ],
  setName: 'rs0',
  setVersion: 7,
  ismaster: true,
  secondary: false,
  primary: 'mongodb_1_s:27017',
  me: 'mongodb_1_s:27017',
  electionId: ObjectId("7fffffff0000000000000002"),
  lastWrite: {
    opTime: { ts: Timestamp({ t: 1700469258, i: 1 }), t: Long("2") },
    lastWriteDate: ISODate("2023-11-20T08:34:18.000Z"),
    majorityOpTime: { ts: Timestamp({ t: 1700469258, i: 1 }), t: Long("2") },
    majorityWriteDate: ISODate("2023-11-20T08:34:18.000Z")
  },
  maxBsonObjectSize: 16777216,
  maxMessageSizeBytes: 48000000,
  maxWriteBatchSize: 100000,
  localTime: ISODate("2023-11-20T08:34:18.784Z"),
  logicalSessionTimeoutMinutes: 30,
  connectionId: 163,
  minWireVersion: 0,
  maxWireVersion: 21,
  readOnly: false,
  ok: 1,
  '$clusterTime': {
    clusterTime: Timestamp({ t: 1700469258, i: 1 }),
    signature: {
      hash: Binary.createFromBase64("cUEJwffFIisAiMVWQUzJkwFarXs=", 0),
      keyId: Long("7303422038071312391")
    }
  },
  operationTime: Timestamp({ t: 1700469258, i: 1 }),
  isWritablePrimary: true
}

rs0 [direct: primary] admin> rs.conf()
{
  _id: 'rs0',
  version: 7,
  term: 2,
  members: [
    {
      _id: 0,
      host: 'mongodb_1_p:27017',
      arbiterOnly: false,
      buildIndexes: true,
      hidden: false,
      priority: 20,
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
      priority: 10,
      tags: {},
      secondaryDelaySecs: Long("0"),
      votes: 1
    },
    {
      _id: 2,
      host: 'mongodb_2_s:27017',
      arbiterOnly: false,
      buildIndexes: true,
      hidden: false,
      priority: 1,
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
    replicaSetId: ObjectId("655af7a64c8b1dfa072b3da8")
  }
}

rs0 [direct: primary] admin> quit()
*/

-- Step 71 -->> On Node 3 (FailOver Test)
[root@mongodb_2_s ~]# mongo --host 192.168.56.151 --port 27017 -u admin -p P#ssw0rd --authenticationDatabase admin
/*
Current Mongosh Log ID: 655b1ad281f4e1aa0fda1ca8
Connecting to:          mongodb://<credentials>@192.168.56.151:27017/?directConnection=true&authSource=admin&appName=mongosh+2.0.2
Using MongoDB:          7.0.3
Using Mongosh:          2.0.2

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

rs0 [direct: secondary] test> use admin
switched to db admin

rs0 [direct: secondary] admin> db
admin

rs0 [direct: secondary] admin> db.getUsers()
MongoServerError: not primary and secondaryOk=false - consider using db.getMongo().setReadPref() or readPreference in the connection string

rs0 [direct: secondary] admin> db.getMongo().setReadPref("secondary")

rs0 [direct: secondary] admin> db.getUsers()
{
  users: [
    {
      _id: 'admin.admin',
      userId: new UUID("b9228be9-e730-4f47-988f-d98e5152b2d4"),
      user: 'admin',
      db: 'admin',
      roles: [
        { role: 'root', db: 'admin' },
        { role: 'userAdminAnyDatabase', db: 'admin' },
        { role: 'clusterAdmin', db: 'admin' }
      ],
      mechanisms: [ 'SCRAM-SHA-1', 'SCRAM-SHA-256' ]
    }
  ],
  ok: 1,
  '$clusterTime': {
    clusterTime: Timestamp({ t: 1700469488, i: 1 }),
    signature: {
      hash: Binary.createFromBase64("MM8Acwqivvs3+U3ccrNm9YC8lSU=", 0),
      keyId: Long("7303422038071312391")
    }
  },
  operationTime: Timestamp({ t: 1700469488, i: 1 })
}

rs0 [direct: secondary] admin> rs.status()
{
  set: 'rs0',
  date: ISODate("2023-11-20T08:38:19.739Z"),
  myState: 2,
  term: Long("2"),
  syncSourceHost: 'mongodb_1_s:27017',
  syncSourceId: 1,
  heartbeatIntervalMillis: Long("2000"),
  majorityVoteCount: 2,
  writeMajorityCount: 2,
  votingMembersCount: 3,
  writableVotingMembersCount: 3,
  optimes: {
    lastCommittedOpTime: { ts: Timestamp({ t: 1700469498, i: 1 }), t: Long("2") },
    lastCommittedWallTime: ISODate("2023-11-20T08:38:18.693Z"),
    readConcernMajorityOpTime: { ts: Timestamp({ t: 1700469498, i: 1 }), t: Long("2") },
    appliedOpTime: { ts: Timestamp({ t: 1700469498, i: 1 }), t: Long("2") },
    durableOpTime: { ts: Timestamp({ t: 1700469498, i: 1 }), t: Long("2") },
    lastAppliedWallTime: ISODate("2023-11-20T08:38:18.693Z"),
    lastDurableWallTime: ISODate("2023-11-20T08:38:18.693Z")
  },
  lastStableRecoveryTimestamp: Timestamp({ t: 1700469448, i: 1 }),
  electionParticipantMetrics: {
    votedForCandidate: true,
    electionTerm: Long("2"),
    lastVoteDate: ISODate("2023-11-20T08:32:28.613Z"),
    electionCandidateMemberId: 1,
    voteReason: '',
    lastAppliedOpTimeAtElection: { ts: Timestamp({ t: 1700469146, i: 1 }), t: Long("1") },
    maxAppliedOpTimeInSet: { ts: Timestamp({ t: 1700469146, i: 1 }), t: Long("1") },
    priorityAtElection: 1,
    newTermStartDate: ISODate("2023-11-20T08:32:28.623Z"),
    newTermAppliedDate: ISODate("2023-11-20T08:32:28.647Z")
  },
  members: [
    {
      _id: 0,
      name: 'mongodb_1_p:27017',
      health: 0,
      state: 8,
      stateStr: '(not reachable/healthy)',
      uptime: 0,
      optime: { ts: Timestamp({ t: 0, i: 0 }), t: Long("-1") },
      optimeDurable: { ts: Timestamp({ t: 0, i: 0 }), t: Long("-1") },
      optimeDate: ISODate("1970-01-01T00:00:00.000Z"),
      optimeDurableDate: ISODate("1970-01-01T00:00:00.000Z"),
      lastAppliedWallTime: ISODate("2023-11-20T08:32:26.591Z"),
      lastDurableWallTime: ISODate("2023-11-20T08:32:26.591Z"),
      lastHeartbeat: ISODate("2023-11-20T08:38:19.278Z"),
      lastHeartbeatRecv: ISODate("2023-11-20T08:32:43.144Z"),
      pingMs: Long("0"),
      lastHeartbeatMessage: 'Error connecting to mongodb_1_p:27017 (192.168.56.149:27017) :: caused by :: onInvoke :: caused by :: Connection refused',
      syncSourceHost: '',
      syncSourceId: -1,
      infoMessage: '',
      configVersion: 7,
      configTerm: 2
    },
    {
      _id: 1,
      name: 'mongodb_1_s:27017',
      health: 1,
      state: 1,
      stateStr: 'PRIMARY',
      uptime: 8988,
      optime: { ts: Timestamp({ t: 1700469498, i: 1 }), t: Long("2") },
      optimeDurable: { ts: Timestamp({ t: 1700469498, i: 1 }), t: Long("2") },
      optimeDate: ISODate("2023-11-20T08:38:18.000Z"),
      optimeDurableDate: ISODate("2023-11-20T08:38:18.000Z"),
      lastAppliedWallTime: ISODate("2023-11-20T08:38:18.693Z"),
      lastDurableWallTime: ISODate("2023-11-20T08:38:18.693Z"),
      lastHeartbeat: ISODate("2023-11-20T08:38:19.521Z"),
      lastHeartbeatRecv: ISODate("2023-11-20T08:38:19.069Z"),
      pingMs: Long("0"),
      lastHeartbeatMessage: '',
      syncSourceHost: '',
      syncSourceId: -1,
      infoMessage: '',
      electionTime: Timestamp({ t: 1700469148, i: 1 }),
      electionDate: ISODate("2023-11-20T08:32:28.000Z"),
      configVersion: 7,
      configTerm: 2
    },
    {
      _id: 2,
      name: 'mongodb_2_s:27017',
      health: 1,
      state: 2,
      stateStr: 'SECONDARY',
      uptime: 9162,
      optime: { ts: Timestamp({ t: 1700469498, i: 1 }), t: Long("2") },
      optimeDate: ISODate("2023-11-20T08:38:18.000Z"),
      lastAppliedWallTime: ISODate("2023-11-20T08:38:18.693Z"),
      lastDurableWallTime: ISODate("2023-11-20T08:38:18.693Z"),
      syncSourceHost: 'mongodb_1_s:27017',
      syncSourceId: 1,
      infoMessage: '',
      configVersion: 7,
      configTerm: 2,
      self: true,
      lastHeartbeatMessage: ''
    }
  ],
  ok: 1,
  '$clusterTime': {
    clusterTime: Timestamp({ t: 1700469498, i: 1 }),
    signature: {
      hash: Binary.createFromBase64("YE6LpqjRQ8HI0IEcz0+pMYWLLpM=", 0),
      keyId: Long("7303422038071312391")
    }
  },
  operationTime: Timestamp({ t: 1700469498, i: 1 })
}

rs0 [direct: secondary] admin> rs.isMaster()
{
  topologyVersion: {
    processId: ObjectId("655af7312b515db59424141a"),
    counter: Long("7")
  },
  hosts: [ 'mongodb_1_p:27017', 'mongodb_1_s:27017', 'mongodb_2_s:27017' ],
  setName: 'rs0',
  setVersion: 7,
  ismaster: false,
  secondary: true,
  primary: 'mongodb_1_s:27017',
  me: 'mongodb_2_s:27017',
  lastWrite: {
    opTime: { ts: Timestamp({ t: 1700469508, i: 1 }), t: Long("2") },
    lastWriteDate: ISODate("2023-11-20T08:38:28.000Z"),
    majorityOpTime: { ts: Timestamp({ t: 1700469508, i: 1 }), t: Long("2") },
    majorityWriteDate: ISODate("2023-11-20T08:38:28.000Z")
  },
  maxBsonObjectSize: 16777216,
  maxMessageSizeBytes: 48000000,
  maxWriteBatchSize: 100000,
  localTime: ISODate("2023-11-20T08:38:29.125Z"),
  logicalSessionTimeoutMinutes: 30,
  connectionId: 144,
  minWireVersion: 0,
  maxWireVersion: 21,
  readOnly: false,
  ok: 1,
  '$clusterTime': {
    clusterTime: Timestamp({ t: 1700469508, i: 1 }),
    signature: {
      hash: Binary.createFromBase64("6i3E1PbBSAwR1mbSQIwkkXXpTTI=", 0),
      keyId: Long("7303422038071312391")
    }
  },
  operationTime: Timestamp({ t: 1700469508, i: 1 }),
  isWritablePrimary: false
}

rs0 [direct: secondary] admin> rs.conf()
{
  _id: 'rs0',
  version: 7,
  term: 2,
  members: [
    {
      _id: 0,
      host: 'mongodb_1_p:27017',
      arbiterOnly: false,
      buildIndexes: true,
      hidden: false,
      priority: 20,
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
      priority: 10,
      tags: {},
      secondaryDelaySecs: Long("0"),
      votes: 1
    },
    {
      _id: 2,
      host: 'mongodb_2_s:27017',
      arbiterOnly: false,
      buildIndexes: true,
      hidden: false,
      priority: 1,
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
    replicaSetId: ObjectId("655af7a64c8b1dfa072b3da8")
  }
}

rs0 [direct: secondary] admin> quit()
*/

-- Step 72 -->> On Node 1 (FailOver Test)
[root@mongodb_1_p ~]# systemctl start mongod

-- Step 73 -->> On Node 1 (FailOver Test)
[root@mongodb_1_p ~]# systemctl status mongod
/*
● mongod.service - MongoDB Database Server
   Loaded: loaded (/usr/lib/systemd/system/mongod.service; enabled; vendor preset: disabled)
   Active: active (running) since Mon 2023-11-20 14:25:12 +0545; 5s ago
     Docs: https://docs.mongodb.org/manual
 Main PID: 15253 (mongod)
   Memory: 186.5M
   CGroup: /system.slice/mongod.service
           └─15253 /usr/bin/mongod -f /etc/mongod.conf

Nov 20 14:25:12 mongodb_1_p.unidev39.org.np systemd[1]: Started MongoDB Database Server.
Nov 20 14:25:12 mongodb_1_p.unidev39.org.np mongod[15253]: {"t":{"$date":"2023-11-20T08:40:12.898Z"},"s":"I",  "c":"CONTROL",  "id":7484500, "ctx":"main","msg":"Environment variable MONGOD>
*/

-- Step 74 -->> On Node 1 (FailOver Test)
[root@mongodb_1_p ~]# mongo --host 192.168.56.149 --port 27017 -u admin -p P#ssw0rd --authenticationDatabase admin
/*
Current Mongosh Log ID: 655b1bb525748f532d736203
Connecting to:          mongodb://<credentials>@192.168.56.149:27017/?directConnection=true&authSource=admin&appName=mongosh+2.0.2
Using MongoDB:          7.0.3
Using Mongosh:          2.0.2

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

rs0 [direct: primary] test> use admin
switched to db admin

rs0 [direct: primary] admin> db
admin

rs0 [direct: primary] admin> db.getUsers()
{
  users: [
    {
      _id: 'admin.admin',
      userId: new UUID("b9228be9-e730-4f47-988f-d98e5152b2d4"),
      user: 'admin',
      db: 'admin',
      roles: [
        { role: 'root', db: 'admin' },
        { role: 'userAdminAnyDatabase', db: 'admin' },
        { role: 'clusterAdmin', db: 'admin' }
      ],
      mechanisms: [ 'SCRAM-SHA-1', 'SCRAM-SHA-256' ]
    }
  ],
  ok: 1,
  '$clusterTime': {
    clusterTime: Timestamp({ t: 1700469694, i: 1 }),
    signature: {
      hash: Binary.createFromBase64("Hop49ftWN81HXCi0/ICjavvStZY=", 0),
      keyId: Long("7303422038071312391")
    }
  },
  operationTime: Timestamp({ t: 1700469694, i: 1 })
}

rs0 [direct: primary] admin> rs.status()
{
  set: 'rs0',
  date: ISODate("2023-11-20T08:41:45.695Z"),
  myState: 1,
  term: Long("3"),
  syncSourceHost: '',
  syncSourceId: -1,
  heartbeatIntervalMillis: Long("2000"),
  majorityVoteCount: 2,
  writeMajorityCount: 2,
  votingMembersCount: 3,
  writableVotingMembersCount: 3,
  optimes: {
    lastCommittedOpTime: { ts: Timestamp({ t: 1700469704, i: 1 }), t: Long("3") },
    lastCommittedWallTime: ISODate("2023-11-20T08:41:44.393Z"),
    readConcernMajorityOpTime: { ts: Timestamp({ t: 1700469704, i: 1 }), t: Long("3") },
    appliedOpTime: { ts: Timestamp({ t: 1700469704, i: 1 }), t: Long("3") },
    durableOpTime: { ts: Timestamp({ t: 1700469704, i: 1 }), t: Long("3") },
    lastAppliedWallTime: ISODate("2023-11-20T08:41:44.393Z"),
    lastDurableWallTime: ISODate("2023-11-20T08:41:44.393Z")
  },
  lastStableRecoveryTimestamp: Timestamp({ t: 1700469664, i: 1 }),
  electionCandidateMetrics: {
    lastElectionReason: 'priorityTakeover',
    lastElectionDate: ISODate("2023-11-20T08:40:24.357Z"),
    electionTerm: Long("3"),
    lastCommittedOpTimeAtElection: { ts: Timestamp({ t: 1700469618, i: 1 }), t: Long("2") },
    lastSeenOpTimeAtElection: { ts: Timestamp({ t: 1700469618, i: 1 }), t: Long("2") },
    numVotesNeeded: 2,
    priorityAtElection: 20,
    electionTimeoutMillis: Long("10000"),
    priorPrimaryMemberId: 1,
    numCatchUpOps: Long("0"),
    newTermStartDate: ISODate("2023-11-20T08:40:24.372Z"),
    wMajorityWriteAvailabilityDate: ISODate("2023-11-20T08:40:24.404Z")
  },
  members: [
    {
      _id: 0,
      name: 'mongodb_1_p:27017',
      health: 1,
      state: 1,
      stateStr: 'PRIMARY',
      uptime: 93,
      optime: { ts: Timestamp({ t: 1700469704, i: 1 }), t: Long("3") },
      optimeDate: ISODate("2023-11-20T08:41:44.000Z"),
      lastAppliedWallTime: ISODate("2023-11-20T08:41:44.393Z"),
      lastDurableWallTime: ISODate("2023-11-20T08:41:44.393Z"),
      syncSourceHost: '',
      syncSourceId: -1,
      infoMessage: '',
      electionTime: Timestamp({ t: 1700469624, i: 1 }),
      electionDate: ISODate("2023-11-20T08:40:24.000Z"),
      configVersion: 7,
      configTerm: 3,
      self: true,
      lastHeartbeatMessage: ''
    },
    {
      _id: 1,
      name: 'mongodb_1_s:27017',
      health: 1,
      state: 2,
      stateStr: 'SECONDARY',
      uptime: 91,
      optime: { ts: Timestamp({ t: 1700469704, i: 1 }), t: Long("3") },
      optimeDurable: { ts: Timestamp({ t: 1700469704, i: 1 }), t: Long("3") },
      optimeDate: ISODate("2023-11-20T08:41:44.000Z"),
      optimeDurableDate: ISODate("2023-11-20T08:41:44.000Z"),
      lastAppliedWallTime: ISODate("2023-11-20T08:41:44.393Z"),
      lastDurableWallTime: ISODate("2023-11-20T08:41:44.393Z"),
      lastHeartbeat: ISODate("2023-11-20T08:41:44.462Z"),
      lastHeartbeatRecv: ISODate("2023-11-20T08:41:44.973Z"),
      pingMs: Long("0"),
      lastHeartbeatMessage: '',
      syncSourceHost: 'mongodb_1_p:27017',
      syncSourceId: 0,
      infoMessage: '',
      configVersion: 7,
      configTerm: 3
    },
    {
      _id: 2,
      name: 'mongodb_2_s:27017',
      health: 1,
      state: 2,
      stateStr: 'SECONDARY',
      uptime: 91,
      optime: { ts: Timestamp({ t: 1700469704, i: 1 }), t: Long("3") },
      optimeDurable: { ts: Timestamp({ t: 1700469704, i: 1 }), t: Long("3") },
      optimeDate: ISODate("2023-11-20T08:41:44.000Z"),
      optimeDurableDate: ISODate("2023-11-20T08:41:44.000Z"),
      lastAppliedWallTime: ISODate("2023-11-20T08:41:44.393Z"),
      lastDurableWallTime: ISODate("2023-11-20T08:41:44.393Z"),
      lastHeartbeat: ISODate("2023-11-20T08:41:44.462Z"),
      lastHeartbeatRecv: ISODate("2023-11-20T08:41:44.461Z"),
      pingMs: Long("0"),
      lastHeartbeatMessage: '',
      syncSourceHost: 'mongodb_1_s:27017',
      syncSourceId: 1,
      infoMessage: '',
      configVersion: 7,
      configTerm: 3
    }
  ],
  ok: 1,
  '$clusterTime': {
    clusterTime: Timestamp({ t: 1700469704, i: 1 }),
    signature: {
      hash: Binary.createFromBase64("PBEJOlHc3cd86eim9PhhkCAGm+k=", 0),
      keyId: Long("7303422038071312391")
    }
  },
  operationTime: Timestamp({ t: 1700469704, i: 1 })
}

rs0 [direct: primary] admin> rs.isMaster()
{
  topologyVersion: {
    processId: ObjectId("655b1b6c4e17d4184ecd2911"),
    counter: Long("6")
  },
  hosts: [ 'mongodb_1_p:27017', 'mongodb_1_s:27017', 'mongodb_2_s:27017' ],
  setName: 'rs0',
  setVersion: 7,
  ismaster: true,
  secondary: false,
  primary: 'mongodb_1_p:27017',
  me: 'mongodb_1_p:27017',
  electionId: ObjectId("7fffffff0000000000000003"),
  lastWrite: {
    opTime: { ts: Timestamp({ t: 1700469704, i: 1 }), t: Long("3") },
    lastWriteDate: ISODate("2023-11-20T08:41:44.000Z"),
    majorityOpTime: { ts: Timestamp({ t: 1700469704, i: 1 }), t: Long("3") },
    majorityWriteDate: ISODate("2023-11-20T08:41:44.000Z")
  },
  maxBsonObjectSize: 16777216,
  maxMessageSizeBytes: 48000000,
  maxWriteBatchSize: 100000,
  localTime: ISODate("2023-11-20T08:41:54.211Z"),
  logicalSessionTimeoutMinutes: 30,
  connectionId: 44,
  minWireVersion: 0,
  maxWireVersion: 21,
  readOnly: false,
  ok: 1,
  '$clusterTime': {
    clusterTime: Timestamp({ t: 1700469704, i: 1 }),
    signature: {
      hash: Binary.createFromBase64("PBEJOlHc3cd86eim9PhhkCAGm+k=", 0),
      keyId: Long("7303422038071312391")
    }
  },
  operationTime: Timestamp({ t: 1700469704, i: 1 }),
  isWritablePrimary: true
}

rs0 [direct: primary] admin> rs.conf()
{
  _id: 'rs0',
  version: 7,
  term: 3,
  members: [
    {
      _id: 0,
      host: 'mongodb_1_p:27017',
      arbiterOnly: false,
      buildIndexes: true,
      hidden: false,
      priority: 20,
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
      priority: 10,
      tags: {},
      secondaryDelaySecs: Long("0"),
      votes: 1
    },
    {
      _id: 2,
      host: 'mongodb_2_s:27017',
      arbiterOnly: false,
      buildIndexes: true,
      hidden: false,
      priority: 1,
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
    replicaSetId: ObjectId("655af7a64c8b1dfa072b3da8")
  }
}

rs0 [direct: primary] admin> quit()
*/

-- Step 75 -->> On Node 2 (FailOver Test)
[root@mongodb_1_s ~]# mongo --host 192.168.56.150 --port 27017 -u admin -p P#ssw0rd --authenticationDatabase admin
/*
Current Mongosh Log ID: 655b1c5fdbe1c583bffbb055
Connecting to:          mongodb://<credentials>@192.168.56.150:27017/?directConnection=true&authSource=admin&appName=mongosh+2.0.2
Using MongoDB:          7.0.3
Using Mongosh:          2.0.2

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

rs0 [direct: secondary] test> use admin
switched to db admin

rs0 [direct: secondary] admin> db
admin

rs0 [direct: secondary] admin> db.getUsers()
MongoServerError: not primary and secondaryOk=false - consider using db.getMongo().setReadPref() or readPreference in the connection string

rs0 [direct: secondary] admin> db.getMongo().setReadPref("secondary")

rs0 [direct: secondary] admin> db.getUsers()
{
  users: [
    {
      _id: 'admin.admin',
      userId: new UUID("b9228be9-e730-4f47-988f-d98e5152b2d4"),
      user: 'admin',
      db: 'admin',
      roles: [
        { role: 'root', db: 'admin' },
        { role: 'userAdminAnyDatabase', db: 'admin' },
        { role: 'clusterAdmin', db: 'admin' }
      ],
      mechanisms: [ 'SCRAM-SHA-1', 'SCRAM-SHA-256' ]
    }
  ],
  ok: 1,
  '$clusterTime': {
    clusterTime: Timestamp({ t: 1700469884, i: 1 }),
    signature: {
      hash: Binary.createFromBase64("4GIta5fv1J3BE8YrpRxb7qjsk9E=", 0),
      keyId: Long("7303422038071312391")
    }
  },
  operationTime: Timestamp({ t: 1700469884, i: 1 })
}

rs0 [direct: secondary] admin> rs.status()
{
  set: 'rs0',
  date: ISODate("2023-11-20T08:44:59.181Z"),
  myState: 2,
  term: Long("3"),
  syncSourceHost: 'mongodb_1_p:27017',
  syncSourceId: 0,
  heartbeatIntervalMillis: Long("2000"),
  majorityVoteCount: 2,
  writeMajorityCount: 2,
  votingMembersCount: 3,
  writableVotingMembersCount: 3,
  optimes: {
    lastCommittedOpTime: { ts: Timestamp({ t: 1700469894, i: 1 }), t: Long("3") },
    lastCommittedWallTime: ISODate("2023-11-20T08:44:54.433Z"),
    readConcernMajorityOpTime: { ts: Timestamp({ t: 1700469894, i: 1 }), t: Long("3") },
    appliedOpTime: { ts: Timestamp({ t: 1700469894, i: 1 }), t: Long("3") },
    durableOpTime: { ts: Timestamp({ t: 1700469894, i: 1 }), t: Long("3") },
    lastAppliedWallTime: ISODate("2023-11-20T08:44:54.433Z"),
    lastDurableWallTime: ISODate("2023-11-20T08:44:54.433Z")
  },
  lastStableRecoveryTimestamp: Timestamp({ t: 1700469864, i: 1 }),
  electionParticipantMetrics: {
    votedForCandidate: true,
    electionTerm: Long("3"),
    lastVoteDate: ISODate("2023-11-20T08:40:24.364Z"),
    electionCandidateMemberId: 0,
    voteReason: '',
    lastAppliedOpTimeAtElection: { ts: Timestamp({ t: 1700469618, i: 1 }), t: Long("2") },
    maxAppliedOpTimeInSet: { ts: Timestamp({ t: 1700469618, i: 1 }), t: Long("2") },
    priorityAtElection: 10,
    newTermStartDate: ISODate("2023-11-20T08:40:24.372Z"),
    newTermAppliedDate: ISODate("2023-11-20T08:40:24.403Z")
  },
  members: [
    {
      _id: 0,
      name: 'mongodb_1_p:27017',
      health: 1,
      state: 1,
      stateStr: 'PRIMARY',
      uptime: 283,
      optime: { ts: Timestamp({ t: 1700469894, i: 1 }), t: Long("3") },
      optimeDurable: { ts: Timestamp({ t: 1700469894, i: 1 }), t: Long("3") },
      optimeDate: ISODate("2023-11-20T08:44:54.000Z"),
      optimeDurableDate: ISODate("2023-11-20T08:44:54.000Z"),
      lastAppliedWallTime: ISODate("2023-11-20T08:44:54.433Z"),
      lastDurableWallTime: ISODate("2023-11-20T08:44:54.433Z"),
      lastHeartbeat: ISODate("2023-11-20T08:44:58.722Z"),
      lastHeartbeatRecv: ISODate("2023-11-20T08:44:58.721Z"),
      pingMs: Long("0"),
      lastHeartbeatMessage: '',
      syncSourceHost: '',
      syncSourceId: -1,
      infoMessage: '',
      electionTime: Timestamp({ t: 1700469624, i: 1 }),
      electionDate: ISODate("2023-11-20T08:40:24.000Z"),
      configVersion: 7,
      configTerm: 3
    },
    {
      _id: 1,
      name: 'mongodb_1_s:27017',
      health: 1,
      state: 2,
      stateStr: 'SECONDARY',
      uptime: 9563,
      optime: { ts: Timestamp({ t: 1700469894, i: 1 }), t: Long("3") },
      optimeDate: ISODate("2023-11-20T08:44:54.000Z"),
      lastAppliedWallTime: ISODate("2023-11-20T08:44:54.433Z"),
      lastDurableWallTime: ISODate("2023-11-20T08:44:54.433Z"),
      syncSourceHost: 'mongodb_1_p:27017',
      syncSourceId: 0,
      infoMessage: '',
      configVersion: 7,
      configTerm: 3,
      self: true,
      lastHeartbeatMessage: ''
    },
    {
      _id: 2,
      name: 'mongodb_2_s:27017',
      health: 1,
      state: 2,
      stateStr: 'SECONDARY',
      uptime: 9387,
      optime: { ts: Timestamp({ t: 1700469894, i: 1 }), t: Long("3") },
      optimeDurable: { ts: Timestamp({ t: 1700469894, i: 1 }), t: Long("3") },
      optimeDate: ISODate("2023-11-20T08:44:54.000Z"),
      optimeDurableDate: ISODate("2023-11-20T08:44:54.000Z"),
      lastAppliedWallTime: ISODate("2023-11-20T08:44:54.433Z"),
      lastDurableWallTime: ISODate("2023-11-20T08:44:54.433Z"),
      lastHeartbeat: ISODate("2023-11-20T08:44:58.723Z"),
      lastHeartbeatRecv: ISODate("2023-11-20T08:44:58.722Z"),
      pingMs: Long("0"),
      lastHeartbeatMessage: '',
      syncSourceHost: 'mongodb_1_s:27017',
      syncSourceId: 1,
      infoMessage: '',
      configVersion: 7,
      configTerm: 3
    }
  ],
  ok: 1,
  '$clusterTime': {
    clusterTime: Timestamp({ t: 1700469894, i: 1 }),
    signature: {
      hash: Binary.createFromBase64("/AgXsxI7GaLGbCTWVX6E7Du0bEI=", 0),
      keyId: Long("7303422038071312391")
    }
  },
  operationTime: Timestamp({ t: 1700469894, i: 1 })
}

rs0 [direct: secondary] admin> rs.isMaster()
{
  topologyVersion: {
    processId: ObjectId("655af7309e3b27fcc40d926e"),
    counter: Long("13")
  },
  hosts: [ 'mongodb_1_p:27017', 'mongodb_1_s:27017', 'mongodb_2_s:27017' ],
  setName: 'rs0',
  setVersion: 7,
  ismaster: false,
  secondary: true,
  primary: 'mongodb_1_p:27017',
  me: 'mongodb_1_s:27017',
  lastWrite: {
    opTime: { ts: Timestamp({ t: 1700469904, i: 1 }), t: Long("3") },
    lastWriteDate: ISODate("2023-11-20T08:45:04.000Z"),
    majorityOpTime: { ts: Timestamp({ t: 1700469904, i: 1 }), t: Long("3") },
    majorityWriteDate: ISODate("2023-11-20T08:45:04.000Z")
  },
  maxBsonObjectSize: 16777216,
  maxMessageSizeBytes: 48000000,
  maxWriteBatchSize: 100000,
  localTime: ISODate("2023-11-20T08:45:07.145Z"),
  logicalSessionTimeoutMinutes: 30,
  connectionId: 201,
  minWireVersion: 0,
  maxWireVersion: 21,
  readOnly: false,
  ok: 1,
  '$clusterTime': {
    clusterTime: Timestamp({ t: 1700469904, i: 1 }),
    signature: {
      hash: Binary.createFromBase64("OyaVamAHaIpklP69IJFkxw4NtRs=", 0),
      keyId: Long("7303422038071312391")
    }
  },
  operationTime: Timestamp({ t: 1700469904, i: 1 }),
  isWritablePrimary: false
}

rs0 [direct: secondary] admin> rs.conf()
{
  _id: 'rs0',
  version: 7,
  term: 3,
  members: [
    {
      _id: 0,
      host: 'mongodb_1_p:27017',
      arbiterOnly: false,
      buildIndexes: true,
      hidden: false,
      priority: 20,
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
      priority: 10,
      tags: {},
      secondaryDelaySecs: Long("0"),
      votes: 1
    },
    {
      _id: 2,
      host: 'mongodb_2_s:27017',
      arbiterOnly: false,
      buildIndexes: true,
      hidden: false,
      priority: 1,
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
    replicaSetId: ObjectId("655af7a64c8b1dfa072b3da8")
  }
}

rs0 [direct: secondary] admin> quit()
*/

-- Step 76 -->> On Node 3 (FailOver Test)
[root@mongodb_2_s ~]# mongo --host 192.168.56.151 --port 27017 -u admin -p P#ssw0rd --authenticationDatabase admin
/*
Current Mongosh Log ID: 655b1cef84ebdf08a9953818
Connecting to:          mongodb://<credentials>@192.168.56.151:27017/?directConnection=true&authSource=admin&appName=mongosh+2.0.2
Using MongoDB:          7.0.3
Using Mongosh:          2.0.2

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

rs0 [direct: secondary] test> use admin
switched to db admin

rs0 [direct: secondary] admin> db
admin

rs0 [direct: secondary] admin> rs.status()
{
  set: 'rs0',
  date: ISODate("2023-11-20T08:46:54.503Z"),
  myState: 2,
  term: Long("3"),
  syncSourceHost: 'mongodb_1_s:27017',
  syncSourceId: 1,
  heartbeatIntervalMillis: Long("2000"),
  majorityVoteCount: 2,
  writeMajorityCount: 2,
  votingMembersCount: 3,
  writableVotingMembersCount: 3,
  optimes: {
    lastCommittedOpTime: { ts: Timestamp({ t: 1700470014, i: 1 }), t: Long("3") },
    lastCommittedWallTime: ISODate("2023-11-20T08:46:54.454Z"),
    readConcernMajorityOpTime: { ts: Timestamp({ t: 1700470014, i: 1 }), t: Long("3") },
    appliedOpTime: { ts: Timestamp({ t: 1700470014, i: 1 }), t: Long("3") },
    durableOpTime: { ts: Timestamp({ t: 1700470014, i: 1 }), t: Long("3") },
    lastAppliedWallTime: ISODate("2023-11-20T08:46:54.454Z"),
    lastDurableWallTime: ISODate("2023-11-20T08:46:54.454Z")
  },
  lastStableRecoveryTimestamp: Timestamp({ t: 1700469984, i: 1 }),
  electionParticipantMetrics: {
    votedForCandidate: true,
    electionTerm: Long("3"),
    lastVoteDate: ISODate("2023-11-20T08:40:24.359Z"),
    electionCandidateMemberId: 0,
    voteReason: '',
    lastAppliedOpTimeAtElection: { ts: Timestamp({ t: 1700469618, i: 1 }), t: Long("2") },
    maxAppliedOpTimeInSet: { ts: Timestamp({ t: 1700469618, i: 1 }), t: Long("2") },
    priorityAtElection: 1,
    newTermStartDate: ISODate("2023-11-20T08:40:24.372Z"),
    newTermAppliedDate: ISODate("2023-11-20T08:40:24.403Z")
  },
  members: [
    {
      _id: 0,
      name: 'mongodb_1_p:27017',
      health: 1,
      state: 1,
      stateStr: 'PRIMARY',
      uptime: 399,
      optime: { ts: Timestamp({ t: 1700470004, i: 1 }), t: Long("3") },
      optimeDurable: { ts: Timestamp({ t: 1700470004, i: 1 }), t: Long("3") },
      optimeDate: ISODate("2023-11-20T08:46:44.000Z"),
      optimeDurableDate: ISODate("2023-11-20T08:46:44.000Z"),
      lastAppliedWallTime: ISODate("2023-11-20T08:46:44.452Z"),
      lastDurableWallTime: ISODate("2023-11-20T08:46:44.452Z"),
      lastHeartbeat: ISODate("2023-11-20T08:46:52.872Z"),
      lastHeartbeatRecv: ISODate("2023-11-20T08:46:52.871Z"),
      pingMs: Long("0"),
      lastHeartbeatMessage: '',
      syncSourceHost: '',
      syncSourceId: -1,
      infoMessage: '',
      electionTime: Timestamp({ t: 1700469624, i: 1 }),
      electionDate: ISODate("2023-11-20T08:40:24.000Z"),
      configVersion: 7,
      configTerm: 3
    },
    {
      _id: 1,
      name: 'mongodb_1_s:27017',
      health: 1,
      state: 2,
      stateStr: 'SECONDARY',
      uptime: 9502,
      optime: { ts: Timestamp({ t: 1700470004, i: 1 }), t: Long("3") },
      optimeDurable: { ts: Timestamp({ t: 1700470004, i: 1 }), t: Long("3") },
      optimeDate: ISODate("2023-11-20T08:46:44.000Z"),
      optimeDurableDate: ISODate("2023-11-20T08:46:44.000Z"),
      lastAppliedWallTime: ISODate("2023-11-20T08:46:44.452Z"),
      lastDurableWallTime: ISODate("2023-11-20T08:46:44.452Z"),
      lastHeartbeat: ISODate("2023-11-20T08:46:52.872Z"),
      lastHeartbeatRecv: ISODate("2023-11-20T08:46:53.372Z"),
      pingMs: Long("0"),
      lastHeartbeatMessage: '',
      syncSourceHost: 'mongodb_1_p:27017',
      syncSourceId: 0,
      infoMessage: '',
      configVersion: 7,
      configTerm: 3
    },
    {
      _id: 2,
      name: 'mongodb_2_s:27017',
      health: 1,
      state: 2,
      stateStr: 'SECONDARY',
      uptime: 9677,
      optime: { ts: Timestamp({ t: 1700470014, i: 1 }), t: Long("3") },
      optimeDate: ISODate("2023-11-20T08:46:54.000Z"),
      lastAppliedWallTime: ISODate("2023-11-20T08:46:54.454Z"),
      lastDurableWallTime: ISODate("2023-11-20T08:46:54.454Z"),
      syncSourceHost: 'mongodb_1_s:27017',
      syncSourceId: 1,
      infoMessage: '',
      configVersion: 7,
      configTerm: 3,
      self: true,
      lastHeartbeatMessage: ''
    }
  ],
  ok: 1,
  '$clusterTime': {
    clusterTime: Timestamp({ t: 1700470014, i: 1 }),
    signature: {
      hash: Binary.createFromBase64("1bX1y2tle4aYOuDVm7a/v3JbhYU=", 0),
      keyId: Long("7303422038071312391")
    }
  },
  operationTime: Timestamp({ t: 1700470014, i: 1 })
}

rs0 [direct: secondary] admin> rs.isMaster()
{
  topologyVersion: {
    processId: ObjectId("655af7312b515db59424141a"),
    counter: Long("8")
  },
  hosts: [ 'mongodb_1_p:27017', 'mongodb_1_s:27017', 'mongodb_2_s:27017' ],
  setName: 'rs0',
  setVersion: 7,
  ismaster: false,
  secondary: true,
  primary: 'mongodb_1_p:27017',
  me: 'mongodb_2_s:27017',
  lastWrite: {
    opTime: { ts: Timestamp({ t: 1700470014, i: 1 }), t: Long("3") },
    lastWriteDate: ISODate("2023-11-20T08:46:54.000Z"),
    majorityOpTime: { ts: Timestamp({ t: 1700470014, i: 1 }), t: Long("3") },
    majorityWriteDate: ISODate("2023-11-20T08:46:54.000Z")
  },
  maxBsonObjectSize: 16777216,
  maxMessageSizeBytes: 48000000,
  maxWriteBatchSize: 100000,
  localTime: ISODate("2023-11-20T08:47:00.493Z"),
  logicalSessionTimeoutMinutes: 30,
  connectionId: 166,
  minWireVersion: 0,
  maxWireVersion: 21,
  readOnly: false,
  ok: 1,
  '$clusterTime': {
    clusterTime: Timestamp({ t: 1700470014, i: 1 }),
    signature: {
      hash: Binary.createFromBase64("1bX1y2tle4aYOuDVm7a/v3JbhYU=", 0),
      keyId: Long("7303422038071312391")
    }
  },
  operationTime: Timestamp({ t: 1700470014, i: 1 }),
  isWritablePrimary: false
}

rs0 [direct: secondary] admin> rs.conf()
{
  _id: 'rs0',
  version: 7,
  term: 3,
  members: [
    {
      _id: 0,
      host: 'mongodb_1_p:27017',
      arbiterOnly: false,
      buildIndexes: true,
      hidden: false,
      priority: 20,
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
      priority: 10,
      tags: {},
      secondaryDelaySecs: Long("0"),
      votes: 1
    },
    {
      _id: 2,
      host: 'mongodb_2_s:27017',
      arbiterOnly: false,
      buildIndexes: true,
      hidden: false,
      priority: 1,
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
    replicaSetId: ObjectId("655af7a64c8b1dfa072b3da8")
  }
}

rs0 [direct: secondary] admin> quit()
*/
