--To Clenup the Mongo Log
cat /dev/null > mongodb.log

--------------------------------------------------------------------------
----------------------------root/P@ssw0rd---------------------------------
--------------------------------------------------------------------------
-- 1 Node on VM (Server Storage)
root@mongodb:~# df -Th
/*
Filesystem                                                                                   Type   Size  Used Avail Use% Mounted on
tmpfs                                                                                        tmpfs  388M  1.5M  386M   1% /run
/dev/mapper/mongodb--lvm-root                                                                xfs     40G  323M   40G   1% /
/dev/disk/by-id/dm-uuid-LVM-W6sa1GFT8xWCd0en83XCkGrzc3RelcAOw1DyFihyCyeUdDI3qOaSeY9i6fp7JOEL xfs     10G  2.7G  7.4G  27% /usr
tmpfs                                                                                        tmpfs  1.9G     0  1.9G   0% /dev/shm
tmpfs                                                                                        tmpfs  5.0M     0  5.0M   0% /run/lock
/dev/mapper/mongodb--lvm-srv                                                                 xfs     10G  104M  9.9G   2% /srv
/dev/sda2                                                                                    xfs   1014M  189M  826M  19% /boot
/dev/mapper/mongodb--lvm-home                                                                xfs     10G  104M  9.9G   2% /home
/dev/mapper/mongodb--lvm-tmp                                                                 xfs     10G  104M  9.9G   2% /tmp
/dev/mapper/mongodb--lvm-var                                                                 xfs     10G  238M  9.8G   3% /var
/dev/mapper/mongodb--lvm-var_lib                                                             xfs     10G  561M  9.5G   6% /var/lib
tmpfs                                                                                        tmpfs  388M  4.0K  388M   1% /run/user/1000
*/

-- 1 Node on VM (Server Kernal version)
root@mongodb:~# uname -msr
/*
Linux 6.5.0-21-generic x86_64
*/

-- 1 Node on VM (Server Release)
root@mongodb:~# cat /etc/lsb-release
/*
DISTRIB_ID=Ubuntu
DISTRIB_RELEASE=22.04
DISTRIB_CODENAME=jammy
DISTRIB_DESCRIPTION="Ubuntu 22.04.4 LTS"
*/

-- 1 Node on VM (Server Release)
root@mongodb:~# cat /etc/os-release
/*
PRETTY_NAME="Ubuntu 22.04.4 LTS"
NAME="Ubuntu"
VERSION_ID="22.04"
VERSION="22.04.4 LTS (Jammy Jellyfish)"
VERSION_CODENAME=jammy
ID=ubuntu
ID_LIKE=debian
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
UBUNTU_CODENAME=jammy
*/

-- Step 1 -->> On Node 1
root@mongodb:~# vi /etc/hosts
/*
127.0.0.1 localhost
127.0.1.1 mongodb

# Public
192.168.56.158 mongodb-unidev39.org.np mongodb
*/

-- Step 2 -->> On Node 1 (Ethernet Configuration)
root@mongodb:~# vi /etc/netplan/00-installer-config.yaml
/*
# This is the network config written by 'subiquity'
network:
  ethernets:
    ens32:
      addresses:
      - 192.168.56.158/24
      nameservers:
        addresses:
        - 8.8.8.8
        - 8.8.8.8
        search: []
      routes:
      - to: default
        via: 192.168.56.2
  version: 2
*/

-- Step 3 -->> On Node 1 (Restart Network)
root@mongodb:~# systemctl restart network-online.target

-- Step 4 -->> On Node 1 (Set Hostname)
root@mongodb:~# hostnamectl | grep hostname
/*
 Static hostname: mongodb
*/

-- Step 4.1 -->> On Node 1
root@mongodb:~# hostnamectl --static
/*
mongodb
*/

-- Step 4.2 -->> On Node 1
root@mongodb:~# hostnamectl
/*
 Static hostname: mongodb
       Icon name: computer-vm
         Chassis: vm
      Machine ID: 3fd6e52673bc4421b0959a2f3abda823
         Boot ID: cd988f78b115402896d1832024d19402
  Virtualization: vmware
Operating System: Ubuntu 22.04.4 LTS
          Kernel: Linux 6.5.0-21-generic
    Architecture: x86-64
 Hardware Vendor: VMware, Inc.
  Hardware Model: VMware Virtual Platform
*/

-- Step 4.3 -->> On Node 1
root@mongodb:~# hostnamectl set-hostname mongodb-unidev39.org.np

-- Step 4.4 -->> On Node 1
root@mongodb:~# hostnamectl
/*
 Static hostname: mongodb-unidev39.org.np
       Icon name: computer-vm
         Chassis: vm
      Machine ID: 3fd6e52673bc4421b0959a2f3abda823
         Boot ID: cd988f78b115402896d1832024d19402
  Virtualization: vmware
Operating System: Ubuntu 22.04.4 LTS
          Kernel: Linux 6.5.0-21-generic
    Architecture: x86-64
 Hardware Vendor: VMware, Inc.
  Hardware Model: VMware Virtual Platform
*/

-- Step 5 -->> On Node 1 (IPtables Configuration)
root@mongodb:~# apt install net-tools
root@mongodb:~# iptables -F
root@mongodb:~# iptables -X
root@mongodb:~# iptables -t nat -F
root@mongodb:~# iptables -t nat -X
root@mongodb:~# iptables -t mangle -F
root@mongodb:~# iptables -t mangle -X
root@mongodb:~# iptables -P INPUT ACCEPT
root@mongodb:~# iptables -P FORWARD ACCEPT
root@mongodb:~# iptables -P OUTPUT ACCEPT
root@mongodb:~# iptables -L -nv

-- Step 5.1 -->> On Node 1
root@mongodb:~# ifconfig
/*
ens32: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 192.168.56.158  netmask 255.255.255.0  broadcast 192.168.56.255
        inet6 fe80::20c:29ff:feb1:24ca  prefixlen 64  scopeid 0x20<link>
        ether 00:0c:29:b1:24:ca  txqueuelen 1000  (Ethernet)
        RX packets 802  bytes 268180 (268.1 KB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 474  bytes 120741 (120.7 KB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
        inet 127.0.0.1  netmask 255.0.0.0
        inet6 ::1  prefixlen 128  scopeid 0x10<host>
        loop  txqueuelen 1000  (Local Loopback)
        RX packets 170  bytes 13603 (13.6 KB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 170  bytes 13603 (13.6 KB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
*/

-- Step 6 -->> On Node 1 (Firew Configuration)
root@mongodb:~# apt install firewalld

-- Step 6.1 -->> On Node 1
root@mongodb:~# systemctl stop firewalld

-- Step 6.2 -->> On Node 1
root@mongodb:~# systemctl disable firewalld
/*
Removed /etc/systemd/system/multi-user.target.wants/firewalld.service.
Removed /etc/systemd/system/dbus-org.fedoraproject.FirewallD1.service.
*/

-- Step 6.3 -->> On Node 1
root@mongodb:~# systemctl status firewalld
/*
○ firewalld.service - firewalld - dynamic firewall daemon
     Loaded: loaded (/lib/systemd/system/firewalld.service; disabled; vendor preset: enabled)
     Active: inactive (dead)
       Docs: man:firewalld(1)

Feb 28 08:11:20 mongodb-unidev39.org.np systemd[1]: Starting firewalld - dynamic firewall daemon...
Feb 28 08:11:21 mongodb-unidev39.org.np systemd[1]: Started firewalld - dynamic firewall daemon.
Feb 28 08:12:23 mongodb-unidev39.org.np systemd[1]: Stopping firewalld - dynamic firewall daemon...
Feb 28 08:12:23 mongodb-unidev39.org.np systemd[1]: firewalld.service: Deactivated successfully.
Feb 28 08:12:23 mongodb-unidev39.org.np systemd[1]: Stopped firewalld - dynamic firewall daemon.
*/

-- Step 6.4 -->> On Node 1
root@mongodb:~# firewall-cmd --list-all
/*
FirewallD is not running
*/

-- Step 7 -->> On Node 1 (Server ALL RMP Updates)
root@mongodb:~# sudo apt update && sudo apt upgrade -y

-- Step 8 -->> On Node 1 (Selinux Configuration)
-- Making sure the SELINUX flag is set as follows.
root@mongodb:~# sudo apt install policycoreutils selinux-basics selinux-utils -y
root@mongodb:~# sudo selinux-activate
/*
Activating SE Linux
Sourcing file `/etc/default/grub'
Sourcing file `/etc/default/grub.d/init-select.cfg'
Generating grub configuration file ...
Found linux image: /boot/vmlinuz-6.5.0-21-generic
Found initrd image: /boot/initrd.img-6.5.0-21-generic
Warning: os-prober will not be executed to detect other bootable partitions.
Systems on them will not be added to the GRUB boot configuration.
Check GRUB_DISABLE_OS_PROBER documentation entry.
done
SE Linux is activated.  You may need to reboot now.
*/

-- Step 8.1 -->> On Node 1
root@mongodb:~# getenforce
/*
Disabled
*/

-- Step 8.2 -->> On Node 1
root@mongodb:~# sestatus
/*
SELinux status:                 disabled
*/

-- Step 8.3 -->> On Node 1
root@mongodb:~# init 6

-- Step 8.4 -->> On Node 1
root@mongodb-unidev39:~# vi /etc/selinux/config
/*
# This file controls the state of SELinux on the system.
# SELINUX= can take one of these three values:
# enforcing - SELinux security policy is enforced.
# permissive - SELinux prints warnings instead of enforcing.
# disabled - No SELinux policy is loaded.
SELINUX=disabled
# SELINUXTYPE= can take one of these two values:
# default - equivalent to the old strict and targeted policies
# mls     - Multi-Level Security (for military and educational use)
# src     - Custom policy built from source
SELINUXTYPE=default

# SETLOCALDEFS= Check local definition changes
SETLOCALDEFS=0
*/

-- Step 8.5 -->> On Node 1
root@mongodb-unidev39:~# getenforce
/*
Disabled
*/

-- Step 8.6 -->> On Node 1
root@mongodb-unidev39:~# sestatus
/*
SELinux status:                 disabled
*/

-- Step 9 -->> On Node 1
root@mongodb-unidev39:~# firewall-cmd --list-all
/*
FirewallD is not running
*/

-- Step 10 -->> On Node 1
root@mongodb-unidev39:~# hostnamectl
/*
 Static hostname: mongodb-unidev39.org.np
       Icon name: computer-vm
         Chassis: vm
      Machine ID: 3fd6e52673bc4421b0959a2f3abda823
         Boot ID: 1594333ece584dcd848ee84b86d9933e
  Virtualization: vmware
Operating System: Ubuntu 22.04.4 LTS
          Kernel: Linux 6.5.0-21-generic
    Architecture: x86-64
 Hardware Vendor: VMware, Inc.
  Hardware Model: VMware Virtual Platform
*/

-- Step 11 -->> On Node 1 (Assign role to MongoDB User)
root@mongodb-unidev39:~# usermod -aG sudo mongodb

-- Step 11.1 -->> On Node 1
root@mongodb-unidev39:~# usermod -aG root mongodb

-- Step 11.2 -->> On Node 1
root@mongodb-unidev39:~# rsync --archive --chown=mongodb:mongodb ~/.ssh /home/mongodb

-- Step 11.3 -->> On Node 1
root@mongodb-unidev39:~# ssh mongodb@192.168.56.158
/*
The authenticity of host '192.168.56.158 (192.168.56.158)' can't be established.
ED25519 key fingerprint is SHA256:gLU/pvGvcBqipfodu70O6XCcC1leiwLWgZ9VO4LaOPY.
This key is not known by any other names
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added '192.168.56.158' (ED25519) to the list of known hosts.
mongodb@192.168.56.158's password:
Welcome to Ubuntu 22.04.4 LTS (GNU/Linux 6.5.0-21-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/pro

  System information as of Wed Feb 28 08:41:08 AM UTC 2024

  System load:    0.01220703125    Processes:              290
  Usage of /home: 1.0% of 9.99GB   Users logged in:        1
  Memory usage:   9%               IPv4 address for ens32: 192.168.56.158
  Swap usage:     0%


Expanded Security Maintenance for Applications is not enabled.

0 updates can be applied immediately.

Enable ESM Apps to receive additional future security updates.
See https://ubuntu.com/esm or run: sudo pro status


Last login: Wed Feb 28 08:36:19 2024 from 192.168.56.1
*/

-- Step 11.4 -->> On Node 1
mongodb@mongodb-unidev39:~$ exit
/*
logout
Connection to 192.168.56.158 closed.
*/

-- Step 12 -->> On Node 1 (LVM Partition Configuration - Before Status)
root@mongodb-unidev39:~# df -Th
/*
Filesystem                                                                                   Type   Size  Used Avail Use% Mounted on
tmpfs                                                                                        tmpfs  388M  1.5M  386M   1% /run
/dev/mapper/mongodb--lvm-root                                                                xfs     40G  333M   40G   1% /
/dev/disk/by-id/dm-uuid-LVM-W6sa1GFT8xWCd0en83XCkGrzc3RelcAOw1DyFihyCyeUdDI3qOaSeY9i6fp7JOEL xfs     10G  2.8G  7.3G  28% /usr
tmpfs                                                                                        tmpfs  1.9G     0  1.9G   0% /dev/shm
tmpfs                                                                                        tmpfs  5.0M     0  5.0M   0% /run/lock
/dev/mapper/mongodb--lvm-srv                                                                 xfs     10G  104M  9.9G   2% /srv
/dev/mapper/mongodb--lvm-home                                                                xfs     10G  104M  9.9G   2% /home
/dev/mapper/mongodb--lvm-var                                                                 xfs     10G  255M  9.8G   3% /var
/dev/mapper/mongodb--lvm-var_lib                                                             xfs     10G  579M  9.5G   6% /var/lib
/dev/mapper/mongodb--lvm-tmp                                                                 xfs     10G  104M  9.9G   2% /tmp
/dev/sda2                                                                                    xfs   1014M  189M  826M  19% /boot
tmpfs                                                                                        tmpfs  388M  4.0K  388M   1% /run/user/1000
*/

-- Step 13 -->> On Node 1 (LVM Partition Configuration - Before Status)
root@mongodb-unidev39:~# lsblk
/*
NAME                     MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
loop0                      7:0    0 63.9M  1 loop /snap/core20/2105
loop1                      7:1    0 40.4M  1 loop /snap/snapd/20671
loop2                      7:2    0 63.9M  1 loop /snap/core20/2182
loop3                      7:3    0   87M  1 loop /snap/lxd/27037
sda                        8:0    0  112G  0 disk
├─sda1                     8:1    0    1M  0 part
├─sda2                     8:2    0    1G  0 part /boot
└─sda3                     8:3    0  111G  0 part
  ├─mongodb--lvm-root    252:0    0   40G  0 lvm  /
  ├─mongodb--lvm-home    252:1    0   10G  0 lvm  /home
  ├─mongodb--lvm-srv     252:2    0   10G  0 lvm  /srv
  ├─mongodb--lvm-usr     252:3    0   10G  0 lvm  /usr
  ├─mongodb--lvm-var     252:4    0   10G  0 lvm  /var
  ├─mongodb--lvm-tmp     252:5    0   10G  0 lvm  /tmp
  ├─mongodb--lvm-swap    252:6    0   10G  0 lvm  [SWAP]
  └─mongodb--lvm-var_lib 252:7    0   10G  0 lvm  /var/lib
sdb                        8:16   0   20G  0 disk
sdc                        8:32   0   25G  0 disk
sr0                       11:0    1    2G  0 rom
*/

-- Step 14 -->> On Node 1 (LVM Partition Configuration - Before Status)
root@mongodb-unidev39:~# fdisk -ll | grep sd
/*
Disk /dev/sda: 112 GiB, 120259084288 bytes, 234881024 sectors
/dev/sda1     2048      4095      2048    1M BIOS boot
/dev/sda2     4096   2101247   2097152    1G Linux filesystem
/dev/sda3  2101248 234878975 232777728  111G Linux filesystem
Disk /dev/sdb: 20 GiB, 21474836480 bytes, 41943040 sectors
Disk /dev/sdc: 25 GiB, 26843545600 bytes, 52428800 sectors
*/

-- Step 15 -->> On Node 1 (LVM Partition Configuration - t with 8e to change LVM Partition)
root@mongodb-unidev39:~# fdisk /dev/sdb
/*
Welcome to fdisk (util-linux 2.37.2).
Changes will remain in memory only, until you decide to write them.
Be careful before using the write command.

Device does not contain a recognized partition table.
Created a new DOS disklabel with disk identifier 0xf60f0d8a.

Command (m for help): p
Disk /dev/sdb: 20 GiB, 21474836480 bytes, 41943040 sectors
Disk model: VMware Virtual S
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: dos
Disk identifier: 0xf60f0d8a

Command (m for help): n
Partition type
   p   primary (0 primary, 0 extended, 4 free)
   e   extended (container for logical partitions)
Select (default p): p
Partition number (1-4, default 1): 1
First sector (2048-41943039, default 2048):
Last sector, +/-sectors or +/-size{K,M,G,T,P} (2048-41943039, default 41943039):

Created a new partition 1 of type 'Linux' and of size 20 GiB.

Command (m for help): p
Disk /dev/sdb: 20 GiB, 21474836480 bytes, 41943040 sectors
Disk model: VMware Virtual S
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: dos
Disk identifier: 0xf60f0d8a

Device     Boot Start      End  Sectors Size Id Type
/dev/sdb1        2048 41943039 41940992  20G 83 Linux

Command (m for help): t
Selected partition 1
Hex code or alias (type L to list all): 8e
Changed type of partition 'Linux' to 'Linux LVM'.

Command (m for help): p
Disk /dev/sdb: 20 GiB, 21474836480 bytes, 41943040 sectors
Disk model: VMware Virtual S
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: dos
Disk identifier: 0xf60f0d8a

Device     Boot Start      End  Sectors Size Id Type
/dev/sdb1        2048 41943039 41940992  20G 8e Linux LVM

Command (m for help): w
The partition table has been altered.
Calling ioctl() to re-read partition table.
Syncing disks.
*/

-- Step 16 -->> On Node 1 (LVM Partition Configuration - t with 8e to change LVM Partition)
root@mongodb-unidev39:~# fdisk /dev/sdc
/*
Welcome to fdisk (util-linux 2.37.2).
Changes will remain in memory only, until you decide to write them.
Be careful before using the write command.

Device does not contain a recognized partition table.
Created a new DOS disklabel with disk identifier 0x3af4a4e3.

Command (m for help): p
Disk /dev/sdc: 25 GiB, 26843545600 bytes, 52428800 sectors
Disk model: VMware Virtual S
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: dos
Disk identifier: 0x3af4a4e3

Command (m for help): n
Partition type
   p   primary (0 primary, 0 extended, 4 free)
   e   extended (container for logical partitions)
Select (default p): p
Partition number (1-4, default 1): 1
First sector (2048-52428799, default 2048):
Last sector, +/-sectors or +/-size{K,M,G,T,P} (2048-52428799, default 52428799):

Created a new partition 1 of type 'Linux' and of size 25 GiB.

Command (m for help): p
Disk /dev/sdc: 25 GiB, 26843545600 bytes, 52428800 sectors
Disk model: VMware Virtual S
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: dos
Disk identifier: 0x3af4a4e3

Device     Boot Start      End  Sectors Size Id Type
/dev/sdc1        2048 52428799 52426752  25G 83 Linux

Command (m for help): t
Selected partition 1
Hex code or alias (type L to list all): 8e
Changed type of partition 'Linux' to 'Linux LVM'.

Command (m for help): p
Disk /dev/sdc: 25 GiB, 26843545600 bytes, 52428800 sectors
Disk model: VMware Virtual S
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: dos
Disk identifier: 0x3af4a4e3

Device     Boot Start      End  Sectors Size Id Type
/dev/sdc1        2048 52428799 52426752  25G 8e Linux LVM

Command (m for help): w
The partition table has been altered.
Calling ioctl() to re-read partition table.
Syncing disks.
*/

-- Step 17 -->> On Node 1 (LVM Partition Configuration - After Status)
root@mongodb-unidev39:~# fdisk -ll | grep sd
/*
Disk /dev/sda: 112 GiB, 120259084288 bytes, 234881024 sectors
/dev/sda1     2048      4095      2048    1M BIOS boot
/dev/sda2     4096   2101247   2097152    1G Linux filesystem
/dev/sda3  2101248 234878975 232777728  111G Linux filesystem
Disk /dev/sdb: 20 GiB, 21474836480 bytes, 41943040 sectors
/dev/sdb1        2048 41943039 41940992  20G 8e Linux LVM
Disk /dev/sdc: 25 GiB, 26843545600 bytes, 52428800 sectors
/dev/sdc1        2048 52428799 52426752  25G 8e Linux LVM
*/

-- Step 18 -->> On Node 1 (LVM Partition Configuration - Make it Avilable)
root@mongodb-unidev39:~# partprobe /dev/sdb

-- Step 19 -->> On Node 1 (LVM Partition Configuration - Make it Avilable)
root@mongodb-unidev39:~# partprobe /dev/sdc

-- Step 20 -->> On Node 1 (LVM Partition Configuration - After Status)
root@mongodb-unidev39:~# lsblk
/*
NAME                     MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
loop0                      7:0    0 63.9M  1 loop /snap/core20/2105
loop1                      7:1    0 40.4M  1 loop /snap/snapd/20671
loop2                      7:2    0 63.9M  1 loop /snap/core20/2182
loop3                      7:3    0   87M  1 loop /snap/lxd/27037
sda                        8:0    0  112G  0 disk
├─sda1                     8:1    0    1M  0 part
├─sda2                     8:2    0    1G  0 part /boot
└─sda3                     8:3    0  111G  0 part
  ├─mongodb--lvm-root    252:0    0   40G  0 lvm  /
  ├─mongodb--lvm-home    252:1    0   10G  0 lvm  /home
  ├─mongodb--lvm-srv     252:2    0   10G  0 lvm  /srv
  ├─mongodb--lvm-usr     252:3    0   10G  0 lvm  /usr
  ├─mongodb--lvm-var     252:4    0   10G  0 lvm  /var
  ├─mongodb--lvm-tmp     252:5    0   10G  0 lvm  /tmp
  ├─mongodb--lvm-swap    252:6    0   10G  0 lvm  [SWAP]
  └─mongodb--lvm-var_lib 252:7    0   10G  0 lvm  /var/lib
sdb                        8:16   0   20G  0 disk
└─sdb1                     8:17   0   20G  0 part
sdc                        8:32   0   25G  0 disk
└─sdc1                     8:33   0   25G  0 part
sr0                       11:0    1    2G  0 rom
*/

-- Step 21 -->> On Node 1 (LVM Partition Configuration - Befor Status of pvs)
root@mongodb-unidev39:~# pvs
/*
  PV         VG          Fmt  Attr PSize    PFree
  /dev/sda3  mongodb-lvm lvm2 a--  <111.00g 1020.00m
*/

-- Step 22 -->> On Node 1 (LVM Partition Configuration - Befor Status of vgs)
root@mongodb-unidev39:~# vgs
/*
  VG          #PV #LV #SN Attr   VSize    VFree
  mongodb-lvm   1   8   0 wz--n- <111.00g 1020.00m
*/

-- Step 23 -->> On Node 1 (LVM Partition Configuration - Befor Status of lvs)
root@mongodb-unidev39:~# lvs
/*
  LV      VG          Attr       LSize  Pool Origin Data%  Meta%  Move Log Cpy%Sync Convert
  home    mongodb-lvm -wi-ao---- 10.00g
  root    mongodb-lvm -wi-ao---- 40.00g
  srv     mongodb-lvm -wi-ao---- 10.00g
  swap    mongodb-lvm -wi-ao---- 10.00g
  tmp     mongodb-lvm -wi-ao---- 10.00g
  usr     mongodb-lvm -wi-ao---- 10.00g
  var     mongodb-lvm -wi-ao---- 10.00g
  var_lib mongodb-lvm -wi-ao---- 10.00g
*/

-- Step 24 -->> On Node 1 (LVM Partition Configuration - After Status)
root@mongodb-unidev39:~# fdisk -ll | grep sd
/*
Disk /dev/sda: 112 GiB, 120259084288 bytes, 234881024 sectors
/dev/sda1     2048      4095      2048    1M BIOS boot
/dev/sda2     4096   2101247   2097152    1G Linux filesystem
/dev/sda3  2101248 234878975 232777728  111G Linux filesystem
Disk /dev/sdb: 20 GiB, 21474836480 bytes, 41943040 sectors
/dev/sdb1        2048 41943039 41940992  20G 8e Linux LVM
Disk /dev/sdc: 25 GiB, 26843545600 bytes, 52428800 sectors
/dev/sdc1        2048 52428799 52426752  25G 8e Linux LVM
*/

-- Step 25 -->> On Node 1 (LVM Partition Configuration - Create pvs)
root@mongodb-unidev39:~# pvcreate /dev/sdb1
/*
  Physical volume "/dev/sdb1" successfully created.
*/

-- Step 26 -->> On Node 1 (LVM Partition Configuration - Create pvs)
root@mongodb-unidev39:~# pvcreate /dev/sdc1
/*
  Physical volume "/dev/sdc1" successfully created.
*/

-- Step 27 -->> On Node 1 (LVM Partition Configuration - Verify pvs)
root@mongodb-unidev39:~# pvs
/*
  PV         VG          Fmt  Attr PSize    PFree
  /dev/sda3  mongodb-lvm lvm2 a--  <111.00g 1020.00m
  /dev/sdb1              lvm2 ---   <20.00g  <20.00g
  /dev/sdc1              lvm2 ---   <25.00g  <25.00g
*/

-- Step 28 -->> On Node 1 (LVM Partition Configuration - Verify pvs)
root@mongodb-unidev39:~# pvdisplay /dev/sdb1
/*
  "/dev/sdb1" is a new physical volume of "<20.00 GiB"
  --- NEW Physical volume ---
  PV Name               /dev/sdb1
  VG Name
  PV Size               <20.00 GiB
  Allocatable           NO
  PE Size               0
  Total PE              0
  Free PE               0
  Allocated PE          0
  PV UUID               lwLfjT-om6d-Q407-xvKy-uw7M-urcs-P2wbDE
*/

-- Step 29 -->> On Node 1 (LVM Partition Configuration - Verify pvs)
root@mongodb-unidev39:~# pvdisplay /dev/sdc1
/*
  "/dev/sdc1" is a new physical volume of "<25.00 GiB"
  --- NEW Physical volume ---
  PV Name               /dev/sdc1
  VG Name
  PV Size               <25.00 GiB
  Allocatable           NO
  PE Size               0
  Total PE              0
  Free PE               0
  Allocated PE          0
  PV UUID               RQbsEU-ZVW1-SCwH-4yKS-Dq3X-ben3-9aGZSz
*/

-- Step 30 -->> On Node 1 (LVM Partition Configuration - Create vgs)
root@mongodb-unidev39:~# vgcreate data_vg /dev/sdb1
/*
  Volume group "data_vg" successfully created
*/

-- Step 31 -->> On Node 1 (LVM Partition Configuration - Create vgs)
root@mongodb-unidev39:~# vgcreate backup_vg /dev/sdc1
/*
  Volume group "backup_vg" successfully created
root@mongodb-unidev39:~#
root@mongodb-unidev39:~# vgs
  VG          #PV #LV #SN Attr   VSize    VFree
  backup_vg     1   0   0 wz--n-  <25.00g  <25.00g
  data_vg       1   0   0 wz--n-  <20.00g  <20.00g
  mongodb-lvm   1   8   0 wz--n- <111.00g 1020.00m
*/

-- Step 32 -->> On Node 1 (LVM Partition Configuration - Verify vgs)
root@mongodb-unidev39:~# vgdisplay data_vg
/*
  --- Volume group ---
  VG Name               data_vg
  System ID
  Format                lvm2
  Metadata Areas        1
  Metadata Sequence No  1
  VG Access             read/write
  VG Status             resizable
  MAX LV                0
  Cur LV                0
  Open LV               0
  Max PV                0
  Cur PV                1
  Act PV                1
  VG Size               <20.00 GiB
  PE Size               4.00 MiB
  Total PE              5119
  Alloc PE / Size       0 / 0
  Free  PE / Size       5119 / <20.00 GiB
  VG UUID               9HhuNt-aoXe-cl2Q-dBxn-gz23-stH1-nEb9Md
*/

-- Step 33 -->> On Node 1 (LVM Partition Configuration - Verify vgs)
root@mongodb-unidev39:~# vgdisplay backup_vg
/*
  --- Volume group ---
  VG Name               backup_vg
  System ID
  Format                lvm2
  Metadata Areas        1
  Metadata Sequence No  1
  VG Access             read/write
  VG Status             resizable
  MAX LV                0
  Cur LV                0
  Open LV               0
  Max PV                0
  Cur PV                1
  Act PV                1
  VG Size               <25.00 GiB
  PE Size               4.00 MiB
  Total PE              6399
  Alloc PE / Size       0 / 0
  Free  PE / Size       6399 / <25.00 GiB
  VG UUID               0B88uY-4lhm-eoui-tBeq-cVmi-1BB6-DdVUxz
*/

-- Step 34 -->> On Node 1 (LVM Partition Configuration - Less Than VG Size)
root@mongodb-unidev39:~# lvcreate -n data_lv -L 19.9GB data_vg
/*
  Rounding up size to full physical extent 19.90 GiB
  Logical volume "data_lv" created.
*/

-- Step 35 -->> On Node 1 (LVM Partition Configuration - Less Than VG Size)
root@mongodb-unidev39:~# lvcreate -n backup_lv -L 24.9GB backup_vg
/*
  Rounding up size to full physical extent 24.90 GiB
  Logical volume "backup_lv" created.
*/

-- Step 36 -->> On Node 1 (LVM Partition Configuration - Verify)
root@mongodb-unidev39:~# lvs
/*
  LV        VG          Attr       LSize  Pool Origin Data%  Meta%  Move Log Cpy%Sync Convert
  backup_lv backup_vg   -wi-a----- 24.90g
  data_lv   data_vg     -wi-a----- 19.90g
  home      mongodb-lvm -wi-ao---- 10.00g
  root      mongodb-lvm -wi-ao---- 40.00g
  srv       mongodb-lvm -wi-ao---- 10.00g
  swap      mongodb-lvm -wi-ao---- 10.00g
  tmp       mongodb-lvm -wi-ao---- 10.00g
  usr       mongodb-lvm -wi-ao---- 10.00g
  var       mongodb-lvm -wi-ao---- 10.00g
  var_lib   mongodb-lvm -wi-ao---- 10.00g
*/

-- Step 37 -->> On Node 1 (LVM Partition Configuration - Verify)
root@mongodb-unidev39:~# fdisk -ll | grep lv
/*
Disk /dev/mapper/mongodb--lvm-root: 40 GiB, 42949672960 bytes, 83886080 sectors
Disk /dev/mapper/mongodb--lvm-home: 10 GiB, 10737418240 bytes, 20971520 sectors
Disk /dev/mapper/mongodb--lvm-srv: 10 GiB, 10737418240 bytes, 20971520 sectors
Disk /dev/mapper/mongodb--lvm-usr: 10 GiB, 10737418240 bytes, 20971520 sectors
Disk /dev/mapper/mongodb--lvm-var: 10 GiB, 10737418240 bytes, 20971520 sectors
Disk /dev/mapper/mongodb--lvm-tmp: 10 GiB, 10737418240 bytes, 20971520 sectors
Disk /dev/mapper/mongodb--lvm-swap: 10 GiB, 10737418240 bytes, 20971520 sectors
Disk /dev/mapper/mongodb--lvm-var_lib: 10 GiB, 10737418240 bytes, 20971520 sectors
Disk /dev/mapper/data_vg-data_lv: 19.9 GiB, 21369978880 bytes, 41738240 sectors
Disk /dev/mapper/backup_vg-backup_lv: 24.9 GiB, 26738688000 bytes, 52224000 sectors
*/

-- Step 38 -->> On Node 1 (LVM Partition Configuration - Verify)
root@mongodb-unidev39:~# lvdisplay /dev/mapper/data_vg-data_lv
/*
  --- Logical volume ---
  LV Path                /dev/data_vg/data_lv
  LV Name                data_lv
  VG Name                data_vg
  LV UUID                CB6yld-Hf59-csWr-aZOA-vBjV-wn1t-1FrUM2
  LV Write Access        read/write
  LV Creation host, time mongodb-unidev39.org.np, 2024-02-28 08:55:25 +0000
  LV Status              available
  # open                 0
  LV Size                19.90 GiB
  Current LE             5095
  Segments               1
  Allocation             inherit
  Read ahead sectors     auto
  - currently set to     256
  Block device           252:8
*/

-- Step 39 -->> On Node 1 (LVM Partition Configuration - Verify)
root@mongodb-unidev39:~# lvdisplay /dev/mapper/backup_vg-backup_lv
/*
  --- Logical volume ---
  LV Path                /dev/backup_vg/backup_lv
  LV Name                backup_lv
  VG Name                backup_vg
  LV UUID                9YBnyF-t3ZV-uzUZ-weSN-W47s-Av4k-MCGDwn
  LV Write Access        read/write
  LV Creation host, time mongodb-unidev39.org.np, 2024-02-28 08:55:49 +0000
  LV Status              available
  # open                 0
  LV Size                24.90 GiB
  Current LE             6375
  Segments               1
  Allocation             inherit
  Read ahead sectors     auto
  - currently set to     256
  Block device           252:9
*/

-- Step 40 -->> On Node 1 (LVM Partition Configuration - Format LVM Partition)
root@mongodb-unidev39:~# mkfs.xfs /dev/mapper/data_vg-data_lv
/*
meta-data=/dev/mapper/data_vg-data_lv isize=512    agcount=4, agsize=1304320 blks
         =                       sectsz=512   attr=2, projid32bit=1
         =                       crc=1        finobt=1, sparse=1, rmapbt=0
         =                       reflink=1    bigtime=0 inobtcount=0
data     =                       bsize=4096   blocks=5217280, imaxpct=25
         =                       sunit=0      swidth=0 blks
naming   =version 2              bsize=4096   ascii-ci=0, ftype=1
log      =internal log           bsize=4096   blocks=2560, version=2
         =                       sectsz=512   sunit=0 blks, lazy-count=1
realtime =none                   extsz=4096   blocks=0, rtextents=0
*/

-- Step 41 -->> On Node 1 (LVM Partition Configuration - Format LVM Partition)
root@mongodb-unidev39:~# mkfs.xfs /dev/mapper/backup_vg-backup_lv
/*
meta-data=/dev/mapper/backup_vg-backup_lv isize=512    agcount=4, agsize=1632000 blks
         =                       sectsz=512   attr=2, projid32bit=1
         =                       crc=1        finobt=1, sparse=1, rmapbt=0
         =                       reflink=1    bigtime=0 inobtcount=0
data     =                       bsize=4096   blocks=6528000, imaxpct=25
         =                       sunit=0      swidth=0 blks
naming   =version 2              bsize=4096   ascii-ci=0, ftype=1
log      =internal log           bsize=4096   blocks=3187, version=2
         =                       sectsz=512   sunit=0 blks, lazy-count=1
realtime =none                   extsz=4096   blocks=0, rtextents=0
*/

-- Step 42 -->> On Node 1 (LVM Partition Configuration - Verify)
root@mongodb-unidev39:~# lsblk
/*
NAME                     MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
loop0                      7:0    0 63.9M  1 loop /snap/core20/2105
loop1                      7:1    0 40.4M  1 loop /snap/snapd/20671
loop2                      7:2    0 63.9M  1 loop /snap/core20/2182
loop3                      7:3    0   87M  1 loop /snap/lxd/27037
sda                        8:0    0  112G  0 disk
├─sda1                     8:1    0    1M  0 part
├─sda2                     8:2    0    1G  0 part /boot
└─sda3                     8:3    0  111G  0 part
  ├─mongodb--lvm-root    252:0    0   40G  0 lvm  /
  ├─mongodb--lvm-home    252:1    0   10G  0 lvm  /home
  ├─mongodb--lvm-srv     252:2    0   10G  0 lvm  /srv
  ├─mongodb--lvm-usr     252:3    0   10G  0 lvm  /usr
  ├─mongodb--lvm-var     252:4    0   10G  0 lvm  /var
  ├─mongodb--lvm-tmp     252:5    0   10G  0 lvm  /tmp
  ├─mongodb--lvm-swap    252:6    0   10G  0 lvm  [SWAP]
  └─mongodb--lvm-var_lib 252:7    0   10G  0 lvm  /var/lib
sdb                        8:16   0   20G  0 disk
└─sdb1                     8:17   0   20G  0 part
  └─data_vg-data_lv      252:8    0 19.9G  0 lvm
sdc                        8:32   0   25G  0 disk
└─sdc1                     8:33   0   25G  0 part
  └─backup_vg-backup_lv  252:9    0 24.9G  0 lvm
sr0                       11:0    1    2G  0 rom
*/

-- Step 43 -->> On Node 1 (LVM Partition Configuration - Verify)
root@mongodb-unidev39:~# blkid
/*
/dev/mapper/mongodb--lvm-home: UUID="37997723-7124-4f2d-a840-f462d96621bc" BLOCK_SIZE="512" TYPE="xfs"
/dev/mapper/mongodb--lvm-swap: UUID="d91af3d4-7722-41c3-9069-7e8212b28686" TYPE="swap"
/dev/mapper/mongodb--lvm-var: UUID="fe16a2ca-3d73-434f-89b0-d3971681392d" BLOCK_SIZE="512" TYPE="xfs"
/dev/mapper/mongodb--lvm-srv: UUID="9555c3c7-19fe-4691-9f8d-b49ca26bd28f" BLOCK_SIZE="512" TYPE="xfs"
/dev/mapper/mongodb--lvm-root: UUID="c5efb531-bc5e-4e05-8ce0-1560a52493de" BLOCK_SIZE="512" TYPE="xfs"
/dev/mapper/mongodb--lvm-var_lib: UUID="6a69d5f3-9591-4957-b09a-3251ef38c49b" BLOCK_SIZE="512" TYPE="xfs"
/dev/sda2: UUID="abc11d41-0786-4ed1-a3a6-09eaa341c23f" BLOCK_SIZE="512" TYPE="xfs" PARTUUID="ed8c13ed-565c-40f5-bfcd-9d75a3d96ad7"
/dev/sda3: UUID="253wUo-RIZS-hmB2-Kquo-ngfk-EO31-Dpv8fX" TYPE="LVM2_member" PARTUUID="1a704ada-458b-48af-b998-eadfc70f2ef0"
/dev/mapper/mongodb--lvm-tmp: UUID="f11cd437-811c-4540-ae17-163947abf40e" BLOCK_SIZE="512" TYPE="xfs"
/dev/mapper/mongodb--lvm-usr: UUID="4ac4f762-c9fa-48c7-b8e0-dd7df64106f3" BLOCK_SIZE="512" TYPE="xfs"
/dev/loop1: TYPE="squashfs"
/dev/mapper/data_vg-data_lv: UUID="615852c2-d7e6-49d1-9882-c41b7bb47a9f" BLOCK_SIZE="512" TYPE="xfs"
/dev/sdb1: UUID="lwLfjT-om6d-Q407-xvKy-uw7M-urcs-P2wbDE" TYPE="LVM2_member" PARTUUID="f60f0d8a-01"
/dev/loop2: TYPE="squashfs"
/dev/loop0: TYPE="squashfs"
/dev/mapper/backup_vg-backup_lv: UUID="4c97daac-b136-44a6-8ef3-ed6824822df2" BLOCK_SIZE="512" TYPE="xfs"
/dev/sdc1: UUID="RQbsEU-ZVW1-SCwH-4yKS-Dq3X-ben3-9aGZSz" TYPE="LVM2_member" PARTUUID="3af4a4e3-01"
/dev/loop3: TYPE="squashfs"
/dev/sda1: PARTUUID="589c587b-e352-4175-bdcc-94823758edfc"
*/

-- Step 44 -->> On Node 1 (LVM Partition Configuration - Before)
root@mongodb-unidev39:~# df -Th
/*
Filesystem                                                                                   Type   Size  Used Avail Use% Mounted on
tmpfs                                                                                        tmpfs  388M  1.6M  386M   1% /run
/dev/mapper/mongodb--lvm-root                                                                xfs     40G  333M   40G   1% /
/dev/disk/by-id/dm-uuid-LVM-W6sa1GFT8xWCd0en83XCkGrzc3RelcAOw1DyFihyCyeUdDI3qOaSeY9i6fp7JOEL xfs     10G  2.8G  7.3G  28% /usr
tmpfs                                                                                        tmpfs  1.9G     0  1.9G   0% /dev/shm
tmpfs                                                                                        tmpfs  5.0M     0  5.0M   0% /run/lock
/dev/mapper/mongodb--lvm-srv                                                                 xfs     10G  104M  9.9G   2% /srv
/dev/mapper/mongodb--lvm-home                                                                xfs     10G  104M  9.9G   2% /home
/dev/mapper/mongodb--lvm-var                                                                 xfs     10G  255M  9.8G   3% /var
/dev/mapper/mongodb--lvm-var_lib                                                             xfs     10G  579M  9.5G   6% /var/lib
/dev/mapper/mongodb--lvm-tmp                                                                 xfs     10G  104M  9.9G   2% /tmp
/dev/sda2                                                                                    xfs   1014M  189M  826M  19% /boot
tmpfs                                                                                        tmpfs  388M  4.0K  388M   1% /run/user/1000
*/

-- Step 45 -->> On Node 1 (LVM Partition Configuration - Mount Additional LVM)
root@mongodb-unidev39:~# mount /dev/mapper/data_vg-data_lv /data
root@mongodb-unidev39:~# mount /dev/mapper/backup_vg-backup_lv /backup
root@mongodb-unidev39:~# df -Th
/*
Filesystem                                                                                   Type   Size  Used Avail Use% Mounted on
tmpfs                                                                                        tmpfs  388M  1.6M  386M   1% /run
/dev/mapper/mongodb--lvm-root                                                                xfs     40G  333M   40G   1% /
/dev/disk/by-id/dm-uuid-LVM-W6sa1GFT8xWCd0en83XCkGrzc3RelcAOw1DyFihyCyeUdDI3qOaSeY9i6fp7JOEL xfs     10G  2.8G  7.3G  28% /usr
tmpfs                                                                                        tmpfs  1.9G     0  1.9G   0% /dev/shm
tmpfs                                                                                        tmpfs  5.0M     0  5.0M   0% /run/lock
/dev/mapper/mongodb--lvm-srv                                                                 xfs     10G  104M  9.9G   2% /srv
/dev/mapper/mongodb--lvm-home                                                                xfs     10G  104M  9.9G   2% /home
/dev/mapper/mongodb--lvm-var                                                                 xfs     10G  256M  9.8G   3% /var
/dev/mapper/mongodb--lvm-var_lib                                                             xfs     10G  579M  9.5G   6% /var/lib
/dev/mapper/mongodb--lvm-tmp                                                                 xfs     10G  104M  9.9G   2% /tmp
/dev/sda2                                                                                    xfs   1014M  189M  826M  19% /boot
tmpfs                                                                                        tmpfs  388M  4.0K  388M   1% /run/user/1000
/dev/mapper/data_vg-data_lv                                                                  xfs     20G  175M   20G   1% /data
/dev/mapper/backup_vg-backup_lv                                                              xfs     25G  210M   25G   1% /backup
*/

-- Step 46 -->> On Node 1 (LVM Partition Configuration - UMount Additional LVM)
root@mongodb-unidev39:~# umount /data/

-- Step 47 -->> On Node 1 (LVM Partition Configuration - UMount Additional LVM)
root@mongodb-unidev39:~# umount /backup

-- Step 48 -->> On Node 1 (LVM Partition Configuration - Verify)
root@mongodb-unidev39:~# df -Th
/*
Filesystem                                                                                   Type   Size  Used Avail Use% Mounted on
tmpfs                                                                                        tmpfs  388M  1.6M  386M   1% /run
/dev/mapper/mongodb--lvm-root                                                                xfs     40G  333M   40G   1% /
/dev/disk/by-id/dm-uuid-LVM-W6sa1GFT8xWCd0en83XCkGrzc3RelcAOw1DyFihyCyeUdDI3qOaSeY9i6fp7JOEL xfs     10G  2.8G  7.3G  28% /usr
tmpfs                                                                                        tmpfs  1.9G     0  1.9G   0% /dev/shm
tmpfs                                                                                        tmpfs  5.0M     0  5.0M   0% /run/lock
/dev/mapper/mongodb--lvm-srv                                                                 xfs     10G  104M  9.9G   2% /srv
/dev/mapper/mongodb--lvm-home                                                                xfs     10G  104M  9.9G   2% /home
/dev/mapper/mongodb--lvm-var                                                                 xfs     10G  256M  9.8G   3% /var
/dev/mapper/mongodb--lvm-var_lib                                                             xfs     10G  579M  9.5G   6% /var/lib
/dev/mapper/mongodb--lvm-tmp                                                                 xfs     10G  104M  9.9G   2% /tmp
/dev/sda2                                                                                    xfs   1014M  189M  826M  19% /boot
tmpfs                                                                                        tmpfs  388M  4.0K  388M   1% /run/user/1000
*/

-- Step 49 -->> On Node 1 (LVM Partition Configuration - Verify)
root@mongodb-unidev39:~# blkid
/*
/dev/mapper/mongodb--lvm-home: UUID="37997723-7124-4f2d-a840-f462d96621bc" BLOCK_SIZE="512" TYPE="xfs"
/dev/mapper/mongodb--lvm-swap: UUID="d91af3d4-7722-41c3-9069-7e8212b28686" TYPE="swap"
/dev/mapper/mongodb--lvm-var: UUID="fe16a2ca-3d73-434f-89b0-d3971681392d" BLOCK_SIZE="512" TYPE="xfs"
/dev/mapper/mongodb--lvm-srv: UUID="9555c3c7-19fe-4691-9f8d-b49ca26bd28f" BLOCK_SIZE="512" TYPE="xfs"
/dev/mapper/mongodb--lvm-root: UUID="c5efb531-bc5e-4e05-8ce0-1560a52493de" BLOCK_SIZE="512" TYPE="xfs"
/dev/mapper/mongodb--lvm-var_lib: UUID="6a69d5f3-9591-4957-b09a-3251ef38c49b" BLOCK_SIZE="512" TYPE="xfs"
/dev/sda2: UUID="abc11d41-0786-4ed1-a3a6-09eaa341c23f" BLOCK_SIZE="512" TYPE="xfs" PARTUUID="ed8c13ed-565c-40f5-bfcd-9d75a3d96ad7"
/dev/sda3: UUID="253wUo-RIZS-hmB2-Kquo-ngfk-EO31-Dpv8fX" TYPE="LVM2_member" PARTUUID="1a704ada-458b-48af-b998-eadfc70f2ef0"
/dev/mapper/mongodb--lvm-tmp: UUID="f11cd437-811c-4540-ae17-163947abf40e" BLOCK_SIZE="512" TYPE="xfs"
/dev/mapper/mongodb--lvm-usr: UUID="4ac4f762-c9fa-48c7-b8e0-dd7df64106f3" BLOCK_SIZE="512" TYPE="xfs"
/dev/loop1: TYPE="squashfs"
/dev/mapper/data_vg-data_lv: UUID="615852c2-d7e6-49d1-9882-c41b7bb47a9f" BLOCK_SIZE="512" TYPE="xfs"
/dev/sdb1: UUID="lwLfjT-om6d-Q407-xvKy-uw7M-urcs-P2wbDE" TYPE="LVM2_member" PARTUUID="f60f0d8a-01"
/dev/loop2: TYPE="squashfs"
/dev/loop0: TYPE="squashfs"
/dev/mapper/backup_vg-backup_lv: UUID="4c97daac-b136-44a6-8ef3-ed6824822df2" BLOCK_SIZE="512" TYPE="xfs"
/dev/sdc1: UUID="RQbsEU-ZVW1-SCwH-4yKS-Dq3X-ben3-9aGZSz" TYPE="LVM2_member" PARTUUID="3af4a4e3-01"
/dev/loop3: TYPE="squashfs"
/dev/sda1: PARTUUID="589c587b-e352-4175-bdcc-94823758edfc"
*/

-- Step 50 -->> On Node 1 (LVM Partition Configuration - Add the id's of LVM to make permanent mount)
root@mongodb-unidev39:~# vi /etc/fstab
/*
# /etc/fstab: static file system information.
#
# Use 'blkid' to print the universally unique identifier for a
# device; this may be used with UUID= as a more robust way to name devices
# that works even if disks are added and removed. See fstab(5).
#
# <file system> <mount point>   <type>  <options>       <dump>  <pass>
/dev/disk/by-id/dm-uuid-LVM-W6sa1GFT8xWCd0en83XCkGrzc3RelcAOhzDxhLXVspoWrBuJStI6bkvr3D7ufYL9 none swap sw 0 0
# / was on /dev/mongodb-lvm/root during curtin installation
/dev/disk/by-id/dm-uuid-LVM-W6sa1GFT8xWCd0en83XCkGrzc3RelcAOvP97MSnbSfgX0U3ZqFtEgna2KaeFklcc / xfs defaults 0 1
# /boot was on /dev/sda2 during curtin installation
/dev/disk/by-uuid/abc11d41-0786-4ed1-a3a6-09eaa341c23f /boot xfs defaults 0 1
# /home was on /dev/mongodb-lvm/home during curtin installation
/dev/disk/by-id/dm-uuid-LVM-W6sa1GFT8xWCd0en83XCkGrzc3RelcAO0olp4addSRvGAYRC5UbtEdhChypWnr7I /home xfs defaults 0 1
# /srv was on /dev/mongodb-lvm/srv during curtin installation
/dev/disk/by-id/dm-uuid-LVM-W6sa1GFT8xWCd0en83XCkGrzc3RelcAO9hZxmD8pF6Az6a41hlkbfKSiwQjNVTUC /srv xfs defaults 0 1
# /usr was on /dev/mongodb-lvm/usr during curtin installation
/dev/disk/by-id/dm-uuid-LVM-W6sa1GFT8xWCd0en83XCkGrzc3RelcAOw1DyFihyCyeUdDI3qOaSeY9i6fp7JOEL /usr xfs defaults 0 1
# /var was on /dev/mongodb-lvm/var during curtin installation
/dev/disk/by-id/dm-uuid-LVM-W6sa1GFT8xWCd0en83XCkGrzc3RelcAOPdDsDTklEr1GV4JvNe6zxinYAPJYkKt9 /var xfs defaults 0 1
# /tmp was on /dev/mongodb-lvm/tmp during curtin installation
/dev/disk/by-id/dm-uuid-LVM-W6sa1GFT8xWCd0en83XCkGrzc3RelcAOnXeF3GDd8fbjQQDb1DHPuoYoD93n9DvM /tmp xfs defaults 0 1
# /var/lib was on /dev/mongodb-lvm/var_lib during curtin installation
/dev/disk/by-id/dm-uuid-LVM-W6sa1GFT8xWCd0en83XCkGrzc3RelcAOs61QyJFnwKfVNdtTnNpfERnCuOqkkWFA /var/lib xfs defaults 0 1
#data
/dev/mapper/data_vg-data_lv /data xfs defaults 0 1
#backup
/dev/mapper/backup_vg-backup_lv /backup xfs defaults 0 1
*/

-- Step 51 -->> On Node 1 (LVM Partition Configuration - Verify)
root@mongodb-unidev39:~# df -Th
/*
Filesystem                                                                                   Type   Size  Used Avail Use% Mounted on
tmpfs                                                                                        tmpfs  388M  1.6M  386M   1% /run
/dev/mapper/mongodb--lvm-root                                                                xfs     40G  333M   40G   1% /
/dev/disk/by-id/dm-uuid-LVM-W6sa1GFT8xWCd0en83XCkGrzc3RelcAOw1DyFihyCyeUdDI3qOaSeY9i6fp7JOEL xfs     10G  2.8G  7.3G  28% /usr
tmpfs                                                                                        tmpfs  1.9G     0  1.9G   0% /dev/shm
tmpfs                                                                                        tmpfs  5.0M     0  5.0M   0% /run/lock
/dev/mapper/mongodb--lvm-srv                                                                 xfs     10G  104M  9.9G   2% /srv
/dev/mapper/mongodb--lvm-home                                                                xfs     10G  104M  9.9G   2% /home
/dev/mapper/mongodb--lvm-var                                                                 xfs     10G  255M  9.8G   3% /var
/dev/mapper/mongodb--lvm-var_lib                                                             xfs     10G  579M  9.5G   6% /var/lib
/dev/mapper/mongodb--lvm-tmp                                                                 xfs     10G  104M  9.9G   2% /tmp
/dev/sda2                                                                                    xfs   1014M  189M  826M  19% /boot
tmpfs                                                                                        tmpfs  388M  4.0K  388M   1% /run/user/1000
*/

-- Step 52 -->> On Node 1 (LVM Partition Configuration - Make permanent mount)
root@mongodb-unidev39:~# mount -a

-- Step 53 -->> On Node 1 (LVM Partition Configuration - Verify)
root@mongodb-unidev39:~# df -Th
/*
Filesystem                                                                                   Type   Size  Used Avail Use% Mounted on
tmpfs                                                                                        tmpfs  388M  1.6M  386M   1% /run
/dev/mapper/mongodb--lvm-root                                                                xfs     40G  333M   40G   1% /
/dev/disk/by-id/dm-uuid-LVM-W6sa1GFT8xWCd0en83XCkGrzc3RelcAOw1DyFihyCyeUdDI3qOaSeY9i6fp7JOEL xfs     10G  2.8G  7.3G  28% /usr
tmpfs                                                                                        tmpfs  1.9G     0  1.9G   0% /dev/shm
tmpfs                                                                                        tmpfs  5.0M     0  5.0M   0% /run/lock
/dev/mapper/mongodb--lvm-srv                                                                 xfs     10G  104M  9.9G   2% /srv
/dev/mapper/mongodb--lvm-home                                                                xfs     10G  104M  9.9G   2% /home
/dev/mapper/mongodb--lvm-var                                                                 xfs     10G  255M  9.8G   3% /var
/dev/mapper/mongodb--lvm-var_lib                                                             xfs     10G  579M  9.5G   6% /var/lib
/dev/mapper/mongodb--lvm-tmp                                                                 xfs     10G  104M  9.9G   2% /tmp
/dev/sda2                                                                                    xfs   1014M  189M  826M  19% /boot
tmpfs                                                                                        tmpfs  388M  4.0K  388M   1% /run/user/1000
/dev/mapper/data_vg-data_lv                                                                  xfs     20G  175M   20G   1% /data
/dev/mapper/backup_vg-backup_lv                                                              xfs     25G  210M   25G   1% /backup
*/

-- Step 54 -->> On Node 1 (LVM Partition Configuration - Reboot)
root@mongodb-unidev39:~# init 6

-- Step 55 -->> On Node 1 (LVM Partition Configuration - Verify)
root@mongodb-unidev39:~# df -Th
/*
Filesystem                                                                                   Type   Size  Used Avail Use% Mounted on
tmpfs                                                                                        tmpfs  388M  1.6M  386M   1% /run
/dev/mapper/mongodb--lvm-root                                                                xfs     40G  333M   40G   1% /
/dev/disk/by-id/dm-uuid-LVM-W6sa1GFT8xWCd0en83XCkGrzc3RelcAOw1DyFihyCyeUdDI3qOaSeY9i6fp7JOEL xfs     10G  2.8G  7.3G  28% /usr
tmpfs                                                                                        tmpfs  1.9G     0  1.9G   0% /dev/shm
tmpfs                                                                                        tmpfs  5.0M     0  5.0M   0% /run/lock
/dev/sda2                                                                                    xfs   1014M  189M  826M  19% /boot
/dev/mapper/mongodb--lvm-var                                                                 xfs     10G  256M  9.8G   3% /var
/dev/mapper/mongodb--lvm-home                                                                xfs     10G  104M  9.9G   2% /home
/dev/mapper/data_vg-data_lv                                                                  xfs     20G  175M   20G   1% /data
/dev/mapper/backup_vg-backup_lv                                                              xfs     25G  210M   25G   1% /backup
/dev/mapper/mongodb--lvm-var_lib                                                             xfs     10G  579M  9.5G   6% /var/lib
/dev/mapper/mongodb--lvm-srv                                                                 xfs     10G  104M  9.9G   2% /srv
/dev/mapper/mongodb--lvm-tmp                                                                 xfs     10G  104M  9.9G   2% /tmp
tmpfs                                                                                        tmpfs  388M  4.0K  388M   1% /run/user/1000
*/

-- Step 56 -->> On Node 1 (LVM Partition Configuration - Verify)
root@mongodb-unidev39:~# lsblk
/*
NAME                     MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
loop0                      7:0    0 63.9M  1 loop /snap/core20/2105
loop1                      7:1    0   87M  1 loop /snap/lxd/27037
loop2                      7:2    0 40.4M  1 loop /snap/snapd/20671
loop3                      7:3    0 63.9M  1 loop /snap/core20/2182
sda                        8:0    0  112G  0 disk
├─sda1                     8:1    0    1M  0 part
├─sda2                     8:2    0    1G  0 part /boot
└─sda3                     8:3    0  111G  0 part
  ├─mongodb--lvm-root    252:2    0   40G  0 lvm  /
  ├─mongodb--lvm-home    252:3    0   10G  0 lvm  /home
  ├─mongodb--lvm-srv     252:4    0   10G  0 lvm  /srv
  ├─mongodb--lvm-usr     252:5    0   10G  0 lvm  /usr
  ├─mongodb--lvm-var     252:6    0   10G  0 lvm  /var
  ├─mongodb--lvm-tmp     252:7    0   10G  0 lvm  /tmp
  ├─mongodb--lvm-swap    252:8    0   10G  0 lvm  [SWAP]
  └─mongodb--lvm-var_lib 252:9    0   10G  0 lvm  /var/lib
sdb                        8:16   0   20G  0 disk
└─sdb1                     8:17   0   20G  0 part
  └─data_vg-data_lv      252:1    0 19.9G  0 lvm  /data
sdc                        8:32   0   25G  0 disk
└─sdc1                     8:33   0   25G  0 part
  └─backup_vg-backup_lv  252:0    0 24.9G  0 lvm  /backup
sr0                       11:0    1 1024M  0 rom
*/

-- Step 57 -->> On Node 1 (Create Backup Directories)
root@mongodb-unidev39:/# mkdir -p /backup/mongodbFullBackup
root@mongodb-unidev39:/# chown -R mongodb:mongodb /backup/
root@mongodb-unidev39:/# chmod -R 775 /backup/

-- Step 58 -->> On Node 1
root@mongodb-unidev39:/# ll | grep backup
/*
drwxrwxr-x    3 mongodb mongodb   31 Feb 28 09:46 backup/
*/

-- Step 59 -->> On Node 1
root@mongodb-unidev39:/# ll  backup/
/*
drwxrwxr-x   3 mongodb mongodb   31 Feb 28 09:46 ./
drwxr-xr-x. 21 root    root    4096 Feb 28 09:04 ../
drwxrwxr-x   2 mongodb mongodb    6 Feb 28 09:46 mongodbFullBackup/
*/

-- Step 60 -->> On Node 1 (Create Data/Log Directories)
root@mongodb-unidev39:/# mkdir -p /data/mongodb
root@mongodb-unidev39:/# mkdir -p /data/log
root@mongodb-unidev39:/# chown -R mongodb:mongodb /data/
root@mongodb-unidev39:/# chmod -R 777 /data/

-- Step 61 -->> On Node 1
root@mongodb-unidev39:/# ll | grep data
/*
drwxrwxrwx    4 mongodb mongodb   32 Feb 29 04:44 data/
*/

-- Step 62 -->> On Node 1
root@mongodb-unidev39:/# ll  data/
/*
drwxrwxrwx   4 mongodb mongodb   32 Feb 29 04:44 ./
drwxr-xr-x. 21 root    root    4096 Feb 28 09:04 ../
drwxrwxrwx   2 mongodb mongodb    6 Feb 29 04:44 log/
drwxrwxrwx   2 mongodb mongodb    6 Feb 28 09:47 mongodb/
*/

-- Step 63 -->> On Node 1 (Verfy the ssh connection)
root@mongodb-unidev39:~# ssh mongodb@192.168.56.158
/*
mongodb@192.168.56.158's password:mongodb
Welcome to Ubuntu 22.04.4 LTS (GNU/Linux 6.5.0-21-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/pro

  System information as of Wed Feb 28 09:58:27 AM UTC 2024

  System load:    0.01806640625    Processes:              304
  Usage of /home: 1.0% of 9.99GB   Users logged in:        1
  Memory usage:   9%               IPv4 address for ens32: 192.168.56.158
  Swap usage:     0%


Expanded Security Maintenance for Applications is not enabled.

0 updates can be applied immediately.

Enable ESM Apps to receive additional future security updates.
See https://ubuntu.com/esm or run: sudo pro status


Last login: Wed Feb 28 09:20:24 2024 from 192.168.56.1
*/

-- Step 64 -->> On Node 1 (Install gnupg and curl)
mongodb@mongodb-unidev39:~$ sudo apt-get install gnupg curl
/*
[sudo] password for mongodb:mongodb
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
curl is already the newest version (7.81.0-1ubuntu1.15).
curl set to manually installed.
gnupg is already the newest version (2.2.27-3ubuntu2.1).
gnupg set to manually installed.
0 upgraded, 0 newly installed, 0 to remove and 0 not upgraded.
*/

-- Step 65 -->> On Node 1 (To import the MongoDB public GPG key)
mongodb@mongodb-unidev39:~$ curl -fsSL https://www.mongodb.org/static/pgp/server-7.0.asc | \
   sudo gpg -o /usr/share/keyrings/mongodb-server-7.0.gpg \
   --dearmor

-- Step 66 -->> On Node 1 (Verification)
mongodb@mongodb-unidev39:~$ apt-key list
/*
Warning: apt-key is deprecated. Manage keyring files in trusted.gpg.d instead (see apt-key(8)).
/etc/apt/trusted.gpg.d/ubuntu-keyring-2012-cdimage.gpg
------------------------------------------------------
pub   rsa4096 2012-05-11 [SC]
      8439 38DF 228D 22F7 B374  2BC0 D94A A3F0 EFE2 1092
uid           [ unknown] Ubuntu CD Image Automatic Signing Key (2012) <cdimage@ubuntu.com>

/etc/apt/trusted.gpg.d/ubuntu-keyring-2018-archive.gpg
------------------------------------------------------
pub   rsa4096 2018-09-17 [SC]
      F6EC B376 2474 EDA9 D21B  7022 8719 20D1 991B C93C
uid           [ unknown] Ubuntu Archive Automatic Signing Key (2018) <ftpmaster@ubuntu.com>
*/

-- Step 67 -->> On Node 1 (Create the repo-list file /etc/apt/sources.list.d/mongodb-org-7.0.list)
mongodb@mongodb-unidev39:~$ echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-7.0.gpg ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-7.0.list
/*
deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-7.0.gpg ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 multiverse
*/

-- Step 68 -->> On Node 1 (Update the Local RPM's)
mongodb@mongodb-unidev39:~$ sudo apt-get update
/*
Ign:1 https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 InRelease
Get:2 http://security.ubuntu.com/ubuntu jammy-security InRelease [110 kB]
Hit:3 http://np.archive.ubuntu.com/ubuntu jammy InRelease
Get:4 https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 Release [2,090 B]
Get:5 http://np.archive.ubuntu.com/ubuntu jammy-updates InRelease [119 kB]
Get:6 https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 Release.gpg [866 B]
Get:7 https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0/multiverse amd64 Packages [26.3 kB]
Hit:8 http://np.archive.ubuntu.com/ubuntu jammy-backports InRelease
Get:9 https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0/multiverse arm64 Packages [25.2 kB]
Fetched 284 kB in 3s (112 kB/s)
Reading package lists... Done
*/

-- Step 69 -->> On Node 1 (Verification)
mongodb@mongodb-unidev39:~$ sudo apt list --upgradable
/*
Listing... Done
*/

-- Step 70 -->> On Node 1 (Install the MongoDB packages)
mongodb@mongodb-unidev39:~$ sudo apt-get install -y mongodb-org
/*
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
The following additional packages will be installed:
  mongodb-database-tools mongodb-mongosh mongodb-org-database mongodb-org-database-tools-extra mongodb-org-mongos mongodb-org-server mongodb-org-shell
  mongodb-org-tools
The following NEW packages will be installed:
  mongodb-database-tools mongodb-mongosh mongodb-org mongodb-org-database mongodb-org-database-tools-extra mongodb-org-mongos mongodb-org-server
  mongodb-org-shell mongodb-org-tools
0 upgraded, 9 newly installed, 0 to remove and 0 not upgraded.
Need to get 163 MB of archives.
After this operation, 535 MB of additional disk space will be used.
Get:1 https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0/multiverse amd64 mongodb-database-tools amd64 100.9.4 [51.9 MB]
Get:2 https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0/multiverse amd64 mongodb-mongosh amd64 2.1.5 [48.7 MB]
Get:3 https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0/multiverse amd64 mongodb-org-shell amd64 7.0.5 [2,982 B]
Get:4 https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0/multiverse amd64 mongodb-org-server amd64 7.0.5 [36.5 MB]
Get:5 https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0/multiverse amd64 mongodb-org-mongos amd64 7.0.5 [25.4 MB]
Get:6 https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0/multiverse amd64 mongodb-org-database-tools-extra amd64 7.0.5 [7,762 B]
Get:7 https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0/multiverse amd64 mongodb-org-database amd64 7.0.5 [3,424 B]
Get:8 https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0/multiverse amd64 mongodb-org-tools amd64 7.0.5 [2,766 B]
Get:9 https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0/multiverse amd64 mongodb-org amd64 7.0.5 [2,800 B]
Fetched 163 MB in 16s (9,857 kB/s)
Selecting previously unselected package mongodb-database-tools.
(Reading database ... 80025 files and directories currently installed.)
Preparing to unpack .../0-mongodb-database-tools_100.9.4_amd64.deb ...
Unpacking mongodb-database-tools (100.9.4) ...
Selecting previously unselected package mongodb-mongosh.
Preparing to unpack .../1-mongodb-mongosh_2.1.5_amd64.deb ...
Unpacking mongodb-mongosh (2.1.5) ...
Selecting previously unselected package mongodb-org-shell.
Preparing to unpack .../2-mongodb-org-shell_7.0.5_amd64.deb ...
Unpacking mongodb-org-shell (7.0.5) ...
Selecting previously unselected package mongodb-org-server.
Preparing to unpack .../3-mongodb-org-server_7.0.5_amd64.deb ...
Unpacking mongodb-org-server (7.0.5) ...
Selecting previously unselected package mongodb-org-mongos.
Preparing to unpack .../4-mongodb-org-mongos_7.0.5_amd64.deb ...
Unpacking mongodb-org-mongos (7.0.5) ...
Selecting previously unselected package mongodb-org-database-tools-extra.
Preparing to unpack .../5-mongodb-org-database-tools-extra_7.0.5_amd64.deb ...
Unpacking mongodb-org-database-tools-extra (7.0.5) ...
Selecting previously unselected package mongodb-org-database.
Preparing to unpack .../6-mongodb-org-database_7.0.5_amd64.deb ...
Unpacking mongodb-org-database (7.0.5) ...
Selecting previously unselected package mongodb-org-tools.
Preparing to unpack .../7-mongodb-org-tools_7.0.5_amd64.deb ...
Unpacking mongodb-org-tools (7.0.5) ...
Selecting previously unselected package mongodb-org.
Preparing to unpack .../8-mongodb-org_7.0.5_amd64.deb ...
Unpacking mongodb-org (7.0.5) ...
Setting up mongodb-mongosh (2.1.5) ...
Setting up mongodb-org-server (7.0.5) ...
Setting up mongodb-org-shell (7.0.5) ...
Setting up mongodb-database-tools (100.9.4) ...
Setting up mongodb-org-mongos (7.0.5) ...
Setting up mongodb-org-database-tools-extra (7.0.5) ...
Setting up mongodb-org-database (7.0.5) ...
Setting up mongodb-org-tools (7.0.5) ...
Setting up mongodb-org (7.0.5) ...
Processing triggers for man-db (2.10.2-1) ...
Scanning processes...
Scanning linux images...

Running kernel seems to be up-to-date.

No services need to be restarted.

No containers need to be restarted.

No user sessions are running outdated binaries.

No VM guests are running outdated hypervisor (qemu) binaries on this host.
*/

-- Step 71 -->> On Node 1 (MongoDB Configuration)
root@mongodb-unidev39:/# cp -r /etc/mongod.conf /etc/mongod.conf.backup

-- Step 72 -->> On Node 1 (MongoDB Configuration)
root@mongodb-unidev39:/# ll /etc/ | grep mongo
/*
-rw-r--r--   1 root root        578 Dec 19  2013 mongod.conf
-rw-r--r--   1 root root        578 Feb 29 04:47 mongod.conf.backup
*/

-- Step 73 -->> On Node 1 (MongoDB Configuration)
root@mongodb-unidev39:/# vi /etc/mongod.conf
/*
# mongod.conf

# for documentation of all options, see:
#   http://docs.mongodb.org/manual/reference/configuration-options/

# Where and how to store data.
storage:
  dbPath: /data/mongodb
#  engine:
#  wiredTiger:

# where to write logging data.
systemLog:
  destination: file
  logAppend: true
  path: /data/log/mongod.log

# network interfaces
net:
  port: 27017
  bindIp: 127.0.0.1,192.168.56.158


# how the process runs
processManagement:
  timeZoneInfo: /usr/share/zoneinfo

#security:

#operationProfiling:

#replication:

#sharding:

## Enterprise-Only Options:

#auditLog:
*/

-- Step 74 -->> On Node 1 (Tuning For MongoDB)
root@mongodb-unidev39:/# vi /etc/mongod.conf
/*
# network interfaces
net:
  port: 27017
  bindIp: 127.0.0.1,192.168.56.148
  maxIncomingConnections: 999999
*/

-- Step 75 -->> On Node 1 (Tuning For MongoDB)
root@mongodb-unidev39:/# ulimit -a
/*
real-time non-blocking time  (microseconds, -R) unlimited
core file size              (blocks, -c) 0
data seg size               (kbytes, -d) unlimited
scheduling priority                 (-e) 0
file size                   (blocks, -f) unlimited
pending signals                     (-i) 14971
max locked memory           (kbytes, -l) 495436
max memory size             (kbytes, -m) unlimited
open files                          (-n) 1024
pipe size                (512 bytes, -p) 8
POSIX message queues         (bytes, -q) 819200
real-time priority                  (-r) 0
stack size                  (kbytes, -s) 8192
cpu time                   (seconds, -t) unlimited
max user processes                  (-u) 14971
virtual memory              (kbytes, -v) unlimited
file locks                          (-x) unlimited
*/

-- Step 76 -->> On Node 1 (Tuning For MongoDB)
root@mongodb-unidev39:/# ulimit -n 64000

-- Step 77 -->> On Node 1 (Tuning For MongoDB)
root@mongodb-unidev39:/# ulimit -a
/*
real-time non-blocking time  (microseconds, -R) unlimited
core file size              (blocks, -c) 0
data seg size               (kbytes, -d) unlimited
scheduling priority                 (-e) 0
file size                   (blocks, -f) unlimited
pending signals                     (-i) 14971
max locked memory           (kbytes, -l) 495436
max memory size             (kbytes, -m) unlimited
open files                          (-n) 64000
pipe size                (512 bytes, -p) 8
POSIX message queues         (bytes, -q) 819200
real-time priority                  (-r) 0
stack size                  (kbytes, -s) 8192
cpu time                   (seconds, -t) unlimited
max user processes                  (-u) 14971
virtual memory              (kbytes, -v) unlimited
file locks                          (-x) unlimited
*/

-- Step 78 -->> On Node 1 (Tuning For MongoDB)
root@mongodb-unidev39:/# echo "mongodb           soft    nofile          9999999" | tee -a /etc/security/limits.conf
root@mongodb-unidev39:/# echo "mongodb           hard    nofile          9999999" | tee -a /etc/security/limits.conf
root@mongodb-unidev39:/# echo "mongodb           soft    nproc           9999999" | tee -a /etc/security/limits.conf
root@mongodb-unidev39:/# echo "mongodb           hard    nproc           9999999" | tee -a /etc/security/limits.conf
root@mongodb-unidev39:/# echo "mongodb           soft    stack           9999999" | tee -a /etc/security/limits.conf
root@mongodb-unidev39:/# echo "mongodb           hard    stack           9999999" | tee -a /etc/security/limits.conf
root@mongodb-unidev39:/# echo 9999999 > /proc/sys/vm/max_map_count
root@mongodb-unidev39:/# echo "vm.max_map_count=9999999" | tee -a /etc/sysctl.conf
root@mongodb-unidev39:/# echo 1024 65530 > /proc/sys/net/ipv4/ip_local_port_range
root@mongodb-unidev39:/# echo "net.ipv4.ip_local_port_range = 1024 65530" | tee -a /etc/sysctl.conf

-- Step 79 -->> On Node 1 (Enable MongoDB)
root@mongodb-unidev39:/# systemctl enable mongod --now
/*
Created symlink /etc/systemd/system/multi-user.target.wants/mongod.service → /lib/systemd/system/mongod.service.
*/

-- Step 80 -->> On Node 1 (Start MongoDB)
root@mongodb-unidev39:/# systemctl start mongod

-- Step 81 -->> On Node 1 (Verify MongoDB)
root@mongodb-unidev39:/# systemctl status mongod
/*
● mongod.service - MongoDB Database Server
     Loaded: loaded (/lib/systemd/system/mongod.service; enabled; vendor preset: enabled)
     Active: active (running) since Thu 2024-02-29 05:17:44 UTC; 14s ago
       Docs: https://docs.mongodb.org/manual
   Main PID: 1862 (mongod)
     Memory: 155.6M
        CPU: 2.957s
     CGroup: /system.slice/mongod.service
             └─1862 /usr/bin/mongod --config /etc/mongod.conf

Feb 29 05:17:44 mongodb-unidev39.org.np systemd[1]: Started MongoDB Database Server.
Feb 29 05:17:46 mongodb-unidev39.org.np mongod[1862]: {"t":{"$date":"2024-02-29T05:17:46.111Z"},"s":"I",  "c":"CONTROL",  "id":7484500, "ctx":"main","msg":"Environment variable MONGODB_CON>
*/

-- Step 82 -->> On Node 1 (Begin using MongoDB)
root@mongodb-unidev39:/# mongosh
/*
Current Mongosh Log ID: 65e015a38caccba26c173cbc
Connecting to:          mongodb://127.0.0.1:27017/?directConnection=true&serverSelectionTimeoutMS=2000&appName=mongosh+2.1.5
Using MongoDB:          7.0.5
Using Mongosh:          2.1.5

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

------
   The server generated these startup warnings when booting
   2024-02-29T05:17:48.640+00:00: Access control is not enabled for the database. Read and write access to data and configuration is unrestricted
------

test> db.version()
7.0.5
test> show databases;
admin   40.00 KiB
config  60.00 KiB
local   40.00 KiB
test> quit()
*/

-- Step 83 -->> On Node 1 (Default DBPath)
root@mongodb-unidev39:~# ll /var/lib/mongodb/
/*
drwxr-xr-x   2 mongodb mongodb    6 Feb 28 10:12 ./
drwxr-xr-x. 43 root    root    4096 Feb 28 10:12 ../
*/

-- Step 84 -->> On Node 1 (Default LogPath)
root@mongodb-unidev39:~# ll /var/log/mongodb/
/*
drwxr-xr-x   2 mongodb mongodb    6 Feb 28 10:12 ./
drwxrwxr-x. 10 root    syslog  4096 Feb 29 04:34 ../
*/

-- Step 85 -->> On Node 1 (Manuall DBPath)
root@mongodb-unidev39:~# ll /data/mongodb/
/*
drwxrwxrwx 4 mongodb mongodb  4096 Feb 29 05:34 ./
drwxrwxrwx 4 mongodb mongodb    32 Feb 29 04:44 ../
-rw------- 1 mongodb mongodb 20480 Feb 29 05:30 collection-0-1729872573736401853.wt
-rw------- 1 mongodb mongodb 36864 Feb 29 05:31 collection-2-1729872573736401853.wt
-rw------- 1 mongodb mongodb 24576 Feb 29 05:28 collection-4-1729872573736401853.wt
drwx------ 2 mongodb mongodb   113 Feb 29 05:34 diagnostic.data/
-rw------- 1 mongodb mongodb 20480 Feb 29 05:30 index-1-1729872573736401853.wt
-rw------- 1 mongodb mongodb 36864 Feb 29 05:31 index-3-1729872573736401853.wt
-rw------- 1 mongodb mongodb 24576 Feb 29 05:28 index-5-1729872573736401853.wt
-rw------- 1 mongodb mongodb 24576 Feb 29 05:31 index-6-1729872573736401853.wt
drwx------ 2 mongodb mongodb   110 Feb 29 05:30 journal/
-rw------- 1 mongodb mongodb 20480 Feb 29 05:30 _mdb_catalog.wt
-rw------- 1 mongodb mongodb     5 Feb 29 05:30 mongod.lock
-rw------- 1 mongodb mongodb 36864 Feb 29 05:31 sizeStorer.wt
-rw------- 1 mongodb mongodb   114 Feb 29 05:17 storage.bson
-rw------- 1 mongodb mongodb    50 Feb 29 05:17 WiredTiger
-rw------- 1 mongodb mongodb  4096 Feb 29 05:30 WiredTigerHS.wt
-rw------- 1 mongodb mongodb    21 Feb 29 05:17 WiredTiger.lock
-rw------- 1 mongodb mongodb  1466 Feb 29 05:34 WiredTiger.turtle
-rw------- 1 mongodb mongodb 69632 Feb 29 05:34 WiredTiger.wt
*/

-- Step 86 -->> On Node 1 (Manuall LogPath)
root@mongodb-unidev39:~# tail -f /data/log/mongod.log
/*
{"t":{"$date":"2024-02-29T05:32:06.374+00:00"},"s":"I",  "c":"NETWORK",  "id":6788700, "ctx":"conn6","msg":"Received first command on ingress connection since session start or auth handshake","attr":{"elapsedMillis":7}}
{"t":{"$date":"2024-02-29T05:32:06.375+00:00"},"s":"I",  "c":"NETWORK",  "id":22943,   "ctx":"listener","msg":"Connection accepted","attr":{"remote":"127.0.0.1:19226","uuid":{"uuid":{"$uuid":"ce2abd58-1782-4ec1-8ab6-a685cb990e11"}},"connectionId":8,"connectionCount":4}}
{"t":{"$date":"2024-02-29T05:32:06.388+00:00"},"s":"I",  "c":"NETWORK",  "id":51800,   "ctx":"conn8","msg":"client metadata","attr":{"remote":"127.0.0.1:19226","client":"conn8","doc":{"application":{"name":"mongosh 2.1.5"},"driver":{"name":"nodejs|mongosh","version":"6.3.0|2.1.5"},"platform":"Node.js v20.11.1, LE","os":{"name":"linux","architecture":"x64","version":"6.5.0-21-generic","type":"Linux"}}}}
{"t":{"$date":"2024-02-29T05:32:06.394+00:00"},"s":"I",  "c":"NETWORK",  "id":6788700, "ctx":"conn8","msg":"Received first command on ingress connection since session start or auth handshake","attr":{"elapsedMillis":6}}
{"t":{"$date":"2024-02-29T05:32:06.830+00:00"},"s":"I",  "c":"NETWORK",  "id":6788700, "ctx":"conn7","msg":"Received first command on ingress connection since session start or auth handshake","attr":{"elapsedMillis":460}}
{"t":{"$date":"2024-02-29T05:32:15.415+00:00"},"s":"I",  "c":"-",        "id":20883,   "ctx":"conn5","msg":"Interrupted operation as its client disconnected","attr":{"opId":1185}}
{"t":{"$date":"2024-02-29T05:32:15.416+00:00"},"s":"I",  "c":"NETWORK",  "id":22944,   "ctx":"conn5","msg":"Connection ended","attr":{"remote":"127.0.0.1:19188","uuid":{"uuid":{"$uuid":"59dcbb0d-8f94-4bc7-a372-30fa058ec325"}},"connectionId":5,"connectionCount":3}}
{"t":{"$date":"2024-02-29T05:32:15.418+00:00"},"s":"I",  "c":"NETWORK",  "id":22944,   "ctx":"conn7","msg":"Connection ended","attr":{"remote":"127.0.0.1:19210","uuid":{"uuid":{"$uuid":"69d19b54-f142-4734-b160-858e89b36b53"}},"connectionId":7,"connectionCount":2}}
{"t":{"$date":"2024-02-29T05:32:15.420+00:00"},"s":"I",  "c":"NETWORK",  "id":22944,   "ctx":"conn8","msg":"Connection ended","attr":{"remote":"127.0.0.1:19226","uuid":{"uuid":{"$uuid":"ce2abd58-1782-4ec1-8ab6-a685cb990e11"}},"connectionId":8,"connectionCount":1}}
{"t":{"$date":"2024-02-29T05:32:15.420+00:00"},"s":"I",  "c":"NETWORK",  "id":22944,   "ctx":"conn6","msg":"Connection ended","attr":{"remote":"127.0.0.1:19196","uuid":{"uuid":{"$uuid":"dc2a3e8b-80e3-4256-a3b4-9fc6847008d2"}},"connectionId":6,"connectionCount":0}}
*/

-- Step 87 -->> On Node 1 (Stop MongoDB)
root@mongodb-unidev39:/# systemctl stop mongod

-- Step 88 -->> On Node 1 (Find the location of MongoDB)
root@mongodb-unidev39:/# which mongosh
/*
/usr/bin/mongosh
*/

-- Step 89 -->> On Node 1 (After MongoDB Version 4.4 the "mongo" shell is not avilable)
root@mongodb-unidev39:/# cd /usr/bin/

-- Step 90 -->> On Node 1
root@mongodb-unidev39:/usr/bin# ll | grep mongo
/*
-rwxr-xr-x   1 mongodb mongodb  13740784 Dec  7 16:17 bsondump*
-rwxr-xr-x   1 root    root    181853696 Dec 19  2013 mongod*
-rwxr-xr-x   1 mongodb mongodb  16185776 Dec  7 16:17 mongodump*
-rwxr-xr-x   1 mongodb mongodb  15877000 Dec  7 16:17 mongoexport*
-rwxr-xr-x   1 mongodb mongodb  16725592 Dec  7 16:17 mongofiles*
-rwxr-xr-x   1 mongodb mongodb  16128496 Dec  7 16:17 mongoimport*
-rwxr-xr-x   1 mongodb mongodb  16517352 Dec  7 16:17 mongorestore*
-rwxr-xr-x   1 root    root    129466856 Dec 19  2013 mongos*
-rwxr-xr-x   1 root    root    112757240 Feb 19 11:00 mongosh*
-rwxr-xr-x   1 mongodb mongodb  15746288 Dec  7 16:17 mongostat*
-rwxr-xr-x   1 mongodb mongodb  15317640 Dec  7 16:17 mongotop*
*/

-- Step 91 -->> On Node 1 (Make a copy of mongosh as mongo)
root@mongodb-unidev39:/usr/bin# cp mongosh mongo

-- Step 92 -->> On Node 1
root@mongodb-unidev39:/usr/bin# ll | grep mongo
/*
-rwxr-xr-x   1 mongodb mongodb  13740784 Dec  7 16:17 bsondump*
-rwxr-xr-x   1 root    root    112757240 Feb 29 05:29 mongo*
-rwxr-xr-x   1 root    root    181853696 Dec 19  2013 mongod*
-rwxr-xr-x   1 mongodb mongodb  16185776 Dec  7 16:17 mongodump*
-rwxr-xr-x   1 mongodb mongodb  15877000 Dec  7 16:17 mongoexport*
-rwxr-xr-x   1 mongodb mongodb  16725592 Dec  7 16:17 mongofiles*
-rwxr-xr-x   1 mongodb mongodb  16128496 Dec  7 16:17 mongoimport*
-rwxr-xr-x   1 mongodb mongodb  16517352 Dec  7 16:17 mongorestore*
-rwxr-xr-x   1 root    root    129466856 Dec 19  2013 mongos*
-rwxr-xr-x   1 root    root    112757240 Feb 19 11:00 mongosh*
-rwxr-xr-x   1 mongodb mongodb  15746288 Dec  7 16:17 mongostat*
-rwxr-xr-x   1 mongodb mongodb  15317640 Dec  7 16:17 mongotop*
*/

-- Step 93 -->> On Node 1 (Start MongoDB)
root@mongodb-unidev39:~# systemctl start mongod

-- Step 94 -->> On Node 1 (Verify MongoDB)
root@mongodb-unidev39:~# systemctl status mongod
/*
● mongod.service - MongoDB Database Server
     Loaded: loaded (/lib/systemd/system/mongod.service; enabled; vendor preset: enabled)
     Active: active (running) since Thu 2024-02-29 05:30:28 UTC; 4s ago
       Docs: https://docs.mongodb.org/manual
   Main PID: 2135 (mongod)
     Memory: 169.3M
        CPU: 3.786s
     CGroup: /system.slice/mongod.service
             └─2135 /usr/bin/mongod --config /etc/mongod.conf

Feb 29 05:30:28 mongodb-unidev39.org.np systemd[1]: Started MongoDB Database Server.
Feb 29 05:30:28 mongodb-unidev39.org.np mongod[2135]: {"t":{"$date":"2024-02-29T05:30:28.195Z"},"s":"I",  "c":"CONTROL",  "id":7484500, "ctx":"main","msg":"Environment variable MONGODB_CON>
*/

-- Step 95 -->> On Node 1 (Begin with MongoDB)
root@mongodb-unidev39:~# mongosh
/*
Current Mongosh Log ID: 65e016a7e3f00bd1fac1ae8d
Connecting to:          mongodb://127.0.0.1:27017/?directConnection=true&serverSelectionTimeoutMS=2000&appName=mongosh+2.1.5
Using MongoDB:          7.0.5
Using Mongosh:          2.1.5

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

------
   The server generated these startup warnings when booting
   2024-02-29T05:30:31.765+00:00: Access control is not enabled for the database. Read and write access to data and configuration is unrestricted
------

test> db.version()
7.0.5
test> show databases;
admin   40.00 KiB
config  72.00 KiB
local   40.00 KiB
test> quit()
*/

-- Step 96 -->> On Node 1 (Begin with MongoDB)
root@mongodb-unidev39:~# mongo
/*
Current Mongosh Log ID: 65e016d5b7961dab851e84d1
Connecting to:          mongodb://127.0.0.1:27017/?directConnection=true&serverSelectionTimeoutMS=2000&appName=mongosh+2.1.5
Using MongoDB:          7.0.5
Using Mongosh:          2.1.5

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

------
   The server generated these startup warnings when booting
   2024-02-29T05:30:31.765+00:00: Access control is not enabled for the database. Read and write access to data and configuration is unrestricted
------

test> db.version()
7.0.5
test> show databases;
admin   40.00 KiB
config  72.00 KiB
local   72.00 KiB
test> quit()
*/

-- Step 97 -->> On Node 1 (Switch user into MongoDB)
root@mongodb-unidev39:~# su - mongodb
mongodb@mongodb-unidev39:~$ systemctl status mongod
/*
● mongod.service - MongoDB Database Server
     Loaded: loaded (/lib/systemd/system/mongod.service; enabled; vendor preset: enabled)
     Active: active (running) since Thu 2024-02-29 05:30:28 UTC; 2min 57s ago
       Docs: https://docs.mongodb.org/manual
   Main PID: 2135 (mongod)
     Memory: 170.9M
        CPU: 7.582s
     CGroup: /system.slice/mongod.service
             └─2135 /usr/bin/mongod --config /etc/mongod.conf

Feb 29 05:30:28 mongodb-unidev39.org.np systemd[1]: Started MongoDB Database Server.
Feb 29 05:30:28 mongodb-unidev39.org.np mongod[2135]: {"t":{"$date":"2024-02-29T05:30:28.195Z"},"s":"I",  "c":"CONTROL",  "id":7484500, "ctx":"main","msg":"Environment variable MONGODB_CON>
*/

-- Step 98 -->> On Node 1 (Verify MongoDB)
mongodb@mongodb-unidev39:~$ mongosh --eval 'db.runCommand({ connectionStatus: 1 })'
/*
Current Mongosh Log ID: 65e018426137251599adeacf
Connecting to:          mongodb://127.0.0.1:27017/?directConnection=true&serverSelectionTimeoutMS=2000&appName=mongosh+2.1.5
Using MongoDB:          7.0.5
Using Mongosh:          2.1.5

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

------
   The server generated these startup warnings when booting
   2024-02-29T05:30:31.765+00:00: Access control is not enabled for the database. Read and write access to data and configuration is unrestricted
------

{
  authInfo: { authenticatedUsers: [], authenticatedUserRoles: [] },
  ok: 1
}
*/

-- Step 99 -->> On Node 1 (Begin with MongoDB - Create user for Authorized)
mongodb@mongodb-unidev39:~$ mongosh
/*
Current Mongosh Log ID: 65e0192f62a00aba40827ed0
Connecting to:          mongodb://127.0.0.1:27017/?directConnection=true&serverSelectionTimeoutMS=2000&appName=mongosh+2.1.5
Using MongoDB:          7.0.5
Using Mongosh:          2.1.5

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

------
   The server generated these startup warnings when booting
   2024-02-29T05:30:31.765+00:00: Access control is not enabled for the database. Read and write access to data and configuration is unrestricted
------

test> db.version()
7.0.5

test> show databases;
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
      userId: UUID('9ea555c7-3e8b-47ed-aee8-2eabcf9c7ccf'),
      user: 'admin',
      db: 'admin',
      roles: [ { role: 'root', db: 'admin' } ],
      mechanisms: [ 'SCRAM-SHA-1', 'SCRAM-SHA-256' ]
    }
  ],
  ok: 1
}

admin> db.auth('admin','P#ssw0rD');
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
      userId: UUID('03afcdb5-d38b-47b5-b5a1-9a5f10f4b8f5'),
      user: 'devesh',
      db: 'devesh',
      roles: [ { role: 'readWrite', db: 'devesh' } ],
      mechanisms: [ 'SCRAM-SHA-1', 'SCRAM-SHA-256' ]
    }
  ],
  ok: 1
}

devesh> show databases;
admin   180.00 KiB
config  108.00 KiB
devesh    8.00 KiB
local    72.00 KiB

devesh> show dbs
admin   180.00 KiB
config  108.00 KiB
devesh    8.00 KiB
local    72.00 KiB

devesh> quit()
*/

-- Step 100 -->> On Node 1 (Stop MongoDB)
mongodb@mongodb-unidev39:~$ sudo systemctl stop mongod

-- Step 101 -->> On Node 1 (Configuration of MongoDB)
mongodb@mongodb-unidev39:~$ sudo vi /etc/mongod.conf
/*
# mongod.conf

# for documentation of all options, see:
#   http://docs.mongodb.org/manual/reference/configuration-options/

# Where and how to store data.
storage:
  dbPath: /data/mongodb
#  engine:
#  wiredTiger:

# where to write logging data.
systemLog:
  destination: file
  logAppend: true
  path: /data/log/mongod.log

# network interfaces
net:
  port: 27017
  bindIp: 127.0.0.1,192.168.56.158
  maxIncomingConnections: 999999


# how the process runs
processManagement:
  timeZoneInfo: /usr/share/zoneinfo

#security:
security.authorization: enabled

#operationProfiling:

#replication:

#sharding:

## Enterprise-Only Options:

#auditLog:
*/

-- Step 102 -->> On Node 1 (Start MongoDB)
mongodb@mongodb-unidev39:~$ sudo systemctl start mongod

-- Step 103 -->> On Node 1 (Verify MongoDB)
mongodb@mongodb-unidev39:~$ sudo systemctl status mongod
/*
● mongod.service - MongoDB Database Server
     Loaded: loaded (/lib/systemd/system/mongod.service; enabled; vendor preset: enabled)
     Active: active (running) since Thu 2024-02-29 05:50:01 UTC; 4s ago
       Docs: https://docs.mongodb.org/manual
   Main PID: 2441 (mongod)
     Memory: 169.3M
        CPU: 2.922s
     CGroup: /system.slice/mongod.service
             └─2441 /usr/bin/mongod --config /etc/mongod.conf

Feb 29 05:50:01 mongodb-unidev39.org.np systemd[1]: Started MongoDB Database Server.
Feb 29 05:50:01 mongodb-unidev39.org.np mongod[2441]: {"t":{"$date":"2024-02-29T05:50:01.350Z"},"s":"I",  "c":"CONTROL",  "id":7484500, "ctx":"main","msg":"Environment variable MONGODB_CON>
*/

-- Step 104 -->> On Node 1 (Begin with MongoDB)
mongodb@mongodb-unidev39:~$ mongosh
/*
Current Mongosh Log ID: 65e01b5b022b9ae8dafea7c2
Connecting to:          mongodb://127.0.0.1:27017/?directConnection=true&serverSelectionTimeoutMS=2000&appName=mongosh+2.1.5
Using MongoDB:          7.0.5
Using Mongosh:          2.1.5

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

test> show dbs
MongoServerError[Unauthorized]: Command listDatabases requires authentication
test> quit()
*/

-- Step 105 -->> On Node 1 (Begin with MongoDB)
mongodb@mongodb-unidev39:~$ mongo
/*
Current Mongosh Log ID: 65e01b7271c01893f83e2b0e
Connecting to:          mongodb://127.0.0.1:27017/?directConnection=true&serverSelectionTimeoutMS=2000&appName=mongosh+2.1.5
Using MongoDB:          7.0.5
Using Mongosh:          2.1.5

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

test> show databases;
MongoServerError[Unauthorized]: Command listDatabases requires authentication
test> exit
*/

-- Step 106 -->> On Node 1 (Begin with MongoDB using Access Details)
mongodb@mongodb-unidev39:~$ mongo --host 127.0.0.1 --port 27017 -u admin -p P#ssw0rD --authenticationDatabase admin
/*
Current Mongosh Log ID: 65e01bc2f1e88d8563195f27
Connecting to:          mongodb://<credentials>@127.0.0.1:27017/?directConnection=true&serverSelectionTimeoutMS=2000&authSource=admin&appName=mongosh+2.1.5
Using MongoDB:          7.0.5
Using Mongosh:          2.1.5

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

test> show dbs
admin   180.00 KiB
config  108.00 KiB
devesh    8.00 KiB
local    72.00 KiB
test> quit()
*/

-- Step 107 -->> On Node 1 (Begin with MongoDB using Access Details)
mongodb@mongodb-unidev39:~$ mongosh --host 192.168.56.158 --port 27017 -u admin -p P#ssw0rD --authenticationDatabase admin
/*
Current Mongosh Log ID: 65e01bdfaa9c1eeb36608373
Connecting to:          mongodb://<credentials>@192.168.56.158:27017/?directConnection=true&authSource=admin&appName=mongosh+2.1.5
Using MongoDB:          7.0.5
Using Mongosh:          2.1.5

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

test> show dbs
admin   180.00 KiB
config  108.00 KiB
devesh    8.00 KiB
local    72.00 KiB

test> use admin
switched to db admin

admin> db.getUsers()
{
  users: [
    {
      _id: 'admin.admin',
      userId: UUID('9ea555c7-3e8b-47ed-aee8-2eabcf9c7ccf'),
      user: 'admin',
      db: 'admin',
      roles: [ { role: 'root', db: 'admin' } ],
      mechanisms: [ 'SCRAM-SHA-1', 'SCRAM-SHA-256' ]
    }
  ],
  ok: 1
}
admin> quit()
*/

-- Step 108 -->> On Node 1 (Begin with MongoDB using Access Details)
mongodb@mongodb-unidev39:~$ mongosh --host 192.168.56.158 --port 27017 -u devesh -p deveshP#ssw0rD --authenticationDatabase devesh
/*
Current Mongosh Log ID: 65e01ce2338cdb0605838d1f
Connecting to:          mongodb://<credentials>@192.168.56.158:27017/?directConnection=true&authSource=devesh&appName=mongosh+2.1.5
Using MongoDB:          7.0.5
Using Mongosh:          2.1.5

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

test> show databases;
devesh  8.00 KiB

test> use devesh
switched to db devesh

devesh> show collections
tbl_devesh

devesh> db.tbl_devesh.insert( { item: "card", qty: 15 } )
DeprecationWarning: Collection.insert() is deprecated. Use insertOne, insertMany, or bulkWrite.
{
  acknowledged: true,
  insertedIds: { '0': ObjectId('65e01d9e338cdb0605838d20') }
}

devesh> db.tbl_devesh.find()
[
  { _id: ObjectId('65e01d9e338cdb0605838d20'), item: 'card', qty: 15 }
]

devesh> quit()
*/

-- Step 109 -->> On Node 1 (Take Full Backup)
mongodb@mongodb-unidev39:~$ mkdir -p /backup/MongoDBFullBackup/DbFullBackUP_29_02_2024/dump

-- Step 110 -->> On Node 1 (Take Full Backup)
mongodb@mongodb-unidev39:~$ mongodump --host 127.0.0.1 --port 27017 -u admin -p P#ssw0rD --authenticationDatabase admin --out /backup/MongoDBFullBackup/DbFullBackUP_29_02_2024/dump/ >> /backup/MongoDBFullBackup/DbFullBackUP_29_02_2024/DbFullBackUP_29_02_2024.log 2>&1

-- Step 111 -->> On Node 1 (Verify Full Backup Log)
mongodb@mongodb-unidev39:~$ cat /backup/MongoDBFullBackup/DbFullBackUP_29_02_2024/DbFullBackUP_29_02_2024.log
/*
2024-02-29T06:08:13.456+0000    writing admin.system.users to /backup/MongoDBFullBackup/DbFullBackUP_29_02_2024/dump/admin/system.users.bson
2024-02-29T06:08:13.457+0000    done dumping admin.system.users (2 documents)
2024-02-29T06:08:13.457+0000    writing admin.system.version to /backup/MongoDBFullBackup/DbFullBackUP_29_02_2024/dump/admin/system.version.bson
2024-02-29T06:08:13.458+0000    done dumping admin.system.version (2 documents)
2024-02-29T06:08:13.458+0000    writing devesh.tbl_devesh to /backup/MongoDBFullBackup/DbFullBackUP_29_02_2024/dump/devesh/tbl_devesh.bson
2024-02-29T06:08:13.459+0000    done dumping devesh.tbl_devesh (1 document)
*/

-- Step 112 -->> On Node 1 (Verify Full Backup DB)
mongodb@mongodb-unidev39:~$ ll /backup/MongoDBFullBackup/DbFullBackUP_29_02_2024/dump/
/*
drwxrwxr-x 4 mongodb mongodb  33 Feb 29 06:08 ./
drwxrwxr-x 3 mongodb mongodb  53 Feb 29 06:08 ../
drwxrwxr-x 2 mongodb mongodb 128 Feb 29 06:08 admin/
drwxrwxr-x 2 mongodb mongodb  61 Feb 29 06:08 devesh/
*/

-- Step 113 -->> On Node 1 (Begin with MOngoDB - Drop Users)
mongodb@mongodb-unidev39:~$ mongosh --host 192.168.56.158 --port 27017 -u admin -p P#ssw0rD --authenticationDatabase admin
/*
Current Mongosh Log ID: 65e01fc7d3dc2933b37f770c
Connecting to:          mongodb://<credentials>@192.168.56.158:27017/?directConnection=true&authSource=admin&appName=mongosh+2.1.5
Using MongoDB:          7.0.5
Using Mongosh:          2.1.5

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

test> show databases;
admin   180.00 KiB
config  108.00 KiB
devesh   40.00 KiB
local    72.00 KiB
test> use devesh
switched to db devesh
devesh>

devesh> db
devesh
devesh>

devesh> db.dropDatabase()
{ ok: 1, dropped: 'devesh' }
devesh> use admin
switched to db admin
admin> show databases;
admin   180.00 KiB
config  108.00 KiB
local    72.00 KiB
admin> quit()
*/

-- Step 114 -->> On Node 1 (Restore Full Backup)
mongodb@mongodb-unidev39:~$ mongorestore --host 192.168.56.158  --port 27017 -u devesh -p deveshP#ssw0rD --authenticationDatabase devesh --db devesh /backup/MongoDBFullBackup/DbFullBackUP_29_02_2024/dump/devesh/
/*
2024-02-29T06:12:23.614+0000    The --db and --collection flags are deprecated for this use-case; please use --nsInclude instead, i.e. with --nsInclude=${DATABASE}.${COLLECTION}
2024-02-29T06:12:23.614+0000    building a list of collections to restore from /backup/MongoDBFullBackup/DbFullBackUP_29_02_2024/dump/devesh dir
2024-02-29T06:12:23.615+0000    reading metadata for devesh.tbl_devesh from /backup/MongoDBFullBackup/DbFullBackUP_29_02_2024/dump/devesh/tbl_devesh.metadata.json
2024-02-29T06:12:23.625+0000    restoring devesh.tbl_devesh from /backup/MongoDBFullBackup/DbFullBackUP_29_02_2024/dump/devesh/tbl_devesh.bson
2024-02-29T06:12:23.647+0000    finished restoring devesh.tbl_devesh (1 document, 0 failures)
2024-02-29T06:12:23.647+0000    no indexes to restore for collection devesh.tbl_devesh
2024-02-29T06:12:23.647+0000    1 document(s) restored successfully. 0 document(s) failed to restore.
*/

-- Step 115 -->> On Node 1 (Begin with MOngoDB - Verify Full Backup Restore)
mongodb@mongodb-unidev39:~$ mongosh --host 192.168.56.158 --port 27017 -u admin -p P#ssw0rD --authenticationDatabase admin
/*
Current Mongosh Log ID: 65e02083ac7599185d3f01ab
Connecting to:          mongodb://<credentials>@192.168.56.158:27017/?directConnection=true&authSource=admin&appName=mongosh+2.1.5
Using MongoDB:          7.0.5
Using Mongosh:          2.1.5

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

test> show dbs
admin   180.00 KiB
config  108.00 KiB
devesh   40.00 KiB
local    72.00 KiB
test> use devesh
switched to db devesh
devesh>

devesh> db
devesh
devesh> show collections
tbl_devesh
devesh> db.tbl_devesh.find()
[
  { _id: ObjectId('65e01d9e338cdb0605838d20'), item: 'card', qty: 15 }
]
devesh> quit()
*/
