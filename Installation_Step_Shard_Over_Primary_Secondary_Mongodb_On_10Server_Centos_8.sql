--------------------------------------------------------------------------
----------------------------root/P@ssw0rd---------------------------------
--------------------------------------------------------------------------
-- 1 All Nodes
[root@mongodb-<<nodes>>-1-2-3-4-5-6-7-8-9-10 ~]# df -Th
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
[root@mongodb-<<nodes>>-1-2-3-4-5-6-7-8-9-10 ~]# cat /etc/os-release
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
[root@mongodb-<<nodes>>-1-2-3-4-5-6-7-8-9-10 ~]# vi /etc/hosts
/*
127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
::1         localhost localhost.localdomain localhost6 localhost6.localdomain6

# Public
#Mongo Query Router (The mongos, used to connect to the sharded cluster)
192.168.6.21 mongodb-mongos.unidev39.org.np mongodb-mongos


#Configuration Server Primary : (Member of the config server replica set)
192.168.6.22 mongodb-config-01.unidev39.org.np mongodb-config-01

#Configuration Server Secondary : (Member of the config server replica set)
192.168.6.23 mongodb-config-02.unidev39.org.np mongodb-config-02

#Configuration Server Secondary : (Member of the config server replica set)
192.168.6.24 mongodb-config-03.unidev39.org.np mongodb-config-03


#Shard – 01 : Primary Node : (Member of the initial data-bearing shard)
192.168.6.25 mongodb-shard-01.unidev39.org.np mongodb-shard-01

#Shard – 01 : Secondary Node : (Member of the initial data-bearing shard)
192.168.6.26 mongodb-shard-02.unidev39.org.np mongodb-shard-02

#Shard – 01 : Secondary Node : (Member of the initial data-bearing shard)
192.168.6.27 mongodb-shard-03.unidev39.org.np mongodb-shard-03


#Shard – 02 : Primary Node : (Member of the initial data-bearing shard)
192.168.6.28 mongodb-shard-04.unidev39.org.np mongodb-shard-04

#Shard – 02 : Secondary Node : (Member of the initial data-bearing shard)
192.168.6.29 mongodb-shard-05.unidev39.org.np mongodb-shard-05

#Shard – 02 : Secondary Node : (Member of the initial data-bearing shard)
192.168.6.30 mongodb-shard-06.unidev39.org.np mongodb-shard-06
*/

-- Step 2 -->> On All Nodes
-- Disable secure linux by editing the "/etc/selinux/config" file, making sure the SELINUX flag is set as follows.
[root@mongodb-<<nodes>>-1-2-3-4-5-6-7-8-9-10 ~]# vi /etc/selinux/config
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
[root@mongodb-config-01 ~]# vi /etc/sysconfig/network
/*
NETWORKING=yes
HOSTNAME=mongodb-config-01.unidev39.org.np
*/

-- Step 3.1 -->> On Node 2
[root@mongodb-config-02 ~]# vi /etc/sysconfig/network
/*
# Created by anaconda
NETWORKING=yes
HOSTNAME=mongodb-config-02.unidev39.org.np
*/

-- Step 3.2 -->> On Node 3
[root@mongodb-config-03 ~]# vi /etc/sysconfig/network
/*
# Created by anaconda
NETWORKING=yes
HOSTNAME=mongodb-config-03.unidev39.org.np
*/

-- Step 3.3 -->> On Node 4
[root@mongodb-mongos ~]# vi /etc/sysconfig/network
/*
NETWORKING=yes
HOSTNAME=mongodb-mongos.unidev39.org.np
*/

-- Step 3.4 -->> On Node 5
[root@mongodb-shard-01 ~]# vi /etc/sysconfig/network
/*
# Created by anaconda
NETWORKING=yes
HOSTNAME=mongodb-shard-01.unidev39.org.np
*/

-- Step 3.5 -->> On Node 6
[root@mongodb-shard-02 ~]# vi /etc/sysconfig/network
/*
# Created by anaconda
NETWORKING=yes
HOSTNAME=mongodb-shard-02.unidev39.org.np
*/

-- Step 3.6 -->> On Node 7
[root@mongodb-shard-03 ~]# vi /etc/sysconfig/network
/*
# Created by anaconda
NETWORKING=yes
HOSTNAME=mongodb-shard-03.unidev39.org.np
*/

-- Step 3.7 -->> On Node 8
[root@mongodb-shard-04 ~]# vi /etc/sysconfig/network
/*
# Created by anaconda
NETWORKING=yes
HOSTNAME=mongodb-shard-04.unidev39.org.np
*/

-- Step 3.8 -->> On Node 9
[root@mongodb-shard-05 ~]# vi /etc/sysconfig/network
/*
# Created by anaconda
NETWORKING=yes
HOSTNAME=mongodb-shard-05.unidev39.org.np
*/

-- Step 3.9 -->> On Node 10
[root@mongodb-shard-06 ~]# vi /etc/sysconfig/network
/*
# Created by anaconda
NETWORKING=yes
HOSTNAME=mongodb-shard-06.unidev39.org.np
*/

-- Step 4 -->> On Node 1
[root@mongodb-config-01 ~]# nmtui
--OR--
-- Step 4 -->> On Node 1
[root@mongodb-config-01 ~]# vi /etc/sysconfig/network-scripts/ifcfg-ens160
/*
TYPE=Ethernet
BOOTPROTO=static
DEFROUTE=yes
NAME=ens160
DEVICE=ens160
ONBOOT=yes
IPADDR=192.168.6.22
NETMASK=255.255.255.0
GATEWAY=192.168.1.1
DNS1=192.168.4.11
DNS2=192.168.4.12
*/

-- Step 4.1 -->> On Node 2
[root@mongodb-config-02 ~]# nmtui
--OR--
-- Step 4.1 -->> On Node 2
[root@mongodb-config-02 ~]# vi /etc/sysconfig/network-scripts/ifcfg-ens160
/*
TYPE=Ethernet
BOOTPROTO=static
DEFROUTE=yes
NAME=ens160
DEVICE=ens160
ONBOOT=yes
IPADDR=192.168.6.23
NETMASK=255.255.255.0
GATEWAY=192.168.1.1
DNS1=192.168.4.11
DNS2=192.168.4.12
*/

-- Step 4.2 -->> On Node 3
[root@mongodb-config-03 ~]# nmtui
--OR--
-- Step 4.2 -->> On Node 3
[root@mongodb-config-03 ~]# vi /etc/sysconfig/network-scripts/ifcfg-ens160
/*
TYPE=Ethernet
DEFROUTE=yes
NAME=ens160
DEVICE=ens160
ONBOOT=yes
IPADDR=192.168.6.24
NETMASK=255.255.255.0
GATEWAY=192.168.1.1
DNS1=192.168.4.11
DNS2=192.168.4.12
*/

-- Step 4.3 -->> On Node 4
[root@mongodb-mongos ~]# nmtui
--OR--
-- Step 4.3 -->> On Node 4
[root@mongodb-mongos ~]# vi /etc/sysconfig/network-scripts/ifcfg-ens160
/*
TYPE=Ethernet
BOOTPROTO=static
DEFROUTE=yes
NAME=ens160
DEVICE=ens160
ONBOOT=yes
IPADDR=192.168.6.21
NETMASK=255.255.255.0
GATEWAY=192.168.1.1
DNS1=192.168.4.11
DNS2=192.168.4.12
*/

-- Step 4.4 -->> On Node 5
[root@mongodb-shard-01 ~]# nmtui
--OR--
-- Step 4.4 -->> On Node 5
[root@mongodb-shard-01 ~]# vi /etc/sysconfig/network-scripts/ifcfg-ens160
/*
TYPE=Ethernet
DEFROUTE=yes
NAME=ens160
DEVICE=ens160
ONBOOT=yes
IPADDR=192.168.6.25
NETMASK=255.255.255.0
GATEWAY=192.168.1.1
DNS1=192.168.4.11
DNS2=192.168.4.12
*/

-- Step 4.5 -->> On Node 6
[root@mongodb-shard-02 ~]# nmtui
--OR--
-- Step 4.5 -->> On Node 6
[root@mongodb-shard-02 ~]# vi /etc/sysconfig/network-scripts/ifcfg-ens160
/*
TYPE=Ethernet
DEFROUTE=yes
NAME=ens160
DEVICE=ens160
ONBOOT=yes
IPADDR=192.168.6.26
NETMASK=255.255.255.0
GATEWAY=192.168.1.1
DNS1=192.168.4.11
DNS2=192.168.4.12
*/
-- Step 4.6 -->> On Node 7
[root@mongodb-shard-03 ~]# nmtui
--OR--
-- Step 4.6 -->> On Node 7
[root@mongodb-shard-03 ~]# vi /etc/sysconfig/network-scripts/ifcfg-ens160
/*
TYPE=Ethernet
DEFROUTE=yes
NAME=ens160
DEVICE=ens160
ONBOOT=yes
IPADDR=192.168.6.27
NETMASK=255.255.255.0
GATEWAY=192.168.1.1
DNS1=192.168.4.11
DNS2=192.168.4.12
*/
-- Step 4.7 -->> On Node 8
[root@mongodb-shard-04 ~]# nmtui
--OR--
-- Step 4.7 -->> On Node 8
[root@mongodb-shard-04 ~]# vi /etc/sysconfig/network-scripts/ifcfg-ens160
/*
TYPE=Ethernet
DEFROUTE=yes
NAME=ens160
DEVICE=ens160
ONBOOT=yes
IPADDR=192.168.6.28
NETMASK=255.255.255.0
GATEWAY=192.168.1.1
DNS1=192.168.4.11
DNS2=192.168.4.12
*/
-- Step 4.8 -->> On Node 9
[root@mongodb-shard-05 ~]# nmtui
--OR--
-- Step 4.8 -->> On Node 9
[root@mongodb-shard-05 ~]# vi /etc/sysconfig/network-scripts/ifcfg-ens160
/*
TYPE=Ethernet
DEFROUTE=yes
NAME=ens160
DEVICE=ens160
ONBOOT=yes
IPADDR=192.168.6.29
NETMASK=255.255.255.0
GATEWAY=192.168.1.1
DNS1=192.168.4.11
DNS2=192.168.4.12
*/

-- Step 4.9 -->> On Node 10
[root@mongodb-shard-06 ~]# nmtui
--OR--
-- Step 4.9 -->> On Node 10
[root@mongodb-shard-06 ~]# vi /etc/sysconfig/network-scripts/ifcfg-ens160
/*
TYPE=Ethernet
DEFROUTE=yes
NAME=ens160
DEVICE=ens160
ONBOOT=yes
IPADDR=192.168.6.30
NETMASK=255.255.255.0
GATEWAY=192.168.1.1
DNS1=192.168.4.11
DNS2=192.168.4.12
*/

-- Step 5 -->> On All Nodes
[root@mongodb-<<nodes>>-1-2-3-4-5-6-7-8-9-10 ~]# systemctl restart network-online.target

-- Step 6.0 -->> On Node 1
[root@mongodb-config-01 ~]# hostnamectl set-hostname mongodb-config-01.unidev39.org.np

-- Step 6.1 -->> On Node 1
[root@mongodb-config-01 ~]# hostnamectl
/*
   Static hostname: mongodb-config-01.unidev39.org.np
         Icon name: computer-vm
           Chassis: vm
        Machine ID: 82fc1aba4e5e40bba0dcfbbcd063329b
           Boot ID: 6ea5e0b64c674e7281339d5d690504e6
    Virtualization: vmware
  Operating System: CentOS Stream 8
       CPE OS Name: cpe:/o:centos:centos:8
            Kernel: Linux 4.18.0-522.el8.x86_64
      Architecture: x86-64
*/

-- Step 6.2 -->> On Node 2
[root@mongodb-config-02 ~]# hostnamectl set-hostname mongodb-config-02.unidev39.org.np

-- Step 6.3 -->> On Node 2
[root@mongodb-config-02 ~]# hostnamectl
/*
   Static hostname: mongodb-config-02.unidev39.org.np
         Icon name: computer-vm
           Chassis: vm
        Machine ID: 82fc1aba4e5e40bba0dcfbbcd063329b
           Boot ID: 20b06c65a9c042faac379d14b5da32b7
    Virtualization: vmware
  Operating System: CentOS Stream 8
       CPE OS Name: cpe:/o:centos:centos:8
            Kernel: Linux 4.18.0-522.el8.x86_64
      Architecture: x86-64
*/

-- Step 6.4 -->> On Node 3
[root@mongodb-config-03 ~]# hostnamectl set-hostname mongodb-config-03.unidev39.org.np

-- Step 6.5 -->> On Node 3
[root@mongodb-config-03 ~]# hostnamectl
/*
   Static hostname: mongodb-config-03.unidev39.org.np
         Icon name: computer-vm
           Chassis: vm
        Machine ID: 82fc1aba4e5e40bba0dcfbbcd063329b
           Boot ID: c4588181283c44cfab99125c6a8f1698
    Virtualization: vmware
  Operating System: CentOS Stream 8
       CPE OS Name: cpe:/o:centos:centos:8
            Kernel: Linux 4.18.0-522.el8.x86_64
      Architecture: x86-64
*/

-- Step 6.6 -->> On Node 4
[root@mongodb-mongos ~]# hostnamectl set-hostname mongodb-mongos.unidev39.org.np

-- Step 6.7 -->> On Node 4
[root@mongodb-mongos ~]# hostnamectl
/*
   Static hostname: mongodb-mongos.unidev39.org.np
         Icon name: computer-vm
           Chassis: vm
        Machine ID: 82fc1aba4e5e40bba0dcfbbcd063329b
           Boot ID: ed3b84e1b78e4420811f1c6b1d4c03d9
    Virtualization: vmware
  Operating System: CentOS Stream 8
       CPE OS Name: cpe:/o:centos:centos:8
            Kernel: Linux 4.18.0-522.el8.x86_64
      Architecture: x86-64
*/

-- Step 6.8 -->> On Node 5
[root@mongodb-shard-01 ~]# hostnamectl set-hostname mongodb-shard-01.unidev39.org.np

-- Step 6.9 -->> On Node 5
[root@mongodb-shard-01 ~]# hostnamectl
/*
   Static hostname: mongodb-shard-01.unidev39.org.np
         Icon name: computer-vm
           Chassis: vm
        Machine ID: 82fc1aba4e5e40bba0dcfbbcd063329b
           Boot ID: f14b7de4261e4fab851f4e191dbcbeb6
    Virtualization: vmware
  Operating System: CentOS Stream 8
       CPE OS Name: cpe:/o:centos:centos:8
            Kernel: Linux 4.18.0-522.el8.x86_64
      Architecture: x86-64
*/

-- Step 6.10 -->> On Node 6
[root@mongodb-shard-02 ~]# hostnamectl set-hostname mongodb-shard-02.unidev39.org.np

-- Step 6.11 -->> On Node 6
[root@mongodb-config-02 ~]# hostnamectl
/*
   Static hostname: mongodb-shard-02.unidev39.org.np
         Icon name: computer-vm
           Chassis: vm
        Machine ID: 82fc1aba4e5e40bba0dcfbbcd063329b
           Boot ID: abf6919055264d8dbc9c2a7967798b1a
    Virtualization: vmware
  Operating System: CentOS Stream 8
       CPE OS Name: cpe:/o:centos:centos:8
            Kernel: Linux 4.18.0-522.el8.x86_64
      Architecture: x86-64
*/

-- Step 6.12 -->> On Node 7
[root@mongodb-shard-03 ~]# hostnamectl set-hostname mongodb-shard-03.unidev39.org.np

-- Step 6.13 -->> On Node 7
[root@mongodb-config-03 ~]# hostnamectl
/*
   Static hostname: mongodb-shard-03.unidev39.org.np
         Icon name: computer-vm
           Chassis: vm
        Machine ID: 82fc1aba4e5e40bba0dcfbbcd063329b
           Boot ID: 2830bde0c538453bb58a56ea1da72c5b
    Virtualization: vmware
  Operating System: CentOS Stream 8
       CPE OS Name: cpe:/o:centos:centos:8
            Kernel: Linux 4.18.0-522.el8.x86_64
      Architecture: x86-64
*/

-- Step 6.14 -->> On Node 8
[root@mongodb-shard-04 ~]# hostnamectl set-hostname mongodb-shard-04.unidev39.org.np

-- Step 6.15 -->> On Node 8
[root@mongodb-config-04 ~]# hostnamectl
/*
   Static hostname: mongodb-shard-04.unidev39.org.np
         Icon name: computer-vm
           Chassis: vm
        Machine ID: 82fc1aba4e5e40bba0dcfbbcd063329b
           Boot ID: c25c31e8aa8740769c93dff722e8c14c
    Virtualization: vmware
  Operating System: CentOS Stream 8
       CPE OS Name: cpe:/o:centos:centos:8
            Kernel: Linux 4.18.0-522.el8.x86_64
      Architecture: x86-64
*/

-- Step 6.16 -->> On Node 9
[root@mongodb-shard-05 ~]# hostnamectl set-hostname mongodb-shard-05.unidev39.org.np

-- Step 6.17 -->> On Node 9
[root@mongodb-config-05 ~]# hostnamectl
/*
   Static hostname: mongodb-shard-05.unidev39.org.np
         Icon name: computer-vm
           Chassis: vm
        Machine ID: 82fc1aba4e5e40bba0dcfbbcd063329b
           Boot ID: 92f4e07b994249ca88c33b9b5be014dc
    Virtualization: vmware
  Operating System: CentOS Stream 8
       CPE OS Name: cpe:/o:centos:centos:8
            Kernel: Linux 4.18.0-522.el8.x86_64
      Architecture: x86-64
*/

-- Step 6.18 -->> On Node 10
[root@mongodb-shard-06 ~]# hostnamectl set-hostname mongodb-shard-06.unidev39.org.np

-- Step 6.19 -->> On Node 10
[root@mongodb-config-06 ~]# hostnamectl
/*
   Static hostname: mongodb-shard-06.unidev39.org.np
         Icon name: computer-vm
           Chassis: vm
        Machine ID: 82fc1aba4e5e40bba0dcfbbcd063329b
           Boot ID: 58184ecabcdc42cbaa2f54b11231a693
    Virtualization: vmware
  Operating System: CentOS Stream 8
       CPE OS Name: cpe:/o:centos:centos:8
            Kernel: Linux 4.18.0-522.el8.x86_64
      Architecture: x86-64
*/

-- Step 7 -->> On All Nodes
[root@mongodb-<<nodes>>-1-2-3-4-5-6-7-8-9-10 ~]# systemctl stop firewalld
[root@mongodb-<<nodes>>-1-2-3-4-5-6-7-8-9-10 ~]# systemctl disable firewalld
/*
Removed "/etc/systemd/system/multi-user.target.wants/firewalld.service".
Removed "/etc/systemd/system/dbus-org.fedoraproject.FirewallD1.service".
*/

-- Step 8 -->> On All Nodes
[root@mongodb-<<nodes>>-1-2-3-4-5-6-7-8-9-10 ~]# iptables -F
[root@mongodb-<<nodes>>-1-2-3-4-5-6-7-8-9-10 ~]# iptables -X
[root@mongodb-<<nodes>>-1-2-3-4-5-6-7-8-9-10 ~]# iptables -t nat -F
[root@mongodb-<<nodes>>-1-2-3-4-5-6-7-8-9-10 ~]# iptables -t nat -X
[root@mongodb-<<nodes>>-1-2-3-4-5-6-7-8-9-10 ~]# iptables -t mangle -F
[root@mongodb-<<nodes>>-1-2-3-4-5-6-7-8-9-10 ~]# iptables -t mangle -X
[root@mongodb-<<nodes>>-1-2-3-4-5-6-7-8-9-10 ~]# iptables -P INPUT ACCEPT
[root@mongodb-<<nodes>>-1-2-3-4-5-6-7-8-9-10 ~]# iptables -P FORWARD ACCEPT
[root@mongodb-<<nodes>>-1-2-3-4-5-6-7-8-9-10 ~]# iptables -P OUTPUT ACCEPT
[root@mongodb-<<nodes>>-1-2-3-4-5-6-7-8-9-10 ~]# iptables -L -nv
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
[root@mongodb-<<nodes>>-1-2-3-4-5-6-7-8-9-10 ~]# systemctl stop libvirtd.service
[root@mongodb-<<nodes>>-1-2-3-4-5-6-7-8-9-10 ~]# systemctl disable libvirtd.service
[root@mongodb-<<nodes>>-1-2-3-4-5-6-7-8-9-10 ~]# virsh net-list
[root@mongodb-<<nodes>>-1-2-3-4-5-6-7-8-9-10 ~]# virsh net-destroy default

-- Step 10 -->> On Node 1
[root@mongodb-config-01 ~]# ifconfig
/*
ens160: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 192.168.6.22  netmask 255.255.255.0  broadcast 192.168.6.255
        inet6 fe80::250:56ff:feac:2150  prefixlen 64  scopeid 0x20<link>
        ether 00:50:56:ac:21:50  txqueuelen 1000  (Ethernet)
        RX packets 2701  bytes 316841 (309.4 KiB)
        RX errors 0  dropped 86  overruns 0  frame 0
        TX packets 827  bytes 82790 (80.8 KiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
        inet 127.0.0.1  netmask 255.0.0.0
        inet6 ::1  prefixlen 128  scopeid 0x10<host>
        loop  txqueuelen 1000  (Local Loopback)
        RX packets 2608  bytes 156480 (152.8 KiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 2608  bytes 156480 (152.8 KiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
*/

-- Step 10.1 -->> On Node 2
[root@mongodb-config-02 ~]# ifconfig
/*
ens160: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 192.168.6.23  netmask 255.255.255.0  broadcast 192.168.6.255
        inet6 fe80::250:56ff:feac:21b3  prefixlen 64  scopeid 0x20<link>
        ether 00:50:56:ac:21:b3  txqueuelen 1000  (Ethernet)
        RX packets 2597  bytes 308254 (301.0 KiB)
        RX errors 0  dropped 78  overruns 0  frame 0
        TX packets 778  bytes 81516 (79.6 KiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
        inet 127.0.0.1  netmask 255.0.0.0
        inet6 ::1  prefixlen 128  scopeid 0x10<host>
        loop  txqueuelen 1000  (Local Loopback)
        RX packets 2632  bytes 157920 (154.2 KiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 2632  bytes 157920 (154.2 KiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
*/

-- Step 10.2 -->> On Node 3
[root@mongodb-config-03 ~]# ifconfig
/*
ens160: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 192.168.6.24  netmask 255.255.255.0  broadcast 192.168.6.255
        inet6 fe80::250:56ff:feac:12ff  prefixlen 64  scopeid 0x20<link>
        ether 00:50:56:ac:12:ff  txqueuelen 1000  (Ethernet)
        RX packets 2642  bytes 335200 (327.3 KiB)
        RX errors 0  dropped 73  overruns 0  frame 0
        TX packets 882  bytes 87835 (85.7 KiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
        inet 127.0.0.1  netmask 255.0.0.0
        inet6 ::1  prefixlen 128  scopeid 0x10<host>
        loop  txqueuelen 1000  (Local Loopback)
        RX packets 2508  bytes 150480 (146.9 KiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 2508  bytes 150480 (146.9 KiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
*/

-- Step 10.3 -->> On Node 4
[root@mongodb-mongos ~]# ifconfig
/*
ens160: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 192.168.6.21  netmask 255.255.255.0  broadcast 192.168.6.255
        inet6 fe80::250:56ff:feac:4c05  prefixlen 64  scopeid 0x20<link>
        ether 00:50:56:ac:4c:05  txqueuelen 1000  (Ethernet)
        RX packets 2806  bytes 326890 (319.2 KiB)
        RX errors 0  dropped 92  overruns 0  frame 0
        TX packets 932  bytes 90636 (88.5 KiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
        inet 127.0.0.1  netmask 255.0.0.0
        inet6 ::1  prefixlen 128  scopeid 0x10<host>
        loop  txqueuelen 1000  (Local Loopback)
        RX packets 2712  bytes 162720 (158.9 KiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 2712  bytes 162720 (158.9 KiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
*/

-- Step 10.4 -->> On Node 5
[root@mongodb-shard-01 ~]# ifconfig
/*
ens160: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 192.168.6.25  netmask 255.255.255.0  broadcast 192.168.6.255
        inet6 fe80::250:56ff:feac:d5e  prefixlen 64  scopeid 0x20<link>
        ether 00:50:56:ac:0d:5e  txqueuelen 1000  (Ethernet)
        RX packets 2552  bytes 300149 (293.1 KiB)
        RX errors 0  dropped 68  overruns 0  frame 0
        TX packets 810  bytes 81471 (79.5 KiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
        inet 127.0.0.1  netmask 255.0.0.0
        inet6 ::1  prefixlen 128  scopeid 0x10<host>
        loop  txqueuelen 1000  (Local Loopback)
        RX packets 2504  bytes 150240 (146.7 KiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 2504  bytes 150240 (146.7 KiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
*/

-- Step 10.5 -->> On Node 6
[root@mongodb-shard-02 ~]# ifconfig
/*
ens160: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 192.168.6.26  netmask 255.255.255.0  broadcast 192.168.6.255
        inet6 fe80::250:56ff:feac:34a4  prefixlen 64  scopeid 0x20<link>
        ether 00:50:56:ac:34:a4  txqueuelen 1000  (Ethernet)
        RX packets 2489  bytes 293405 (286.5 KiB)
        RX errors 0  dropped 62  overruns 0  frame 0
        TX packets 795  bytes 79190 (77.3 KiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
        inet 127.0.0.1  netmask 255.0.0.0
        inet6 ::1  prefixlen 128  scopeid 0x10<host>
        loop  txqueuelen 1000  (Local Loopback)
        RX packets 2600  bytes 156000 (152.3 KiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 2600  bytes 156000 (152.3 KiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
*/

-- Step 10.6 -->> On Node 7
[root@mongodb-shard-03 ~]# ifconfig
/*
ens160: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 192.168.6.27  netmask 255.255.255.0  broadcast 192.168.6.255
        inet6 fe80::250:56ff:feac:3326  prefixlen 64  scopeid 0x20<link>
        ether 00:50:56:ac:33:26  txqueuelen 1000  (Ethernet)
        RX packets 2484  bytes 291481 (284.6 KiB)
        RX errors 0  dropped 56  overruns 0  frame 0
        TX packets 825  bytes 81952 (80.0 KiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
        inet 127.0.0.1  netmask 255.0.0.0
        inet6 ::1  prefixlen 128  scopeid 0x10<host>
        loop  txqueuelen 1000  (Local Loopback)
        RX packets 2524  bytes 151440 (147.8 KiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 2524  bytes 151440 (147.8 KiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
*/

-- Step 10.7 -->> On Node 8
[root@mongodb-shard-04 ~]# ifconfig
/*
ens160: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 192.168.6.28  netmask 255.255.255.0  broadcast 192.168.6.255
        inet6 fe80::250:56ff:feac:58bd  prefixlen 64  scopeid 0x20<link>
        ether 00:50:56:ac:58:bd  txqueuelen 1000  (Ethernet)
        RX packets 2560  bytes 298136 (291.1 KiB)
        RX errors 0  dropped 49  overruns 0  frame 0
        TX packets 934  bytes 92884 (90.7 KiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
        inet 127.0.0.1  netmask 255.0.0.0
        inet6 ::1  prefixlen 128  scopeid 0x10<host>
        loop  txqueuelen 1000  (Local Loopback)
        RX packets 2712  bytes 162720 (158.9 KiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 2712  bytes 162720 (158.9 KiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
*/

-- Step 10.8 -->> On Node 9
[root@mongodb-shard-05 ~]# ifconfig
/*
ens160: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 192.168.6.29  netmask 255.255.255.0  broadcast 192.168.6.255
        inet6 fe80::250:56ff:feac:19c7  prefixlen 64  scopeid 0x20<link>
        ether 00:50:56:ac:19:c7  txqueuelen 1000  (Ethernet)
        RX packets 2379  bytes 279246 (272.7 KiB)
        RX errors 0  dropped 46  overruns 0  frame 0
        TX packets 774  bytes 77555 (75.7 KiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
        inet 127.0.0.1  netmask 255.0.0.0
        inet6 ::1  prefixlen 128  scopeid 0x10<host>
        loop  txqueuelen 1000  (Local Loopback)
        RX packets 2504  bytes 150240 (146.7 KiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 2504  bytes 150240 (146.7 KiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
*/

-- Step 10.9 -->> On Node 10
[root@mongodb-shard-06 ~]# ifconfig
/*
ens160: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 192.168.6.30  netmask 255.255.255.0  broadcast 192.168.6.255
        inet6 fe80::250:56ff:feac:daf  prefixlen 64  scopeid 0x20<link>
        ether 00:50:56:ac:0d:af  txqueuelen 1000  (Ethernet)
        RX packets 2370  bytes 276911 (270.4 KiB)
        RX errors 0  dropped 36  overruns 0  frame 0
        TX packets 832  bytes 81848 (79.9 KiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
        inet 127.0.0.1  netmask 255.0.0.0
        inet6 ::1  prefixlen 128  scopeid 0x10<host>
        loop  txqueuelen 1000  (Local Loopback)
        RX packets 2752  bytes 165120 (161.2 KiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 2752  bytes 165120 (161.2 KiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
*/

-- Step 11 -->> On All Nodes
[root@mongodb-<<nodes>>-1-2-3-4-5-6-7-8-9-10 ~]# init 6

-- Step 12 -->> On All Nodes
[root@mongodb-<<nodes>>-1-2-3-4-5-6-7-8-9-10 ~]# firewall-cmd --list-all
/*
FirewallD is not running
*/

-- Step 13 -->> On All Nodes
[root@mongodb-<<nodes>>-1-2-3-4-5-6-7-8-9-10 ~]# systemctl status firewalld
/*
● firewalld.service - firewalld - dynamic firewall daemon
   Loaded: loaded (/usr/lib/systemd/system/firewalld.service; disabled; vendor preset: enabled)
   Active: inactive (dead)
     Docs: man:firewalld(1)
*/

-- Step 14 -->> On All Nodes
[root@mongodb-<<nodes>>-1-2-3-4-5-6-7-8-9-10 ~]# cd /run/media/root/CentOS-Stream-8-BaseOS-x86_64/AppStream/Packages
[root@mongodb-<<nodes>>-1-2-3-4-5-6-7-8-9-10 ~]# yum -y update

-- Step 15 -->> On All Nodes
[root@mongodb-<<nodes>>-1-2-3-4-5-6-7-8-9-10 ~]# usermod -aG wheel mongodb
[root@mongodb-<<nodes>>-1-2-3-4-5-6-7-8-9-10 ~]# usermod -aG root mongodb

-- Step 16 -->> On All Nodes
[root@mongodb-<<nodes>>-1-2-3-4-5-6-7-8-9-10 ~]# cd /etc/yum.repos.d/
[root@mongodb-<<nodes>>-1-2-3-4-5-6-7-8-9-10 yum.repos.d]# ll
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

-- Step 17 -->> On All Nodes (Add MongoDB Repository)
[root@mongodb-<<nodes>>-1-2-3-4-5-6-7-8-9-10 yum.repos.d]# vi /etc/yum.repos.d/mongodb-org.repo
/*
[mongodb-org-4.4]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/$releasever/mongodb-org/4.4/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-4.4.asc
*/ 

-- Step 18 -->> On All Nodes
[root@mongodb-<<nodes>>-1-2-3-4-5-6-7-8-9-10 yum.repos.d]# ll | grep mongo
/*
-rw-r--r--  1 root root  200 Nov 28 11:26 mongodb-org.repo
*/
[root@mongodb-<<nodes>>-1-2-3-4-5-6-7-8-9-10 yum.repos.d]# yum repolist
/*
repo id                              repo name
appstream                            CentOS Stream 8 - AppStream
baseos                               CentOS Stream 8 - BaseOS
extras                               CentOS Stream 8 - Extras
extras-common                        CentOS Stream 8 - Extras common packages
mongodb-org-4.4                      MongoDB Repository
*/

-- Step 19 -->> On All Nodes (Install MongoDB)
[root@mongodb-<<nodes>>-1-2-3-4-5-6-7-8-9-10 ~]# yum install -y mongodb-org
/*
CentOS Stream 8 - BaseOS                                                                                                                                     4.5 kB/s | 3.9 kB     00:00
CentOS Stream 8 - Extras                                                                                                                                     3.6 kB/s | 2.9 kB     00:00
CentOS Stream 8 - Extras common packages                                                                                                                     4.9 kB/s | 3.0 kB     00:00
MongoDB Repository                                                                                                                                            82 kB/s |  83 kB     00:01
Dependencies resolved.
=============================================================================================================================================================================================
 Package                                                      Architecture                       Version                                   Repository                                   Size
=============================================================================================================================================================================================
Installing:
 mongodb-org                                                  x86_64                             4.4.26-1.el8                              mongodb-org-4.4                             9.6 k
Installing dependencies:
 mongodb-database-tools                                       x86_64                             100.9.3-1                                 mongodb-org-4.4                              52 M
 mongodb-org-database-tools-extra                             x86_64                             4.4.26-1.el8                              mongodb-org-4.4                              22 k
 mongodb-org-mongos                                           x86_64                             4.4.26-1.el8                              mongodb-org-4.4                              17 M
 mongodb-org-server                                           x86_64                             4.4.26-1.el8                              mongodb-org-4.4                              22 M
 mongodb-org-shell                                            x86_64                             4.4.26-1.el8                              mongodb-org-4.4                              14 M
 mongodb-org-tools                                            x86_64                             4.4.26-1.el8                              mongodb-org-4.4                             9.5 k

Transaction Summary
=============================================================================================================================================================================================
Install  7 Packages

Total download size: 105 M
Installed size: 314 M
Downloading Packages:
(1/7): mongodb-org-4.4.26-1.el8.x86_64.rpm                                                                                                                    19 kB/s | 9.6 kB     00:00
(2/7): mongodb-org-database-tools-extra-4.4.26-1.el8.x86_64.rpm                                                                                               41 kB/s |  22 kB     00:00
(3/7): mongodb-org-server-4.4.26-1.el8.x86_64.rpm                                                                                                            2.9 MB/s |  22 MB     00:07
(4/7): mongodb-org-mongos-4.4.26-1.el8.x86_64.rpm                                                                                                            2.0 MB/s |  17 MB     00:08
(5/7): mongodb-database-tools-100.9.3.x86_64.rpm                                                                                                             5.0 MB/s |  52 MB     00:10
(6/7): mongodb-org-tools-4.4.26-1.el8.x86_64.rpm                                                                                                             5.6 kB/s | 9.5 kB     00:01
(7/7): mongodb-org-shell-4.4.26-1.el8.x86_64.rpm                                                                                                             3.5 MB/s |  14 MB     00:04
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Total                                                                                                                                                        8.7 MB/s | 105 MB     00:12
MongoDB Repository                                                                                                                                           682  B/s | 1.6 kB     00:02
Importing GPG key 0x90CFB1F5:
 Userid     : "MongoDB 4.4 Release Signing Key <packaging@mongodb.com>"
 Fingerprint: 2069 1EEC 3521 6C63 CAF6 6CE1 6564 08E3 90CF B1F5
 From       : https://www.mongodb.org/static/pgp/server-4.4.asc
Key imported successfully
Running transaction check
Transaction check succeeded.
Running transaction test
Transaction test succeeded.
Running transaction
  Preparing        :                                                                                                                                                                     1/1
  Installing       : mongodb-org-shell-4.4.26-1.el8.x86_64                                                                                                                               1/7
  Running scriptlet: mongodb-org-server-4.4.26-1.el8.x86_64                                                                                                                              2/7
  Installing       : mongodb-org-server-4.4.26-1.el8.x86_64                                                                                                                              2/7
  Running scriptlet: mongodb-org-server-4.4.26-1.el8.x86_64                                                                                                                              2/7
Created symlink /etc/systemd/system/multi-user.target.wants/mongod.service → /usr/lib/systemd/system/mongod.service.

  Installing       : mongodb-org-mongos-4.4.26-1.el8.x86_64                                                                                                                              3/7
  Installing       : mongodb-org-database-tools-extra-4.4.26-1.el8.x86_64                                                                                                                4/7
  Running scriptlet: mongodb-database-tools-100.9.3-1.x86_64                                                                                                                             5/7
  Installing       : mongodb-database-tools-100.9.3-1.x86_64                                                                                                                             5/7
  Running scriptlet: mongodb-database-tools-100.9.3-1.x86_64                                                                                                                             5/7
  Installing       : mongodb-org-tools-4.4.26-1.el8.x86_64                                                                                                                               6/7
  Installing       : mongodb-org-4.4.26-1.el8.x86_64                                                                                                                                     7/7
  Running scriptlet: mongodb-org-4.4.26-1.el8.x86_64                                                                                                                                     7/7
  Verifying        : mongodb-database-tools-100.9.3-1.x86_64                                                                                                                             1/7
  Verifying        : mongodb-org-4.4.26-1.el8.x86_64                                                                                                                                     2/7
  Verifying        : mongodb-org-database-tools-extra-4.4.26-1.el8.x86_64                                                                                                                3/7
  Verifying        : mongodb-org-mongos-4.4.26-1.el8.x86_64                                                                                                                              4/7
  Verifying        : mongodb-org-server-4.4.26-1.el8.x86_64                                                                                                                              5/7
  Verifying        : mongodb-org-shell-4.4.26-1.el8.x86_64                                                                                                                               6/7
  Verifying        : mongodb-org-tools-4.4.26-1.el8.x86_64                                                                                                                               7/7

Installed:
  mongodb-database-tools-100.9.3-1.x86_64     mongodb-org-4.4.26-1.el8.x86_64           mongodb-org-database-tools-extra-4.4.26-1.el8.x86_64     mongodb-org-mongos-4.4.26-1.el8.x86_64
  mongodb-org-server-4.4.26-1.el8.x86_64      mongodb-org-shell-4.4.26-1.el8.x86_64     mongodb-org-tools-4.4.26-1.el8.x86_64

Complete!
*/

-- Step 20 -->> On All Nodes
[root@mongodb-<<nodes>>-1-2-3-4-5-6-7-8-9-10 ~]# ll /var/lib/ | grep mongo
/*
drwxr-xr-x   2 mongod         mongod            6 Oct  6 01:52 mongo
*/

-- Step 21 -->> On All Nodes (Create a MongoDB Data and Log directory)
[root@mongodb-<<nodes>>-1-2-3-4-5-6-7-8-9-10 ~]# mkdir -p /data/mongodb
[root@mongodb-<<nodes>>-1-2-3-4-5-6-7-8-9-10 ~]# mkdir -p /data/log
[root@mongodb-<<nodes>>-1-2-3-4-5-6-7-8-9-10 ~]# chown -R mongod:mongod /data/
[root@mongodb-<<nodes>>-1-2-3-4-5-6-7-8-9-10 ~]# chown -R mongod:mongod /data
[root@mongodb-<<nodes>>-1-2-3-4-5-6-7-8-9-10 ~]# chmod -R 777 /data/
[root@mongodb-<<nodes>>-1-2-3-4-5-6-7-8-9-10 ~]# chmod -R 777 /data
[root@mongodb-<<nodes>>-1-2-3-4-5-6-7-8-9-10 ~]# ll / | grep data
/*
drwxrwxrwx.   4 mongod mongod    32 Nov 28 11:38 data
*/

-- Step 22 -->> On All Nodes
[root@mongodb-<<nodes>>-1-2-3-4-5-6-7-8-9-10 ~]# ll /data/
/*
drwxrwxrwx 2 mongod mongod 6 Nov 28 11:38 log
drwxrwxrwx 2 mongod mongod 6 Nov 28 11:38 mongodb
*/

-- Step 23 -->> On All Nodes
[root@mongodb-<<nodes>>-1-2-3-4-5-6-7-8-9-10 ~]# cp -r /etc/mongod.conf /etc/mongod.conf.backup
[root@mongodb-<<nodes>>-1-2-3-4-5-6-7-8-9-10 ~]# ll /etc/mongod*
/*
-rw-r--r-- 1 root root 721 Nov 16 03:23 /etc/mongod.conf
-rw-r--r-- 1 root root 721 Nov 28 11:39 /etc/mongod.conf.backup
*/

-- Step 24 -->> On All Nodes
[root@mongodb-<<nodes>>-1-2-3-4-5-6-7-8-9-10 ~]# vi /etc/mongod.conf
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
  journal:
    enabled: true
#  engine:
#  wiredTiger:

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

#snmp:
*/

-- Step 25 -->> On All Nodes (Tuning For MongoDB)
-- Step 25.1 -->> On Node 1
[root@mongodb-config-01 ~]# vi /etc/mongod.conf
/*
# network interfaces
net:
  port: 27017
  bindIp: 127.0.0.1,mongodb-config-01.unidev39.org.np
  maxIncomingConnections: 999999
*/

-- Step 25.2 -->> On Node 2
[root@mongodb-config-02 ~]# vi /etc/mongod.conf
/*
# network interfaces
net:
  port: 27017
  bindIp: 127.0.0.1,mongodb-config-02.unidev39.org.np
  maxIncomingConnections: 999999
*/

-- Step 25.3 -->> On Node 3
[root@mongodb-config-03 ~]# vi /etc/mongod.conf
/*
# network interfaces
net:
  port: 27017
  bindIp: 127.0.0.1,mongodb-config-03.unidev39.org.np
  maxIncomingConnections: 999999
*/

-- Step 25.4 -->> On Node 4
[root@mongodb-mongos ~]# vi /etc/mongod.conf
/*
# network interfaces
net:
  port: 27017
  bindIp: 127.0.0.1,mongodb-mongos.unidev39.org.np
  maxIncomingConnections: 999999
*/

-- Step 25.5 -->> On Node 5
[root@mongodb-shard-01 ~]# vi /etc/mongod.conf
/*
# network interfaces
net:
  port: 27017
  bindIp: 127.0.0.1,mongodb-shard-01.unidev39.org.np
  maxIncomingConnections: 999999
*/

-- Step 25.6 -->> On Node 6
[root@mongodb-shard-02 ~]# vi /etc/mongod.conf
/*
# network interfaces
net:
  port: 27017
  bindIp: 127.0.0.1,mongodb-shard-02.unidev39.org.np
  maxIncomingConnections: 999999
*/

-- Step 25.7 -->> On Node 7
[root@mongodb-shard-03 ~]# vi /etc/mongod.conf
/*
# network interfaces
net:
  port: 27017
  bindIp: 127.0.0.1,mongodb-shard-03.unidev39.org.np
  maxIncomingConnections: 999999
*/

-- Step 25.8 -->> On Node 8
[root@mongodb-shard-04 ~]# vi /etc/mongod.conf
/*
# network interfaces
net:
  port: 27017
  bindIp: 127.0.0.1,mongodb-shard-04.unidev39.org.np
  maxIncomingConnections: 999999
*/

-- Step 25.9 -->> On Node 9
[root@mongodb-shard-05 ~]# vi /etc/mongod.conf
/*
# network interfaces
net:
  port: 27017
  bindIp: 127.0.0.1,mongodb-shard-05.unidev39.org.np
  maxIncomingConnections: 999999
*/

-- Step 25.10 -->> On Node 10
[root@mongodb-shard-06 ~]# vi /etc/mongod.conf
/*
# network interfaces
net:
  port: 27017
  bindIp: 127.0.0.1,mongodb-shard-06.unidev39.org.np
  maxIncomingConnections: 999999
*/

-- Step 26 -->> On All Nodes
[root@mongodb-<<nodes>>-1-2-3-4-5-6-7-8-9-10 ~]# systemctl enable mongod --now
[root@mongodb-<<nodes>>-1-2-3-4-5-6-7-8-9-10 ~]# systemctl start mongod
[root@mongodb-<<nodes>>-1-2-3-4-5-6-7-8-9-10 ~]# systemctl status mongod
/*
● mongod.service - MongoDB Database Server
   Loaded: loaded (/usr/lib/systemd/system/mongod.service; enabled; vendor preset: disabled)
   Active: active (running) since Tue 2023-11-28 11:51:17 +0545; 32s ago
     Docs: https://docs.mongodb.org/manual
 Main PID: 6116 (mongod)
   Memory: 64.2M
   CGroup: /system.slice/mongod.service
           └─6116 /usr/bin/mongod -f /etc/mongod.conf

Nov 28 11:51:17 mongodb-config-01.unidev39.org.np systemd[1]: Started MongoDB Database Server.
Nov 28 11:51:18 mongodb-config-01.unidev39.org.np mongod[6116]: {"t":{"$date":"2023-11-28T06:06:1>
*/

-- Step 27.1 -->> On All Nodes
[root@mongodb-<<nodes>>-1-2-3-4-5-6-7-8-9-10 ~]# which mongo
/*
/usr/bin/mongo
*/

-- Step 27.2 -->> On All Nodes
[root@mongodb-<<nodes>>-1-2-3-4-5-6-7-8-9-10 ~]# ll /data/mongodb/
/*
-rw------- 1 mongod mongod 20480 Nov 28 11:52 collection-0--7236489823170359299.wt
-rw------- 1 mongod mongod 20480 Nov 28 11:52 collection-2--7236489823170359299.wt
-rw------- 1 mongod mongod  4096 Nov 28 11:51 collection-4--7236489823170359299.wt
drwx------ 2 mongod mongod    71 Nov 28 11:53 diagnostic.data
-rw------- 1 mongod mongod 20480 Nov 28 11:52 index-1--7236489823170359299.wt
-rw------- 1 mongod mongod 20480 Nov 28 11:52 index-3--7236489823170359299.wt
-rw------- 1 mongod mongod  4096 Nov 28 11:51 index-5--7236489823170359299.wt
-rw------- 1 mongod mongod  4096 Nov 28 11:51 index-6--7236489823170359299.wt
drwx------ 2 mongod mongod   110 Nov 28 11:51 journal
-rw------- 1 mongod mongod 20480 Nov 28 11:52 _mdb_catalog.wt
-rw------- 1 mongod mongod     5 Nov 28 11:51 mongod.lock
-rw------- 1 mongod mongod 20480 Nov 28 11:53 sizeStorer.wt
-rw------- 1 mongod mongod   114 Nov 28 11:51 storage.bson
-rw------- 1 mongod mongod    50 Nov 28 11:51 WiredTiger
-rw------- 1 mongod mongod  4096 Nov 28 11:51 WiredTigerHS.wt
-rw------- 1 mongod mongod    21 Nov 28 11:51 WiredTiger.lock
-rw------- 1 mongod mongod  1464 Nov 28 11:53 WiredTiger.turtle
-rw------- 1 mongod mongod 69632 Nov 28 11:53 WiredTiger.wt
*/

-- Step 27.3 -->> On All Nodes
[root@mongodb-<<nodes>>-1-2-3-4-5-6-7-8-9-10 ~]# ll /data/log/
/*
-rw------- 1 mongod mongod 8872 Nov 28 11:53 mongod.log
*/

-- Step 27.4 -->> On All Nodes
[root@mongodb-<<nodes>>-1-2-3-4-5-6-7-8-9-10 ~]# mongo
/*
MongoDB shell version v4.4.26
connecting to: mongodb://127.0.0.1:27017/?compressors=disabled&gssapiServiceName=mongodb
Implicit session: session { "id" : UUID("29c42c14-9a18-49d6-bd5a-231d4e51f5d1") }
MongoDB server version: 4.4.26
Welcome to the MongoDB shell.
For interactive help, type "help".
For more comprehensive documentation, see
        https://docs.mongodb.com/
Questions? Try the MongoDB Developer Community Forums
        https://community.mongodb.com
---
The server generated these startup warnings when booting:
        2023-11-28T11:51:19.343+05:45: Access control is not enabled for the database. Read and write access to data and configuration is unrestricted
        2023-11-28T11:51:19.343+05:45: /sys/kernel/mm/transparent_hugepage/enabled is 'always'. We suggest setting it to 'never'
---
> db.version()
4.4.26

> show dbs
admin   0.000GB
config  0.000GB
local   0.000GB

> quit()
*/

-- Step 27.5 -->> On All Nodes
[root@mongodb-<<nodes>>-1-2-3-4-5-6-7-8-9-10 ~]# systemctl stop mongod


-- Step 28.1 -->> On All Nodes (Tuning For MongoDB)
[root@mongodb-<<nodes>>-1-2-3-4-5-6-7-8-9-10 ~]# ulimit -a
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

-- Step 28.2 -->> On All Nodes
[root@mongodb-<<nodes>>-1-2-3-4-5-6-7-8-9-10 ~]# ulimit -n 64000
[root@mongodb-<<nodes>>-1-2-3-4-5-6-7-8-9-10 ~]# ulimit -a
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

-- Step 28.3 -->> On All Nodes
[root@mongodb-<<nodes>>-1-2-3-4-5-6-7-8-9-10 ~]# cat /etc/group | grep mongo
/*
root:x:0:mongodb
wheel:x:10:mongodb
mongodb:x:1000:
mongod:x:969:
*/

-- Step 28.4 -->> On All Nodes
[root@mongodb-<<nodes>>-1-2-3-4-5-6-7-8-9-10 ~]# echo "mongod           soft    nofile          9999999" | tee -a /etc/security/limits.conf
[root@mongodb-<<nodes>>-1-2-3-4-5-6-7-8-9-10 ~]# echo "mongod           hard    nofile          9999999" | tee -a /etc/security/limits.conf
[root@mongodb-<<nodes>>-1-2-3-4-5-6-7-8-9-10 ~]# echo "mongod           soft    nproc           9999999" | tee -a /etc/security/limits.conf
[root@mongodb-<<nodes>>-1-2-3-4-5-6-7-8-9-10 ~]# echo "mongod           hard    nproc           9999999" | tee -a /etc/security/limits.conf
[root@mongodb-<<nodes>>-1-2-3-4-5-6-7-8-9-10 ~]# echo "mongod           soft    stack           9999999" | tee -a /etc/security/limits.conf
[root@mongodb-<<nodes>>-1-2-3-4-5-6-7-8-9-10 ~]# echo "mongod           hard    stack           9999999" | tee -a /etc/security/limits.conf
[root@mongodb-<<nodes>>-1-2-3-4-5-6-7-8-9-10 ~]# echo 9999999 > /proc/sys/vm/max_map_count
[root@mongodb-<<nodes>>-1-2-3-4-5-6-7-8-9-10 ~]# echo "vm.max_map_count=9999999" | tee -a /etc/sysctl.conf
[root@mongodb-<<nodes>>-1-2-3-4-5-6-7-8-9-10 ~]# echo 1024 65530 > /proc/sys/net/ipv4/ip_local_port_range
[root@mongodb-<<nodes>>-1-2-3-4-5-6-7-8-9-10 ~]# echo "net.ipv4.ip_local_port_range = 1024 65530" | tee -a /etc/sysctl.conf

-- Step 29 -->> On All Nodes
[root@mongodb-<<nodes>>-1-2-3-4-5-6-7-8-9-10 ~]# systemctl start mongod
[root@mongodb-<<nodes>>-1-2-3-4-5-6-7-8-9-10 ~]# systemctl status mongod
/*
● mongod.service - MongoDB Database Server
   Loaded: loaded (/usr/lib/systemd/system/mongod.service; enabled; vendor preset: disabled)
   Active: active (running) since Tue 2023-11-28 12:02:32 +0545; 13s ago
     Docs: https://docs.mongodb.org/manual
 Main PID: 7086 (mongod)
   Memory: 161.4M
   CGroup: /system.slice/mongod.service
           └─7086 /usr/bin/mongod -f /etc/mongod.conf

Nov 28 12:02:32 mongodb-config-01.unidev39.org.np systemd[1]: Started MongoDB Database Server.
Nov 28 12:02:32 mongodb-config-01.unidev39.org.np mongod[7086]: {"t":{"$date":"2023-11-28T06:17:3>
*/

-- Step 30 -->> On All Nodes
[root@mongodb-<<nodes>>-1-2-3-4-5-6-7-8-9-10 ~]# mongo
/*
MongoDB shell version v4.4.26
connecting to: mongodb://127.0.0.1:27017/?compressors=disabled&gssapiServiceName=mongodb
Implicit session: session { "id" : UUID("c7ccf4e6-2e71-429d-8911-4533c284030a") }
MongoDB server version: 4.4.26
---
The server generated these startup warnings when booting:
        2023-11-28T12:02:33.754+05:45: Access control is not enabled for the database. Read and write access to data and configuration is unrestricted
        2023-11-28T12:02:33.754+05:45: /sys/kernel/mm/transparent_hugepage/enabled is 'always'. We suggest setting it to 'never'
---
> db.version()
4.4.26

> show dbs
admin   0.000GB
config  0.000GB
local   0.000GB

> quit()
*/

-- Step 31 -->> On All Nodes (Fixing The MongoDB Warnings - /sys/kernel/mm/transparent_hugepage/enabled is 'always'. We suggest setting it to 'never')
[root@mongodb-<<nodes>>-1-2-3-4-5-6-7-8-9-10 ~]# vi /etc/systemd/system/disable-mogodb-warnig.service
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
[root@mongodb-<<nodes>>-1-2-3-4-5-6-7-8-9-10 ~]# systemctl daemon-reload
-- Step 31.2 -->> On All Nodes
[root@mongodb-<<nodes>>-1-2-3-4-5-6-7-8-9-10 ~]# systemctl start disable-mogodb-warnig.service
-- Step 31.3 -->> On All Nodes
[root@mongodb-<<nodes>>-1-2-3-4-5-6-7-8-9-10 ~]# systemctl enable disable-mogodb-warnig.service
/*
Created symlink /etc/systemd/system/multi-user.target.wants/disable-mogodb-warnig.service → /etc/systemd/system/disable-mogodb-warnig.service.
*/

-- Step 31.4 -->> On All Nodes
[root@mongodb-<<nodes>>-1-2-3-4-5-6-7-8-9-10 ~]# systemctl restart mongod
-- Step 31.5 -->> On All Nodes
[root@mongodb-<<nodes>>-1-2-3-4-5-6-7-8-9-10 ~]# systemctl status mongod
/*
● mongod.service - MongoDB Database Server
   Loaded: loaded (/usr/lib/systemd/system/mongod.service; enabled; vendor preset: disabled)
   Active: active (running) since Tue 2023-11-28 12:08:05 +0545; 22s ago
     Docs: https://docs.mongodb.org/manual
 Main PID: 7313 (mongod)
   Memory: 161.9M
   CGroup: /system.slice/mongod.service
           └─7313 /usr/bin/mongod -f /etc/mongod.conf

Nov 28 12:08:05 mongodb-config-01.unidev39.org.np systemd[1]: Started MongoDB Database Server.
Nov 28 12:08:06 mongodb-config-01.unidev39.org.np mongod[7313]: {"t":{"$date":"2023-11-28T06:23:0>
*/

-- Step 32 -->> On All Nodes
[root@mongodb-<<nodes>>-1-2-3-4-5-6-7-8-9-10 ~]# mongo
/*
MongoDB shell version v4.4.26
connecting to: mongodb://127.0.0.1:27017/?compressors=disabled&gssapiServiceName=mongodb
Implicit session: session { "id" : UUID("0eab61e3-c3a8-4a68-9521-1712affe478d") }
MongoDB server version: 4.4.26
---
The server generated these startup warnings when booting:
        2023-11-28T12:08:07.518+05:45: Access control is not enabled for the database. Read and write access to data and configuration is unrestricted
---
> db.version()
4.4.26

> show dbs
admin   0.000GB
config  0.000GB
local   0.000GB

> quit()
*/

-- Step 34 -->> On Node 1 (Create a Administrative User)
[root@mongodb-config-01 ~]# mongo
/*
MongoDB shell version v4.4.26
connecting to: mongodb://127.0.0.1:27017/?compressors=disabled&gssapiServiceName=mongodb
Implicit session: session { "id" : UUID("e69963ce-4ac4-43ab-a6ab-e7952951b964") }
MongoDB server version: 4.4.26
---
The server generated these startup warnings when booting:
        2023-11-28T12:26:18.135+05:45: Access control is not enabled for the database. Read and write access to data and configuration is unrestricted
---
> db.version()
4.4.26

> show databases
admin   0.000GB
config  0.000GB
local   0.000GB

> use admin
switched to db admin

> db
admin

> db.createUser(
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

Successfully added user: {
        "user" : "admin",
        "roles" : [
                {
                        "role" : "userAdminAnyDatabase",
                        "db" : "admin"
                },
                {
                        "role" : "clusterAdmin",
                        "db" : "admin"
                },
                {
                        "role" : "root",
                        "db" : "admin"
                }
        ]
}

> db.getUsers()
[
        {
                "_id" : "admin.admin",
                "userId" : UUID("83b59d6e-141a-4c8a-940f-a9983532ec30"),
                "user" : "admin",
                "db" : "admin",
                "roles" : [
                        {
                                "role" : "userAdminAnyDatabase",
                                "db" : "admin"
                        },
                        {
                                "role" : "clusterAdmin",
                                "db" : "admin"
                        },
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

> db.auth('admin','P#ssw0rd');
1

> quit()
*/

-- Step 35 -->> On All Nodes
[root@@mongodb-<<nodes>>-1-2-3-4-5-6-7-8-9-10 ~]# systemctl stop mongod

-- Step 36 -->> On All Nodes (Access control is enabled for the database)
[root@@mongodb-<<nodes>>-1-2-3-4-5-6-7-8-9-10 ~]# vi /etc/mongod.conf
/*
#security:
security:
 authorization: enabled
*/

-- Step 37 -->> On All Nodes
[root@mongodb-<<nodes>>-1-2-3-4-5-6-7-8-9-10 ~]# systemctl start mongod

-- Step 38 -->> On All Nodes
[root@mongodb-<<nodes>>-1-2-3-4-5-6-7-8-9-10 ~]# systemctl status mongod
/*
● mongod.service - MongoDB Database Server
   Loaded: loaded (/usr/lib/systemd/system/mongod.service; enabled; vendor preset: disabled)
   Active: active (running) since Tue 2023-11-28 13:02:31 +0545; 12s ago
     Docs: https://docs.mongodb.org/manual
 Main PID: 5731 (mongod)
   Memory: 159.8M
   CGroup: /system.slice/mongod.service
           └─5731 /usr/bin/mongod -f /etc/mongod.conf

Nov 28 13:02:31 mongodb-config-01.unidev39.org.np systemd[1]: Started MongoDB Database Server.
Nov 28 13:02:31 mongodb-config-01.unidev39.org.np mongod[5731]: {"t":{"$date":"2023-11-28T07:17:3>
*/

-- Step 39 -->> On All Nodes
[mongodb@mongodb-<<nodes>>-1-2-3-4-5-6-7-8-9-10 ~]# mongo
/*
MongoDB shell version v4.4.26
connecting to: mongodb://127.0.0.1:27017/?compressors=disabled&gssapiServiceName=mongodb
Implicit session: session { "id" : UUID("d0a27c41-ea5a-415a-ae8e-80925d868d78") }
MongoDB server version: 4.4.26
> show dbs

> show databases

> db.version()
4.4.26

> quit()
*/

-- Step 40 -->> On Node 1 (Start Configuration From Config Servers)
[mongodb@mongodb-config-01 ~]$ mongo --host mongodb-config-01.unidev39.org.np --port 27017 -u admin -p P#ssw0rd --authenticationDatabase admin
/*
MongoDB shell version v4.4.26
connecting to: mongodb://mongodb-config-01.unidev39.org.np:27017/?authSource=admin&compressors=disabled&gssapiServiceName=mongodb
Implicit session: session { "id" : UUID("7a40586b-7bea-40a4-a38f-7416db08263f") }
MongoDB server version: 4.4.26
> db.version()
4.4.26

> show dbs
admin   0.000GB
config  0.000GB
local   0.000GB

> use admin
switched to db admin

> db
admin

> db.getUsers()
[
        {
                "_id" : "admin.admin",
                "userId" : UUID("83b59d6e-141a-4c8a-940f-a9983532ec30"),
                "user" : "admin",
                "db" : "admin",
                "roles" : [
                        {
                                "role" : "userAdminAnyDatabase",
                                "db" : "admin"
                        },
                        {
                                "role" : "clusterAdmin",
                                "db" : "admin"
                        },
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

> quit()

*/

-- Step 41 -->> On Node 1 (Set Up MongoDB Authentication)
[root@mongodb-config-01 ~]# cd /data/mongodb/

-- Step 41.1 -->> On Node 1
[root@mongodb-config-01 mongodb]# ll
/*
-rw------- 1 mongod mongod 36864 Nov 28 13:02 collection-0--7236489823170359299.wt
-rw------- 1 mongod mongod 20480 Nov 28 13:03 collection-0--8335973616453609618.wt
-rw------- 1 mongod mongod 36864 Nov 28 13:03 collection-2--7236489823170359299.wt
-rw------- 1 mongod mongod 36864 Nov 28 13:07 collection-4--7236489823170359299.wt
drwx------ 2 mongod mongod  4096 Nov 28 13:10 diagnostic.data
-rw------- 1 mongod mongod 36864 Nov 28 13:02 index-1--7236489823170359299.wt
-rw------- 1 mongod mongod 20480 Nov 28 12:58 index-1--8335973616453609618.wt
-rw------- 1 mongod mongod 20480 Nov 28 13:04 index-2--8335973616453609618.wt
-rw------- 1 mongod mongod 36864 Nov 28 13:03 index-3--7236489823170359299.wt
-rw------- 1 mongod mongod 36864 Nov 28 13:07 index-5--7236489823170359299.wt
-rw------- 1 mongod mongod 36864 Nov 28 13:07 index-6--7236489823170359299.wt
drwx------ 2 mongod mongod   110 Nov 28 13:02 journal
-rw------- 1 mongod mongod 36864 Nov 28 13:02 _mdb_catalog.wt
-rw------- 1 mongod mongod     5 Nov 28 13:02 mongod.lock
-rw------- 1 mongod mongod 36864 Nov 28 13:08 sizeStorer.wt
-rw------- 1 mongod mongod   114 Nov 28 11:51 storage.bson
-rw------- 1 mongod mongod    50 Nov 28 11:51 WiredTiger
-rw------- 1 mongod mongod  4096 Nov 28 13:02 WiredTigerHS.wt
-rw------- 1 mongod mongod    21 Nov 28 11:51 WiredTiger.lock
-rw------- 1 mongod mongod  1472 Nov 28 13:10 WiredTiger.turtle
-rw------- 1 mongod mongod 86016 Nov 28 13:10 WiredTiger.wt
*/

-- Step 41.2 -->> On Node 1
[root@mongodb-config-01 mongodb]# openssl rand -base64 756 > keyfile
-- Step 41.3 -->> On Node 1
[root@mongodb-config-01 mongodb]# chmod 400 keyfile
-- Step 41.4 -->> On Node 1
[root@mongodb-config-01 mongodb]# chown mongod:mongod keyfile
-- Step 41.5 -->> On Node 1
[root@mongodb-config-01 mongodb]# ll
/*
-rw------- 1 mongod mongod 36864 Nov 28 13:02 collection-0--7236489823170359299.wt
-rw------- 1 mongod mongod 20480 Nov 28 13:03 collection-0--8335973616453609618.wt
-rw------- 1 mongod mongod 36864 Nov 28 13:03 collection-2--7236489823170359299.wt
-rw------- 1 mongod mongod 36864 Nov 28 13:07 collection-4--7236489823170359299.wt
drwx------ 2 mongod mongod  4096 Nov 28 13:12 diagnostic.data
-rw------- 1 mongod mongod 36864 Nov 28 13:02 index-1--7236489823170359299.wt
-rw------- 1 mongod mongod 20480 Nov 28 12:58 index-1--8335973616453609618.wt
-rw------- 1 mongod mongod 20480 Nov 28 13:04 index-2--8335973616453609618.wt
-rw------- 1 mongod mongod 36864 Nov 28 13:03 index-3--7236489823170359299.wt
-rw------- 1 mongod mongod 36864 Nov 28 13:07 index-5--7236489823170359299.wt
-rw------- 1 mongod mongod 36864 Nov 28 13:07 index-6--7236489823170359299.wt
drwx------ 2 mongod mongod   110 Nov 28 13:02 journal
-r-------- 1 mongod mongod  1024 Nov 28 13:11 keyfile
-rw------- 1 mongod mongod 36864 Nov 28 13:02 _mdb_catalog.wt
-rw------- 1 mongod mongod     5 Nov 28 13:02 mongod.lock
-rw------- 1 mongod mongod 36864 Nov 28 13:08 sizeStorer.wt
-rw------- 1 mongod mongod   114 Nov 28 11:51 storage.bson
-rw------- 1 mongod mongod    50 Nov 28 11:51 WiredTiger
-rw------- 1 mongod mongod  4096 Nov 28 13:02 WiredTigerHS.wt
-rw------- 1 mongod mongod    21 Nov 28 11:51 WiredTiger.lock
-rw------- 1 mongod mongod  1472 Nov 28 13:11 WiredTiger.turtle
-rw------- 1 mongod mongod 86016 Nov 28 13:11 WiredTiger.wt
*/

-- Step 41.6 -->> On Node 1
[root@mongodb-config-01 mongodb]# ll | grep keyfile
/*
-r-------- 1 mongod mongod  1024 Nov 28 13:11 keyfile
*/

-- Step 41.7 -->> On Node 1 (Copy KeyFile file to each of servers under /data/mongodb/ with proper woner ship & permission)
[root@mongodb-config-01 mongodb]# scp -r keyfile root@mongodb-config-02.unidev39.org.np:/data/mongodb
/*
The authenticity of host 'mongodb-config-02.unidev39.org.np (192.168.6.23)' can't be established.
ECDSA key fingerprint is SHA256:lPltR+2btR1AjlrHyog4Y6FIxJNM6XHIEo8SOuHEW7I.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added 'mongodb-config-02.unidev39.org.np,192.168.6.23' (ECDSA) to the list of known hosts.
root@mongodb-config-02.unidev39.org.np's password:
keyfile                                                                                                                                                    100% 1024   731.9KB/s   00:00
*/

-- Step 41.8 -->> On Node 1
[root@mongodb-config-01 mongodb]# scp -r keyfile root@mongodb-config-03.unidev39.org.np:/data/mongodb
/*
The authenticity of host 'mongodb-config-03.unidev39.org.np (192.168.6.24)' can't be established.
ECDSA key fingerprint is SHA256:lPltR+2btR1AjlrHyog4Y6FIxJNM6XHIEo8SOuHEW7I.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added 'mongodb-config-03.unidev39.org.np,192.168.6.24' (ECDSA) to the list of known hosts.
root@mongodb-config-03.unidev39.org.np's password:
keyfile                                                                                                                                                    100% 1024   911.1KB/s   00:00
*/

-- Step 41.9 -->> On Node 1
[root@mongodb-config-01 mongodb]# scp -r keyfile root@mongodb-mongos.unidev39.org.np:/data/mongodb
/*
The authenticity of host 'mongodb-mongos.unidev39.org.np (192.168.6.21)' can't be established.
ECDSA key fingerprint is SHA256:lPltR+2btR1AjlrHyog4Y6FIxJNM6XHIEo8SOuHEW7I.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added 'mongodb-mongos.unidev39.org.np,192.168.6.21' (ECDSA) to the list of known hosts.
root@mongodb-mongos.unidev39.org.np's password:
keyfile                                                                                                                                                    100% 1024   849.3KB/s   00:00
*/

-- Step 41.10 -->> On Node 1
[root@mongodb-config-01 mongodb]# scp -r keyfile root@mongodb-shard-01.unidev39.org.np:/data/mongodb
/*
The authenticity of host 'mongodb-shard-01.unidev39.org.np (192.168.6.25)' can't be established.
ECDSA key fingerprint is SHA256:lPltR+2btR1AjlrHyog4Y6FIxJNM6XHIEo8SOuHEW7I.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added 'mongodb-shard-01.unidev39.org.np,192.168.6.25' (ECDSA) to the list of known hosts.
root@mongodb-shard-01.unidev39.org.np's password:
keyfile                                                                                                                                                    100% 1024   879.9KB/s   00:00
*/

-- Step 41.11 -->> On Node 1
[root@mongodb-config-01 mongodb]# scp -r keyfile root@mongodb-shard-02.unidev39.org.np:/data/mongodb
/*
The authenticity of host 'mongodb-shard-02.unidev39.org.np (192.168.6.26)' can't be established.
ECDSA key fingerprint is SHA256:lPltR+2btR1AjlrHyog4Y6FIxJNM6XHIEo8SOuHEW7I.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added 'mongodb-shard-02.unidev39.org.np,192.168.6.26' (ECDSA) to the list of known hosts.
root@mongodb-shard-02.unidev39.org.np's password:
keyfile                                                                                                                                                    100% 1024   772.3KB/s   00:00
*/

-- Step 41.12 -->> On Node 1
[root@mongodb-config-01 mongodb]# scp -r keyfile root@mongodb-shard-03.unidev39.org.np:/data/mongodb
/*
The authenticity of host 'mongodb-shard-03.unidev39.org.np (192.168.6.27)' can't be established.
ECDSA key fingerprint is SHA256:lPltR+2btR1AjlrHyog4Y6FIxJNM6XHIEo8SOuHEW7I.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added 'mongodb-shard-03.unidev39.org.np,192.168.6.27' (ECDSA) to the list of known hosts.
root@mongodb-shard-03.unidev39.org.np's password:
keyfile                                                                                                                                                    100% 1024   777.4KB/s   00:00
*/

-- Step 41.13 -->> On Node 1
[root@mongodb-config-01 mongodb]# scp -r keyfile root@mongodb-shard-04.unidev39.org.np:/data/mongodb
/*
The authenticity of host 'mongodb-shard-04.unidev39.org.np (192.168.6.28)' can't be established.
ECDSA key fingerprint is SHA256:lPltR+2btR1AjlrHyog4Y6FIxJNM6XHIEo8SOuHEW7I.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added 'mongodb-shard-04.unidev39.org.np,192.168.6.28' (ECDSA) to the list of known hosts.
root@mongodb-shard-04.unidev39.org.np's password:
keyfile                                                                                                                                                    100% 1024   828.2KB/s   00:00
*/

-- Step 41.14 -->> On Node 1
[root@mongodb-config-01 mongodb]# scp -r keyfile root@mongodb-shard-05.unidev39.org.np:/data/mongodb
/*
The authenticity of host 'mongodb-shard-05.unidev39.org.np (192.168.6.29)' can't be established.
ECDSA key fingerprint is SHA256:lPltR+2btR1AjlrHyog4Y6FIxJNM6XHIEo8SOuHEW7I.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added 'mongodb-shard-05.unidev39.org.np,192.168.6.29' (ECDSA) to the list of known hosts.
root@mongodb-shard-05.unidev39.org.np's password:
keyfile                                                                                                                                                    100% 1024   718.3KB/s   00:00
*/

-- Step 41.15 -->> On Node 1
[root@mongodb-config-01 mongodb]# scp -r keyfile root@mongodb-shard-06.unidev39.org.np:/data/mongodb
/*
The authenticity of host 'mongodb-shard-06.unidev39.org.np (192.168.6.30)' can't be established.
ECDSA key fingerprint is SHA256:lPltR+2btR1AjlrHyog4Y6FIxJNM6XHIEo8SOuHEW7I.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added 'mongodb-shard-06.unidev39.org.np,192.168.6.30' (ECDSA) to the list of known hosts.
root@mongodb-shard-06.unidev39.org.np's password:
keyfile                                                                                                                                                    100% 1024   969.7KB/s   00:00
*/


-- Step 41.16 -->> On All Nodes Except Node 1
[root@@mongodb-<<nodes>>-2-3-4-5-6-7-8-9-10 ~]# cd /data/mongodb/
-- Step 41.17 -->> On All Nodes Except Node 1
[root@@mongodb-<<nodes>>-2-3-4-5-6-7-8-9-10 mongodb]# ll | grep keyfile
/*
-r-------- 1 root   root    1024 Nov 28 13:21 keyfile
*/

-- Step 41.18 -->> On All Nodes Except Node 1
[root@@mongodb-<<nodes>>-2-3-4-5-6-7-8-9-10 mongodb]# chmod 400 keyfile
-- Step 41.19 -->> On All Nodes Except Node 1
[root@@mongodb-<<nodes>>-2-3-4-5-6-7-8-9-10 mongodb]# chown mongod:mongod keyfile
-- Step 41.20 -->> On All Nodes Except Node 1
[root@@mongodb-<<nodes>>-2-3-4-5-6-7-8-9-10 mongodb]# ll | grep keyfile
/*
-r-------- 1 mongod mongod  1024 Nov 28 13:22 keyfile
*/

-- Step 42 -->> On All Nodes
[root@mongodb-<<nodes>>-1-2-3-4-5-6-7-8-9-10 ~]# vi /etc/mongod.conf
/*
#security:
security:
 authorization: enabled
 keyFile: /data/mongodb/keyfile
*/

-- Step 43 -->> On All Nodes
[root@mongodb-<<nodes>>-1-2-3-4-5-6-7-8-9-10 ~]# systemctl restart mongod
-- Step 44 -->> On All Nodes
[root@mongodb-<<nodes>>-1-2-3-4-5-6-7-8-9-10 ~]# systemctl status mongod
/*
● mongod.service - MongoDB Database Server
   Loaded: loaded (/usr/lib/systemd/system/mongod.service; enabled; vendor preset: disabled)
   Active: active (running) since Tue 2023-11-28 14:26:28 +0545; 14s ago
     Docs: https://docs.mongodb.org/manual
 Main PID: 9126 (mongod)
   Memory: 159.9M
   CGroup: /system.slice/mongod.service
           └─9126 /usr/bin/mongod -f /etc/mongod.conf

Nov 28 14:26:28 mongodb-config-01.unidev39.org.np systemd[1]: Started MongoDB Database Server.
Nov 28 14:26:28 mongodb-config-01.unidev39.org.np mongod[9126]: {"t":{"$date":"2023-11-28T08:41:2>
*/

-- Step 45 -->> On Node 1 (Set Up Config Servers Replica Set)
[root@mongodb-config-01 ~]# vi /etc/mongod.conf
/*
# network interfaces
net:
  port: 27019
  bindIp: 127.0.0.1,mongodb-config-01.unidev39.org.np  # Enter 0.0.0.0,:: to bind to all IPv4 and IPv6 addresses or, alternatively, use the net.bindIpAll setting.
  maxIncomingConnections: 999999

#security:
security:
 authorization: enabled
 keyFile: /data/mongodb/keyfile

#operationProfiling:

#replication:
replication:
 replSetName: configReplSet

#sharding:
sharding:
 clusterRole: configsvr
*/

-- Step 46 -->> On Node 2 (Set Up Config Servers Replica Set)
[root@mongodb-config-02 ~]# vi /etc/mongod.conf
/*
# network interfaces
net:
  port: 27019
  bindIp: 127.0.0.1,mongodb-config-02.unidev39.org.np  # Enter 0.0.0.0,:: to bind to all IPv4 and IPv6 addresses or, alternatively, use the net.bindIpAll setting.
  maxIncomingConnections: 999999


#security:
security:
 authorization: enabled
 keyFile: /data/mongodb/keyfile

#operationProfiling:

#replication:
replication:
 replSetName: configReplSet

#sharding:
sharding:
 clusterRole: configsvr
*/

-- Step 47 -->> On Node 3 (Set Up Config Servers Replica Set)
[root@mongodb-config-03 ~]# vi /etc/mongod.conf
/*
# network interfaces
net:
  port: 27019
  bindIp: 127.0.0.1,mongodb-config-03.unidev39.org.np  # Enter 0.0.0.0,:: to bind to all IPv4 and IPv6 addresses or, alternatively, use the net.bindIpAll setting.
  maxIncomingConnections: 999999

#security:
security:
 authorization: enabled
 keyFile: /data/mongodb/keyfile

#operationProfiling:

#replication:
replication:
 replSetName: configReplSet

#sharding:
sharding:
 clusterRole: configsvr
*/

-- Step 48 -->> On Node 1
[root@mongodb-config-01 ~]# systemctl restart mongod
-- Step 48.1 -->> On Node 1
[root@mongodb-config-01 ~]# systemctl status mongod
/*
● mongod.service - MongoDB Database Server
   Loaded: loaded (/usr/lib/systemd/system/mongod.service; enabled; vendor preset: disabled)
   Active: active (running) since Tue 2023-11-28 14:39:31 +0545; 6s ago
     Docs: https://docs.mongodb.org/manual
 Main PID: 9653 (mongod)
   Memory: 172.3M
   CGroup: /system.slice/mongod.service
           └─9653 /usr/bin/mongod -f /etc/mongod.conf

Nov 28 14:39:31 mongodb-config-01.unidev39.org.np systemd[1]: Started MongoDB Database Server.
Nov 28 14:39:31 mongodb-config-01.unidev39.org.np mongod[9653]: {"t":{"$date":"2023-11-28T08:54:31.624Z"},"s":"I",  "c":"CONTROL",  "id":7484500, "ctx":"main","msg":"Environment variable M>
*/

-- Step 49 -->> On Node 2
[root@mongodb-config-02 ~]# systemctl restart mongod
-- Step 49.1 -->> On Node 2
[root@mongodb-config-02 ~]# systemctl status mongod
/*
● mongod.service - MongoDB Database Server
   Loaded: loaded (/usr/lib/systemd/system/mongod.service; enabled; vendor preset: disabled)
   Active: active (running) since Tue 2023-11-28 14:41:23 +0545; 5s ago
     Docs: https://docs.mongodb.org/manual
 Main PID: 9743 (mongod)
   Memory: 176.7M
   CGroup: /system.slice/mongod.service
           └─9743 /usr/bin/mongod -f /etc/mongod.conf

Nov 28 14:41:23 mongodb-config-02.unidev39.org.np systemd[1]: Started MongoDB Database Server.
Nov 28 14:41:23 mongodb-config-02.unidev39.org.np mongod[9743]: {"t":{"$date":"2023-11-28T08:56:23.517Z"},"s":"I",  "c":"CONTROL",  "id":7484500, "ctx":"main","msg":"Environment variable M>
*/

-- Step 50 -->> On Node 3
[root@mongodb-config-03 ~]# systemctl restart mongod
-- Step 50.1 -->> On Node 3
[root@mongodb-config-03 ~]# systemctl status mongod
/*
● mongod.service - MongoDB Database Server
   Loaded: loaded (/usr/lib/systemd/system/mongod.service; enabled; vendor preset: disabled)
   Active: active (running) since Tue 2023-11-28 14:42:46 +0545; 4s ago
     Docs: https://docs.mongodb.org/manual
 Main PID: 9750 (mongod)
   Memory: 173.1M
   CGroup: /system.slice/mongod.service
           └─9750 /usr/bin/mongod -f /etc/mongod.conf

Nov 28 14:42:46 mongodb-config-03.unidev39.org.np systemd[1]: Started MongoDB Database Server.
Nov 28 14:42:46 mongodb-config-03.unidev39.org.np mongod[9750]: {"t":{"$date":"2023-11-28T08:57:46.493Z"},"s":"I",  "c":"CONTROL",  "id":7484500, "ctx":"main","msg":"Environment variable M>
*/

-- Step 51 -->> On Node 1 (Initiate the Config Replica Sets)
[mongodb@mongodb-config-01 ~]$ mongo --host mongodb-config-01.unidev39.org.np --port 27019 -u admin -p P#ssw0rd --authenticationDatabase admin
/*
MongoDB shell version v4.4.26
connecting to: mongodb://mongodb-config-01.unidev39.org.np:27019/?authSource=admin&compressors=disabled&gssapiServiceName=mongodb
Implicit session: session { "id" : UUID("8dc5d931-891d-4816-acf9-f559d47fe34b") }
MongoDB server version: 4.4.26
> db.version()
4.4.26

> use admin
switched to db admin

> db
admin

rs.initiate({
  _id: "configReplSet",
  configsvr: true,
  members: [
    { _id: 0, host: "mongodb-config-01.unidev39.org.np:27019" },
    { _id: 1, host: "mongodb-config-02.unidev39.org.np:27019" },
    { _id: 2, host: "mongodb-config-03.unidev39.org.np:27019" }
  ]
})

{
        "ok" : 1,
        "$gleStats" : {
                "lastOpTime" : Timestamp(1701162226, 1),
                "electionId" : ObjectId("000000000000000000000000")
        },
        "lastCommittedOpTime" : Timestamp(0, 0)
}

configReplSet:PRIMARY> rs.config()
{
        "_id" : "configReplSet",
        "version" : 1,
        "term" : 1,
        "configsvr" : true,
        "protocolVersion" : NumberLong(1),
        "writeConcernMajorityJournalDefault" : true,
        "members" : [
                {
                        "_id" : 0,
                        "host" : "mongodb-config-01.unidev39.org.np:27019",
                        "arbiterOnly" : false,
                        "buildIndexes" : true,
                        "hidden" : false,
                        "priority" : 1,
                        "tags" : {

                        },
                        "slaveDelay" : NumberLong(0),
                        "votes" : 1
                },
                {
                        "_id" : 1,
                        "host" : "mongodb-config-02.unidev39.org.np:27019",
                        "arbiterOnly" : false,
                        "buildIndexes" : true,
                        "hidden" : false,
                        "priority" : 1,
                        "tags" : {

                        },
                        "slaveDelay" : NumberLong(0),
                        "votes" : 1
                },
                {
                        "_id" : 2,
                        "host" : "mongodb-config-03.unidev39.org.np:27019",
                        "arbiterOnly" : false,
                        "buildIndexes" : true,
                        "hidden" : false,
                        "priority" : 1,
                        "tags" : {

                        },
                        "slaveDelay" : NumberLong(0),
                        "votes" : 1
                }
        ],
        "settings" : {
                "chainingAllowed" : true,
                "heartbeatIntervalMillis" : 2000,
                "heartbeatTimeoutSecs" : 10,
                "electionTimeoutMillis" : 10000,
                "catchUpTimeoutMillis" : -1,
                "catchUpTakeoverDelayMillis" : 30000,
                "getLastErrorModes" : {

                },
                "getLastErrorDefaults" : {
                        "w" : 1,
                        "wtimeout" : 0
                },
                "replicaSetId" : ObjectId("6565acf23d284c39f0993f44")
        }
}

configReplSet:PRIMARY> rs.status()
{
        "set" : "configReplSet",
        "date" : ISODate("2023-11-28T09:06:53.863Z"),
        "myState" : 1,
        "term" : NumberLong(1),
        "syncSourceHost" : "",
        "syncSourceId" : -1,
        "configsvr" : true,
        "heartbeatIntervalMillis" : NumberLong(2000),
        "majorityVoteCount" : 2,
        "writeMajorityCount" : 2,
        "votingMembersCount" : 3,
        "writableVotingMembersCount" : 3,
        "optimes" : {
                "lastCommittedOpTime" : {
                        "ts" : Timestamp(1701162413, 1),
                        "t" : NumberLong(1)
                },
                "lastCommittedWallTime" : ISODate("2023-11-28T09:06:53.557Z"),
                "readConcernMajorityOpTime" : {
                        "ts" : Timestamp(1701162413, 1),
                        "t" : NumberLong(1)
                },
                "readConcernMajorityWallTime" : ISODate("2023-11-28T09:06:53.557Z"),
                "appliedOpTime" : {
                        "ts" : Timestamp(1701162413, 1),
                        "t" : NumberLong(1)
                },
                "durableOpTime" : {
                        "ts" : Timestamp(1701162413, 1),
                        "t" : NumberLong(1)
                },
                "lastAppliedWallTime" : ISODate("2023-11-28T09:06:53.557Z"),
                "lastDurableWallTime" : ISODate("2023-11-28T09:06:53.557Z")
        },
        "lastStableRecoveryTimestamp" : Timestamp(1701162357, 1),
        "electionCandidateMetrics" : {
                "lastElectionReason" : "electionTimeout",
                "lastElectionDate" : ISODate("2023-11-28T09:03:57.364Z"),
                "electionTerm" : NumberLong(1),
                "lastCommittedOpTimeAtElection" : {
                        "ts" : Timestamp(0, 0),
                        "t" : NumberLong(-1)
                },
                "lastSeenOpTimeAtElection" : {
                        "ts" : Timestamp(1701162226, 1),
                        "t" : NumberLong(-1)
                },
                "numVotesNeeded" : 2,
                "priorityAtElection" : 1,
                "electionTimeoutMillis" : NumberLong(10000),
                "numCatchUpOps" : NumberLong(0),
                "newTermStartDate" : ISODate("2023-11-28T09:03:57.391Z"),
                "wMajorityWriteAvailabilityDate" : ISODate("2023-11-28T09:03:58.048Z")
        },
        "members" : [
                {
                        "_id" : 0,
                        "name" : "mongodb-config-01.unidev39.org.np:27019",
                        "health" : 1,
                        "state" : 1,
                        "stateStr" : "PRIMARY",
                        "uptime" : 742,
                        "optime" : {
                                "ts" : Timestamp(1701162413, 1),
                                "t" : NumberLong(1)
                        },
                        "optimeDate" : ISODate("2023-11-28T09:06:53Z"),
                        "lastAppliedWallTime" : ISODate("2023-11-28T09:06:53.557Z"),
                        "lastDurableWallTime" : ISODate("2023-11-28T09:06:53.557Z"),
                        "syncSourceHost" : "",
                        "syncSourceId" : -1,
                        "infoMessage" : "",
                        "electionTime" : Timestamp(1701162237, 1),
                        "electionDate" : ISODate("2023-11-28T09:03:57Z"),
                        "configVersion" : 1,
                        "configTerm" : 1,
                        "self" : true,
                        "lastHeartbeatMessage" : ""
                },
                {
                        "_id" : 1,
                        "name" : "mongodb-config-02.unidev39.org.np:27019",
                        "health" : 1,
                        "state" : 2,
                        "stateStr" : "SECONDARY",
                        "uptime" : 187,
                        "optime" : {
                                "ts" : Timestamp(1701162412, 1),
                                "t" : NumberLong(1)
                        },
                        "optimeDurable" : {
                                "ts" : Timestamp(1701162412, 1),
                                "t" : NumberLong(1)
                        },
                        "optimeDate" : ISODate("2023-11-28T09:06:52Z"),
                        "optimeDurableDate" : ISODate("2023-11-28T09:06:52Z"),
                        "lastAppliedWallTime" : ISODate("2023-11-28T09:06:53.557Z"),
                        "lastDurableWallTime" : ISODate("2023-11-28T09:06:53.557Z"),
                        "lastHeartbeat" : ISODate("2023-11-28T09:06:53.453Z"),
                        "lastHeartbeatRecv" : ISODate("2023-11-28T09:06:52.456Z"),
                        "pingMs" : NumberLong(0),
                        "lastHeartbeatMessage" : "",
                        "syncSourceHost" : "mongodb-config-01.unidev39.org.np:27019",
                        "syncSourceId" : 0,
                        "infoMessage" : "",
                        "configVersion" : 1,
                        "configTerm" : 1
                },
                {
                        "_id" : 2,
                        "name" : "mongodb-config-03.unidev39.org.np:27019",
                        "health" : 1,
                        "state" : 2,
                        "stateStr" : "SECONDARY",
                        "uptime" : 187,
                        "optime" : {
                                "ts" : Timestamp(1701162412, 1),
                                "t" : NumberLong(1)
                        },
                        "optimeDurable" : {
                                "ts" : Timestamp(1701162412, 1),
                                "t" : NumberLong(1)
                        },
                        "optimeDate" : ISODate("2023-11-28T09:06:52Z"),
                        "optimeDurableDate" : ISODate("2023-11-28T09:06:52Z"),
                        "lastAppliedWallTime" : ISODate("2023-11-28T09:06:53.557Z"),
                        "lastDurableWallTime" : ISODate("2023-11-28T09:06:53.557Z"),
                        "lastHeartbeat" : ISODate("2023-11-28T09:06:53.444Z"),
                        "lastHeartbeatRecv" : ISODate("2023-11-28T09:06:52.453Z"),
                        "pingMs" : NumberLong(0),
                        "lastHeartbeatMessage" : "",
                        "syncSourceHost" : "mongodb-config-01.unidev39.org.np:27019",
                        "syncSourceId" : 0,
                        "infoMessage" : "",
                        "configVersion" : 1,
                        "configTerm" : 1
                }
        ],
        "ok" : 1,
        "$gleStats" : {
                "lastOpTime" : Timestamp(1701162226, 1),
                "electionId" : ObjectId("7fffffff0000000000000001")
        },
        "lastCommittedOpTime" : Timestamp(1701162413, 1),
        "$clusterTime" : {
                "clusterTime" : Timestamp(1701162413, 1),
                "signature" : {
                        "hash" : BinData(0,"3FzAJtVFX8bD5PekyYeSzqIFUlA="),
                        "keyId" : NumberLong("7306436173105201174")
                }
        },
        "operationTime" : Timestamp(1701162413, 1)
}

configReplSet:PRIMARY> rs.isMaster()
{
        "topologyVersion" : {
                "processId" : ObjectId("6565aac73d284c39f0993f11"),
                "counter" : NumberLong(6)
        },
        "hosts" : [
                "mongodb-config-01.unidev39.org.np:27019",
                "mongodb-config-02.unidev39.org.np:27019",
                "mongodb-config-03.unidev39.org.np:27019"
        ],
        "setName" : "configReplSet",
        "setVersion" : 1,
        "ismaster" : true,
        "secondary" : false,
        "primary" : "mongodb-config-01.unidev39.org.np:27019",
        "me" : "mongodb-config-01.unidev39.org.np:27019",
        "electionId" : ObjectId("7fffffff0000000000000001"),
        "lastWrite" : {
                "opTime" : {
                        "ts" : Timestamp(1701163151, 1),
                        "t" : NumberLong(1)
                },
                "lastWriteDate" : ISODate("2023-11-28T09:19:11Z"),
                "majorityOpTime" : {
                        "ts" : Timestamp(1701163151, 1),
                        "t" : NumberLong(1)
                },
                "majorityWriteDate" : ISODate("2023-11-28T09:19:11Z")
        },
        "configsvr" : 2,
        "maxBsonObjectSize" : 16777216,
        "maxMessageSizeBytes" : 48000000,
        "maxWriteBatchSize" : 100000,
        "localTime" : ISODate("2023-11-28T09:19:12.378Z"),
        "logicalSessionTimeoutMinutes" : 30,
        "connectionId" : 27,
        "minWireVersion" : 0,
        "maxWireVersion" : 9,
        "readOnly" : false,
        "ok" : 1,
        "$gleStats" : {
                "lastOpTime" : Timestamp(0, 0),
                "electionId" : ObjectId("7fffffff0000000000000001")
        },
        "lastCommittedOpTime" : Timestamp(1701163151, 1),
        "$clusterTime" : {
                "clusterTime" : Timestamp(1701163151, 1),
                "signature" : {
                        "hash" : BinData(0,"eNdU6UcFkNTrr+vG++KmQENX+Fo="),
                        "keyId" : NumberLong("7306436173105201174")
                }
        },
        "operationTime" : Timestamp(1701163151, 1)
}

configReplSet:PRIMARY> rs.printSecondaryReplicationInfo()
source: mongodb-config-02.unidev39.org.np:27019
        syncedTo: Tue Nov 28 2023 15:04:16 GMT+0545 (+0545)
        2 secs (0 hrs) behind the primary
source: mongodb-config-03.unidev39.org.np:27019
        syncedTo: Tue Nov 28 2023 15:04:16 GMT+0545 (+0545)
        2 secs (0 hrs) behind the primary

configReplSet:PRIMARY> quit()
*/

-- Step 52 -->> On Node 1
[root@mongodb-config-01 ~]# mongo --host mongodb-config-01.unidev39.org.np --port 27019 -u admin -p P#ssw0rd --authenticationDatabase admin
/*
MongoDB shell version v4.4.26
connecting to: mongodb://mongodb-config-01.unidev39.org.np:27019/?authSource=admin&compressors=disabled&gssapiServiceName=mongodb
Implicit session: session { "id" : UUID("1fe85776-c054-4adb-86a4-c56fe085bd7f") }
MongoDB server version: 4.4.26

configReplSet:PRIMARY> db.version()
4.4.26

configReplSet:PRIMARY> show dbs
admin   0.000GB
config  0.000GB
local   0.000GB

configReplSet:PRIMARY> use admin
switched to db admin

configReplSet:PRIMARY> db.getUsers()
[
        {
                "_id" : "admin.admin",
                "userId" : UUID("83b59d6e-141a-4c8a-940f-a9983532ec30"),
                "user" : "admin",
                "db" : "admin",
                "roles" : [
                        {
                                "role" : "userAdminAnyDatabase",
                                "db" : "admin"
                        },
                        {
                                "role" : "clusterAdmin",
                                "db" : "admin"
                        },
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

configReplSet:PRIMARY> quit()
*/

-- Step 53 -->> On Node 2 (Verify each config server has been added the replica sets)
[root@mongodb-config-02 ~]# mongo --host mongodb-config-02.unidev39.org.np --port 27019 -u admin -p P#ssw0rd --authenticationDatabase admin
/*
MongoDB shell version v4.4.26
connecting to: mongodb://mongodb-config-02.unidev39.org.np:27019/?authSource=admin&compressors=disabled&gssapiServiceName=mongodb
Implicit session: session { "id" : UUID("dc84aa28-4cc3-415a-ae98-fb4833cb44d2") }
MongoDB server version: 4.4.26

configReplSet:SECONDARY> db.version()
4.4.26

configReplSet:SECONDARY> rs.config()
{
        "_id" : "configReplSet",
        "version" : 1,
        "term" : 1,
        "configsvr" : true,
        "protocolVersion" : NumberLong(1),
        "writeConcernMajorityJournalDefault" : true,
        "members" : [
                {
                        "_id" : 0,
                        "host" : "mongodb-config-01.unidev39.org.np:27019",
                        "arbiterOnly" : false,
                        "buildIndexes" : true,
                        "hidden" : false,
                        "priority" : 1,
                        "tags" : {

                        },
                        "slaveDelay" : NumberLong(0),
                        "votes" : 1
                },
                {
                        "_id" : 1,
                        "host" : "mongodb-config-02.unidev39.org.np:27019",
                        "arbiterOnly" : false,
                        "buildIndexes" : true,
                        "hidden" : false,
                        "priority" : 1,
                        "tags" : {

                        },
                        "slaveDelay" : NumberLong(0),
                        "votes" : 1
                },
                {
                        "_id" : 2,
                        "host" : "mongodb-config-03.unidev39.org.np:27019",
                        "arbiterOnly" : false,
                        "buildIndexes" : true,
                        "hidden" : false,
                        "priority" : 1,
                        "tags" : {

                        },
                        "slaveDelay" : NumberLong(0),
                        "votes" : 1
                }
        ],
        "settings" : {
                "chainingAllowed" : true,
                "heartbeatIntervalMillis" : 2000,
                "heartbeatTimeoutSecs" : 10,
                "electionTimeoutMillis" : 10000,
                "catchUpTimeoutMillis" : -1,
                "catchUpTakeoverDelayMillis" : 30000,
                "getLastErrorModes" : {

                },
                "getLastErrorDefaults" : {
                        "w" : 1,
                        "wtimeout" : 0
                },
                "replicaSetId" : ObjectId("6565acf23d284c39f0993f44")
        }
}

configReplSet:SECONDARY> rs.status()
{
        "set" : "configReplSet",
        "date" : ISODate("2023-11-28T09:14:36.336Z"),
        "myState" : 2,
        "term" : NumberLong(1),
        "syncSourceHost" : "mongodb-config-01.unidev39.org.np:27019",
        "syncSourceId" : 0,
        "configsvr" : true,
        "heartbeatIntervalMillis" : NumberLong(2000),
        "majorityVoteCount" : 2,
        "writeMajorityCount" : 2,
        "votingMembersCount" : 3,
        "writableVotingMembersCount" : 3,
        "optimes" : {
                "lastCommittedOpTime" : {
                        "ts" : Timestamp(1701162875, 1),
                        "t" : NumberLong(1)
                },
                "lastCommittedWallTime" : ISODate("2023-11-28T09:14:35.703Z"),
                "readConcernMajorityOpTime" : {
                        "ts" : Timestamp(1701162875, 1),
                        "t" : NumberLong(1)
                },
                "readConcernMajorityWallTime" : ISODate("2023-11-28T09:14:35.703Z"),
                "appliedOpTime" : {
                        "ts" : Timestamp(1701162875, 1),
                        "t" : NumberLong(1)
                },
                "durableOpTime" : {
                        "ts" : Timestamp(1701162875, 1),
                        "t" : NumberLong(1)
                },
                "lastAppliedWallTime" : ISODate("2023-11-28T09:14:35.703Z"),
                "lastDurableWallTime" : ISODate("2023-11-28T09:14:35.703Z")
        },
        "lastStableRecoveryTimestamp" : Timestamp(1701162837, 1),
        "electionParticipantMetrics" : {
                "votedForCandidate" : true,
                "electionTerm" : NumberLong(1),
                "lastVoteDate" : ISODate("2023-11-28T09:03:57.366Z"),
                "electionCandidateMemberId" : 0,
                "voteReason" : "",
                "lastAppliedOpTimeAtElection" : {
                        "ts" : Timestamp(1701162226, 1),
                        "t" : NumberLong(-1)
                },
                "maxAppliedOpTimeInSet" : {
                        "ts" : Timestamp(1701162226, 1),
                        "t" : NumberLong(-1)
                },
                "priorityAtElection" : 1,
                "newTermStartDate" : ISODate("2023-11-28T09:03:57.391Z"),
                "newTermAppliedDate" : ISODate("2023-11-28T09:03:58.058Z")
        },
        "members" : [
                {
                        "_id" : 0,
                        "name" : "mongodb-config-01.unidev39.org.np:27019",
                        "health" : 1,
                        "state" : 1,
                        "stateStr" : "PRIMARY",
                        "uptime" : 649,
                        "optime" : {
                                "ts" : Timestamp(1701162873, 1),
                                "t" : NumberLong(1)
                        },
                        "optimeDurable" : {
                                "ts" : Timestamp(1701162873, 1),
                                "t" : NumberLong(1)
                        },
                        "optimeDate" : ISODate("2023-11-28T09:14:33Z"),
                        "optimeDurableDate" : ISODate("2023-11-28T09:14:33Z"),
                        "lastAppliedWallTime" : ISODate("2023-11-28T09:14:33.411Z"),
                        "lastDurableWallTime" : ISODate("2023-11-28T09:14:33.411Z"),
                        "lastHeartbeat" : ISODate("2023-11-28T09:14:34.641Z"),
                        "lastHeartbeatRecv" : ISODate("2023-11-28T09:14:35.635Z"),
                        "pingMs" : NumberLong(0),
                        "lastHeartbeatMessage" : "",
                        "syncSourceHost" : "",
                        "syncSourceId" : -1,
                        "infoMessage" : "",
                        "electionTime" : Timestamp(1701162237, 1),
                        "electionDate" : ISODate("2023-11-28T09:03:57Z"),
                        "configVersion" : 1,
                        "configTerm" : 1
                },
                {
                        "_id" : 1,
                        "name" : "mongodb-config-02.unidev39.org.np:27019",
                        "health" : 1,
                        "state" : 2,
                        "stateStr" : "SECONDARY",
                        "uptime" : 1093,
                        "optime" : {
                                "ts" : Timestamp(1701162875, 1),
                                "t" : NumberLong(1)
                        },
                        "optimeDate" : ISODate("2023-11-28T09:14:35Z"),
                        "lastAppliedWallTime" : ISODate("2023-11-28T09:14:35.703Z"),
                        "lastDurableWallTime" : ISODate("2023-11-28T09:14:35.703Z"),
                        "syncSourceHost" : "mongodb-config-01.unidev39.org.np:27019",
                        "syncSourceId" : 0,
                        "infoMessage" : "",
                        "configVersion" : 1,
                        "configTerm" : 1,
                        "self" : true,
                        "lastHeartbeatMessage" : ""
                },
                {
                        "_id" : 2,
                        "name" : "mongodb-config-03.unidev39.org.np:27019",
                        "health" : 1,
                        "state" : 2,
                        "stateStr" : "SECONDARY",
                        "uptime" : 649,
                        "optime" : {
                                "ts" : Timestamp(1701162873, 1),
                                "t" : NumberLong(1)
                        },
                        "optimeDurable" : {
                                "ts" : Timestamp(1701162873, 1),
                                "t" : NumberLong(1)
                        },
                        "optimeDate" : ISODate("2023-11-28T09:14:33Z"),
                        "optimeDurableDate" : ISODate("2023-11-28T09:14:33Z"),
                        "lastAppliedWallTime" : ISODate("2023-11-28T09:14:33.411Z"),
                        "lastDurableWallTime" : ISODate("2023-11-28T09:14:33.411Z"),
                        "lastHeartbeat" : ISODate("2023-11-28T09:14:34.642Z"),
                        "lastHeartbeatRecv" : ISODate("2023-11-28T09:14:34.641Z"),
                        "pingMs" : NumberLong(0),
                        "lastHeartbeatMessage" : "",
                        "syncSourceHost" : "mongodb-config-01.unidev39.org.np:27019",
                        "syncSourceId" : 0,
                        "infoMessage" : "",
                        "configVersion" : 1,
                        "configTerm" : 1
                }
        ],
        "ok" : 1,
        "$gleStats" : {
                "lastOpTime" : Timestamp(0, 0),
                "electionId" : ObjectId("000000000000000000000000")
        },
        "lastCommittedOpTime" : Timestamp(1701162875, 1),
        "$clusterTime" : {
                "clusterTime" : Timestamp(1701162875, 1),
                "signature" : {
                        "hash" : BinData(0,"xCPZvv6aMDz3++tT70fZfvBHG/c="),
                        "keyId" : NumberLong("7306436173105201174")
                }
        },
        "operationTime" : Timestamp(1701162875, 1)
}

configReplSet:SECONDARY> rs.isMaster()
{
        "topologyVersion" : {
                "processId" : ObjectId("6565ab37a984fd8ab32255aa"),
                "counter" : NumberLong(4)
        },
        "hosts" : [
                "mongodb-config-01.unidev39.org.np:27019",
                "mongodb-config-02.unidev39.org.np:27019",
                "mongodb-config-03.unidev39.org.np:27019"
        ],
        "setName" : "configReplSet",
        "setVersion" : 1,
        "ismaster" : false,
        "secondary" : true,
        "primary" : "mongodb-config-01.unidev39.org.np:27019",
        "me" : "mongodb-config-02.unidev39.org.np:27019",
        "lastWrite" : {
                "opTime" : {
                        "ts" : Timestamp(1701162919, 1),
                        "t" : NumberLong(1)
                },
                "lastWriteDate" : ISODate("2023-11-28T09:15:19Z"),
                "majorityOpTime" : {
                        "ts" : Timestamp(1701162919, 1),
                        "t" : NumberLong(1)
                },
                "majorityWriteDate" : ISODate("2023-11-28T09:15:19Z")
        },
        "configsvr" : 2,
        "maxBsonObjectSize" : 16777216,
        "maxMessageSizeBytes" : 48000000,
        "maxWriteBatchSize" : 100000,
        "localTime" : ISODate("2023-11-28T09:15:19.881Z"),
        "logicalSessionTimeoutMinutes" : 30,
        "connectionId" : 22,
        "minWireVersion" : 0,
        "maxWireVersion" : 9,
        "readOnly" : false,
        "ok" : 1,
        "$gleStats" : {
                "lastOpTime" : Timestamp(0, 0),
                "electionId" : ObjectId("000000000000000000000000")
        },
        "lastCommittedOpTime" : Timestamp(1701162919, 1),
        "$clusterTime" : {
                "clusterTime" : Timestamp(1701162919, 1),
                "signature" : {
                        "hash" : BinData(0,"PNEoJGhR9FLoYkKn6QyokT9hdB8="),
                        "keyId" : NumberLong("7306436173105201174")
                }
        },
        "operationTime" : Timestamp(1701162919, 1)
}

configReplSet:SECONDARY> rs.printSecondaryReplicationInfo()
source: mongodb-config-02.unidev39.org.np:27019
        syncedTo: Tue Nov 28 2023 15:02:59 GMT+0545 (+0545)
        -2 secs (0 hrs) behind the primary
source: mongodb-config-03.unidev39.org.np:27019
        syncedTo: Tue Nov 28 2023 15:02:57 GMT+0545 (+0545)
        0 secs (0 hrs) behind the primary

configReplSet:SECONDARY> quit()
*/

-- Step 54 -->> On Node 3 (Verify each config server has been added the replica sets)
[root@mongodb-config-03 ~]# mongo --host mongodb-config-03.unidev39.org.np --port 27019 -u admin -p P#ssw0rd --authenticationDatabase admin
/*
MongoDB shell version v4.4.26
connecting to: mongodb://mongodb-config-03.unidev39.org.np:27019/?authSource=admin&compressors=disabled&gssapiServiceName=mongodb
Implicit session: session { "id" : UUID("9464557a-fe7e-43ac-9b3d-dbc05ac5b087") }
MongoDB server version: 4.4.26

configReplSet:SECONDARY> db.version()
4.4.26

configReplSet:SECONDARY> rs.config()
{
        "_id" : "configReplSet",
        "version" : 1,
        "term" : 1,
        "configsvr" : true,
        "protocolVersion" : NumberLong(1),
        "writeConcernMajorityJournalDefault" : true,
        "members" : [
                {
                        "_id" : 0,
                        "host" : "mongodb-config-01.unidev39.org.np:27019",
                        "arbiterOnly" : false,
                        "buildIndexes" : true,
                        "hidden" : false,
                        "priority" : 1,
                        "tags" : {

                        },
                        "slaveDelay" : NumberLong(0),
                        "votes" : 1
                },
                {
                        "_id" : 1,
                        "host" : "mongodb-config-02.unidev39.org.np:27019",
                        "arbiterOnly" : false,
                        "buildIndexes" : true,
                        "hidden" : false,
                        "priority" : 1,
                        "tags" : {

                        },
                        "slaveDelay" : NumberLong(0),
                        "votes" : 1
                },
                {
                        "_id" : 2,
                        "host" : "mongodb-config-03.unidev39.org.np:27019",
                        "arbiterOnly" : false,
                        "buildIndexes" : true,
                        "hidden" : false,
                        "priority" : 1,
                        "tags" : {

                        },
                        "slaveDelay" : NumberLong(0),
                        "votes" : 1
                }
        ],
        "settings" : {
                "chainingAllowed" : true,
                "heartbeatIntervalMillis" : 2000,
                "heartbeatTimeoutSecs" : 10,
                "electionTimeoutMillis" : 10000,
                "catchUpTimeoutMillis" : -1,
                "catchUpTakeoverDelayMillis" : 30000,
                "getLastErrorModes" : {

                },
                "getLastErrorDefaults" : {
                        "w" : 1,
                        "wtimeout" : 0
                },
                "replicaSetId" : ObjectId("6565acf23d284c39f0993f44")
        }
}

configReplSet:SECONDARY> rs.status()
{
        "set" : "configReplSet",
        "date" : ISODate("2023-11-28T09:21:50.610Z"),
        "myState" : 2,
        "term" : NumberLong(1),
        "syncSourceHost" : "mongodb-config-01.unidev39.org.np:27019",
        "syncSourceId" : 0,
        "configsvr" : true,
        "heartbeatIntervalMillis" : NumberLong(2000),
        "majorityVoteCount" : 2,
        "writeMajorityCount" : 2,
        "votingMembersCount" : 3,
        "writableVotingMembersCount" : 3,
        "optimes" : {
                "lastCommittedOpTime" : {
                        "ts" : Timestamp(1701163309, 1),
                        "t" : NumberLong(1)
                },
                "lastCommittedWallTime" : ISODate("2023-11-28T09:21:49.837Z"),
                "readConcernMajorityOpTime" : {
                        "ts" : Timestamp(1701163309, 1),
                        "t" : NumberLong(1)
                },
                "readConcernMajorityWallTime" : ISODate("2023-11-28T09:21:49.837Z"),
                "appliedOpTime" : {
                        "ts" : Timestamp(1701163309, 1),
                        "t" : NumberLong(1)
                },
                "durableOpTime" : {
                        "ts" : Timestamp(1701163309, 1),
                        "t" : NumberLong(1)
                },
                "lastAppliedWallTime" : ISODate("2023-11-28T09:21:49.837Z"),
                "lastDurableWallTime" : ISODate("2023-11-28T09:21:49.837Z")
        },
        "lastStableRecoveryTimestamp" : Timestamp(1701163257, 1),
        "electionParticipantMetrics" : {
                "votedForCandidate" : true,
                "electionTerm" : NumberLong(1),
                "lastVoteDate" : ISODate("2023-11-28T09:03:57.366Z"),
                "electionCandidateMemberId" : 0,
                "voteReason" : "",
                "lastAppliedOpTimeAtElection" : {
                        "ts" : Timestamp(1701162226, 1),
                        "t" : NumberLong(-1)
                },
                "maxAppliedOpTimeInSet" : {
                        "ts" : Timestamp(1701162226, 1),
                        "t" : NumberLong(-1)
                },
                "priorityAtElection" : 1,
                "newTermStartDate" : ISODate("2023-11-28T09:03:57.391Z"),
                "newTermAppliedDate" : ISODate("2023-11-28T09:03:58.046Z")
        },
        "members" : [
                {
                        "_id" : 0,
                        "name" : "mongodb-config-01.unidev39.org.np:27019",
                        "health" : 1,
                        "state" : 1,
                        "stateStr" : "PRIMARY",
                        "uptime" : 1083,
                        "optime" : {
                                "ts" : Timestamp(1701163307, 1),
                                "t" : NumberLong(1)
                        },
                        "optimeDurable" : {
                                "ts" : Timestamp(1701163307, 1),
                                "t" : NumberLong(1)
                        },
                        "optimeDate" : ISODate("2023-11-28T09:21:47Z"),
                        "optimeDurableDate" : ISODate("2023-11-28T09:21:47Z"),
                        "lastAppliedWallTime" : ISODate("2023-11-28T09:21:47.837Z"),
                        "lastDurableWallTime" : ISODate("2023-11-28T09:21:47.837Z"),
                        "lastHeartbeat" : ISODate("2023-11-28T09:21:48.816Z"),
                        "lastHeartbeatRecv" : ISODate("2023-11-28T09:21:49.776Z"),
                        "pingMs" : NumberLong(0),
                        "lastHeartbeatMessage" : "",
                        "syncSourceHost" : "",
                        "syncSourceId" : -1,
                        "infoMessage" : "",
                        "electionTime" : Timestamp(1701162237, 1),
                        "electionDate" : ISODate("2023-11-28T09:03:57Z"),
                        "configVersion" : 1,
                        "configTerm" : 1
                },
                {
                        "_id" : 1,
                        "name" : "mongodb-config-02.unidev39.org.np:27019",
                        "health" : 1,
                        "state" : 2,
                        "stateStr" : "SECONDARY",
                        "uptime" : 1083,
                        "optime" : {
                                "ts" : Timestamp(1701163307, 1),
                                "t" : NumberLong(1)
                        },
                        "optimeDurable" : {
                                "ts" : Timestamp(1701163307, 1),
                                "t" : NumberLong(1)
                        },
                        "optimeDate" : ISODate("2023-11-28T09:21:47Z"),
                        "optimeDurableDate" : ISODate("2023-11-28T09:21:47Z"),
                        "lastAppliedWallTime" : ISODate("2023-11-28T09:21:47.837Z"),
                        "lastDurableWallTime" : ISODate("2023-11-28T09:21:47.837Z"),
                        "lastHeartbeat" : ISODate("2023-11-28T09:21:48.817Z"),
                        "lastHeartbeatRecv" : ISODate("2023-11-28T09:21:48.818Z"),
                        "pingMs" : NumberLong(0),
                        "lastHeartbeatMessage" : "",
                        "syncSourceHost" : "mongodb-config-01.unidev39.org.np:27019",
                        "syncSourceId" : 0,
                        "infoMessage" : "",
                        "configVersion" : 1,
                        "configTerm" : 1
                },
                {
                        "_id" : 2,
                        "name" : "mongodb-config-03.unidev39.org.np:27019",
                        "health" : 1,
                        "state" : 2,
                        "stateStr" : "SECONDARY",
                        "uptime" : 1444,
                        "optime" : {
                                "ts" : Timestamp(1701163309, 1),
                                "t" : NumberLong(1)
                        },
                        "optimeDate" : ISODate("2023-11-28T09:21:49Z"),
                        "lastAppliedWallTime" : ISODate("2023-11-28T09:21:49.837Z"),
                        "lastDurableWallTime" : ISODate("2023-11-28T09:21:49.837Z"),
                        "syncSourceHost" : "mongodb-config-01.unidev39.org.np:27019",
                        "syncSourceId" : 0,
                        "infoMessage" : "",
                        "configVersion" : 1,
                        "configTerm" : 1,
                        "self" : true,
                        "lastHeartbeatMessage" : ""
                }
        ],
        "ok" : 1,
        "$gleStats" : {
                "lastOpTime" : Timestamp(0, 0),
                "electionId" : ObjectId("000000000000000000000000")
        },
        "lastCommittedOpTime" : Timestamp(1701163309, 1),
        "$clusterTime" : {
                "clusterTime" : Timestamp(1701163309, 1),
                "signature" : {
                        "hash" : BinData(0,"W211fhfWuLz79Jj1/b0iE1I6EEs="),
                        "keyId" : NumberLong("7306436173105201174")
                }
        },
        "operationTime" : Timestamp(1701163309, 1)
}

configReplSet:SECONDARY> rs.isMaster()
{
        "topologyVersion" : {
                "processId" : ObjectId("6565ab8add348113b42bcd40"),
                "counter" : NumberLong(4)
        },
        "hosts" : [
                "mongodb-config-01.unidev39.org.np:27019",
                "mongodb-config-02.unidev39.org.np:27019",
                "mongodb-config-03.unidev39.org.np:27019"
        ],
        "setName" : "configReplSet",
        "setVersion" : 1,
        "ismaster" : false,
        "secondary" : true,
        "primary" : "mongodb-config-01.unidev39.org.np:27019",
        "me" : "mongodb-config-03.unidev39.org.np:27019",
        "lastWrite" : {
                "opTime" : {
                        "ts" : Timestamp(1701163316, 1),
                        "t" : NumberLong(1)
                },
                "lastWriteDate" : ISODate("2023-11-28T09:21:56Z"),
                "majorityOpTime" : {
                        "ts" : Timestamp(1701163316, 1),
                        "t" : NumberLong(1)
                },
                "majorityWriteDate" : ISODate("2023-11-28T09:21:56Z")
        },
        "configsvr" : 2,
        "maxBsonObjectSize" : 16777216,
        "maxMessageSizeBytes" : 48000000,
        "maxWriteBatchSize" : 100000,
        "localTime" : ISODate("2023-11-28T09:21:57.776Z"),
        "logicalSessionTimeoutMinutes" : 30,
        "connectionId" : 24,
        "minWireVersion" : 0,
        "maxWireVersion" : 9,
        "readOnly" : false,
        "ok" : 1,
        "$gleStats" : {
                "lastOpTime" : Timestamp(0, 0),
                "electionId" : ObjectId("000000000000000000000000")
        },
        "lastCommittedOpTime" : Timestamp(1701163316, 1),
        "$clusterTime" : {
                "clusterTime" : Timestamp(1701163316, 1),
                "signature" : {
                        "hash" : BinData(0,"dbwyFS0cF06MXUzFJEFiyv22yy8="),
                        "keyId" : NumberLong("7306436173105201174")
                }
        },
        "operationTime" : Timestamp(1701163316, 1)
}

configReplSet:SECONDARY> rs.printSecondaryReplicationInfo()
source: mongodb-config-02.unidev39.org.np:27019
        syncedTo: Tue Nov 28 2023 15:07:17 GMT+0545 (+0545)
        0 secs (0 hrs) behind the primary
source: mongodb-config-03.unidev39.org.np:27019
        syncedTo: Tue Nov 28 2023 15:07:18 GMT+0545 (+0545)
        -1 secs (0 hrs) behind the primary

configReplSet:SECONDARY> quit()
*/

--If admin@admin not exists into shared servers - /data/log/mongod.log
-- Step 55 -->> On Node 5 (Setup at Port 27018 for Shard Server)
[root@mongodb-shard-01 ~]# vi /etc/mongod.conf
/*
# network interfaces
net:
  port: 27018
  bindIp: 127.0.0.1,mongodb-shard-01.unidev39.org.np  # Enter 0.0.0.0,:: to bind to all IPv4 and IPv6 addresses or, alternatively, use the net.bindIpAll setting.
  maxIncomingConnections: 999999
*/

-- Step 56 -->> On Node 5
[root@mongodb-shard-01 ~]# systemctl restart mongod
-- Step 56.1 -->> On Node 5
[root@mongodb-shard-01 ~]# systemctl status mongod
/*
● mongod.service - MongoDB Database Server
   Loaded: loaded (/usr/lib/systemd/system/mongod.service; enabled; vendor pre>
   Active: active (running) since Tue 2023-11-28 15:14:58 +0545; 8s ago
     Docs: https://docs.mongodb.org/manual
 Main PID: 11003 (mongod)
   Memory: 174.1M
   CGroup: /system.slice/mongod.service
           └─11003 /usr/bin/mongod -f /etc/mongod.conf

Nov 28 15:14:58 mongodb-shard-01.unidev39.org.np systemd[1]: Started MongoDB D>
Nov 28 15:14:58 mongodb-shard-01.unidev39.org.np mongod[11003]: {"t":{"$date":>
*/

-- Step 57 -->> On Node 5 (Create a Administrative User)
[root@mongodb-shard-01 ~]# mongo --port 27018
/*
MongoDB shell version v4.4.26
connecting to: mongodb://127.0.0.1:27018/?compressors=disabled&gssapiServiceName=mongodb
Implicit session: session { "id" : UUID("b093d242-93e4-4ed3-8f9b-0242ac940849") }
MongoDB server version: 4.4.26
---
The server generated these startup warnings when booting:
        2023-11-28T16:41:18.642+05:45: Access control is not enabled for the database. Read and write access to data and configuration is unrestricted
---
> db.version()
4.4.26

> show dbs
admin   0.000GB
config  0.000GB
local   0.000GB

> use admin
switched to db admin

> db
admin

> db.getUsers()
[ ]

> db.createUser(
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

Successfully added user: {
        "user" : "admin",
        "roles" : [
                {
                        "role" : "userAdminAnyDatabase",
                        "db" : "admin"
                },
                {
                        "role" : "clusterAdmin",
                        "db" : "admin"
                },
                {
                        "role" : "root",
                        "db" : "admin"
                }
        ]
}

> db.getUsers()
[
        {
                "_id" : "admin.admin",
                "userId" : UUID("fd2f4161-a2fa-4f1a-8f69-2b04ee0de547"),
                "user" : "admin",
                "db" : "admin",
                "roles" : [
                        {
                                "role" : "userAdminAnyDatabase",
                                "db" : "admin"
                        },
                        {
                                "role" : "clusterAdmin",
                                "db" : "admin"
                        },
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

> db.auth('admin','P#ssw0rd');
1

> quit()
*/

-- Step 58 -->> On Node 5 (Create the Shard Replica Set - rs0)
[root@mongodb-shard-01 ~]# vi /etc/mongod.conf
/*
# network interfaces
net:
  port: 27018
  bindIp: 127.0.0.1,mongodb-shard-01.unidev39.org.np  # Enter 0.0.0.0,:: to bind to all IPv4 and IPv6 addresses or, alternatively, use the net.bindIpAll setting.
  maxIncomingConnections: 999999

#security:
security:
 authorization: enabled
 keyFile: /data/mongodb/keyfile

#operationProfiling:

#replication:
replication:
  replSetName: rs0

#sharding:
sharding:
  clusterRole: shardsvr
*/

-- Step 59 -->> On Node 6 (Create the Shard Replica Set - rs0)
[root@mongodb-shard-02 ~]# vi /etc/mongod.conf
/*
# network interfaces
net:
  port: 27018
  bindIp: 127.0.0.1,mongodb-shard-02.unidev39.org.np  # Enter 0.0.0.0,:: to bind to all IPv4 and IPv6 addresses or, alternatively, use the net.bindIpAll setting.
  maxIncomingConnections: 999999

#security:
security:
 authorization: enabled
 keyFile: /data/mongodb/keyfile

#operationProfiling:

#replication:
replication:
  replSetName: rs0

#sharding:
sharding:
  clusterRole: shardsvr
*/

-- Step 60 -->> On Node 7 (Create the Shard Replica Set - rs0)
[root@mongodb-shard-03 ~]# vi /etc/mongod.conf
/*
# network interfaces
net:
  port: 27018
  bindIp: 127.0.0.1,mongodb-shard-03.unidev39.org.np  # Enter 0.0.0.0,:: to bind to all IPv4 and IPv6 addresses or, alternatively, use the net.bindIpAll setting.
  maxIncomingConnections: 999999

#security:
security:
 authorization: enabled
 keyFile: /data/mongodb/keyfile

#operationProfiling:

#replication:
replication:
  replSetName: rs0

#sharding:
sharding:
  clusterRole: shardsvr
*/

-- Step 61 -->> On Node 5
[root@mongodb-shard-01 ~]# systemctl restart mongod
-- Step 61.1 -->> On Node 5
[root@mongodb-shard-01 ~]# systemctl status mongod
/*
● mongod.service - MongoDB Database Server
   Loaded: loaded (/usr/lib/systemd/system/mongod.service; enabled; vendor pre>
   Active: active (running) since Tue 2023-11-28 15:14:58 +0545; 8s ago
     Docs: https://docs.mongodb.org/manual
 Main PID: 11003 (mongod)
   Memory: 174.1M
   CGroup: /system.slice/mongod.service
           └─11003 /usr/bin/mongod -f /etc/mongod.conf

Nov 28 15:14:58 mongodb-shard-01.unidev39.org.np systemd[1]: Started MongoDB D>
Nov 28 15:14:58 mongodb-shard-01.unidev39.org.np mongod[11003]: {"t":{"$date":>
*/

-- Step 62 -->> On Node 6
[root@mongodb-shard-02 ~]# systemctl restart mongod
-- Step 62.1 -->> On Node 6
[root@mongodb-shard-02 ~]# systemctl status mongod
/*
● mongod.service - MongoDB Database Server
   Loaded: loaded (/usr/lib/systemd/system/mongod.service; enabled; vendor pre>
   Active: active (running) since Tue 2023-11-28 15:14:59 +0545; 8s ago
     Docs: https://docs.mongodb.org/manual
 Main PID: 10977 (mongod)
   Memory: 179.1M
   CGroup: /system.slice/mongod.service
           └─10977 /usr/bin/mongod -f /etc/mongod.conf

Nov 28 15:14:59 mongodb-shard-02.unidev39.org.np systemd[1]: Started MongoDB D>
Nov 28 15:14:59 mongodb-shard-02.unidev39.org.np mongod[10977]: {"t":{"$date":>
*/

-- Step 63 -->> On Node 7
[root@mongodb-shard-03 ~]# systemctl restart mongod
-- Step 63.1 -->> On Node 7
[root@mongodb-shard-03 ~]# systemctl status mongod
/*
● mongod.service - MongoDB Database Server
   Loaded: loaded (/usr/lib/systemd/system/mongod.service; enabled; vendor pre>
   Active: active (running) since Tue 2023-11-28 15:15:00 +0545; 8s ago
     Docs: https://docs.mongodb.org/manual
 Main PID: 10984 (mongod)
   Memory: 177.2M
   CGroup: /system.slice/mongod.service
           └─10984 /usr/bin/mongod -f /etc/mongod.conf

Nov 28 15:15:00 mongodb-shard-03.unidev39.org.np systemd[1]: Started MongoDB D>
Nov 28 15:15:00 mongodb-shard-03.unidev39.org.np mongod[10984]: {"t":{"$date":>
*/

-- Step 64 -->> On Node 5 (Initiate the shard replica sets - rs0 )
[root@mongodb-shard-01 ~]# mongo --host mongodb-shard-01.unidev39.org.np --port 27018 -u admin -p P#ssw0rd --authenticationDatabase admin
/*
MongoDB shell version v4.4.26
connecting to: mongodb://mongodb-shard-01.unidev39.org.np:27018/?authSource=admin&compressors=disabled&gssapiServiceName=mongodb
Implicit session: session { "id" : UUID("3527db0d-58b3-4284-a8c5-cdb2e6aad273") }
MongoDB server version: 4.4.26

> db.version()
4.4.26

> use admin
switched to db admin

> rs.initiate({
...   _id: "rs0",
...   members: [
...     { _id: 0, host: "mongodb-shard-01.unidev39.org.np:27018" },
...     { _id: 1, host: "mongodb-shard-02.unidev39.org.np:27018" },
...     { _id: 2, host: "mongodb-shard-03.unidev39.org.np:27018" }
...   ]
... })
{ "ok" : 1 }

rs0:PRIMARY> rs.config()
{
        "_id" : "rs0",
        "version" : 1,
        "term" : 1,
        "protocolVersion" : NumberLong(1),
        "writeConcernMajorityJournalDefault" : true,
        "members" : [
                {
                        "_id" : 0,
                        "host" : "mongodb-shard-01.unidev39.org.np:27018",
                        "arbiterOnly" : false,
                        "buildIndexes" : true,
                        "hidden" : false,
                        "priority" : 1,
                        "tags" : {

                        },
                        "slaveDelay" : NumberLong(0),
                        "votes" : 1
                },
                {
                        "_id" : 1,
                        "host" : "mongodb-shard-02.unidev39.org.np:27018",
                        "arbiterOnly" : false,
                        "buildIndexes" : true,
                        "hidden" : false,
                        "priority" : 1,
                        "tags" : {

                        },
                        "slaveDelay" : NumberLong(0),
                        "votes" : 1
                },
                {
                        "_id" : 2,
                        "host" : "mongodb-shard-03.unidev39.org.np:27018",
                        "arbiterOnly" : false,
                        "buildIndexes" : true,
                        "hidden" : false,
                        "priority" : 1,
                        "tags" : {

                        },
                        "slaveDelay" : NumberLong(0),
                        "votes" : 1
                }
        ],
        "settings" : {
                "chainingAllowed" : true,
                "heartbeatIntervalMillis" : 2000,
                "heartbeatTimeoutSecs" : 10,
                "electionTimeoutMillis" : 10000,
                "catchUpTimeoutMillis" : -1,
                "catchUpTakeoverDelayMillis" : 30000,
                "getLastErrorModes" : {

                },
                "getLastErrorDefaults" : {
                        "w" : 1,
                        "wtimeout" : 0
                },
                "replicaSetId" : ObjectId("6565c8c47982ce3d4d921b7a")
        }
}

rs0:PRIMARY> rs.status()
{
        "set" : "rs0",
        "date" : ISODate("2023-11-28T11:02:53.154Z"),
        "myState" : 1,
        "term" : NumberLong(1),
        "syncSourceHost" : "",
        "syncSourceId" : -1,
        "heartbeatIntervalMillis" : NumberLong(2000),
        "majorityVoteCount" : 2,
        "writeMajorityCount" : 2,
        "votingMembersCount" : 3,
        "writableVotingMembersCount" : 3,
        "optimes" : {
                "lastCommittedOpTime" : {
                        "ts" : Timestamp(1701169369, 1),
                        "t" : NumberLong(1)
                },
                "lastCommittedWallTime" : ISODate("2023-11-28T11:02:49.430Z"),
                "readConcernMajorityOpTime" : {
                        "ts" : Timestamp(1701169369, 1),
                        "t" : NumberLong(1)
                },
                "readConcernMajorityWallTime" : ISODate("2023-11-28T11:02:49.430Z"),
                "appliedOpTime" : {
                        "ts" : Timestamp(1701169369, 1),
                        "t" : NumberLong(1)
                },
                "durableOpTime" : {
                        "ts" : Timestamp(1701169369, 1),
                        "t" : NumberLong(1)
                },
                "lastAppliedWallTime" : ISODate("2023-11-28T11:02:49.430Z"),
                "lastDurableWallTime" : ISODate("2023-11-28T11:02:49.430Z")
        },
        "lastStableRecoveryTimestamp" : Timestamp(1701169359, 4),
        "electionCandidateMetrics" : {
                "lastElectionReason" : "electionTimeout",
                "lastElectionDate" : ISODate("2023-11-28T11:02:39.385Z"),
                "electionTerm" : NumberLong(1),
                "lastCommittedOpTimeAtElection" : {
                        "ts" : Timestamp(0, 0),
                        "t" : NumberLong(-1)
                },
                "lastSeenOpTimeAtElection" : {
                        "ts" : Timestamp(1701169348, 1),
                        "t" : NumberLong(-1)
                },
                "numVotesNeeded" : 2,
                "priorityAtElection" : 1,
                "electionTimeoutMillis" : NumberLong(10000),
                "numCatchUpOps" : NumberLong(0),
                "newTermStartDate" : ISODate("2023-11-28T11:02:39.421Z"),
                "wMajorityWriteAvailabilityDate" : ISODate("2023-11-28T11:02:40.092Z")
        },
        "members" : [
                {
                        "_id" : 0,
                        "name" : "mongodb-shard-01.unidev39.org.np:27018",
                        "health" : 1,
                        "state" : 1,
                        "stateStr" : "PRIMARY",
                        "uptime" : 200,
                        "optime" : {
                                "ts" : Timestamp(1701169369, 1),
                                "t" : NumberLong(1)
                        },
                        "optimeDate" : ISODate("2023-11-28T11:02:49Z"),
                        "lastAppliedWallTime" : ISODate("2023-11-28T11:02:49.430Z"),
                        "lastDurableWallTime" : ISODate("2023-11-28T11:02:49.430Z"),
                        "syncSourceHost" : "",
                        "syncSourceId" : -1,
                        "infoMessage" : "",
                        "electionTime" : Timestamp(1701169359, 1),
                        "electionDate" : ISODate("2023-11-28T11:02:39Z"),
                        "configVersion" : 1,
                        "configTerm" : 1,
                        "self" : true,
                        "lastHeartbeatMessage" : ""
                },
                {
                        "_id" : 1,
                        "name" : "mongodb-shard-02.unidev39.org.np:27018",
                        "health" : 1,
                        "state" : 2,
                        "stateStr" : "SECONDARY",
                        "uptime" : 24,
                        "optime" : {
                                "ts" : Timestamp(1701169369, 1),
                                "t" : NumberLong(1)
                        },
                        "optimeDurable" : {
                                "ts" : Timestamp(1701169369, 1),
                                "t" : NumberLong(1)
                        },
                        "optimeDate" : ISODate("2023-11-28T11:02:49Z"),
                        "optimeDurableDate" : ISODate("2023-11-28T11:02:49Z"),
                        "lastAppliedWallTime" : ISODate("2023-11-28T11:02:49.430Z"),
                        "lastDurableWallTime" : ISODate("2023-11-28T11:02:49.430Z"),
                        "lastHeartbeat" : ISODate("2023-11-28T11:02:51.397Z"),
                        "lastHeartbeatRecv" : ISODate("2023-11-28T11:02:52.409Z"),
                        "pingMs" : NumberLong(0),
                        "lastHeartbeatMessage" : "",
                        "syncSourceHost" : "mongodb-shard-01.unidev39.org.np:27018",
                        "syncSourceId" : 0,
                        "infoMessage" : "",
                        "configVersion" : 1,
                        "configTerm" : 1
                },
                {
                        "_id" : 2,
                        "name" : "mongodb-shard-03.unidev39.org.np:27018",
                        "health" : 1,
                        "state" : 2,
                        "stateStr" : "SECONDARY",
                        "uptime" : 24,
                        "optime" : {
                                "ts" : Timestamp(1701169369, 1),
                                "t" : NumberLong(1)
                        },
                        "optimeDurable" : {
                                "ts" : Timestamp(1701169369, 1),
                                "t" : NumberLong(1)
                        },
                        "optimeDate" : ISODate("2023-11-28T11:02:49Z"),
                        "optimeDurableDate" : ISODate("2023-11-28T11:02:49Z"),
                        "lastAppliedWallTime" : ISODate("2023-11-28T11:02:49.430Z"),
                        "lastDurableWallTime" : ISODate("2023-11-28T11:02:49.430Z"),
                        "lastHeartbeat" : ISODate("2023-11-28T11:02:51.396Z"),
                        "lastHeartbeatRecv" : ISODate("2023-11-28T11:02:52.409Z"),
                        "pingMs" : NumberLong(0),
                        "lastHeartbeatMessage" : "",
                        "syncSourceHost" : "mongodb-shard-01.unidev39.org.np:27018",
                        "syncSourceId" : 0,
                        "infoMessage" : "",
                        "configVersion" : 1,
                        "configTerm" : 1
                }
        ],
        "ok" : 1
}

rs0:PRIMARY> rs.isMaster()
{
        "topologyVersion" : {
                "processId" : ObjectId("6565c8157982ce3d4d921b56"),
                "counter" : NumberLong(6)
        },
        "hosts" : [
                "mongodb-shard-01.unidev39.org.np:27018",
                "mongodb-shard-02.unidev39.org.np:27018",
                "mongodb-shard-03.unidev39.org.np:27018"
        ],
        "setName" : "rs0",
        "setVersion" : 1,
        "ismaster" : true,
        "secondary" : false,
        "primary" : "mongodb-shard-01.unidev39.org.np:27018",
        "me" : "mongodb-shard-01.unidev39.org.np:27018",
        "electionId" : ObjectId("7fffffff0000000000000001"),
        "lastWrite" : {
                "opTime" : {
                        "ts" : Timestamp(1701169369, 1),
                        "t" : NumberLong(1)
                },
                "lastWriteDate" : ISODate("2023-11-28T11:02:49Z"),
                "majorityOpTime" : {
                        "ts" : Timestamp(1701169369, 1),
                        "t" : NumberLong(1)
                },
                "majorityWriteDate" : ISODate("2023-11-28T11:02:49Z")
        },
        "maxBsonObjectSize" : 16777216,
        "maxMessageSizeBytes" : 48000000,
        "maxWriteBatchSize" : 100000,
        "localTime" : ISODate("2023-11-28T11:02:58.906Z"),
        "logicalSessionTimeoutMinutes" : 30,
        "connectionId" : 2,
        "minWireVersion" : 0,
        "maxWireVersion" : 9,
        "readOnly" : false,
        "ok" : 1
}

rs0:PRIMARY> rs.printSecondaryReplicationInfo()
source: mongodb-shard-02.unidev39.org.np:27018
        syncedTo: Tue Nov 28 2023 16:48:09 GMT+0545 (+0545)
        0 secs (0 hrs) behind the primary
source: mongodb-shard-03.unidev39.org.np:27018
        syncedTo: Tue Nov 28 2023 16:48:09 GMT+0545 (+0545)
        0 secs (0 hrs) behind the primary

rs0:PRIMARY> quit()
*/

-- Step 65 -->> On Node 6 (Verify the shard replica sets - rs0 )
[root@mongodb-shard-02 ~]# mongo --host mongodb-shard-02.unidev39.org.np --port 27018 -u admin -p P#ssw0rd --authenticationDatabase admin
/*
MongoDB shell version v4.4.26
connecting to: mongodb://mongodb-shard-02.unidev39.org.np:27018/?authSource=admin&compressors=disabled&gssapiServiceName=mongodb
Implicit session: session { "id" : UUID("2f7a59ed-c86e-432e-98d2-73371c181436") }
MongoDB server version: 4.4.26

rs0:SECONDARY> db.version()
4.4.26

rs0:SECONDARY> rs.config()
{
        "_id" : "rs0",
        "version" : 1,
        "term" : 1,
        "protocolVersion" : NumberLong(1),
        "writeConcernMajorityJournalDefault" : true,
        "members" : [
                {
                        "_id" : 0,
                        "host" : "mongodb-shard-01.unidev39.org.np:27018",
                        "arbiterOnly" : false,
                        "buildIndexes" : true,
                        "hidden" : false,
                        "priority" : 1,
                        "tags" : {

                        },
                        "slaveDelay" : NumberLong(0),
                        "votes" : 1
                },
                {
                        "_id" : 1,
                        "host" : "mongodb-shard-02.unidev39.org.np:27018",
                        "arbiterOnly" : false,
                        "buildIndexes" : true,
                        "hidden" : false,
                        "priority" : 1,
                        "tags" : {

                        },
                        "slaveDelay" : NumberLong(0),
                        "votes" : 1
                },
                {
                        "_id" : 2,
                        "host" : "mongodb-shard-03.unidev39.org.np:27018",
                        "arbiterOnly" : false,
                        "buildIndexes" : true,
                        "hidden" : false,
                        "priority" : 1,
                        "tags" : {

                        },
                        "slaveDelay" : NumberLong(0),
                        "votes" : 1
                }
        ],
        "settings" : {
                "chainingAllowed" : true,
                "heartbeatIntervalMillis" : 2000,
                "heartbeatTimeoutSecs" : 10,
                "electionTimeoutMillis" : 10000,
                "catchUpTimeoutMillis" : -1,
                "catchUpTakeoverDelayMillis" : 30000,
                "getLastErrorModes" : {

                },
                "getLastErrorDefaults" : {
                        "w" : 1,
                        "wtimeout" : 0
                },
                "replicaSetId" : ObjectId("6565c8c47982ce3d4d921b7a")
        }
}

rs0:SECONDARY> rs.status()
{
        "set" : "rs0",
        "date" : ISODate("2023-11-28T11:09:28.010Z"),
        "myState" : 2,
        "term" : NumberLong(1),
        "syncSourceHost" : "mongodb-shard-01.unidev39.org.np:27018",
        "syncSourceId" : 0,
        "heartbeatIntervalMillis" : NumberLong(2000),
        "majorityVoteCount" : 2,
        "writeMajorityCount" : 2,
        "votingMembersCount" : 3,
        "writableVotingMembersCount" : 3,
        "optimes" : {
                "lastCommittedOpTime" : {
                        "ts" : Timestamp(1701169759, 1),
                        "t" : NumberLong(1)
                },
                "lastCommittedWallTime" : ISODate("2023-11-28T11:09:19.446Z"),
                "readConcernMajorityOpTime" : {
                        "ts" : Timestamp(1701169759, 1),
                        "t" : NumberLong(1)
                },
                "readConcernMajorityWallTime" : ISODate("2023-11-28T11:09:19.446Z"),
                "appliedOpTime" : {
                        "ts" : Timestamp(1701169759, 1),
                        "t" : NumberLong(1)
                },
                "durableOpTime" : {
                        "ts" : Timestamp(1701169759, 1),
                        "t" : NumberLong(1)
                },
                "lastAppliedWallTime" : ISODate("2023-11-28T11:09:19.446Z"),
                "lastDurableWallTime" : ISODate("2023-11-28T11:09:19.446Z")
        },
        "lastStableRecoveryTimestamp" : Timestamp(1701169719, 1),
        "electionParticipantMetrics" : {
                "votedForCandidate" : true,
                "electionTerm" : NumberLong(1),
                "lastVoteDate" : ISODate("2023-11-28T11:02:39.388Z"),
                "electionCandidateMemberId" : 0,
                "voteReason" : "",
                "lastAppliedOpTimeAtElection" : {
                        "ts" : Timestamp(1701169348, 1),
                        "t" : NumberLong(-1)
                },
                "maxAppliedOpTimeInSet" : {
                        "ts" : Timestamp(1701169348, 1),
                        "t" : NumberLong(-1)
                },
                "priorityAtElection" : 1,
                "newTermStartDate" : ISODate("2023-11-28T11:02:39.421Z"),
                "newTermAppliedDate" : ISODate("2023-11-28T11:02:40.143Z")
        },
        "members" : [
                {
                        "_id" : 0,
                        "name" : "mongodb-shard-01.unidev39.org.np:27018",
                        "health" : 1,
                        "state" : 1,
                        "stateStr" : "PRIMARY",
                        "uptime" : 419,
                        "optime" : {
                                "ts" : Timestamp(1701169759, 1),
                                "t" : NumberLong(1)
                        },
                        "optimeDurable" : {
                                "ts" : Timestamp(1701169759, 1),
                                "t" : NumberLong(1)
                        },
                        "optimeDate" : ISODate("2023-11-28T11:09:19Z"),
                        "optimeDurableDate" : ISODate("2023-11-28T11:09:19Z"),
                        "lastAppliedWallTime" : ISODate("2023-11-28T11:09:19.446Z"),
                        "lastDurableWallTime" : ISODate("2023-11-28T11:09:19.446Z"),
                        "lastHeartbeat" : ISODate("2023-11-28T11:09:26.512Z"),
                        "lastHeartbeatRecv" : ISODate("2023-11-28T11:09:27.552Z"),
                        "pingMs" : NumberLong(0),
                        "lastHeartbeatMessage" : "",
                        "syncSourceHost" : "",
                        "syncSourceId" : -1,
                        "infoMessage" : "",
                        "electionTime" : Timestamp(1701169359, 1),
                        "electionDate" : ISODate("2023-11-28T11:02:39Z"),
                        "configVersion" : 1,
                        "configTerm" : 1
                },
                {
                        "_id" : 1,
                        "name" : "mongodb-shard-02.unidev39.org.np:27018",
                        "health" : 1,
                        "state" : 2,
                        "stateStr" : "SECONDARY",
                        "uptime" : 3876,
                        "optime" : {
                                "ts" : Timestamp(1701169759, 1),
                                "t" : NumberLong(1)
                        },
                        "optimeDate" : ISODate("2023-11-28T11:09:19Z"),
                        "lastAppliedWallTime" : ISODate("2023-11-28T11:09:19.446Z"),
                        "lastDurableWallTime" : ISODate("2023-11-28T11:09:19.446Z"),
                        "syncSourceHost" : "mongodb-shard-01.unidev39.org.np:27018",
                        "syncSourceId" : 0,
                        "infoMessage" : "",
                        "configVersion" : 1,
                        "configTerm" : 1,
                        "self" : true,
                        "lastHeartbeatMessage" : ""
                },
                {
                        "_id" : 2,
                        "name" : "mongodb-shard-03.unidev39.org.np:27018",
                        "health" : 1,
                        "state" : 2,
                        "stateStr" : "SECONDARY",
                        "uptime" : 419,
                        "optime" : {
                                "ts" : Timestamp(1701169759, 1),
                                "t" : NumberLong(1)
                        },
                        "optimeDurable" : {
                                "ts" : Timestamp(1701169759, 1),
                                "t" : NumberLong(1)
                        },
                        "optimeDate" : ISODate("2023-11-28T11:09:19Z"),
                        "optimeDurableDate" : ISODate("2023-11-28T11:09:19Z"),
                        "lastAppliedWallTime" : ISODate("2023-11-28T11:09:19.446Z"),
                        "lastDurableWallTime" : ISODate("2023-11-28T11:09:19.446Z"),
                        "lastHeartbeat" : ISODate("2023-11-28T11:09:26.510Z"),
                        "lastHeartbeatRecv" : ISODate("2023-11-28T11:09:26.510Z"),
                        "pingMs" : NumberLong(0),
                        "lastHeartbeatMessage" : "",
                        "syncSourceHost" : "mongodb-shard-01.unidev39.org.np:27018",
                        "syncSourceId" : 0,
                        "infoMessage" : "",
                        "configVersion" : 1,
                        "configTerm" : 1
                }
        ],
        "ok" : 1
}

rs0:SECONDARY> rs.isMaster()
{
        "topologyVersion" : {
                "processId" : ObjectId("6565bb45dd2ad3efce0c6606"),
                "counter" : NumberLong(4)
        },
        "hosts" : [
                "mongodb-shard-01.unidev39.org.np:27018",
                "mongodb-shard-02.unidev39.org.np:27018",
                "mongodb-shard-03.unidev39.org.np:27018"
        ],
        "setName" : "rs0",
        "setVersion" : 1,
        "ismaster" : false,
        "secondary" : true,
        "primary" : "mongodb-shard-01.unidev39.org.np:27018",
        "me" : "mongodb-shard-02.unidev39.org.np:27018",
        "lastWrite" : {
                "opTime" : {
                        "ts" : Timestamp(1701169769, 1),
                        "t" : NumberLong(1)
                },
                "lastWriteDate" : ISODate("2023-11-28T11:09:29Z"),
                "majorityOpTime" : {
                        "ts" : Timestamp(1701169769, 1),
                        "t" : NumberLong(1)
                },
                "majorityWriteDate" : ISODate("2023-11-28T11:09:29Z")
        },
        "maxBsonObjectSize" : 16777216,
        "maxMessageSizeBytes" : 48000000,
        "maxWriteBatchSize" : 100000,
        "localTime" : ISODate("2023-11-28T11:09:33.045Z"),
        "logicalSessionTimeoutMinutes" : 30,
        "connectionId" : 21,
        "minWireVersion" : 0,
        "maxWireVersion" : 9,
        "readOnly" : false,
        "ok" : 1
}

rs0:SECONDARY> rs.printSecondaryReplicationInfo()
source: mongodb-shard-02.unidev39.org.np:27018
        syncedTo: Tue Nov 28 2023 16:54:39 GMT+0545 (+0545)
        -10 secs (0 hrs) behind the primary
source: mongodb-shard-03.unidev39.org.np:27018
        syncedTo: Tue Nov 28 2023 16:54:29 GMT+0545 (+0545)
        0 secs (0 hrs) behind the primary

rs0:SECONDARY> quit()
*/

-- Step 66 -->> On Node 7 (Verify the shard replica sets - rs0 )
[root@mongodb-shard-03 ~]# mongo --host mongodb-shard-03.unidev39.org.np --port 27018 -u admin -p P#ssw0rd --authenticationDatabase admin
/*
MongoDB shell version v4.4.26
connecting to: mongodb://mongodb-shard-03.unidev39.org.np:27018/?authSource=admin&compressors=disabled&gssapiServiceName=mongodb
Implicit session: session { "id" : UUID("34c17629-1632-4a9b-a24b-c398f768544a") }
MongoDB server version: 4.4.26
rs0:SECONDARY> db.verison()
uncaught exception: TypeError: db.verison is not a function :
@(shell):1:1

rs0:SECONDARY> db.version()
4.4.26

rs0:SECONDARY> rs.config()
{
        "_id" : "rs0",
        "version" : 1,
        "term" : 1,
        "protocolVersion" : NumberLong(1),
        "writeConcernMajorityJournalDefault" : true,
        "members" : [
                {
                        "_id" : 0,
                        "host" : "mongodb-shard-01.unidev39.org.np:27018",
                        "arbiterOnly" : false,
                        "buildIndexes" : true,
                        "hidden" : false,
                        "priority" : 1,
                        "tags" : {

                        },
                        "slaveDelay" : NumberLong(0),
                        "votes" : 1
                },
                {
                        "_id" : 1,
                        "host" : "mongodb-shard-02.unidev39.org.np:27018",
                        "arbiterOnly" : false,
                        "buildIndexes" : true,
                        "hidden" : false,
                        "priority" : 1,
                        "tags" : {

                        },
                        "slaveDelay" : NumberLong(0),
                        "votes" : 1
                },
                {
                        "_id" : 2,
                        "host" : "mongodb-shard-03.unidev39.org.np:27018",
                        "arbiterOnly" : false,
                        "buildIndexes" : true,
                        "hidden" : false,
                        "priority" : 1,
                        "tags" : {

                        },
                        "slaveDelay" : NumberLong(0),
                        "votes" : 1
                }
        ],
        "settings" : {
                "chainingAllowed" : true,
                "heartbeatIntervalMillis" : 2000,
                "heartbeatTimeoutSecs" : 10,
                "electionTimeoutMillis" : 10000,
                "catchUpTimeoutMillis" : -1,
                "catchUpTakeoverDelayMillis" : 30000,
                "getLastErrorModes" : {

                },
                "getLastErrorDefaults" : {
                        "w" : 1,
                        "wtimeout" : 0
                },
                "replicaSetId" : ObjectId("6565c8c47982ce3d4d921b7a")
        }
}

rs0:SECONDARY> rs.status()
{
        "set" : "rs0",
        "date" : ISODate("2023-11-28T11:11:35.286Z"),
        "myState" : 2,
        "term" : NumberLong(1),
        "syncSourceHost" : "mongodb-shard-01.unidev39.org.np:27018",
        "syncSourceId" : 0,
        "heartbeatIntervalMillis" : NumberLong(2000),
        "majorityVoteCount" : 2,
        "writeMajorityCount" : 2,
        "votingMembersCount" : 3,
        "writableVotingMembersCount" : 3,
        "optimes" : {
                "lastCommittedOpTime" : {
                        "ts" : Timestamp(1701169889, 1),
                        "t" : NumberLong(1)
                },
                "lastCommittedWallTime" : ISODate("2023-11-28T11:11:29.451Z"),
                "readConcernMajorityOpTime" : {
                        "ts" : Timestamp(1701169889, 1),
                        "t" : NumberLong(1)
                },
                "readConcernMajorityWallTime" : ISODate("2023-11-28T11:11:29.451Z"),
                "appliedOpTime" : {
                        "ts" : Timestamp(1701169889, 1),
                        "t" : NumberLong(1)
                },
                "durableOpTime" : {
                        "ts" : Timestamp(1701169889, 1),
                        "t" : NumberLong(1)
                },
                "lastAppliedWallTime" : ISODate("2023-11-28T11:11:29.451Z"),
                "lastDurableWallTime" : ISODate("2023-11-28T11:11:29.451Z")
        },
        "lastStableRecoveryTimestamp" : Timestamp(1701169839, 1),
        "electionParticipantMetrics" : {
                "votedForCandidate" : true,
                "electionTerm" : NumberLong(1),
                "lastVoteDate" : ISODate("2023-11-28T11:02:39.388Z"),
                "electionCandidateMemberId" : 0,
                "voteReason" : "",
                "lastAppliedOpTimeAtElection" : {
                        "ts" : Timestamp(1701169348, 1),
                        "t" : NumberLong(-1)
                },
                "maxAppliedOpTimeInSet" : {
                        "ts" : Timestamp(1701169348, 1),
                        "t" : NumberLong(-1)
                },
                "priorityAtElection" : 1,
                "newTermStartDate" : ISODate("2023-11-28T11:02:39.421Z"),
                "newTermAppliedDate" : ISODate("2023-11-28T11:02:40.091Z")
        },
        "members" : [
                {
                        "_id" : 0,
                        "name" : "mongodb-shard-01.unidev39.org.np:27018",
                        "health" : 1,
                        "state" : 1,
                        "stateStr" : "PRIMARY",
                        "uptime" : 546,
                        "optime" : {
                                "ts" : Timestamp(1701169889, 1),
                                "t" : NumberLong(1)
                        },
                        "optimeDurable" : {
                                "ts" : Timestamp(1701169889, 1),
                                "t" : NumberLong(1)
                        },
                        "optimeDate" : ISODate("2023-11-28T11:11:29Z"),
                        "optimeDurableDate" : ISODate("2023-11-28T11:11:29Z"),
                        "lastAppliedWallTime" : ISODate("2023-11-28T11:11:29.451Z"),
                        "lastDurableWallTime" : ISODate("2023-11-28T11:11:29.451Z"),
                        "lastHeartbeat" : ISODate("2023-11-28T11:11:34.543Z"),
                        "lastHeartbeatRecv" : ISODate("2023-11-28T11:11:33.593Z"),
                        "pingMs" : NumberLong(0),
                        "lastHeartbeatMessage" : "",
                        "syncSourceHost" : "",
                        "syncSourceId" : -1,
                        "infoMessage" : "",
                        "electionTime" : Timestamp(1701169359, 1),
                        "electionDate" : ISODate("2023-11-28T11:02:39Z"),
                        "configVersion" : 1,
                        "configTerm" : 1
                },
                {
                        "_id" : 1,
                        "name" : "mongodb-shard-02.unidev39.org.np:27018",
                        "health" : 1,
                        "state" : 2,
                        "stateStr" : "SECONDARY",
                        "uptime" : 546,
                        "optime" : {
                                "ts" : Timestamp(1701169889, 1),
                                "t" : NumberLong(1)
                        },
                        "optimeDurable" : {
                                "ts" : Timestamp(1701169889, 1),
                                "t" : NumberLong(1)
                        },
                        "optimeDate" : ISODate("2023-11-28T11:11:29Z"),
                        "optimeDurableDate" : ISODate("2023-11-28T11:11:29Z"),
                        "lastAppliedWallTime" : ISODate("2023-11-28T11:11:29.451Z"),
                        "lastDurableWallTime" : ISODate("2023-11-28T11:11:29.451Z"),
                        "lastHeartbeat" : ISODate("2023-11-28T11:11:34.543Z"),
                        "lastHeartbeatRecv" : ISODate("2023-11-28T11:11:34.543Z"),
                        "pingMs" : NumberLong(0),
                        "lastHeartbeatMessage" : "",
                        "syncSourceHost" : "mongodb-shard-01.unidev39.org.np:27018",
                        "syncSourceId" : 0,
                        "infoMessage" : "",
                        "configVersion" : 1,
                        "configTerm" : 1
                },
                {
                        "_id" : 2,
                        "name" : "mongodb-shard-03.unidev39.org.np:27018",
                        "health" : 1,
                        "state" : 2,
                        "stateStr" : "SECONDARY",
                        "uptime" : 3997,
                        "optime" : {
                                "ts" : Timestamp(1701169889, 1),
                                "t" : NumberLong(1)
                        },
                        "optimeDate" : ISODate("2023-11-28T11:11:29Z"),
                        "lastAppliedWallTime" : ISODate("2023-11-28T11:11:29.451Z"),
                        "lastDurableWallTime" : ISODate("2023-11-28T11:11:29.451Z"),
                        "syncSourceHost" : "mongodb-shard-01.unidev39.org.np:27018",
                        "syncSourceId" : 0,
                        "infoMessage" : "",
                        "configVersion" : 1,
                        "configTerm" : 1,
                        "self" : true,
                        "lastHeartbeatMessage" : ""
                }
        ],
        "ok" : 1
}

rs0:SECONDARY> rs.isMaster()
{
        "topologyVersion" : {
                "processId" : ObjectId("6565bb4a87eeadaaf9cc1044"),
                "counter" : NumberLong(4)
        },
        "hosts" : [
                "mongodb-shard-01.unidev39.org.np:27018",
                "mongodb-shard-02.unidev39.org.np:27018",
                "mongodb-shard-03.unidev39.org.np:27018"
        ],
        "setName" : "rs0",
        "setVersion" : 1,
        "ismaster" : false,
        "secondary" : true,
        "primary" : "mongodb-shard-01.unidev39.org.np:27018",
        "me" : "mongodb-shard-03.unidev39.org.np:27018",
        "lastWrite" : {
                "opTime" : {
                        "ts" : Timestamp(1701169899, 1),
                        "t" : NumberLong(1)
                },
                "lastWriteDate" : ISODate("2023-11-28T11:11:39Z"),
                "majorityOpTime" : {
                        "ts" : Timestamp(1701169899, 1),
                        "t" : NumberLong(1)
                },
                "majorityWriteDate" : ISODate("2023-11-28T11:11:39Z")
        },
        "maxBsonObjectSize" : 16777216,
        "maxMessageSizeBytes" : 48000000,
        "maxWriteBatchSize" : 100000,
        "localTime" : ISODate("2023-11-28T11:11:41.048Z"),
        "logicalSessionTimeoutMinutes" : 30,
        "connectionId" : 20,
        "minWireVersion" : 0,
        "maxWireVersion" : 9,
        "readOnly" : false,
        "ok" : 1
}

rs0:SECONDARY> rs.printSecondaryReplicationInfo()
source: mongodb-shard-02.unidev39.org.np:27018
        syncedTo: Tue Nov 28 2023 16:56:39 GMT+0545 (+0545)
        0 secs (0 hrs) behind the primary
source: mongodb-shard-03.unidev39.org.np:27018
        syncedTo: Tue Nov 28 2023 16:56:39 GMT+0545 (+0545)
        0 secs (0 hrs) behind the primary

rs0:SECONDARY> quit()
*/

--If admin@admin not exists into shared servers - /data/log/mongod.log
-- Step 67 -->> On Node 8 (Setup at Port 27020 for Shard Server)
[root@mongodb-shard-04 ~]# vi /etc/mongod.conf
/*
# network interfaces
net:
  port: 27020
  bindIp: 127.0.0.1,mongodb-shard-04.unidev39.org.np  # Enter 0.0.0.0,:: to bind to all IPv4 and IPv6 addresses or, alternatively, use the net.bindIpAll setting.
  maxIncomingConnections: 999999
*/

-- Step 68 -->> On Node 8
[root@mongodb-shard-04 ~]# systemctl restart mongod
-- Step 68.1 -->> On Node 8
[root@mongodb-shard-04 ~]# systemctl status mongod
/*
● mongod.service - MongoDB Database Server
   Loaded: loaded (/usr/lib/systemd/system/mongod.service; enabled; vendor pre>
   Active: active (running) since Tue 2023-11-28 17:08:27 +0545; 5s ago
     Docs: https://docs.mongodb.org/manual
 Main PID: 15776 (mongod)
   Memory: 159.6M
   CGroup: /system.slice/mongod.service
           └─15776 /usr/bin/mongod -f /etc/mongod.conf

Nov 28 17:08:27 mongodb-shard-04.unidev39.org.np systemd[1]: Started MongoDB D>
Nov 28 17:08:27 mongodb-shard-04.unidev39.org.np mongod[15776]: {"t":{"$date":>
*/

-- Step 69 -->> On Node 8 (Create a Administrative User)
[root@mongodb-shard-04 ~]# mongo --port 27020
/*
MongoDB shell version v4.4.26
connecting to: mongodb://127.0.0.1:27020/?compressors=disabled&gssapiServiceName=mongodb
Implicit session: session { "id" : UUID("27b6d34a-8edd-4b39-aad3-8fa2324cfc34") }
MongoDB server version: 4.4.26
---
The server generated these startup warnings when booting:
        2023-11-28T17:08:29.214+05:45: Access control is not enabled for the database. Read and write access to data and configuration is unrestricted
---
> db.version()
4.4.26

> show dbs
admin   0.000GB
config  0.000GB
local   0.000GB

> use admin
switched to db admin

> db
admin

> db.getUsers()
[ ]

> db.createUser(
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
...             db: "admin"    ]

...         }
...     ]
... })

Successfully added user: {
        "user" : "admin",
        "roles" : [
                {
                        "role" : "userAdminAnyDatabase",
                        "db" : "admin"
                },
                {
                        "role" : "clusterAdmin",
                        "db" : "admin"
                },
                {
                        "role" : "root",
                        "db" : "admin"
                }
        ]
}

> db.getUsers()
[
        {
                "_id" : "admin.admin",
                "userId" : UUID("ab55d560-e2ee-4a56-a2fc-b22e2300970d"),
                "user" : "admin",
                "db" : "admin",
                "roles" : [
                        {
                                "role" : "userAdminAnyDatabase",
                                "db" : "admin"
                        },
                        {
                                "role" : "clusterAdmin",
                                "db" : "admin"
                        },
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

> db.auth('admin','P#ssw0rd');
1

> quit()
*/

-- Step 70 -->> On Node 8 (Create the Shard Replica Set - rs1)
[root@mongodb-shard-04 ~]# vi /etc/mongod.conf
/*
# network interfaces
net:
  port: 27020
  bindIp: 127.0.0.1,mongodb-shard-04.unidev39.org.np  # Enter 0.0.0.0,:: to bind to all IPv4 and IPv6 addresses or, alternatively, use the net.bindIpAll setting.
  maxIncomingConnections: 999999

#security:
security:
 authorization: enabled
 keyFile: /data/mongodb/keyfile

#operationProfiling:

#replication:
replication:
 replSetName: rs1

#sharding:
sharding:
 clusterRole: shardsvr
*/

-- Step 71 -->> On Node 9 (Create the Shard Replica Set - rs1)
[root@mongodb-shard-05 ~]# vi /etc/mongod.conf
/*
# network interfaces
net:
  port: 27020
  bindIp: 127.0.0.1,mongodb-shard-05.unidev39.org.np  # Enter 0.0.0.0,:: to bind to all IPv4 and IPv6 addresses or, alternatively, use the net.bindIpAll setting.
  maxIncomingConnections: 999999

#security:
security:
 authorization: enabled
 keyFile: /data/mongodb/keyfile

#operationProfiling:

#replication:
replication:
 replSetName: rs1

#sharding:
sharding:
 clusterRole: shardsvr
*/

-- Step 72 -->> On Node 10 (Create the Shard Replica Set - rs1)
[root@mongodb-shard-06 ~]# vi /etc/mongod.conf
/*
# network interfaces
net:
  port: 27020
  bindIp: 127.0.0.1,mongodb-shard-06.unidev39.org.np  # Enter 0.0.0.0,:: to bind to all IPv4 and IPv6 addresses or, alternatively, use the net.bindIpAll setting.
  maxIncomingConnections: 999999

#security:
security:
 authorization: enabled
 keyFile: /data/mongodb/keyfile

#operationProfiling:

#replication:
replication:
 replSetName: rs1

#sharding:
sharding:
 clusterRole: shardsvr
*/

-- Step 73 -->> On Node 8
[root@mongodb-shard-04 ~]# systemctl restart mongod
-- Step 73.1 -->> On Node 8
[root@mongodb-shard-04 ~]# systemctl status mongod
/*
● mongod.service - MongoDB Database Server
   Loaded: loaded (/usr/lib/systemd/system/mongod.service; enabled; vendor pre>
   Active: active (running) since Tue 2023-11-28 17:18:48 +0545; 12s ago
     Docs: https://docs.mongodb.org/manual
 Main PID: 16048 (mongod)
   Memory: 164.9M
   CGroup: /system.slice/mongod.service
           └─16048 /usr/bin/mongod -f /etc/mongod.conf

Nov 28 17:18:48 mongodb-shard-04.unidev39.org.np systemd[1]: Started MongoDB D>
Nov 28 17:18:48 mongodb-shard-04.unidev39.org.np mongod[16048]: {"t":{"$date":>
*/

-- Step 74 -->> On Node 9
[root@mongodb-shard-05 ~]# systemctl restart mongod
-- Step 74.1 -->> On Node 9
[root@mongodb-shard-05 ~]# systemctl status mongod
/*
● mongod.service - MongoDB Database Server
   Loaded: loaded (/usr/lib/systemd/system/mongod.service; enabled; vendor pre>
   Active: active (running) since Tue 2023-11-28 17:18:53 +0545; 15s ago
     Docs: https://docs.mongodb.org/manual
 Main PID: 15877 (mongod)
   Memory: 177.4M
   CGroup: /system.slice/mongod.service
           └─15877 /usr/bin/mongod -f /etc/mongod.conf

Nov 28 17:18:53 mongodb-shard-05.unidev39.org.np systemd[1]: Started MongoDB D>
Nov 28 17:18:53 mongodb-shard-05.unidev39.org.np mongod[15877]: {"t":{"$date":>
*/

-- Step 75 -->> On Node 10
[root@mongodb-shard-06 ~]# systemctl restart mongod
-- Step 75.1 -->> On Node 10
[root@mongodb-shard-06 ~]# systemctl status mongod
/*
● mongod.service - MongoDB Database Server
   Loaded: loaded (/usr/lib/systemd/system/mongod.service; enabled; vendor pre>
   Active: active (running) since Tue 2023-11-28 17:18:55 +0545; 15s ago
     Docs: https://docs.mongodb.org/manual
 Main PID: 15792 (mongod)
   Memory: 177.6M
   CGroup: /system.slice/mongod.service
           └─15792 /usr/bin/mongod -f /etc/mongod.conf

Nov 28 17:18:55 mongodb-shard-06.unidev39.org.np systemd[1]: Started MongoDB D>
Nov 28 17:18:55 mongodb-shard-06.unidev39.org.np mongod[15792]: {"t":{"$date":>
*/

-- Step 76 -->> On Node 8 (Initiate the shard replica set - rs1)
[root@mongodb-shard-04 ~]# mongo --host mongodb-shard-04.unidev39.org.np --port 27020 -u admin -p P#ssw0rd --authenticationDatabase admin
/*
MongoDB shell version v4.4.26
connecting to: mongodb://mongodb-shard-04.unidev39.org.np:27020/?authSource=admin&compressors=disabled&gssapiServiceName=mongodb
Implicit session: session { "id" : UUID("f6fbeec3-109c-4127-809b-ab9bc24bce1b") }
MongoDB server version: 4.4.26

> db.version()
4.4.26

> use admin
switched to db admin

> db
admin

> rs.initiate({
...   _id: "rs1",
...   members: [
...     { _id: 0, host: "mongodb-shard-04.unidev39.org.np:27020" },
...     { _id: 1, host: "mongodb-shard-05.unidev39.org.np:27020" },
...     { _id: 2, host: "mongodb-shard-06.unidev39.org.np:27020" }
...   ]
... })
{ "ok" : 1 }

rs1:PRIMARY> rs.config()
{
        "_id" : "rs1",
        "version" : 1,
        "term" : 1,
        "protocolVersion" : NumberLong(1),
        "writeConcernMajorityJournalDefault" : true,
        "members" : [
                {
                        "_id" : 0,
                        "host" : "mongodb-shard-04.unidev39.org.np:27020",
                        "arbiterOnly" : false,
                        "buildIndexes" : true,
                        "hidden" : false,
                        "priority" : 1,
                        "tags" : {

                        },
                        "slaveDelay" : NumberLong(0),
                        "votes" : 1
                },
                {
                        "_id" : 1,
                        "host" : "mongodb-shard-05.unidev39.org.np:27020",
                        "arbiterOnly" : false,
                        "buildIndexes" : true,
                        "hidden" : false,
                        "priority" : 1,
                        "tags" : {

                        },
                        "slaveDelay" : NumberLong(0),
                        "votes" : 1
                },
                {
                        "_id" : 2,
                        "host" : "mongodb-shard-06.unidev39.org.np:27020",
                        "arbiterOnly" : false,
                        "buildIndexes" : true,
                        "hidden" : false,
                        "priority" : 1,
                        "tags" : {

                        },
                        "slaveDelay" : NumberLong(0),
                        "votes" : 1
                }
        ],
        "settings" : {
                "chainingAllowed" : true,
                "heartbeatIntervalMillis" : 2000,
                "heartbeatTimeoutSecs" : 10,
                "electionTimeoutMillis" : 10000,
                "catchUpTimeoutMillis" : -1,
                "catchUpTakeoverDelayMillis" : 30000,
                "getLastErrorModes" : {

                },
                "getLastErrorDefaults" : {
                        "w" : 1,
                        "wtimeout" : 0
                },
                "replicaSetId" : ObjectId("6565d0e010c322b9b22e8ae8")
        }
}

rs1:PRIMARY> rs.status()
{
        "set" : "rs1",
        "date" : ISODate("2023-11-28T11:37:36.606Z"),
        "myState" : 1,
        "term" : NumberLong(1),
        "syncSourceHost" : "",
        "syncSourceId" : -1,
        "heartbeatIntervalMillis" : NumberLong(2000),
        "majorityVoteCount" : 2,
        "writeMajorityCount" : 2,
        "votingMembersCount" : 3,
        "writableVotingMembersCount" : 3,
        "optimes" : {
                "lastCommittedOpTime" : {
                        "ts" : Timestamp(1701171456, 1),
                        "t" : NumberLong(1)
                },
                "lastCommittedWallTime" : ISODate("2023-11-28T11:37:36.061Z"),
                "readConcernMajorityOpTime" : {
                        "ts" : Timestamp(1701171456, 1),
                        "t" : NumberLong(1)
                },
                "readConcernMajorityWallTime" : ISODate("2023-11-28T11:37:36.061Z"),
                "appliedOpTime" : {
                        "ts" : Timestamp(1701171456, 1),
                        "t" : NumberLong(1)
                },
                "durableOpTime" : {
                        "ts" : Timestamp(1701171456, 1),
                        "t" : NumberLong(1)
                },
                "lastAppliedWallTime" : ISODate("2023-11-28T11:37:36.061Z"),
                "lastDurableWallTime" : ISODate("2023-11-28T11:37:36.061Z")
        },
        "lastStableRecoveryTimestamp" : Timestamp(1701171436, 4),
        "electionCandidateMetrics" : {
                "lastElectionReason" : "electionTimeout",
                "lastElectionDate" : ISODate("2023-11-28T11:37:16.021Z"),
                "electionTerm" : NumberLong(1),
                "lastCommittedOpTimeAtElection" : {
                        "ts" : Timestamp(0, 0),
                        "t" : NumberLong(-1)
                },
                "lastSeenOpTimeAtElection" : {
                        "ts" : Timestamp(1701171424, 1),
                        "t" : NumberLong(-1)
                },
                "numVotesNeeded" : 2,
                "priorityAtElection" : 1,
                "electionTimeoutMillis" : NumberLong(10000),
                "numCatchUpOps" : NumberLong(0),
                "newTermStartDate" : ISODate("2023-11-28T11:37:16.052Z"),
                "wMajorityWriteAvailabilityDate" : ISODate("2023-11-28T11:37:17.320Z")
        },
        "members" : [
                {
                        "_id" : 0,
                        "name" : "mongodb-shard-04.unidev39.org.np:27020",
                        "health" : 1,
                        "state" : 1,
                        "stateStr" : "PRIMARY",
                        "uptime" : 228,
                        "optime" : {
                                "ts" : Timestamp(1701171456, 1),
                                "t" : NumberLong(1)
                        },
                        "optimeDate" : ISODate("2023-11-28T11:37:36Z"),
                        "lastAppliedWallTime" : ISODate("2023-11-28T11:37:36.061Z"),
                        "lastDurableWallTime" : ISODate("2023-11-28T11:37:36.061Z"),
                        "syncSourceHost" : "",
                        "syncSourceId" : -1,
                        "infoMessage" : "",
                        "electionTime" : Timestamp(1701171436, 1),
                        "electionDate" : ISODate("2023-11-28T11:37:16Z"),
                        "configVersion" : 1,
                        "configTerm" : 1,
                        "self" : true,
                        "lastHeartbeatMessage" : ""
                },
                {
                        "_id" : 1,
                        "name" : "mongodb-shard-05.unidev39.org.np:27020",
                        "health" : 1,
                        "state" : 2,
                        "stateStr" : "SECONDARY",
                        "uptime" : 31,
                        "optime" : {
                                "ts" : Timestamp(1701171446, 1),
                                "t" : NumberLong(1)
                        },
                        "optimeDurable" : {
                                "ts" : Timestamp(1701171446, 1),
                                "t" : NumberLong(1)
                        },
                        "optimeDate" : ISODate("2023-11-28T11:37:26Z"),
                        "optimeDurableDate" : ISODate("2023-11-28T11:37:26Z"),
                        "lastAppliedWallTime" : ISODate("2023-11-28T11:37:36.061Z"),
                        "lastDurableWallTime" : ISODate("2023-11-28T11:37:36.061Z"),
                        "lastHeartbeat" : ISODate("2023-11-28T11:37:36.036Z"),
                        "lastHeartbeatRecv" : ISODate("2023-11-28T11:37:35.548Z"),
                        "pingMs" : NumberLong(0),
                        "lastHeartbeatMessage" : "",
                        "syncSourceHost" : "mongodb-shard-04.unidev39.org.np:27020",
                        "syncSourceId" : 0,
                        "infoMessage" : "",
                        "configVersion" : 1,
                        "configTerm" : 1
                },
                {
                        "_id" : 2,
                        "name" : "mongodb-shard-06.unidev39.org.np:27020",
                        "health" : 1,
                        "state" : 2,
                        "stateStr" : "SECONDARY",
                        "uptime" : 31,
                        "optime" : {
                                "ts" : Timestamp(1701171446, 1),
                                "t" : NumberLong(1)
                        },
                        "optimeDurable" : {
                                "ts" : Timestamp(1701171446, 1),
                                "t" : NumberLong(1)
                        },
                        "optimeDate" : ISODate("2023-11-28T11:37:26Z"),
                        "optimeDurableDate" : ISODate("2023-11-28T11:37:26Z"),
                        "lastAppliedWallTime" : ISODate("2023-11-28T11:37:36.061Z"),
                        "lastDurableWallTime" : ISODate("2023-11-28T11:37:36.061Z"),
                        "lastHeartbeat" : ISODate("2023-11-28T11:37:36.032Z"),
                        "lastHeartbeatRecv" : ISODate("2023-11-28T11:37:35.546Z"),
                        "pingMs" : NumberLong(0),
                        "lastHeartbeatMessage" : "",
                        "syncSourceHost" : "mongodb-shard-04.unidev39.org.np:27020",
                        "syncSourceId" : 0,
                        "infoMessage" : "",
                        "configVersion" : 1,
                        "configTerm" : 1
                }
        ],
        "ok" : 1
}

rs1:PRIMARY> rs.isMaster()
{
        "topologyVersion" : {
                "processId" : ObjectId("6565d01c10c322b9b22e8acd"),
                "counter" : NumberLong(6)
        },
        "hosts" : [
                "mongodb-shard-04.unidev39.org.np:27020",
                "mongodb-shard-05.unidev39.org.np:27020",
                "mongodb-shard-06.unidev39.org.np:27020"
        ],
        "setName" : "rs1",
        "setVersion" : 1,
        "ismaster" : true,
        "secondary" : false,
        "primary" : "mongodb-shard-04.unidev39.org.np:27020",
        "me" : "mongodb-shard-04.unidev39.org.np:27020",
        "electionId" : ObjectId("7fffffff0000000000000001"),
        "lastWrite" : {
                "opTime" : {
                        "ts" : Timestamp(1701171466, 1),
                        "t" : NumberLong(1)
                },
                "lastWriteDate" : ISODate("2023-11-28T11:37:46Z"),
                "majorityOpTime" : {
                        "ts" : Timestamp(1701171466, 1),
                        "t" : NumberLong(1)
                },
                "majorityWriteDate" : ISODate("2023-11-28T11:37:46Z")
        },
        "maxBsonObjectSize" : 16777216,
        "maxMessageSizeBytes" : 48000000,
        "maxWriteBatchSize" : 100000,
        "localTime" : ISODate("2023-11-28T11:37:49.059Z"),
        "logicalSessionTimeoutMinutes" : 30,
        "connectionId" : 1,
        "minWireVersion" : 0,
        "maxWireVersion" : 9,
        "readOnly" : false,
        "ok" : 1
}

rs1:PRIMARY> rs.printSecondaryReplicationInfo()
source: mongodb-shard-05.unidev39.org.np:27020
        syncedTo: Tue Nov 28 2023 17:22:56 GMT+0545 (+0545)
        0 secs (0 hrs) behind the primary
source: mongodb-shard-06.unidev39.org.np:27020
        syncedTo: Tue Nov 28 2023 17:22:56 GMT+0545 (+0545)
        0 secs (0 hrs) behind the primary

rs1:PRIMARY> quit()
*/

-- Step 77 -->> On Node 9 (Verify the shard replica set - rs1)
[root@mongodb-shard-05 ~]# mongo --host mongodb-shard-05.unidev39.org.np --port 27020 -u admin -p P#ssw0rd --authenticationDatabase admin
/*
MongoDB shell version v4.4.26
connecting to: mongodb://mongodb-shard-05.unidev39.org.np:27020/?authSource=admin&compressors=disabled&gssapiServiceName=mongodb
Implicit session: session { "id" : UUID("0b8377eb-9fad-48fc-9050-1d878652f156") }
MongoDB server version: 4.4.26

rs1:SECONDARY> db.version()
4.4.26

rs1:SECONDARY> rs.config()
{
        "_id" : "rs1",
        "version" : 1,
        "term" : 1,
        "protocolVersion" : NumberLong(1),
        "writeConcernMajorityJournalDefault" : true,
        "members" : [
                {
                        "_id" : 0,
                        "host" : "mongodb-shard-04.unidev39.org.np:27020",
                        "arbiterOnly" : false,
                        "buildIndexes" : true,
                        "hidden" : false,
                        "priority" : 1,
                        "tags" : {

                        },
                        "slaveDelay" : NumberLong(0),
                        "votes" : 1
                },
                {
                        "_id" : 1,
                        "host" : "mongodb-shard-05.unidev39.org.np:27020",
                        "arbiterOnly" : false,
                        "buildIndexes" : true,
                        "hidden" : false,
                        "priority" : 1,
                        "tags" : {

                        },
                        "slaveDelay" : NumberLong(0),
                        "votes" : 1
                },
                {
                        "_id" : 2,
                        "host" : "mongodb-shard-06.unidev39.org.np:27020",
                        "arbiterOnly" : false,
                        "buildIndexes" : true,
                        "hidden" : false,
                        "priority" : 1,
                        "tags" : {

                        },
                        "slaveDelay" : NumberLong(0),
                        "votes" : 1
                }
        ],
        "settings" : {
                "chainingAllowed" : true,
                "heartbeatIntervalMillis" : 2000,
                "heartbeatTimeoutSecs" : 10,
                "electionTimeoutMillis" : 10000,
                "catchUpTimeoutMillis" : -1,
                "catchUpTakeoverDelayMillis" : 30000,
                "getLastErrorModes" : {

                },
                "getLastErrorDefaults" : {
                        "w" : 1,
                        "wtimeout" : 0
                },
                "replicaSetId" : ObjectId("6565d0e010c322b9b22e8ae8")
        }
}

rs1:SECONDARY> rs.status()
{
        "set" : "rs1",
        "date" : ISODate("2023-11-28T11:40:22.939Z"),
        "myState" : 2,
        "term" : NumberLong(1),
        "syncSourceHost" : "mongodb-shard-04.unidev39.org.np:27020",
        "syncSourceId" : 0,
        "heartbeatIntervalMillis" : NumberLong(2000),
        "majorityVoteCount" : 2,
        "writeMajorityCount" : 2,
        "votingMembersCount" : 3,
        "writableVotingMembersCount" : 3,
        "optimes" : {
                "lastCommittedOpTime" : {
                        "ts" : Timestamp(1701171616, 1),
                        "t" : NumberLong(1)
                },
                "lastCommittedWallTime" : ISODate("2023-11-28T11:40:16.066Z"),
                "readConcernMajorityOpTime" : {
                        "ts" : Timestamp(1701171616, 1),
                        "t" : NumberLong(1)
                },
                "readConcernMajorityWallTime" : ISODate("2023-11-28T11:40:16.066Z"),
                "appliedOpTime" : {
                        "ts" : Timestamp(1701171616, 1),
                        "t" : NumberLong(1)
                },
                "durableOpTime" : {
                        "ts" : Timestamp(1701171616, 1),
                        "t" : NumberLong(1)
                },
                "lastAppliedWallTime" : ISODate("2023-11-28T11:40:16.066Z"),
                "lastDurableWallTime" : ISODate("2023-11-28T11:40:16.066Z")
        },
        "lastStableRecoveryTimestamp" : Timestamp(1701171616, 1),
        "electionParticipantMetrics" : {
                "votedForCandidate" : true,
                "electionTerm" : NumberLong(1),
                "lastVoteDate" : ISODate("2023-11-28T11:37:16.023Z"),
                "electionCandidateMemberId" : 0,
                "voteReason" : "",
                "lastAppliedOpTimeAtElection" : {
                        "ts" : Timestamp(1701171424, 1),
                        "t" : NumberLong(-1)
                },
                "maxAppliedOpTimeInSet" : {
                        "ts" : Timestamp(1701171424, 1),
                        "t" : NumberLong(-1)
                },
                "priorityAtElection" : 1,
                "newTermStartDate" : ISODate("2023-11-28T11:37:16.052Z"),
                "newTermAppliedDate" : ISODate("2023-11-28T11:37:17.330Z")
        },
        "members" : [
                {
                        "_id" : 0,
                        "name" : "mongodb-shard-04.unidev39.org.np:27020",
                        "health" : 1,
                        "state" : 1,
                        "stateStr" : "PRIMARY",
                        "uptime" : 197,
                        "optime" : {
                                "ts" : Timestamp(1701171616, 1),
                                "t" : NumberLong(1)
                        },
                        "optimeDurable" : {
                                "ts" : Timestamp(1701171616, 1),
                                "t" : NumberLong(1)
                        },
                        "optimeDate" : ISODate("2023-11-28T11:40:16Z"),
                        "optimeDurableDate" : ISODate("2023-11-28T11:40:16Z"),
                        "lastAppliedWallTime" : ISODate("2023-11-28T11:40:16.066Z"),
                        "lastDurableWallTime" : ISODate("2023-11-28T11:40:16.066Z"),
                        "lastHeartbeat" : ISODate("2023-11-28T11:40:21.612Z"),
                        "lastHeartbeatRecv" : ISODate("2023-11-28T11:40:22.065Z"),
                        "pingMs" : NumberLong(0),
                        "lastHeartbeatMessage" : "",
                        "syncSourceHost" : "",
                        "syncSourceId" : -1,
                        "infoMessage" : "",
                        "electionTime" : Timestamp(1701171436, 1),
                        "electionDate" : ISODate("2023-11-28T11:37:16Z"),
                        "configVersion" : 1,
                        "configTerm" : 1
                },
                {
                        "_id" : 1,
                        "name" : "mongodb-shard-05.unidev39.org.np:27020",
                        "health" : 1,
                        "state" : 2,
                        "stateStr" : "SECONDARY",
                        "uptime" : 389,
                        "optime" : {
                                "ts" : Timestamp(1701171616, 1),
                                "t" : NumberLong(1)
                        },
                        "optimeDate" : ISODate("2023-11-28T11:40:16Z"),
                        "lastAppliedWallTime" : ISODate("2023-11-28T11:40:16.066Z"),
                        "lastDurableWallTime" : ISODate("2023-11-28T11:40:16.066Z"),
                        "syncSourceHost" : "mongodb-shard-04.unidev39.org.np:27020",
                        "syncSourceId" : 0,
                        "infoMessage" : "",
                        "configVersion" : 1,
                        "configTerm" : 1,
                        "self" : true,
                        "lastHeartbeatMessage" : ""
                },
                {
                        "_id" : 2,
                        "name" : "mongodb-shard-06.unidev39.org.np:27020",
                        "health" : 1,
                        "state" : 2,
                        "stateStr" : "SECONDARY",
                        "uptime" : 197,
                        "optime" : {
                                "ts" : Timestamp(1701171616, 1),
                                "t" : NumberLong(1)
                        },
                        "optimeDurable" : {
                                "ts" : Timestamp(1701171616, 1),
                                "t" : NumberLong(1)
                        },
                        "optimeDate" : ISODate("2023-11-28T11:40:16Z"),
                        "optimeDurableDate" : ISODate("2023-11-28T11:40:16Z"),
                        "lastAppliedWallTime" : ISODate("2023-11-28T11:40:16.066Z"),
                        "lastDurableWallTime" : ISODate("2023-11-28T11:40:16.066Z"),
                        "lastHeartbeat" : ISODate("2023-11-28T11:40:21.612Z"),
                        "lastHeartbeatRecv" : ISODate("2023-11-28T11:40:21.602Z"),
                        "pingMs" : NumberLong(0),
                        "lastHeartbeatMessage" : "",
                        "syncSourceHost" : "mongodb-shard-04.unidev39.org.np:27020",
                        "syncSourceId" : 0,
                        "infoMessage" : "",
                        "configVersion" : 1,
                        "configTerm" : 1
                }
        ],
        "ok" : 1
}

rs1:SECONDARY> rs.isMaster()
{
        "topologyVersion" : {
                "processId" : ObjectId("6565d02193c6b28f75622570"),
                "counter" : NumberLong(4)
        },
        "hosts" : [
                "mongodb-shard-04.unidev39.org.np:27020",
                "mongodb-shard-05.unidev39.org.np:27020",
                "mongodb-shard-06.unidev39.org.np:27020"
        ],
        "setName" : "rs1",
        "setVersion" : 1,
        "ismaster" : false,
        "secondary" : true,
        "primary" : "mongodb-shard-04.unidev39.org.np:27020",
        "me" : "mongodb-shard-05.unidev39.org.np:27020",
        "lastWrite" : {
                "opTime" : {
                        "ts" : Timestamp(1701171626, 1),
                        "t" : NumberLong(1)
                },
                "lastWriteDate" : ISODate("2023-11-28T11:40:26Z"),
                "majorityOpTime" : {
                        "ts" : Timestamp(1701171626, 1),
                        "t" : NumberLong(1)
                },
                "majorityWriteDate" : ISODate("2023-11-28T11:40:26Z")
        },
        "maxBsonObjectSize" : 16777216,
        "maxMessageSizeBytes" : 48000000,
        "maxWriteBatchSize" : 100000,
        "localTime" : ISODate("2023-11-28T11:40:27.875Z"),
        "logicalSessionTimeoutMinutes" : 30,
        "connectionId" : 20,
        "minWireVersion" : 0,
        "maxWireVersion" : 9,
        "readOnly" : false,
        "ok" : 1
}

rs1:SECONDARY> rs.printSecondaryReplicationInfo()
source: mongodb-shard-05.unidev39.org.np:27020
        syncedTo: Tue Nov 28 2023 17:25:26 GMT+0545 (+0545)
        0 secs (0 hrs) behind the primary
source: mongodb-shard-06.unidev39.org.np:27020
        syncedTo: Tue Nov 28 2023 17:25:26 GMT+0545 (+0545)
        0 secs (0 hrs) behind the primary

rs1:SECONDARY> quit()
*/

-- Step 78 -->> On Node 10 (Verify the shard replica set - rs1)
[root@mongodb-shard-06 ~]# mongo --host mongodb-shard-06.unidev39.org.np --port 27020 -u admin -p P#ssw0rd --authenticationDatabase admin
/*
MongoDB shell version v4.4.26
connecting to: mongodb://mongodb-shard-06.unidev39.org.np:27020/?authSource=admin&compressors=disabled&gssapiServiceName=mongodb
Implicit session: session { "id" : UUID("a6a3b440-5173-4412-925e-61d92ff7c911") }
MongoDB server version: 4.4.26

rs1:SECONDARY> db.version()
4.4.26

rs1:SECONDARY> rs.config()
{
        "_id" : "rs1",
        "version" : 1,
        "term" : 1,
        "protocolVersion" : NumberLong(1),
        "writeConcernMajorityJournalDefault" : true,
        "members" : [
                {
                        "_id" : 0,
                        "host" : "mongodb-shard-04.unidev39.org.np:27020",
                        "arbiterOnly" : false,
                        "buildIndexes" : true,
                        "hidden" : false,
                        "priority" : 1,
                        "tags" : {

                        },
                        "slaveDelay" : NumberLong(0),
                        "votes" : 1
                },
                {
                        "_id" : 1,
                        "host" : "mongodb-shard-05.unidev39.org.np:27020",
                        "arbiterOnly" : false,
                        "buildIndexes" : true,
                        "hidden" : false,
                        "priority" : 1,
                        "tags" : {

                        },
                        "slaveDelay" : NumberLong(0),
                        "votes" : 1
                },
                {
                        "_id" : 2,
                        "host" : "mongodb-shard-06.unidev39.org.np:27020",
                        "arbiterOnly" : false,
                        "buildIndexes" : true,
                        "hidden" : false,
                        "priority" : 1,
                        "tags" : {

                        },
                        "slaveDelay" : NumberLong(0),
                        "votes" : 1
                }
        ],
        "settings" : {
                "chainingAllowed" : true,
                "heartbeatIntervalMillis" : 2000,
                "heartbeatTimeoutSecs" : 10,
                "electionTimeoutMillis" : 10000,
                "catchUpTimeoutMillis" : -1,
                "catchUpTakeoverDelayMillis" : 30000,
                "getLastErrorModes" : {

                },
                "getLastErrorDefaults" : {
                        "w" : 1,
                        "wtimeout" : 0
                },
                "replicaSetId" : ObjectId("6565d0e010c322b9b22e8ae8")
        }
}

rs1:SECONDARY> rs.status()
{
        "set" : "rs1",
        "date" : ISODate("2023-11-28T11:42:12.667Z"),
        "myState" : 2,
        "term" : NumberLong(1),
        "syncSourceHost" : "mongodb-shard-04.unidev39.org.np:27020",
        "syncSourceId" : 0,
        "heartbeatIntervalMillis" : NumberLong(2000),
        "majorityVoteCount" : 2,
        "writeMajorityCount" : 2,
        "votingMembersCount" : 3,
        "writableVotingMembersCount" : 3,
        "optimes" : {
                "lastCommittedOpTime" : {
                        "ts" : Timestamp(1701171726, 1),
                        "t" : NumberLong(1)
                },
                "lastCommittedWallTime" : ISODate("2023-11-28T11:42:06.069Z"),
                "readConcernMajorityOpTime" : {
                        "ts" : Timestamp(1701171726, 1),
                        "t" : NumberLong(1)
                },
                "readConcernMajorityWallTime" : ISODate("2023-11-28T11:42:06.069Z"),
                "appliedOpTime" : {
                        "ts" : Timestamp(1701171726, 1),
                        "t" : NumberLong(1)
                },
                "durableOpTime" : {
                        "ts" : Timestamp(1701171726, 1),
                        "t" : NumberLong(1)
                },
                "lastAppliedWallTime" : ISODate("2023-11-28T11:42:06.069Z"),
                "lastDurableWallTime" : ISODate("2023-11-28T11:42:06.069Z")
        },
        "lastStableRecoveryTimestamp" : Timestamp(1701171676, 1),
        "electionParticipantMetrics" : {
                "votedForCandidate" : true,
                "electionTerm" : NumberLong(1),
                "lastVoteDate" : ISODate("2023-11-28T11:37:16.023Z"),
                "electionCandidateMemberId" : 0,
                "voteReason" : "",
                "lastAppliedOpTimeAtElection" : {
                        "ts" : Timestamp(1701171424, 1),
                        "t" : NumberLong(-1)
                },
                "maxAppliedOpTimeInSet" : {
                        "ts" : Timestamp(1701171424, 1),
                        "t" : NumberLong(-1)
                },
                "priorityAtElection" : 1,
                "newTermStartDate" : ISODate("2023-11-28T11:37:16.052Z"),
                "newTermAppliedDate" : ISODate("2023-11-28T11:37:17.319Z")
        },
        "members" : [
                {
                        "_id" : 0,
                        "name" : "mongodb-shard-04.unidev39.org.np:27020",
                        "health" : 1,
                        "state" : 1,
                        "stateStr" : "PRIMARY",
                        "uptime" : 307,
                        "optime" : {
                                "ts" : Timestamp(1701171726, 1),
                                "t" : NumberLong(1)
                        },
                        "optimeDurable" : {
                                "ts" : Timestamp(1701171726, 1),
                                "t" : NumberLong(1)
                        },
                        "optimeDate" : ISODate("2023-11-28T11:42:06Z"),
                        "optimeDurableDate" : ISODate("2023-11-28T11:42:06Z"),
                        "lastAppliedWallTime" : ISODate("2023-11-28T11:42:06.069Z"),
                        "lastDurableWallTime" : ISODate("2023-11-28T11:42:06.069Z"),
                        "lastHeartbeat" : ISODate("2023-11-28T11:42:11.627Z"),
                        "lastHeartbeatRecv" : ISODate("2023-11-28T11:42:12.088Z"),
                        "pingMs" : NumberLong(0),
                        "lastHeartbeatMessage" : "",
                        "syncSourceHost" : "",
                        "syncSourceId" : -1,
                        "infoMessage" : "",
                        "electionTime" : Timestamp(1701171436, 1),
                        "electionDate" : ISODate("2023-11-28T11:37:16Z"),
                        "configVersion" : 1,
                        "configTerm" : 1
                },
                {
                        "_id" : 1,
                        "name" : "mongodb-shard-05.unidev39.org.np:27020",
                        "health" : 1,
                        "state" : 2,
                        "stateStr" : "SECONDARY",
                        "uptime" : 307,
                        "optime" : {
                                "ts" : Timestamp(1701171726, 1),
                                "t" : NumberLong(1)
                        },
                        "optimeDurable" : {
                                "ts" : Timestamp(1701171726, 1),
                                "t" : NumberLong(1)
                        },
                        "optimeDate" : ISODate("2023-11-28T11:42:06Z"),
                        "optimeDurableDate" : ISODate("2023-11-28T11:42:06Z"),
                        "lastAppliedWallTime" : ISODate("2023-11-28T11:42:06.069Z"),
                        "lastDurableWallTime" : ISODate("2023-11-28T11:42:06.069Z"),
                        "lastHeartbeat" : ISODate("2023-11-28T11:42:11.628Z"),
                        "lastHeartbeatRecv" : ISODate("2023-11-28T11:42:11.663Z"),
                        "pingMs" : NumberLong(0),
                        "lastHeartbeatMessage" : "",
                        "syncSourceHost" : "mongodb-shard-04.unidev39.org.np:27020",
                        "syncSourceId" : 0,
                        "infoMessage" : "",
                        "configVersion" : 1,
                        "configTerm" : 1
                },
                {
                        "_id" : 2,
                        "name" : "mongodb-shard-06.unidev39.org.np:27020",
                        "health" : 1,
                        "state" : 2,
                        "stateStr" : "SECONDARY",
                        "uptime" : 497,
                        "optime" : {
                                "ts" : Timestamp(1701171726, 1),
                                "t" : NumberLong(1)
                        },
                        "optimeDate" : ISODate("2023-11-28T11:42:06Z"),
                        "lastAppliedWallTime" : ISODate("2023-11-28T11:42:06.069Z"),
                        "lastDurableWallTime" : ISODate("2023-11-28T11:42:06.069Z"),
                        "syncSourceHost" : "mongodb-shard-04.unidev39.org.np:27020",
                        "syncSourceId" : 0,
                        "infoMessage" : "",
                        "configVersion" : 1,
                        "configTerm" : 1,
                        "self" : true,
                        "lastHeartbeatMessage" : ""
                }
        ],
        "ok" : 1
}

rs1:SECONDARY> rs.isMaster()
{
        "topologyVersion" : {
                "processId" : ObjectId("6565d023953d0ace69fcb6bc"),
                "counter" : NumberLong(4)
        },
        "hosts" : [
                "mongodb-shard-04.unidev39.org.np:27020",
                "mongodb-shard-05.unidev39.org.np:27020",
                "mongodb-shard-06.unidev39.org.np:27020"
        ],
        "setName" : "rs1",
        "setVersion" : 1,
        "ismaster" : false,
        "secondary" : true,
        "primary" : "mongodb-shard-04.unidev39.org.np:27020",
        "me" : "mongodb-shard-06.unidev39.org.np:27020",
        "lastWrite" : {
                "opTime" : {
                        "ts" : Timestamp(1701171736, 1),
                        "t" : NumberLong(1)
                },
                "lastWriteDate" : ISODate("2023-11-28T11:42:16Z"),
                "majorityOpTime" : {
                        "ts" : Timestamp(1701171736, 1),
                        "t" : NumberLong(1)
                },
                "majorityWriteDate" : ISODate("2023-11-28T11:42:16Z")
        },
        "maxBsonObjectSize" : 16777216,
        "maxMessageSizeBytes" : 48000000,
        "maxWriteBatchSize" : 100000,
        "localTime" : ISODate("2023-11-28T11:42:17.925Z"),
        "logicalSessionTimeoutMinutes" : 30,
        "connectionId" : 20,
        "minWireVersion" : 0,
        "maxWireVersion" : 9,
        "readOnly" : false,
        "ok" : 1
}

rs1:SECONDARY> rs.printSecondaryReplicationInfo()
source: mongodb-shard-05.unidev39.org.np:27020
        syncedTo: Tue Nov 28 2023 17:27:16 GMT+0545 (+0545)
        0 secs (0 hrs) behind the primary
source: mongodb-shard-06.unidev39.org.np:27020
        syncedTo: Tue Nov 28 2023 17:27:16 GMT+0545 (+0545)
        0 secs (0 hrs) behind the primary

rs1:SECONDARY> quit()
*/

-- Step 79 -->> On Node 4 (Configure Mongos - Query Router)
[root@mongodb-mongos ~]# systemctl status mongod
/*
● mongod.service - MongoDB Database Server
   Loaded: loaded (/usr/lib/systemd/system/mongod.service; enabled; vendor preset: disabled)
   Active: active (running) since Tue 2023-11-28 14:26:31 +0545; 3h 3min ago
     Docs: https://docs.mongodb.org/manual
 Main PID: 9192 (mongod)
   Memory: 170.6M
   CGroup: /system.slice/mongod.service
           └─9192 /usr/bin/mongod -f /etc/mongod.conf

Nov 28 14:26:31 mongodb-mongos.unidev39.org.np systemd[1]: Started MongoDB Database Server.
Nov 28 14:26:31 mongodb-mongos.unidev39.org.np mongod[9192]: {"t":{"$date":"2023-11-28T08:41:31.768Z"},"s":"I",  "c":"CONTROL",  "id":7484500, "ctx":"main","msg":"Environment variable MONG>
*/

-- Step 80 -->> On Node 4
[root@mongodb-mongos ~]# systemctl stop mongod
-- Step 80.1 -->> On Node 4
[root@mongodb-mongos ~]# systemctl disable mongod
/*
Removed /etc/systemd/system/multi-user.target.wants/mongod.service.
*/

-- Step 80.2 -->> On Node 4
[root@mongodb-mongos ~]# systemctl status mongod
/*
● mongod.service - MongoDB Database Server
   Loaded: loaded (/usr/lib/systemd/system/mongod.service; disabled; vendor preset: disabled)
   Active: inactive (dead)
     Docs: https://docs.mongodb.org/manual

Nov 28 13:02:33 mongodb-mongos.unidev39.org.np systemd[1]: Started MongoDB Database Server.
Nov 28 13:02:33 mongodb-mongos.unidev39.org.np mongod[5722]: {"t":{"$date":"2023-11-28T07:17:33.788Z"},"s":"I",  "c":"CONTROL",  "id":7484500, "ctx":"main","msg":"Environment variable MONG>
Nov 28 14:26:31 mongodb-mongos.unidev39.org.np systemd[1]: Stopping MongoDB Database Server...
Nov 28 14:26:31 mongodb-mongos.unidev39.org.np systemd[1]: mongod.service: Succeeded.
Nov 28 14:26:31 mongodb-mongos.unidev39.org.np systemd[1]: Stopped MongoDB Database Server.
Nov 28 14:26:31 mongodb-mongos.unidev39.org.np systemd[1]: Started MongoDB Database Server.
Nov 28 14:26:31 mongodb-mongos.unidev39.org.np mongod[9192]: {"t":{"$date":"2023-11-28T08:41:31.768Z"},"s":"I",  "c":"CONTROL",  "id":7484500, "ctx":"main","msg":"Environment variable MONG>
Nov 28 17:44:14 mongodb-mongos.unidev39.org.np systemd[1]: Stopping MongoDB Database Server...
Nov 28 17:44:14 mongodb-mongos.unidev39.org.np systemd[1]: mongod.service: Succeeded.
Nov 28 17:44:14 mongodb-mongos.unidev39.org.np systemd[1]: Stopped MongoDB Database Server.
*/

-- Step 81 -->> On Node 4 (Create a mongos.conf file for Mongos - Query Router)
[root@mongodb-mongos ~]# vi /etc/mongos.conf
/*
# where to write logging data.
systemLog:
 destination: file
 logAppend: true
 path: /data/log/mongos.log

# network interfaces
net:
 port: 27017
 bindIp: mongodb-mongos.unidev39.org.np

#security:
security:
 keyFile: /data/mongodb/keyfile

sharding:
 configDB: configReplSet/mongodb-config-01.unidev39.org.np:27019,mongodb-config-02.unidev39.org.np:27019,mongodb-config-03.unidev39.org.np:27019
*/

-- Step 82 -->> On Node 4 (Create a mongos service for Mongos - Query Router)
[root@mongodb-mongos ~]# vi /usr/lib/systemd/system/mongos.service
/*
[Unit]
Description=Mongo Cluster Router
After=network.target

[Service]
User=mongod
Group=mongod

ExecStart=/usr/bin/mongos --config /etc/mongos.conf

LimitFSIZE=infinity
LimitCPU=infinity
LimitAS=infinity

LimitNOFILE=64000
LimitNPROC=64000

TasksMax=infinity
TasksAccounting=false

[Install]
WantedBy=multi-user.target
*/

-- Step 83 -->> On Node 4 (Start mongos service for Mongos - Query Router)
[root@mongodb-mongos ~]# systemctl start mongos
-- Step 83.1 -->> On Node 4
[root@mongodb-mongos ~]# systemctl enable mongos --now
-- Step 83.2 -->> On Node 4
[root@mongodb-mongos ~]# systemctl status mongos
/*
● mongos.service - Mongo Cluster Router
   Loaded: loaded (/usr/lib/systemd/system/mongos.service; enabled; vendor preset: disabled)
   Active: active (running) since Tue 2023-11-28 18:09:27 +0545; 16s ago
 Main PID: 18802 (mongos)
   Memory: 15.7M
   CGroup: /system.slice/mongos.service
           └─18802 /usr/bin/mongos --config /etc/mongos.conf

Nov 28 18:09:27 mongodb-mongos.unidev39.org.np systemd[1]: Started Mongo Cluster Router.
*/

-- Step 84 -->> On Node 4 (Add Shards rs0 & rs1 to the Cluster)
[root@mongodb-mongos ~]# mongo --host mongodb-mongos.unidev39.org.np --port 27017 -u admin -p P#ssw0rd --authenticationDatabase admin
/*
MongoDB shell version v4.4.26
connecting to: mongodb://mongodb-mongos.unidev39.org.np:27017/?authSource=admin&compressors=disabled&gssapiServiceName=mongodb
Implicit session: session { "id" : UUID("fea210bd-f858-40ea-a1a3-e18e18dcfa6d") }
MongoDB server version: 4.4.26

mongos> db.version()
4.4.26

mongos> show dbs
admin   0.000GB
config  0.000GB

mongos> use admin
switched to db admin

mongos> db.getUsers()
[
        {
                "_id" : "admin.admin",
                "userId" : UUID("83b59d6e-141a-4c8a-940f-a9983532ec30"),
                "user" : "admin",
                "db" : "admin",
                "roles" : [
                        {
                                "role" : "userAdminAnyDatabase",
                                "db" : "admin"
                        },
                        {
                                "role" : "clusterAdmin",
                                "db" : "admin"
                        },
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

mongos> sh.addShard( "rs0/mongodb-shard-01.unidev39.org.np:27018,mongodb-shard-02.unidev39.org.np:27018,mongodb-shard-03.unidev39.org.np:27018" )
{
        "shardAdded" : "rs0",
        "ok" : 1,
        "operationTime" : Timestamp(1701174808, 8),
        "$clusterTime" : {
                "clusterTime" : Timestamp(1701174808, 8),
                "signature" : {
                        "hash" : BinData(0,"UMqZNrok+nwmFhr4brPGmkY26xo="),
                        "keyId" : NumberLong("7306436173105201174")
                }
        }
}

mongos> sh.addShard( "rs1/mongodb-shard-04.unidev39.org.np:27020,mongodb-shard-05.unidev39.org.np:27020,mongodb-shard-06.unidev39.org.np:27020" )
{
        "shardAdded" : "rs1",
        "ok" : 1,
        "operationTime" : Timestamp(1701174829, 6),
        "$clusterTime" : {
                "clusterTime" : Timestamp(1701174829, 7),
                "signature" : {
                        "hash" : BinData(0,"dQg9SaDwNPRPFQ0u4hVPpyE5yHo="),
                        "keyId" : NumberLong("7306436173105201174")
                }
        }
}

mongos> quit()
*/

--Enable Sharding
-- Step 85 -->> On Node 4 (Enable Sharding at Database Level)
[root@mongodb-mongos ~]# mongo --host mongodb-mongos.unidev39.org.np --port 27017 -u admin -p P#ssw0rd --authenticationDatabase admin
/*
MongoDB shell version v4.4.26
connecting to: mongodb://mongodb-mongos.unidev39.org.np:27017/?authSource=admin&compressors=disabled&gssapiServiceName=mongodb
Implicit session: session { "id" : UUID("45de0b1f-7265-4b57-8eed-63e5761c2112") }
MongoDB server version: 4.4.26

mongos> show dbs
admin   0.000GB
config  0.003GB

mongos> use devesh
switched to db devesh

mongos> db
devesh

mongos> sh.enableSharding("devesh")
{
        "ok" : 1,
        "operationTime" : Timestamp(1701175414, 9),
        "$clusterTime" : {
                "clusterTime" : Timestamp(1701175414, 9),
                "signature" : {
                        "hash" : BinData(0,"OYdEGlBMAHEegZ4Bc4wVacUPnmk="),
                        "keyId" : NumberLong("7306436173105201174")
                }
        }
}

mongos> db.createCollection('tbl_cib_2')
{
        "ok" : 1,
        "operationTime" : Timestamp(1701175488, 2),
        "$clusterTime" : {
                "clusterTime" : Timestamp(1701175488, 2),
                "signature" : {
                        "hash" : BinData(0,"l0B40P8AJta9DeAeh2MqPIMYXT0="),
                        "keyId" : NumberLong("7306436173105201174")
                }
        }
}

mongos> db.tbl_cib_1.insertOne({name: "Devesh", age: 44})
{
        "acknowledged" : true,
        "insertedId" : ObjectId("6565e0efa9b669adee85635d")
}

mongos> db.tbl_cib_1.insertMany([{name: "Devesh", age: 44}, {name: "Madhu", age: 44}])
{
        "acknowledged" : true,
        "insertedIds" : [
                ObjectId("6565e0f7a9b669adee85635e"),
                ObjectId("6565e0f7a9b669adee85635f")
        ]
}

mongos> db.tbl_cib_1.bulkWrite([
... { insertOne : { document : { name: "Devesh", age: 25 } } },
... { updateOne : { filter : { name: "Madhu" }, update : { $set : { age: 40 } } } },
... { deleteOne : { filter : { name: "Manish" } } }
... ])
{
        "acknowledged" : true,
        "deletedCount" : 0,
        "insertedCount" : 1,
        "matchedCount" : 1,
        "upsertedCount" : 0,
        "insertedIds" : {
                "0" : ObjectId("6565e0ffa9b669adee856360")
        },
        "upsertedIds" : {

        }
}

mongos> use config
switched to db config

mongos> db
config

mongos> db.databases.find()
{ "_id" : "devesh", "primary" : "rs1", "partitioned" : true, "version" : { "uuid" : UUID("b8829b9a-7fba-42de-a60a-2bbc9b02926c"), "lastMod" : 1 } }
*/


-- Step 86 -->> On Node 4 (Enable Sharding at Collection Level)
[root@mongodb-mongos ~]# mongo --host mongodb-mongos.unidev39.org.np --port 27017 -u admin -p P#ssw0rd --authenticationDatabase admin
/*
MongoDB shell version v4.4.26
connecting to: mongodb://mongodb-mongos.unidev39.org.np:27017/?authSource=admin&compressors=disabled&gssapiServiceName=mongodb
Implicit session: session { "id" : UUID("8566fbb4-d3c7-4477-b8b9-b7cd8753baa2") }
MongoDB server version: 4.4.26

mongos> show dbs
admin   0.000GB
config  0.003GB
devesh  0.000GB

mongos> use devesh
switched to db devesh

mongos> db
devesh

mongos> db.tbl_cib_2.ensureIndex( { _id : "hashed" } )
{
        "raw" : {
                "rs1/mongodb-shard-04.unidev39.org.np:27020,mongodb-shard-05.unidev39.org.np:27020,mongodb-shard-06.unidev39.org.np:27020" : {
                        "createdCollectionAutomatically" : true,
                        "numIndexesBefore" : 1,
                        "numIndexesAfter" : 2,
                        "commitQuorum" : "votingMembers",
                        "ok" : 1
                }
        },
        "ok" : 1,
        "operationTime" : Timestamp(1701176040, 2),
        "$clusterTime" : {
                "clusterTime" : Timestamp(1701176040, 2),
                "signature" : {
                        "hash" : BinData(0,"KRuI4X+aukFVZkOSxYberiUZUTA="),
                        "keyId" : NumberLong("7306436173105201174")
                }
        }
}

mongos> sh.shardCollection( "devesh.tbl_cib_2", { "_id" : "hashed" } )
{
        "collectionsharded" : "devesh.tbl_cib_2",
        "collectionUUID" : UUID("36dd4699-7fb5-4ac7-aa53-29a9fbee74d7"),
        "ok" : 1,
        "operationTime" : Timestamp(1701176116, 24),
        "$clusterTime" : {
                "clusterTime" : Timestamp(1701176116, 24),
                "signature" : {
                        "hash" : BinData(0,"JlPzZxAdwQLbudQrMCOBa1SPaJk="),
                        "keyId" : NumberLong("7306436173105201174")
                }
        }
}
mongos> use config
switched to db config

mongos> db
config

mongos> db.databases.find()
{ "_id" : "devesh", "primary" : "rs1", "partitioned" : true, "version" : { "uuid" : UUID("b8829b9a-7fba-42de-a60a-2bbc9b02926c"), "lastMod" : 1 } }

mongos> use devesh
switched to db devesh

mongos> db
devesh

mongos> for (var i = 1; i <= 500; i++) db.tbl_cib_2.insert( { x : i } )
WriteResult({ "nInserted" : 1 })

mongos> db.tbl_cib_2.getShardDistribution()

Shard rs1 at rs1/mongodb-shard-04.unidev39.org.np:27020,mongodb-shard-05.unidev39.org.np:27020,mongodb-shard-06.unidev39.org.np:27020
 data : 8KiB docs : 256 chunks : 2
 estimated data per chunk : 4KiB
 estimated docs per chunk : 128

Shard rs0 at rs0/mongodb-shard-01.unidev39.org.np:27018,mongodb-shard-02.unidev39.org.np:27018,mongodb-shard-03.unidev39.org.np:27018
 data : 7KiB docs : 244 chunks : 2
 estimated data per chunk : 3KiB
 estimated docs per chunk : 122

Totals
 data : 16KiB docs : 500 chunks : 4
 Shard rs1 contains 51.2% data, 51.2% docs in cluster, avg obj size on shard : 33B
 Shard rs0 contains 48.8% data, 48.8% docs in cluster, avg obj size on shard : 33B

mongos> quit()
*/

-- Step 87 -->> On Node 4 (Verify the MongoDB Sharded Cluster - Query Router)
[root@mongodb-mongos ~]# mongo --host mongodb-mongos.unidev39.org.np --port 27017 -u admin -p P#ssw0rd --authenticationDatabase admin
/*
MongoDB shell version v4.4.26
connecting to: mongodb://mongodb-mongos.unidev39.org.np:27017/?authSource=admin&compressors=disabled&gssapiServiceName=mongodb
Implicit session: session { "id" : UUID("164598bd-654f-410a-81e0-8a742e686b03") }
MongoDB server version: 4.4.26

mongos> use devesh
switched to db devesh

mongos> db
devesh

mongos> db.tbl_cib_1.getShardDistribution()
Collection devesh.tbl_cib_1 is not sharded.

mongos> sh.shardCollection( "devesh.tbl_cib_1", { "_id" : "hashed" } )
{
        "ok" : 0,
        "errmsg" : "Please create an index that starts with the proposed shard key before sharding the collection",
        "code" : 72,
        "codeName" : "InvalidOptions",
        "operationTime" : Timestamp(1701176394, 5),
        "$clusterTime" : {
                "clusterTime" : Timestamp(1701176394, 5),
                "signature" : {
                        "hash" : BinData(0,"1Wxz6hIM3h4G3phQqOVESh/4Up4="),
                        "keyId" : NumberLong("7306436173105201174")
                }
        }
}

mongos> db.tbl_cib_1.getShardDistribution()
Collection devesh.tbl_cib_1 is not sharded.

mongos> show collections
tbl_cib_1
tbl_cib_2

mongos> db.tbl_cib_1.ensureIndex( { _id : "hashed" } )
{
        "raw" : {
                "rs1/mongodb-shard-04.unidev39.org.np:27020,mongodb-shard-05.unidev39.org.np:27020,mongodb-shard-06.unidev39.org.np:27020" : {
                        "createdCollectionAutomatically" : false,
                        "numIndexesBefore" : 1,
                        "numIndexesAfter" : 2,
                        "commitQuorum" : "votingMembers",
                        "ok" : 1
                }
        },
        "ok" : 1,
        "operationTime" : Timestamp(1701176457, 8),
        "$clusterTime" : {
                "clusterTime" : Timestamp(1701176457, 8),
                "signature" : {
                        "hash" : BinData(0,"HOON/oPBm/UPTAwtWXX1wj5RZ8A="),
                        "keyId" : NumberLong("7306436173105201174")
                }
        }
}

mongos> sh.shardCollection( "devesh.tbl_cib_1", { "_id" : "hashed" } )
{
        "collectionsharded" : "devesh.tbl_cib_1",
        "collectionUUID" : UUID("533b2019-c144-4116-b7b8-6620259c3a78"),
        "ok" : 1,
        "operationTime" : Timestamp(1701176463, 10),
        "$clusterTime" : {
                "clusterTime" : Timestamp(1701176463, 10),
                "signature" : {
                        "hash" : BinData(0,"RgOs/mzJxbEfvO9Tv5cPZvI+Yio="),
                        "keyId" : NumberLong("7306436173105201174")
                }
        }
}

mongos> db.tbl_cib_1.getShardDistribution()

Shard rs1 at rs1/mongodb-shard-04.unidev39.org.np:27020,mongodb-shard-05.unidev39.org.np:27020,mongodb-shard-06.unidev39.org.np:27020
 data : 207B docs : 4 chunks : 1
 estimated data per chunk : 207B
 estimated docs per chunk : 4

Totals
 data : 207B docs : 4 chunks : 1
 Shard rs1 contains 100% data, 100% docs in cluster, avg obj size on shard : 51B

mongos> db.tbl_cib_1.find().pretty()
{
        "_id" : ObjectId("6565e0efa9b669adee85635d"),
        "name" : "Devesh",
        "age" : 44
}
{
        "_id" : ObjectId("6565e0f7a9b669adee85635e"),
        "name" : "Devesh",
        "age" : 44
}
{
        "_id" : ObjectId("6565e0f7a9b669adee85635f"),
        "name" : "Madhu",
        "age" : 40
}
{
        "_id" : ObjectId("6565e0ffa9b669adee856360"),
        "name" : "Devesh",
        "age" : 25
}

mongos> quit()
*/

-- Step 88 -->> On Node 1 (Verify the MongoDB Sharded Cluster - Config)
[root@mongodb-config-01 ~]# mongo --host mongodb-config-01.unidev39.org.np --port 27019 -u admin -p P#ssw0rd --authenticationDatabase admin
/*
MongoDB shell version v4.4.26
connecting to: mongodb://mongodb-config-01.unidev39.org.np:27019/?authSource=admin&compressors=disabled&gssapiServiceName=mongodb
Implicit session: session { "id" : UUID("d880eb62-91ec-414a-9937-398674b2a711") }
MongoDB server version: 4.4.26

configReplSet:PRIMARY> show dbs
admin   0.000GB
config  0.002GB
local   0.003GB

configReplSet:PRIMARY> quit()
*/

-- Step 89 -->> On Node 2 (Verify the MongoDB Sharded Cluster - Config)
[root@mongodb-config-02 ~]# mongo --host mongodb-config-02.unidev39.org.np --port 27019 -u admin -p P#ssw0rd --authenticationDatabase admin
/*
MongoDB shell version v4.4.26
connecting to: mongodb://mongodb-config-02.unidev39.org.np:27019/?authSource=admin&compressors=disabled&gssapiServiceName=mongodb
Implicit session: session { "id" : UUID("89a87bb6-d4a0-4328-b437-49107021efc1") }
MongoDB server version: 4.4.26

configReplSet:SECONDARY>  rs.secondaryOk()

configReplSet:SECONDARY> show dbs
admin   0.000GB
config  0.002GB
local   0.004GB

configReplSet:SECONDARY> quit()
*/

-- Step 90 -->> On Node 3 (Verify the MongoDB Sharded Cluster - Config)
[root@mongodb-config-03 ~]# mongo --host mongodb-config-03.unidev39.org.np --port 27019 -u admin -p P#ssw0rd --authenticationDatabase admin
/*
MongoDB shell version v4.4.26
connecting to: mongodb://mongodb-config-03.unidev39.org.np:27019/?authSource=admin&compressors=disabled&gssapiServiceName=mongodb
Implicit session: session { "id" : UUID("5e025142-1194-427d-939b-7f7cf5764f09") }
MongoDB server version: 4.4.26

configReplSet:SECONDARY> rs.secondaryOk()

configReplSet:SECONDARY> show dbs
admin   0.000GB
config  0.002GB
local   0.004GB

configReplSet:SECONDARY> quit()
*/

-- Step 91 -->> On Node 4 (Verify the MongoDB Sharded Cluster - Query Router)
[root@mongodb-mongos ~]# mongo --host mongodb-mongos.unidev39.org.np --port 27017 -u admin -p P#ssw0rd --authenticationDatabase admin
/*
MongoDB shell version v4.4.26
connecting to: mongodb://mongodb-mongos.unidev39.org.np:27017/?authSource=admin&compressors=disabled&gssapiServiceName=mongodb
Implicit session: session { "id" : UUID("75d468e2-44e0-4726-8609-0853d5b94237") }
MongoDB server version: 4.4.26

mongos> show dbs
admin   0.000GB
config  0.003GB
devesh  0.000GB

mongos> use devesh
switched to db devesh

mongos> show collections
tbl_cib_1
tbl_cib_2

mongos> db.tbl_cib_1.getShardDistribution()

Shard rs1 at rs1/mongodb-shard-04.unidev39.org.np:27020,mongodb-shard-05.unidev39.org.np:27020,mongodb-shard-06.unidev39.org.np:27020
 data : 3KiB docs : 73 chunks : 1
 estimated data per chunk : 3KiB
 estimated docs per chunk : 73

Totals
 data : 3KiB docs : 73 chunks : 1
 Shard rs1 contains 100% data, 100% docs in cluster, avg obj size on shard : 51B

mongos> db.tbl_cib_2.getShardDistribution()

Shard rs0 at rs0/mongodb-shard-01.unidev39.org.np:27018,mongodb-shard-02.unidev39.org.np:27018,mongodb-shard-03.unidev39.org.np:27018
 data : 7KiB docs : 244 chunks : 2
 estimated data per chunk : 3KiB
 estimated docs per chunk : 122

Shard rs1 at rs1/mongodb-shard-04.unidev39.org.np:27020,mongodb-shard-05.unidev39.org.np:27020,mongodb-shard-06.unidev39.org.np:27020
 data : 8KiB docs : 256 chunks : 2
 estimated data per chunk : 4KiB
 estimated docs per chunk : 128

Totals
 data : 16KiB docs : 500 chunks : 4
 Shard rs0 contains 48.8% data, 48.8% docs in cluster, avg obj size on shard : 33B
 Shard rs1 contains 51.2% data, 51.2% docs in cluster, avg obj size on shard : 33B

mongos> quit()
*/

-- Step 92 -->> On Node 5 (Verify the MongoDB Sharded Cluster - rs0)
[root@mongodb-shard-01 ~]# mongo --host mongodb-shard-01.unidev39.org.np --port 27018 -u admin -p P#ssw0rd --authenticationDatabase admin
/*
MongoDB shell version v4.4.26
connecting to: mongodb://mongodb-shard-01.unidev39.org.np:27018/?authSource=admin&compressors=disabled&gssapiServiceName=mongodb
Implicit session: session { "id" : UUID("e784e298-7fd3-4622-86a6-7fa92316a6b3") }
MongoDB server version: 4.4.26

rs0:PRIMARY> show dbs
admin   0.000GB
config  0.001GB
devesh  0.000GB
local   0.001GB

rs0:PRIMARY> use devesh
switched to db devesh

rs0:PRIMARY> show collections
tbl_cib_2

rs0:PRIMARY> db.tbl_cib_2.find().pretty()
{ "_id" : ObjectId("6565e388696c2d2c743f3847"), "x" : 1 }
{ "_id" : ObjectId("6565e388696c2d2c743f3848"), "x" : 2 }
{ "_id" : ObjectId("6565e388696c2d2c743f3849"), "x" : 3 }
{ "_id" : ObjectId("6565e388696c2d2c743f384b"), "x" : 5 }
{ "_id" : ObjectId("6565e388696c2d2c743f384d"), "x" : 7 }
{ "_id" : ObjectId("6565e388696c2d2c743f3850"), "x" : 10 }
{ "_id" : ObjectId("6565e388696c2d2c743f3851"), "x" : 11 }
{ "_id" : ObjectId("6565e388696c2d2c743f3852"), "x" : 12 }
{ "_id" : ObjectId("6565e388696c2d2c743f3853"), "x" : 13 }
{ "_id" : ObjectId("6565e388696c2d2c743f3854"), "x" : 14 }
{ "_id" : ObjectId("6565e388696c2d2c743f3856"), "x" : 16 }
{ "_id" : ObjectId("6565e388696c2d2c743f3859"), "x" : 19 }
{ "_id" : ObjectId("6565e388696c2d2c743f385a"), "x" : 20 }
{ "_id" : ObjectId("6565e388696c2d2c743f385b"), "x" : 21 }
{ "_id" : ObjectId("6565e388696c2d2c743f385e"), "x" : 24 }
{ "_id" : ObjectId("6565e388696c2d2c743f3862"), "x" : 28 }
{ "_id" : ObjectId("6565e388696c2d2c743f3863"), "x" : 29 }
{ "_id" : ObjectId("6565e388696c2d2c743f3865"), "x" : 31 }
{ "_id" : ObjectId("6565e389696c2d2c743f386b"), "x" : 37 }
{ "_id" : ObjectId("6565e389696c2d2c743f386d"), "x" : 39 }
Type "it" for more

rs0:PRIMARY> quit()
*/

-- Step 93 -->> On Node 6 (Verify the MongoDB Sharded Cluster - rs0)
[root@mongodb-shard-02 ~]# mongo --host mongodb-shard-02.unidev39.org.np --port 27018 -u admin -p P#ssw0rd --authenticationDatabase admin
/*
MongoDB shell version v4.4.26
connecting to: mongodb://mongodb-shard-02.unidev39.org.np:27018/?authSource=admin&compressors=disabled&gssapiServiceName=mongodb
Implicit session: session { "id" : UUID("f053eac9-1502-4bb6-b707-d0e289b5e9d9") }
MongoDB server version: 4.4.26

rs0:SECONDARY> rs.secondaryOk()

rs0:SECONDARY> show dbs
admin   0.000GB
config  0.001GB
devesh  0.000GB
local   0.001GB

rs0:SECONDARY> use devesh
switched to db devesh

rs0:SECONDARY> show collections
tbl_cib_2

rs0:SECONDARY> db.tbl_cib_2.find().pretty()
{ "_id" : ObjectId("6565e388696c2d2c743f3847"), "x" : 1 }
{ "_id" : ObjectId("6565e388696c2d2c743f3848"), "x" : 2 }
{ "_id" : ObjectId("6565e388696c2d2c743f3849"), "x" : 3 }
{ "_id" : ObjectId("6565e388696c2d2c743f384b"), "x" : 5 }
{ "_id" : ObjectId("6565e388696c2d2c743f384d"), "x" : 7 }
{ "_id" : ObjectId("6565e388696c2d2c743f3850"), "x" : 10 }
{ "_id" : ObjectId("6565e388696c2d2c743f3851"), "x" : 11 }
{ "_id" : ObjectId("6565e388696c2d2c743f3852"), "x" : 12 }
{ "_id" : ObjectId("6565e388696c2d2c743f3853"), "x" : 13 }
{ "_id" : ObjectId("6565e388696c2d2c743f3854"), "x" : 14 }
{ "_id" : ObjectId("6565e388696c2d2c743f3856"), "x" : 16 }
{ "_id" : ObjectId("6565e388696c2d2c743f3859"), "x" : 19 }
{ "_id" : ObjectId("6565e388696c2d2c743f385a"), "x" : 20 }
{ "_id" : ObjectId("6565e388696c2d2c743f385b"), "x" : 21 }
{ "_id" : ObjectId("6565e388696c2d2c743f385e"), "x" : 24 }
{ "_id" : ObjectId("6565e388696c2d2c743f3862"), "x" : 28 }
{ "_id" : ObjectId("6565e388696c2d2c743f3863"), "x" : 29 }
{ "_id" : ObjectId("6565e388696c2d2c743f3865"), "x" : 31 }
{ "_id" : ObjectId("6565e389696c2d2c743f386b"), "x" : 37 }
{ "_id" : ObjectId("6565e389696c2d2c743f386d"), "x" : 39 }
Type "it" for more

rs0:SECONDARY> quit()
*/

-- Step 94 -->> On Node 7 (Verify the MongoDB Sharded Cluster - rs0)
[root@mongodb-shard-03 ~]# mongo --host mongodb-shard-03.unidev39.org.np --port 27018 -u admin -p P#ssw0rd --authenticationDatabase admin
/*
MongoDB shell version v4.4.26
connecting to: mongodb://mongodb-shard-03.unidev39.org.np:27018/?authSource=admin&compressors=disabled&gssapiServiceName=mongodb
Implicit session: session { "id" : UUID("59c6e19e-d0fc-473d-8ee3-6fb47740d9ed") }
MongoDB server version: 4.4.26

rs0:SECONDARY> rs.secondaryOk()

rs0:SECONDARY> show dbs
admin   0.000GB
config  0.001GB
devesh  0.000GB
local   0.001GB

rs0:SECONDARY> use devesh
switched to db devesh

rs0:SECONDARY> show collections
tbl_cib_2

rs0:SECONDARY> db.tbl_cib_2.find().pretty()
{ "_id" : ObjectId("6565e388696c2d2c743f3847"), "x" : 1 }
{ "_id" : ObjectId("6565e388696c2d2c743f3848"), "x" : 2 }
{ "_id" : ObjectId("6565e388696c2d2c743f3849"), "x" : 3 }
{ "_id" : ObjectId("6565e388696c2d2c743f384b"), "x" : 5 }
{ "_id" : ObjectId("6565e388696c2d2c743f384d"), "x" : 7 }
{ "_id" : ObjectId("6565e388696c2d2c743f3850"), "x" : 10 }
{ "_id" : ObjectId("6565e388696c2d2c743f3851"), "x" : 11 }
{ "_id" : ObjectId("6565e388696c2d2c743f3852"), "x" : 12 }
{ "_id" : ObjectId("6565e388696c2d2c743f3853"), "x" : 13 }
{ "_id" : ObjectId("6565e388696c2d2c743f3854"), "x" : 14 }
{ "_id" : ObjectId("6565e388696c2d2c743f3856"), "x" : 16 }
{ "_id" : ObjectId("6565e388696c2d2c743f3859"), "x" : 19 }
{ "_id" : ObjectId("6565e388696c2d2c743f385a"), "x" : 20 }
{ "_id" : ObjectId("6565e388696c2d2c743f385b"), "x" : 21 }
{ "_id" : ObjectId("6565e388696c2d2c743f385e"), "x" : 24 }
{ "_id" : ObjectId("6565e388696c2d2c743f3862"), "x" : 28 }
{ "_id" : ObjectId("6565e388696c2d2c743f3863"), "x" : 29 }
{ "_id" : ObjectId("6565e388696c2d2c743f3865"), "x" : 31 }
{ "_id" : ObjectId("6565e389696c2d2c743f386b"), "x" : 37 }
{ "_id" : ObjectId("6565e389696c2d2c743f386d"), "x" : 39 }
Type "it" for more
rs0:SECONDARY> quit()
*/

-- Step 95 -->> On Node 8 (Verify the MongoDB Sharded Cluster - rs1)
[root@mongodb-shard-04 ~]# mongo --host mongodb-shard-04.unidev39.org.np --port 27020 -u admin -p P#ssw0rd --authenticationDatabase admin
/*
MongoDB shell version v4.4.26
connecting to: mongodb://mongodb-shard-04.unidev39.org.np:27020/?authSource=admin&compressors=disabled&gssapiServiceName=mongodb
Implicit session: session { "id" : UUID("5426e85f-fd7b-4f22-ae7d-77b264764733") }
MongoDB server version: 4.4.26

rs1:PRIMARY> show dbs
admin   0.000GB
config  0.001GB
devesh  0.000GB
local   0.001GB

rs1:PRIMARY> use devesh
switched to db devesh

rs1:PRIMARY> show collections
tbl_cib_1
tbl_cib_2

rs1:PRIMARY> db.tbl_cib_2.find().pretty()
{ "_id" : ObjectId("6565e388696c2d2c743f384a"), "x" : 4 }
{ "_id" : ObjectId("6565e388696c2d2c743f384c"), "x" : 6 }
{ "_id" : ObjectId("6565e388696c2d2c743f384e"), "x" : 8 }
{ "_id" : ObjectId("6565e388696c2d2c743f384f"), "x" : 9 }
{ "_id" : ObjectId("6565e388696c2d2c743f3855"), "x" : 15 }
{ "_id" : ObjectId("6565e388696c2d2c743f3857"), "x" : 17 }
{ "_id" : ObjectId("6565e388696c2d2c743f3858"), "x" : 18 }
{ "_id" : ObjectId("6565e388696c2d2c743f385c"), "x" : 22 }
{ "_id" : ObjectId("6565e388696c2d2c743f385d"), "x" : 23 }
{ "_id" : ObjectId("6565e388696c2d2c743f385f"), "x" : 25 }
{ "_id" : ObjectId("6565e388696c2d2c743f3860"), "x" : 26 }
{ "_id" : ObjectId("6565e388696c2d2c743f3861"), "x" : 27 }
{ "_id" : ObjectId("6565e388696c2d2c743f3864"), "x" : 30 }
{ "_id" : ObjectId("6565e388696c2d2c743f3866"), "x" : 32 }
{ "_id" : ObjectId("6565e388696c2d2c743f3867"), "x" : 33 }
{ "_id" : ObjectId("6565e389696c2d2c743f3868"), "x" : 34 }
{ "_id" : ObjectId("6565e389696c2d2c743f3869"), "x" : 35 }
{ "_id" : ObjectId("6565e389696c2d2c743f386a"), "x" : 36 }
{ "_id" : ObjectId("6565e389696c2d2c743f386c"), "x" : 38 }
{ "_id" : ObjectId("6565e389696c2d2c743f3872"), "x" : 44 }
Type "it" for more

rs1:PRIMARY> db.tbl_cib_1.find().pretty()
{
        "_id" : ObjectId("6565e0efa9b669adee85635d"),
        "name" : "Devesh",
        "age" : 44
}
{
        "_id" : ObjectId("6565e0f7a9b669adee85635e"),
        "name" : "Devesh",
        "age" : 44
}
{
        "_id" : ObjectId("6565e0f7a9b669adee85635f"),
        "name" : "Madhu",
        "age" : 40
}
{
        "_id" : ObjectId("6565e0ffa9b669adee856360"),
        "name" : "Devesh",
        "age" : 25
}
{
        "_id" : ObjectId("6565e54d78745da3e2c39c9b"),
        "name" : "Devesh",
        "age" : 25
}
{
        "_id" : ObjectId("6565e58578745da3e2c39c9c"),
        "name" : "Devesh",
        "age" : 44
}
{
        "_id" : ObjectId("6565e58578745da3e2c39c9d"),
        "name" : "Madhu",
        "age" : 44
}
{
        "_id" : ObjectId("6565e58878745da3e2c39c9e"),
        "name" : "Devesh",
        "age" : 44
}
{
        "_id" : ObjectId("6565e58878745da3e2c39c9f"),
        "name" : "Madhu",
        "age" : 44
}
{
        "_id" : ObjectId("6565e58978745da3e2c39ca0"),
        "name" : "Devesh",
        "age" : 44
}
{
        "_id" : ObjectId("6565e58978745da3e2c39ca1"),
        "name" : "Madhu",
        "age" : 44
}
{
        "_id" : ObjectId("6565e58978745da3e2c39ca2"),
        "name" : "Devesh",
        "age" : 44
}
{
        "_id" : ObjectId("6565e58978745da3e2c39ca3"),
        "name" : "Madhu",
        "age" : 44
}
{
        "_id" : ObjectId("6565e58a78745da3e2c39ca4"),
        "name" : "Devesh",
        "age" : 44
}
{
        "_id" : ObjectId("6565e58a78745da3e2c39ca5"),
        "name" : "Madhu",
        "age" : 44
}
{
        "_id" : ObjectId("6565e58a78745da3e2c39ca6"),
        "name" : "Devesh",
        "age" : 44
}
{
        "_id" : ObjectId("6565e58a78745da3e2c39ca7"),
        "name" : "Madhu",
        "age" : 44
}
{
        "_id" : ObjectId("6565e58b78745da3e2c39ca8"),
        "name" : "Devesh",
        "age" : 44
}
{
        "_id" : ObjectId("6565e58b78745da3e2c39ca9"),
        "name" : "Madhu",
        "age" : 44
}
{
        "_id" : ObjectId("6565e58b78745da3e2c39caa"),
        "name" : "Devesh",
        "age" : 44
}
Type "it" for more

rs1:PRIMARY> quit()
*/

-- Step 96 -->> On Node 9 (Verify the MongoDB Sharded Cluster - rs1)
[root@mongodb-shard-05 ~]# mongo --host mongodb-shard-05.unidev39.org.np --port 27020 -u admin -p P#ssw0rd --authenticationDatabase admin
/*
MongoDB shell version v4.4.26
connecting to: mongodb://mongodb-shard-05.unidev39.org.np:27020/?authSource=admin&compressors=disabled&gssapiServiceName=mongodb
Implicit session: session { "id" : UUID("3bf18e7f-3d43-4b94-a8d3-060bda6b775b") }
MongoDB server version: 4.4.26

rs1:SECONDARY> rs.secondaryOk()

rs1:SECONDARY> show dbs
admin   0.000GB
config  0.001GB
devesh  0.000GB
local   0.001GB

rs1:SECONDARY> use devesh
switched to db devesh

rs1:SECONDARY> show collections
tbl_cib_1
tbl_cib_2

rs1:SECONDARY> db.tbl_cib_2.find().pretty()
{ "_id" : ObjectId("6565e388696c2d2c743f384a"), "x" : 4 }
{ "_id" : ObjectId("6565e388696c2d2c743f384c"), "x" : 6 }
{ "_id" : ObjectId("6565e388696c2d2c743f384e"), "x" : 8 }
{ "_id" : ObjectId("6565e388696c2d2c743f384f"), "x" : 9 }
{ "_id" : ObjectId("6565e388696c2d2c743f3855"), "x" : 15 }
{ "_id" : ObjectId("6565e388696c2d2c743f3857"), "x" : 17 }
{ "_id" : ObjectId("6565e388696c2d2c743f3858"), "x" : 18 }
{ "_id" : ObjectId("6565e388696c2d2c743f385c"), "x" : 22 }
{ "_id" : ObjectId("6565e388696c2d2c743f385d"), "x" : 23 }
{ "_id" : ObjectId("6565e388696c2d2c743f385f"), "x" : 25 }
{ "_id" : ObjectId("6565e388696c2d2c743f3860"), "x" : 26 }
{ "_id" : ObjectId("6565e388696c2d2c743f3861"), "x" : 27 }
{ "_id" : ObjectId("6565e388696c2d2c743f3864"), "x" : 30 }
{ "_id" : ObjectId("6565e388696c2d2c743f3866"), "x" : 32 }
{ "_id" : ObjectId("6565e388696c2d2c743f3867"), "x" : 33 }
{ "_id" : ObjectId("6565e389696c2d2c743f3868"), "x" : 34 }
{ "_id" : ObjectId("6565e389696c2d2c743f3869"), "x" : 35 }
{ "_id" : ObjectId("6565e389696c2d2c743f386a"), "x" : 36 }
{ "_id" : ObjectId("6565e389696c2d2c743f386c"), "x" : 38 }
{ "_id" : ObjectId("6565e389696c2d2c743f3872"), "x" : 44 }
Type "it" for more

rs1:SECONDARY> db.tbl_cib_1.find().pretty()
{
        "_id" : ObjectId("6565e0efa9b669adee85635d"),
        "name" : "Devesh",
        "age" : 44
}
{
        "_id" : ObjectId("6565e0f7a9b669adee85635f"),
        "name" : "Madhu",
        "age" : 40
}
{
        "_id" : ObjectId("6565e0f7a9b669adee85635e"),
        "name" : "Devesh",
        "age" : 44
}
{
        "_id" : ObjectId("6565e0ffa9b669adee856360"),
        "name" : "Devesh",
        "age" : 25
}
{
        "_id" : ObjectId("6565e54d78745da3e2c39c9b"),
        "name" : "Devesh",
        "age" : 25
}
{
        "_id" : ObjectId("6565e58578745da3e2c39c9c"),
        "name" : "Devesh",
        "age" : 44
}
{
        "_id" : ObjectId("6565e58578745da3e2c39c9d"),
        "name" : "Madhu",
        "age" : 44
}
{
        "_id" : ObjectId("6565e58878745da3e2c39c9e"),
        "name" : "Devesh",
        "age" : 44
}
{
        "_id" : ObjectId("6565e58878745da3e2c39c9f"),
        "name" : "Madhu",
        "age" : 44
}
{
        "_id" : ObjectId("6565e58978745da3e2c39ca0"),
        "name" : "Devesh",
        "age" : 44
}
{
        "_id" : ObjectId("6565e58978745da3e2c39ca1"),
        "name" : "Madhu",
        "age" : 44
}
{
        "_id" : ObjectId("6565e58978745da3e2c39ca3"),
        "name" : "Madhu",
        "age" : 44
}
{
        "_id" : ObjectId("6565e58978745da3e2c39ca2"),
        "name" : "Devesh",
        "age" : 44
}
{
        "_id" : ObjectId("6565e58a78745da3e2c39ca4"),
        "name" : "Devesh",
        "age" : 44
}
{
        "_id" : ObjectId("6565e58a78745da3e2c39ca5"),
        "name" : "Madhu",
        "age" : 44
}
{
        "_id" : ObjectId("6565e58a78745da3e2c39ca7"),
        "name" : "Madhu",
        "age" : 44
}
{
        "_id" : ObjectId("6565e58a78745da3e2c39ca6"),
        "name" : "Devesh",
        "age" : 44
}
{
        "_id" : ObjectId("6565e58b78745da3e2c39ca9"),
        "name" : "Madhu",
        "age" : 44
}
{
        "_id" : ObjectId("6565e58b78745da3e2c39ca8"),
        "name" : "Devesh",
        "age" : 44
}
{
        "_id" : ObjectId("6565e58b78745da3e2c39cab"),
        "name" : "Madhu",
        "age" : 44
}
Type "it" for more

rs1:SECONDARY> quit()
*/

-- Step 97 -->> On Node 10 (Verify the MongoDB Sharded Cluster - rs1)
[root@mongodb-shard-06 ~]# mongo --host mongodb-shard-06.unidev39.org.np --port 27020 -u admin -p P#ssw0rd --authenticationDatabase admin
/*
MongoDB shell version v4.4.26
connecting to: mongodb://mongodb-shard-06.unidev39.org.np:27020/?authSource=admin&compressors=disabled&gssapiServiceName=mongodb
Implicit session: session { "id" : UUID("64a64f21-4af1-4b69-9be4-fae7095a2e63") }
MongoDB server version: 4.4.26

rs1:SECONDARY> rs.secondaryOk()

rs1:SECONDARY> show dbs
admin   0.000GB
config  0.001GB
devesh  0.000GB
local   0.001GB

rs1:SECONDARY> use devesh
switched to db devesh

rs1:SECONDARY> show collections
tbl_cib_1
tbl_cib_2

rs1:SECONDARY> db.tbl_cib_2.find().pretty()
{ "_id" : ObjectId("6565e388696c2d2c743f384a"), "x" : 4 }
{ "_id" : ObjectId("6565e388696c2d2c743f384c"), "x" : 6 }
{ "_id" : ObjectId("6565e388696c2d2c743f384e"), "x" : 8 }
{ "_id" : ObjectId("6565e388696c2d2c743f384f"), "x" : 9 }
{ "_id" : ObjectId("6565e388696c2d2c743f3855"), "x" : 15 }
{ "_id" : ObjectId("6565e388696c2d2c743f3857"), "x" : 17 }
{ "_id" : ObjectId("6565e388696c2d2c743f3858"), "x" : 18 }
{ "_id" : ObjectId("6565e388696c2d2c743f385c"), "x" : 22 }
{ "_id" : ObjectId("6565e388696c2d2c743f385d"), "x" : 23 }
{ "_id" : ObjectId("6565e388696c2d2c743f385f"), "x" : 25 }
{ "_id" : ObjectId("6565e388696c2d2c743f3860"), "x" : 26 }
{ "_id" : ObjectId("6565e388696c2d2c743f3861"), "x" : 27 }
{ "_id" : ObjectId("6565e388696c2d2c743f3864"), "x" : 30 }
{ "_id" : ObjectId("6565e388696c2d2c743f3866"), "x" : 32 }
{ "_id" : ObjectId("6565e388696c2d2c743f3867"), "x" : 33 }
{ "_id" : ObjectId("6565e389696c2d2c743f3868"), "x" : 34 }
{ "_id" : ObjectId("6565e389696c2d2c743f3869"), "x" : 35 }
{ "_id" : ObjectId("6565e389696c2d2c743f386a"), "x" : 36 }
{ "_id" : ObjectId("6565e389696c2d2c743f386c"), "x" : 38 }
{ "_id" : ObjectId("6565e389696c2d2c743f3872"), "x" : 44 }
Type "it" for more

rs1:SECONDARY> db.tbl_cib_1.find().pretty()
{
        "_id" : ObjectId("6565e0efa9b669adee85635d"),
        "name" : "Devesh",
        "age" : 44
}
{
        "_id" : ObjectId("6565e0f7a9b669adee85635e"),
        "name" : "Devesh",
        "age" : 44
}
{
        "_id" : ObjectId("6565e0f7a9b669adee85635f"),
        "name" : "Madhu",
        "age" : 40
}
{
        "_id" : ObjectId("6565e0ffa9b669adee856360"),
        "name" : "Devesh",
        "age" : 25
}
{
        "_id" : ObjectId("6565e54d78745da3e2c39c9b"),
        "name" : "Devesh",
        "age" : 25
}
{
        "_id" : ObjectId("6565e58578745da3e2c39c9d"),
        "name" : "Madhu",
        "age" : 44
}
{
        "_id" : ObjectId("6565e58578745da3e2c39c9c"),
        "name" : "Devesh",
        "age" : 44
}
{
        "_id" : ObjectId("6565e58878745da3e2c39c9f"),
        "name" : "Madhu",
        "age" : 44
}
{
        "_id" : ObjectId("6565e58878745da3e2c39c9e"),
        "name" : "Devesh",
        "age" : 44
}
{
        "_id" : ObjectId("6565e58978745da3e2c39ca0"),
        "name" : "Devesh",
        "age" : 44
}
{
        "_id" : ObjectId("6565e58978745da3e2c39ca1"),
        "name" : "Madhu",
        "age" : 44
}
{
        "_id" : ObjectId("6565e58978745da3e2c39ca2"),
        "name" : "Devesh",
        "age" : 44
}
{
        "_id" : ObjectId("6565e58978745da3e2c39ca3"),
        "name" : "Madhu",
        "age" : 44
}
{
        "_id" : ObjectId("6565e58a78745da3e2c39ca5"),
        "name" : "Madhu",
        "age" : 44
}
{
        "_id" : ObjectId("6565e58a78745da3e2c39ca4"),
        "name" : "Devesh",
        "age" : 44
}
{
        "_id" : ObjectId("6565e58a78745da3e2c39ca6"),
        "name" : "Devesh",
        "age" : 44
}
{
        "_id" : ObjectId("6565e58a78745da3e2c39ca7"),
        "name" : "Madhu",
        "age" : 44
}
{
        "_id" : ObjectId("6565e58b78745da3e2c39ca9"),
        "name" : "Madhu",
        "age" : 44
}
{
        "_id" : ObjectId("6565e58b78745da3e2c39ca8"),
        "name" : "Devesh",
        "age" : 44
}
{
        "_id" : ObjectId("6565e58b78745da3e2c39caa"),
        "name" : "Devesh",
        "age" : 44
}
Type "it" for more

rs1:SECONDARY> quit()
*/

-- Stop Shard Cluster
-- Step 98 -->> On Node 4 (Stop the mongos - Query Router)
[root@mongodb-mongos ~]# mongo --host mongodb-mongos.unidev39.org.np --port 27017 -u admin -p P#ssw0rd --authenticationDatabase admin
/*
MongoDB shell version v4.4.26
connecting to: mongodb://mongodb-mongos.unidev39.org.np:27017/?authSource=admin&compressors=disabled&gssapiServiceName=mongodb
Implicit session: session { "id" : UUID("1d5b3465-e387-4faa-88b0-353580a56702") }
MongoDB server version: 4.4.26

mongos> sh.getBalancerState()
true

mongos> sh.stopBalancer()
{
        "ok" : 1,
        "operationTime" : Timestamp(1701237350, 4),
        "$clusterTime" : {
                "clusterTime" : Timestamp(1701237350, 4),
                "signature" : {
                        "hash" : BinData(0,"0EUAQGKAjbzhRpKVUqR/0KzocVM="),
                        "keyId" : NumberLong("7306436173105201174")
                }
        }
}

mongos> sh.getBalancerState()
false

mongos> quit()
*/

-- Step 98.1 -->> On Node 4 (ShutDown the mongos - Query Router - Server)
[root@mongodb-mongos ~]# init 0

-- Step 99 -->> On Node 5 (Stop the Shard - rs0)
[root@mongodb-shard-01 ~]# mongo --host mongodb-shard-01.unidev39.org.np --port 27018 -u admin -p P#ssw0rd --authenticationDatabase admin
/*
MongoDB shell version v4.4.26
connecting to: mongodb://mongodb-shard-01.unidev39.org.np:27018/?authSource=admin&compressors=disabled&gssapiServiceName=mongodb
Implicit session: session { "id" : UUID("996584a8-6c09-4a54-89a2-dd3279489518") }
MongoDB server version: 4.4.26

rs0:PRIMARY> use admin
switched to db admin

rs0:PRIMARY> db.shutdownServer()
server should be down...

> exit
bye
*/

-- Step 99.1 -->> On Node 5 (ShutDown the Shard - rs0 - Server)
[root@mongodb-shard-01 ~]# init 0

-- Step 100 -->> On Node 6 (Stop the Shard - rs0)
[root@mongodb-shard-02 ~]# mongo --host mongodb-shard-02.unidev39.org.np --port 27018 -u admin -p P#ssw0rd --authenticationDatabase admin
/*
MongoDB shell version v4.4.26
connecting to: mongodb://mongodb-shard-02.unidev39.org.np:27018/?authSource=admin&compressors=disabled&gssapiServiceName=mongodb
Implicit session: session { "id" : UUID("a9de471b-38f3-4b3b-a0e5-4cb801f472aa") }
MongoDB server version: 4.4.26

rs0:PRIMARY> use admin
switched to db admin

rs0:PRIMARY> db.shutdownServer()
server should be down...

> quit()
*/

-- Step 100.1 -->> On Node 6 (ShutDown the Shard - rs0 - Server)
[root@mongodb-shard-02 ~]# init 0

-- Step 101 -->> On Node 7 (Stop the Shard - rs0)
[root@mongodb-shard-03 ~]# mongo --host mongodb-shard-03.unidev39.org.np --port 27018 -u admin -p P#ssw0rd --authenticationDatabase admin
/*
MongoDB shell version v4.4.26
connecting to: mongodb://mongodb-shard-03.unidev39.org.np:27018/?authSource=admin&compressors=disabled&gssapiServiceName=mongodb
Implicit session: session { "id" : UUID("540ac9ff-b789-4437-8894-eac68e796cb9") }
MongoDB server version: 4.4.26

rs0:SECONDARY> use admin
switched to db admin

rs0:SECONDARY> db.shutdownServer()
server should be down...

> quit()
*/

-- Step 101.1 -->> On Node 7 (ShutDown the Shard - rs0 - Server)
[root@mongodb-shard-03 ~]# init 0

-- Step 102 -->> On Node 8 (Stop the Shard - rs1)
[root@mongodb-shard-04 ~]# mongo --host mongodb-shard-04.unidev39.org.np --port 27020 -u admin -p P#ssw0rd --authenticationDatabase admin
/*
MongoDB shell version v4.4.26
connecting to: mongodb://mongodb-shard-04.unidev39.org.np:27020/?authSource=admin&compressors=disabled&gssapiServiceName=mongodb
Implicit session: session { "id" : UUID("b1bd8a2e-2120-4d61-8200-e7ddb6f5e0b7") }
MongoDB server version: 4.4.26

rs1:PRIMARY> use admin
switched to db admin

rs1:PRIMARY> db.shutdownServer()
server should be down...

> quit()
*/

-- Step 102.1 -->> On Node 8 (ShutDown the Shard - rs1 - Server)
[root@mongodb-shard-04 ~]# init 0

-- Step 103 -->> On Node 9 (Stop the Shard - rs1)
[root@mongodb-shard-05 ~]# mongo --host mongodb-shard-05.unidev39.org.np --port 27020 -u admin -p P#ssw0rd --authenticationDatabase admin
/*
MongoDB shell version v4.4.26
connecting to: mongodb://mongodb-shard-05.unidev39.org.np:27020/?authSource=admin&compressors=disabled&gssapiServiceName=mongodb
Implicit session: session { "id" : UUID("b0d8e757-f6b2-4ca6-aec7-b588520f8c45") }
MongoDB server version: 4.4.26

rs1:PRIMARY> use admin
switched to db admin

rs1:PRIMARY> db.shutdownServer()
server should be down...

> quit()
*/

-- Step 103.1 -->> On Node 9 (ShutDown the Shard - rs1 - Server)
[root@mongodb-shard-05 ~]# init 0

-- Step 103 -->> On Node 10 (Stop the Shard - rs1)
[root@mongodb-shard-06 ~]# mongo --host mongodb-shard-06.unidev39.org.np --port 27020 -u admin -p P#ssw0rd --authenticationDatabase admin
/*
MongoDB shell version v4.4.26
connecting to: mongodb://mongodb-shard-06.unidev39.org.np:27020/?authSource=admin&compressors=disabled&gssapiServiceName=mongodb
Implicit session: session { "id" : UUID("566f1f61-a835-4247-ac26-83da70f85d6f") }
MongoDB server version: 4.4.26

rs1:SECONDARY> use admin
switched to db admin

rs1:SECONDARY> db.shutdownServer()
server should be down...

> quit()
*/

-- Step 103.1 -->> On Node 10 (ShutDown the Shard - rs1 - Server)
[root@mongodb-shard-06 ~]# init 0

-- Step 104 -->> On Node 1 (Stop the MongoDB - Config)
[root@mongodb-config-01 ~]# mongo --host mongodb-config-01.unidev39.org.np --port 27019 -u admin -p P#ssw0rd --authenticationDatabase admin
/*
MongoDB shell version v4.4.26
connecting to: mongodb://mongodb-config-01.unidev39.org.np:27019/?authSource=admin&compressors=disabled&gssapiServiceName=mongodb
Implicit session: session { "id" : UUID("b27a2c23-ce11-4513-a852-44ee94843513") }
MongoDB server version: 4.4.26

configReplSet:PRIMARY> use admin
switched to db admin

configReplSet:PRIMARY> db.shutdownServer()
server should be down...

> quit()
*/

-- Step 104.1 -->> On Node 1 (ShutDown the MongoDB - COnfig - Server)
[root@mongodb-config-01 ~]# init 0

-- Step 105 -->> On Node 2 (Stop the MongoDB - Config)
[root@mongodb-config-02 ~]# mongo --host mongodb-config-02.unidev39.org.np --port 27019 -u admin -p P#ssw0rd --authenticationDatabase admin
/*
MongoDB shell version v4.4.26
connecting to: mongodb://mongodb-config-02.unidev39.org.np:27019/?authSource=admin&compressors=disabled&gssapiServiceName=mongodb
Implicit session: session { "id" : UUID("780568b2-e5a3-42f7-a5f7-6b73fb14be1b") }
MongoDB server version: 4.4.26

configReplSet:PRIMARY> use admin
switched to db admin

configReplSet:PRIMARY> db.shutdownServer()
server should be down...

> quit()
*/

-- Step 105.1 -->> On Node 2 (ShutDown the MongoDB - COnfig - Server)
[root@mongodb-config-02 ~]# init 0

-- Step 106 -->> On Node 3 (Stop the MongoDB - Config)
[root@mongodb-config-03 ~]# mongo --host mongodb-config-03.unidev39.org.np --port 27019 -u admin -p P#ssw0rd --authenticationDatabase admin
/*
MongoDB shell version v4.4.26
connecting to: mongodb://mongodb-config-03.unidev39.org.np:27019/?authSource=admin&compressors=disabled&gssapiServiceName=mongodb
Implicit session: session { "id" : UUID("db6db591-d692-453a-8a16-bdb93ad8d52b") }
MongoDB server version: 4.4.26

configReplSet:SECONDARY> use admin
switched to db admin

configReplSet:SECONDARY> db.shutdownServer()
server should be down...

> quit()
*/

-- Step 106.1 -->> On Node 3 (ShutDown the MongoDB - COnfig - Server)
[root@mongodb-config-03 ~]# init 0

