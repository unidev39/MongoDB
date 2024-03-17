--To Clenup the Mongo Log
cat /dev/null > mongodb.log

--------------------------------------------------------------------------
----------------------------root/P@ssw0rd---------------------------------
--------------------------------------------------------------------------
-- 1 All Nodes on VM (Server Storage)
root@mongodb:~# df -Th
/*
Filesystem                                                                                   Type   Size  Used Avail Use% Mounted on
tmpfs                                                                                        tmpfs  388M  1.5M  386M   1% /run
/dev/mapper/mongodb-root                                                                     xfs     31G  259M   31G   1% /
/dev/disk/by-id/dm-uuid-LVM-3ptCeLXDFgsxMn412K5qwRMotc1eqWRhYVA9bhAXVnBn98NZplLdnF5JkdxNYsOC xfs    8.0G  2.7G  5.4G  33% /usr
tmpfs                                                                                        tmpfs  1.9G     0  1.9G   0% /dev/shm
tmpfs                                                                                        tmpfs  5.0M     0  5.0M   0% /run/lock
/dev/mapper/mongodb-tmp                                                                      xfs    8.0G   90M  8.0G   2% /tmp
/dev/mapper/mongodb-var                                                                      xfs    8.0G  231M  7.8G   3% /var
/dev/mapper/mongodb-srv                                                                      xfs    8.0G   90M  8.0G   2% /srv
/dev/mapper/mongodb-home                                                                     xfs    8.0G   90M  8.0G   2% /home
/dev/mapper/mongodb-var_lib                                                                  xfs    8.0G  674M  7.4G   9% /var/lib
/dev/sda2                                                                                    xfs    2.0G  196M  1.8G  10% /boot
tmpfs                                                                                        tmpfs  388M  4.0K  388M   1% /run/user/1000
*/

-- 1 All Nodes on VM (Server Kernal version)
root@mongodb:~# uname -msr
/*
Linux 6.5.0-21-generic x86_64
*/

-- 1 All Nodes on VM (Server Release)
root@mongodb:~# cat /etc/lsb-release
/*
DISTRIB_ID=Ubuntu
DISTRIB_RELEASE=22.04
DISTRIB_CODENAME=jammy
DISTRIB_DESCRIPTION="Ubuntu 22.04.4 LTS"
*/

-- 1 All Nodes on VM (Server Release)
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

-- Step 1 -->> On All Nodes
root@mongodb:~# vi /etc/hosts
/*
127.0.0.1 localhost
127.0.1.1 mongodb

# Public
192.168.56.159 mongodb-1-p.unidev39.org.np mongodb-1-p
192.168.56.160 mongodb-1-s.unidev39.org.np mongodb-1-s
192.168.56.161 mongodb-1-a.unidev39.org.np mongodb-1-a
*/

-- Step 2 -->> On Node 1 (Ethernet Configuration)
root@mongodb:~# vi /etc/netplan/00-installer-config.yaml
/*
# This is the network config written by 'subiquity'
network:
  ethernets:
    ens32:
      addresses:
      - 192.168.56.159/24
      nameservers:
        addresses:
        - 8.8.8.8
        search: []
      routes:
      - to: default
        via: 192.168.56.2
  version: 2
*/

-- Step 2.1 -->> On Node 2 (Ethernet Configuration)
root@mongodb:~# vi /etc/netplan/00-installer-config.yaml
/*
# This is the network config written by 'subiquity'
# This is the network config written by 'subiquity'
network:
  ethernets:
    ens32:
      addresses:
      - 192.168.56.160/24
      nameservers:
        addresses:
        - 8.8.8.8
        search: []
      routes:
      - to: default
        via: 192.168.56.2
  version: 2
*/

-- Step 2.2 -->> On Node 3 (Ethernet Configuration)
root@mongodb:~# vi /etc/netplan/00-installer-config.yaml
/*
# This is the network config written by 'subiquity'
network:
  ethernets:
    ens32:
      addresses:
      - 192.168.56.161/24
      nameservers:
        addresses:
        - 8.8.8.8
        search: []
      routes:
      - to: default
        via: 192.168.56.2
  version: 2
*/

-- Step 3 -->> On All Nodes (Restart Network)
root@mongodb:~# systemctl restart network-online.target

-- Step 4 -->> On All Nodes (Set Hostname)
root@mongodb:~# hostnamectl | grep hostname
/*
 Static hostname: mongodb
*/

-- Step 4.1 -->> On All Nodes
root@mongodb:~# hostnamectl --static
/*
mongodb
*/

-- Step 4.2 -->> On All Nodes
root@mongodb:~# hostnamectl
/*
 Static hostname: mongodb
       Icon name: computer-vm
         Chassis: vm
      Machine ID: 331c2034bd21478bbf65b345244f9120
         Boot ID: 7c4d694d2e5544af8a3869f105feb27a
  Virtualization: vmware
Operating System: Ubuntu 22.04.4 LTS
          Kernel: Linux 6.5.0-21-generic
    Architecture: x86-64
 Hardware Vendor: VMware, Inc.
  Hardware Model: VMware Virtual Platform
*/

-- Step 4.3 -->> On Node 1
root@mongodb:~# hostnamectl set-hostname mongodb-1-p.unidev39.org.np

-- Step 4.3.1 -->> On Node 2
root@mongodb:~# hostnamectl set-hostname mongodb-1-s.unidev39.org.np

-- Step 4.3.2 -->> On Node 3
root@mongodb:~# hostnamectl set-hostname mongodb-1-a.unidev39.org.np

-- Step 4.4 -->> On Node 1
root@mongodb:~# hostnamectl
/*
 Static hostname: mongodb-1-p.unidev39.org.np
       Icon name: computer-vm
         Chassis: vm
      Machine ID: 331c2034bd21478bbf65b345244f9120
         Boot ID: 91428965b8094519a3830b6ddafc02b7
  Virtualization: vmware
Operating System: Ubuntu 22.04.4 LTS
          Kernel: Linux 6.5.0-25-generic
    Architecture: x86-64
 Hardware Vendor: VMware, Inc.
  Hardware Model: VMware Virtual Platform
*/

-- Step 4.4.1 -->> On Node 2
root@mongodb:~# hostnamectl
/*
 Static hostname: mongodb-1-s.unidev39.org.np
       Icon name: computer-vm
         Chassis: vm
      Machine ID: e8377dfb4e0b49ff81c792d6f9e2fc1c
         Boot ID: 2a81160b28ac4665bef19a6b95c6c57e
  Virtualization: vmware
Operating System: Ubuntu 22.04.4 LTS
          Kernel: Linux 6.5.0-25-generic
    Architecture: x86-64
 Hardware Vendor: VMware, Inc.
  Hardware Model: VMware Virtual Platform
*/

-- Step 4.4.2 -->> On Node 3
root@mongodb:~# hostnamectl
/*
 Static hostname: mongodb-1-a.unidev39.org.np
       Icon name: computer-vm
         Chassis: vm
      Machine ID: 8a0912f113284909835485d719795dfa
         Boot ID: e52f79be81d244179b207b94a21e06d5
  Virtualization: vmware
Operating System: Ubuntu 22.04.4 LTS
          Kernel: Linux 6.5.0-25-generic
    Architecture: x86-64
*/

-- Step 5 -->> On All Nodes (IPtables Configuration)
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
        inet 192.168.56.159  netmask 255.255.255.0  broadcast 192.168.56.255
        inet6 fe80::20c:29ff:fe2b:ff7f  prefixlen 64  scopeid 0x20<link>
        ether 00:0c:29:2b:ff:7f  txqueuelen 1000  (Ethernet)
        RX packets 66675  bytes 98479254 (98.4 MB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 7928  bytes 592695 (592.6 KB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
        inet 127.0.0.1  netmask 255.0.0.0
        inet6 ::1  prefixlen 128  scopeid 0x10<host>
        loop  txqueuelen 1000  (Local Loopback)
        RX packets 148  bytes 13329 (13.3 KB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 148  bytes 13329 (13.3 KB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
*/

-- Step 5.1.1 -->> On Node 2
root@mongodb:~# ifconfig
/*
ens32: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 192.168.56.160  netmask 255.255.255.0  broadcast 192.168.56.255
        inet6 fe80::20c:29ff:fef1:517d  prefixlen 64  scopeid 0x20<link>
        ether 00:0c:29:f1:51:7d  txqueuelen 1000  (Ethernet)
        RX packets 44044  bytes 64741689 (64.7 MB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 4780  bytes 382929 (382.9 KB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
        inet 127.0.0.1  netmask 255.0.0.0
        inet6 ::1  prefixlen 128  scopeid 0x10<host>
        loop  txqueuelen 1000  (Local Loopback)
        RX packets 136  bytes 11992 (11.9 KB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 136  bytes 11992 (11.9 KB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
*/

-- Step 5.1.2 -->> On Node 3
root@mongodb:~# ifconfig
/*
ens32: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 192.168.56.161  netmask 255.255.255.0  broadcast 192.168.56.255
        inet6 fe80::20c:29ff:fed9:6249  prefixlen 64  scopeid 0x20<link>
        ether 00:0c:29:d9:62:49  txqueuelen 1000  (Ethernet)
        RX packets 1073  bytes 590083 (590.0 KB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 581  bytes 114478 (114.4 KB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
        inet 127.0.0.1  netmask 255.0.0.0
        inet6 ::1  prefixlen 128  scopeid 0x10<host>
        loop  txqueuelen 1000  (Local Loopback)
        RX packets 110  bytes 9121 (9.1 KB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 110  bytes 9121 (9.1 KB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
*/

-- Step 6 -->> On All Nodes (Firew Configuration)
root@mongodb:~# apt install firewalld

-- Step 6.1 -->> On All Nodes
root@mongodb:~# systemctl enable firewalld

-- Step 6.2 -->> On All Nodes
root@mongodb:~# systemctl start firewalld


-- Step 6.3 -->> On All Nodes
root@mongodb:~# systemctl status firewalld
/*
● firewalld.service - firewalld - dynamic firewall daemon
     Loaded: loaded (/lib/systemd/system/firewalld.service; enabled; vendor preset: enabled)
     Active: active (running) since Sun 2024-03-10 05:47:57 UTC; 17min ago
       Docs: man:firewalld(1)
   Main PID: 1004 (firewalld)
      Tasks: 2 (limit: 4491)
     Memory: 27.5M
        CPU: 642ms
     CGroup: /system.slice/firewalld.service
             └─1004 /usr/bin/python3 /usr/sbin/firewalld --nofork --nopid

Mar 10 05:47:56 mongodb1p.unidev39.org.np systemd[1]: Starting firewalld - dynamic firewall daemon...
Mar 10 05:47:57 mongodb1p.unidev39.org.np systemd[1]: Started firewalld - dynamic firewall daemon.
*/

-- Step 6.4 -->> On All Nodes
root@mongodb:~# sudo firewall-cmd --zone=public --add-port=27017/tcp --permanent
root@mongodb:~# sudo firewall-cmd --zone=public --add-port=27017/udp --permanent
root@mongodb:~# sudo firewall-cmd --zone=public --add-port=22/tcp --permanent
root@mongodb:~# sudo firewall-cmd --zone=public --add-port=22/udp --permanent

-- Step 6.5 -->> On All Nodes
root@mongodb:~# firewall-cmd --list-all
/*
public
  target: default
  icmp-block-inversion: no
  interfaces:
  sources:
  services: dhcpv6-client ssh
  ports:
  protocols:
  forward: yes
  masquerade: no
  forward-ports:
  source-ports:
  icmp-blocks:
  rich rules:
*/

-- Step 7 -->> On All Nodes (Server ALL RMP Updates)
root@mongodb:~# sudo apt update && sudo apt upgrade -y

-- Step 8 -->> On All Nodes (Selinux Configuration)
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

-- Step 8.1 -->> On All Nodes
root@mongodb:~# getenforce
/*
Disabled
*/

-- Step 8.2 -->> On All Nodes
root@mongodb:~# sestatus
/*
SELinux status:                 disabled
*/

-- Step 8.3 -->> On All Nodes
root@mongodb:~# init 6

-- Step 8.4 -->> On Node 1
root@mongodb-1-p/mongodb-1-s/mongodb-1-a:~# vi /etc/selinux/config
/*
# This file controls the state of SELinux on the system.
# SELINUX= can take one of these three values:
# enforcing - SELinux security policy is enforced.
# permissive - SELinux prints warnings instead of enforcing.
# disabled - No SELinux policy is loaded.
SELINUX=permissive
# SELINUXTYPE= can take one of these two values:
# default - equivalent to the old strict and targeted policies
# mls     - Multi-Level Security (for military and educational use)
# src     - Custom policy built from source
SELINUXTYPE=default

# SETLOCALDEFS= Check local definition changes
SETLOCALDEFS=0
*/

-- Step 8.5 -->> On Node 1
root@mongodb-1-p/mongodb-1-s/mongodb-1-a:~# getenforce
/*
Permissive
*/

-- Step 8.6 -->> On Node 1
root@mongodb-1-p/mongodb-1-s/mongodb-1-a:~# sestatus
/*
SELinux status:                 enabled
SELinuxfs mount:                /sys/fs/selinux
SELinux root directory:         /etc/selinux
Loaded policy name:             default
Current mode:                   permissive
Mode from config file:          permissive
Policy MLS status:              enabled
Policy deny_unknown status:     allowed
Memory protection checking:     actual (secure)
Max kernel policy version:      33
*/

-- Step 9 -->> On Node 1
root@mongodb-1-p/mongodb-1-s/mongodb-1-a:~# firewall-cmd --list-all
/*
public
  target: default
  icmp-block-inversion: no
  interfaces:
  sources:
  services: dhcpv6-client ssh
  ports: 27017/tcp 27017/udp 22/tcp 22/udp
  protocols:
  forward: yes
  masquerade: no
  forward-ports:
  source-ports:
  icmp-blocks:
  rich rules:
*/

-- Step 10 -->> On Node 1
root@mongodb-1-p:~# hostnamectl
/*
 Static hostname: mongodb-1-p.unidev39.org.np
       Icon name: computer-vm
         Chassis: vm
      Machine ID: 331c2034bd21478bbf65b345244f9120
         Boot ID: 91428965b8094519a3830b6ddafc02b7
  Virtualization: vmware
Operating System: Ubuntu 22.04.4 LTS
          Kernel: Linux 6.5.0-25-generic
    Architecture: x86-64
 Hardware Vendor: VMware, Inc.
  Hardware Model: VMware Virtual Platform
*/

-- Step 10.1 -->> On Node 2
root@mongodb-1-s:~# hostnamectl
/*
 Static hostname: mongodb-1-s.unidev39.org.np
       Icon name: computer-vm
         Chassis: vm
      Machine ID: e8377dfb4e0b49ff81c792d6f9e2fc1c
         Boot ID: 12d4a0d9e0ee4dbb81bfd21aafad4763
  Virtualization: vmware
Operating System: Ubuntu 22.04.4 LTS
          Kernel: Linux 6.5.0-25-generic
    Architecture: x86-64
*/

-- Step 10.2 -->> On Node 3
root@mongodb-1-a:~# hostnamectl
/*
 Static hostname: mongodb-1-a.unidev39.org.np
       Icon name: computer-vm
         Chassis: vm
      Machine ID: 8a0912f113284909835485d719795dfa
         Boot ID: db7ad778da564e53956cc8dd3127f615
  Virtualization: vmware
Operating System: Ubuntu 22.04.4 LTS
          Kernel: Linux 6.5.0-25-generic
    Architecture: x86-64
 Hardware Vendor: VMware, Inc.
  Hardware Model: VMware Virtual Platform
*/

-- Step 11 -->> On All Nodes (Assign role to MongoDB User)
root@mongodb-1-p/mongodb-1-s/mongodb-1-a:~# usermod -aG sudo mongodb

-- Step 11.1 -->> On All Nodes 
root@mongodb-1-p/mongodb-1-s/mongodb-1-a:~# usermod -aG root mongodb

-- Step 11.2 -->> On All Nodes 
root@mongodb-1-p/mongodb-1-s/mongodb-1-a:~# rsync --archive --chown=mongodb:mongodb ~/.ssh /home/mongodb

-- Step 11.3 -->> On Node 1
root@mongodb-1-p:~# ssh mongodb@192.168.56.159
/*
The authenticity of host '192.168.56.159 (192.168.56.159)' can't be established.
ED25519 key fingerprint is SHA256:3u7oUtW/ojpLMv9cvaoT9LjFMXTc8rTYgRSY0LbnD9M.
This key is not known by any other names
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added '192.168.56.159' (ED25519) to the list of known hosts.
mongodb@192.168.56.159's password:
Welcome to Ubuntu 22.04.4 LTS (GNU/Linux 6.5.0-25-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/pro

  System information as of Sun Mar 10 06:42:43 AM UTC 2024

  System load:    0.0              Processes:              288
  Usage of /home: 1.1% of 7.99GB   Users logged in:        1
  Memory usage:   11%              IPv4 address for ens32: 192.168.56.159
  Swap usage:     0%


Expanded Security Maintenance for Applications is not enabled.

0 updates can be applied immediately.

Enable ESM Apps to receive additional future security updates.
See https://ubuntu.com/esm or run: sudo pro status


Last login: Sun Mar 10 06:26:04 2024 from 192.168.56.1
*/

-- Step 11.3.1 -->> On Node 2
root@mongodb-1-s:~# ssh mongodb@192.168.56.160
/*
The authenticity of host '192.168.56.160 (192.168.56.160)' can't be established.
ED25519 key fingerprint is SHA256:3tGmlNux80t5hktdbDNbiazkT3KSeUMIrWHs3Xv7T/c.
This key is not known by any other names
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added '192.168.56.160' (ED25519) to the list of known hosts.
mongodb@192.168.56.160's password:
Welcome to Ubuntu 22.04.4 LTS (GNU/Linux 6.5.0-25-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/pro

  System information as of Sun Mar 10 06:44:05 AM UTC 2024

  System load:    0.1083984375     Processes:              284
  Usage of /home: 1.1% of 7.99GB   Users logged in:        1
  Memory usage:   11%              IPv4 address for ens32: 192.168.56.160
  Swap usage:     0%


Expanded Security Maintenance for Applications is not enabled.

0 updates can be applied immediately.

Enable ESM Apps to receive additional future security updates.
See https://ubuntu.com/esm or run: sudo pro status


Last login: Sun Mar 10 06:37:02 2024 from 192.168.56.1
mongodb@mongodb-1-s:~$ exit
logout
Connection to 192.168.56.160 closed.
*/

-- Step 11.3.2 -->> On Node 3
root@mongodb-1-a:~# ssh mongodb@192.168.56.161
/*
The authenticity of host '192.168.56.161 (192.168.56.161)' can't be established.
ED25519 key fingerprint is SHA256:f1Mvb7yw4WPMgOaudGwbDrXVMXAUhgqnSfI51nt6vRQ.
This key is not known by any other names
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added '192.168.56.161' (ED25519) to the list of known hosts.
mongodb@192.168.56.161's password:
Welcome to Ubuntu 22.04.4 LTS (GNU/Linux 6.5.0-25-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/pro

  System information as of Sun Mar 10 06:44:52 AM UTC 2024

  System load:    0.02783203125    Processes:              286
  Usage of /home: 1.1% of 7.99GB   Users logged in:        1
  Memory usage:   11%              IPv4 address for ens32: 192.168.56.161
  Swap usage:     0%


Expanded Security Maintenance for Applications is not enabled.

0 updates can be applied immediately.

Enable ESM Apps to receive additional future security updates.
See https://ubuntu.com/esm or run: sudo pro status


Last login: Sun Mar 10 06:37:19 2024 from 192.168.56.1
*/

-- Step 11.4 -->> On All Nodes
mongodb@mongodb-1-p/mongodb-1-s/mongodb-1-a:~$ exit

-- Step 12 -->> On All Nodes (LVM Partition Configuration - Before Status)
root@mongodb-1-p/mongodb-1-s/mongodb-1-a:~# df -Th
/*
Filesystem                                                                                   Type   Size  Used Avail Use% Mounted on
tmpfs                                                                                        tmpfs  388M  1.5M  386M   1% /run
/dev/mapper/mongodb-root                                                                     xfs     31G  259M   31G   1% /
/dev/disk/by-id/dm-uuid-LVM-3ptCeLXDFgsxMn412K5qwRMotc1eqWRhYVA9bhAXVnBn98NZplLdnF5JkdxNYsOC xfs    8.0G  2.7G  5.4G  33% /usr
tmpfs                                                                                        tmpfs  1.9G     0  1.9G   0% /dev/shm
tmpfs                                                                                        tmpfs  5.0M     0  5.0M   0% /run/lock
/dev/mapper/mongodb-tmp                                                                      xfs    8.0G   90M  8.0G   2% /tmp
/dev/mapper/mongodb-var                                                                      xfs    8.0G  231M  7.8G   3% /var
/dev/mapper/mongodb-srv                                                                      xfs    8.0G   90M  8.0G   2% /srv
/dev/mapper/mongodb-home                                                                     xfs    8.0G   90M  8.0G   2% /home
/dev/mapper/mongodb-var_lib                                                                  xfs    8.0G  674M  7.4G   9% /var/lib
/dev/sda2                                                                                    xfs    2.0G  196M  1.8G  10% /boot
tmpfs                                                                                        tmpfs  388M  4.0K  388M   1% /run/user/1000
*/

-- Step 13 -->> On Node 1 (LVM Partition Configuration - Before Status)
root@mongodb-1-p/mongodb-1-s/mongodb-1-a:~# lsblk
/*
NAME                    MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
loop0                     7:0    0 63.9M  1 loop /snap/core20/2105
loop1                     7:1    0   87M  1 loop /snap/lxd/27037
loop2                     7:2    0 40.4M  1 loop /snap/snapd/20671
sda                       8:0    0   90G  0 disk
├─sda1                    8:1    0    1M  0 part
├─sda2                    8:2    0    2G  0 part /boot
└─sda3                    8:3    0   88G  0 part
  ├─mongodb-root          252:0    0   31G  0 lvm  /
  ├─mongodb-home          252:1    0    8G  0 lvm  /home
  ├─mongodb-srv           252:2    0    8G  0 lvm  /srv
  ├─mongodb-usr           252:3    0    8G  0 lvm  /usr
  ├─mongodb-var           252:4    0    8G  0 lvm  /var
  ├─mongodb-var_lib       252:5    0    8G  0 lvm  /var/lib
  ├─mongodb-tmp           252:6    0    8G  0 lvm  /tmp
  └─mongodb-swap          252:7    0    8G  0 lvm  [SWAP]
sdb                       8:16   0   10G  0 disk
sdc                       8:32   0   10G  0 disk
sr0                      11:0    1    2G  0 rom
*/

-- Step 14 -->> On Node 1 (LVM Partition Configuration - Before Status)
root@mongodb-1-p/mongodb-1-s/mongodb-1-a:~# fdisk -ll | grep sd
/*
/dev/sda1     2048      4095      2048   1M BIOS boot
/dev/sda2     4096   4198399   4194304   2G Linux filesystem
/dev/sda3  4198400 188741631 184543232  88G Linux filesystem
Disk /dev/sdb: 10 GiB, 10737418240 bytes, 20971520 sectors
Disk /dev/sdc: 10 GiB, 10737418240 bytes, 20971520 sectors
*/

-- Step 15 -->> On All Nodes (LVM Partition Configuration - t with 8e to change LVM Partition)
root@mongodb-1-p/mongodb-1-s/mongodb-1-a:~# fdisk /dev/sdb
/*

Welcome to fdisk (util-linux 2.37.2).
Changes will remain in memory only, until you decide to write them.
Be careful before using the write command.

Device does not contain a recognized partition table.
Created a new DOS disklabel with disk identifier 0x8ac75535.

Command (m for help): p
Disk /dev/sdb: 10 GiB, 10737418240 bytes, 20971520 sectors
Disk model: VMware Virtual S
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: dos
Disk identifier: 0x8ac75535

Command (m for help): n
Partition type
   p   primary (0 primary, 0 extended, 4 free)
   e   extended (container for logical partitions)
Select (default p): p
Partition number (1-4, default 1): 1
First sector (2048-20971519, default 2048):
Last sector, +/-sectors or +/-size{K,M,G,T,P} (2048-20971519, default 20971519):

Created a new partition 1 of type 'Linux' and of size 10 GiB.

Command (m for help): p
Disk /dev/sdb: 10 GiB, 10737418240 bytes, 20971520 sectors
Disk model: VMware Virtual S
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: dos
Disk identifier: 0x8ac75535

Device     Boot Start      End  Sectors Size Id Type
/dev/sdb1        2048 20971519 20969472  10G 83 Linux

Command (m for help): t
Selected partition 1
Hex code or alias (type L to list all): 8e
Changed type of partition 'Linux' to 'Linux LVM'.

Command (m for help): p
Disk /dev/sdb: 10 GiB, 10737418240 bytes, 20971520 sectors
Disk model: VMware Virtual S
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: dos
Disk identifier: 0x8ac75535

Device     Boot Start      End  Sectors Size Id Type
/dev/sdb1        2048 20971519 20969472  10G 8e Linux LVM

Command (m for help): w
The partition table has been altered.
Calling ioctl() to re-read partition table.
Syncing disks.
*/

-- Step 16 -->> On All Nodes (LVM Partition Configuration - t with 8e to change LVM Partition)
root@mongodb-1-p/mongodb-1-s/mongodb-1-a:~# fdisk /dev/sdc
/*
Welcome to fdisk (util-linux 2.37.2).
Changes will remain in memory only, until you decide to write them.
Be careful before using the write command.

Device does not contain a recognized partition table.
Created a new DOS disklabel with disk identifier 0x1fd490e3.

Command (m for help): p
Disk /dev/sdc: 10 GiB, 10737418240 bytes, 20971520 sectors
Disk model: VMware Virtual S
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: dos
Disk identifier: 0x1fd490e3

Command (m for help): n
Partition type
   p   primary (0 primary, 0 extended, 4 free)
   e   extended (container for logical partitions)
Select (default p): p
Partition number (1-4, default 1): 1
First sector (2048-20971519, default 2048):
Last sector, +/-sectors or +/-size{K,M,G,T,P} (2048-20971519, default 20971519):

Created a new partition 1 of type 'Linux' and of size 10 GiB.

Command (m for help): p
Disk /dev/sdc: 10 GiB, 10737418240 bytes, 20971520 sectors
Disk model: VMware Virtual S
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: dos
Disk identifier: 0x1fd490e3

Device     Boot Start      End  Sectors Size Id Type
/dev/sdc1        2048 20971519 20969472  10G 83 Linux

Command (m for help): t
Selected partition 1
Hex code or alias (type L to list all): 8e
Changed type of partition 'Linux' to 'Linux LVM'.

Command (m for help): p
Disk /dev/sdc: 10 GiB, 10737418240 bytes, 20971520 sectors
Disk model: VMware Virtual S
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: dos
Disk identifier: 0x1fd490e3

Device     Boot Start      End  Sectors Size Id Type
/dev/sdc1        2048 20971519 20969472  10G 8e Linux LVM

Command (m for help): w
The partition table has been altered.
Calling ioctl() to re-read partition table.
Syncing disks.
*/

-- Step 17 -->> On All Nodes (LVM Partition Configuration - After Status)
root@mongodb-1-p/mongodb-1-s/mongodb-1-a:~# fdisk -ll | grep sd
/*
Disk /dev/sda: 90 GiB, 96636764160 bytes, 188743680 sectors
/dev/sda1     2048      4095      2048   1M BIOS boot
/dev/sda2     4096   4198399   4194304   2G Linux filesystem
/dev/sda3  4198400 188741631 184543232  88G Linux filesystem
Disk /dev/sdb: 10 GiB, 10737418240 bytes, 20971520 sectors
/dev/sdb1        2048 20971519 20969472  10G 8e Linux LVM
Disk /dev/sdc: 10 GiB, 10737418240 bytes, 20971520 sectors
/dev/sdc1        2048 20971519 20969472  10G 8e Linux LVM
*/

-- Step 18 -->> On All Nodes (LVM Partition Configuration - Make it Avilable)
root@mongodb-1-p/mongodb-1-s/mongodb-1-a:~# partprobe /dev/sdb

-- Step 19 -->> On All Nodes (LVM Partition Configuration - Make it Avilable)
root@mongodb-1-p/mongodb-1-s/mongodb-1-a:~# partprobe /dev/sdc

-- Step 20 -->> On All Nodes (LVM Partition Configuration - After Status)
root@mongodb-1-p/mongodb-1-s/mongodb-1-a:~# lsblk
/*
NAME                    MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
loop0                     7:0    0 63.9M  1 loop /snap/core20/2105
loop1                     7:1    0   87M  1 loop /snap/lxd/27037
loop2                     7:2    0 40.4M  1 loop /snap/snapd/20671
sda                       8:0    0   90G  0 disk
├─sda1                    8:1    0    1M  0 part
├─sda2                    8:2    0    2G  0 part /boot
└─sda3                    8:3    0   88G  0 part
  ├─mongodb-root          252:0    0   31G  0 lvm  /
  ├─mongodb-home          252:1    0    8G  0 lvm  /home
  ├─mongodb-srv           252:2    0    8G  0 lvm  /srv
  ├─mongodb-usr           252:3    0    8G  0 lvm  /usr
  ├─mongodb-var           252:4    0    8G  0 lvm  /var
  ├─mongodb-var_lib       252:5    0    8G  0 lvm  /var/lib
  ├─mongodb-tmp           252:6    0    8G  0 lvm  /tmp
  └─mongodb-swap          252:7    0    8G  0 lvm  [SWAP]
sdb                       8:16   0   10G  0 disk
└─sdb1                    8:17   0   10G  0 part
sdc                       8:32   0   10G  0 disk
└─sdc1                    8:33   0   10G  0 part
sr0                      11:0    1    2G  0 rom
*/

-- Step 21 -->> On All Nodes (LVM Partition Configuration - Befor Status of pvs)
root@mongodb-1-p/mongodb-1-s/mongodb-1-a:~# pvs
/*
  PV         VG       Fmt  Attr PSize   PFree
  /dev/sda3  mongodb  lvm2 a--  <88.00g 1020.00m
*/

-- Step 22 -->> On All Nodes (LVM Partition Configuration - Befor Status of vgs)
root@mongodb-1-p/mongodb-1-s/mongodb-1-a:~# vgs
/*
  VG       #PV #LV #SN Attr   VSize   VFree
  mongodb  1   8   0 wz--n- <88.00g 1020.00m
*/

-- Step 23 -->> On All Nodes (LVM Partition Configuration - Befor Status of lvs)
root@mongodb-1-p/mongodb-1-s/mongodb-1-a:~# lvs
/*
  LV      VG      Attr       LSize  Pool Origin Data%  Meta%  Move Log Cpy%Sync Convert
  home    mongodb -wi-ao----  8.00g
  root    mongodb -wi-ao---- 31.00g
  srv     mongodb -wi-ao----  8.00g
  swap    mongodb -wi-ao----  8.00g
  tmp     mongodb -wi-ao----  8.00g
  usr     mongodb -wi-ao----  8.00g
  var     mongodb -wi-ao----  8.00g
  var_lib mongodb -wi-ao----  8.00g
*/

-- Step 24 -->> On All Nodes (LVM Partition Configuration - After Status)
root@mongodb-1-p/mongodb-1-s/mongodb-1-a:~# fdisk -ll | grep sd
/*
Disk /dev/sda: 90 GiB, 96636764160 bytes, 188743680 sectors
/dev/sda1     2048      4095      2048   1M BIOS boot
/dev/sda2     4096   4198399   4194304   2G Linux filesystem
/dev/sda3  4198400 188741631 184543232  88G Linux filesystem
Disk /dev/sdb: 10 GiB, 10737418240 bytes, 20971520 sectors
/dev/sdb1        2048 20971519 20969472  10G 8e Linux LVM
Disk /dev/sdc: 10 GiB, 10737418240 bytes, 20971520 sectors
/dev/sdc1        2048 20971519 20969472  10G 8e Linux LVM
*/

-- Step 25 -->> On All Nodes (LVM Partition Configuration - Create pvs)
root@mongodb-1-p/mongodb-1-s/mongodb-1-a:~# pvcreate /dev/sdb1
/*
  Physical volume "/dev/sdb1" successfully created.
*/

-- Step 26 -->> On All Nodes (LVM Partition Configuration - Create pvs)
root@mongodb-1-p/mongodb-1-s/mongodb-1-a:~# pvcreate /dev/sdc1
/*
  Physical volume "/dev/sdc1" successfully created.
*/

-- Step 27 -->> On All Nodes (LVM Partition Configuration - Verify pvs)
root@mongodb-1-p/mongodb-1-s/mongodb-1-a:~# pvs
/*
  PV         VG          Fmt  Attr PSize    PFree
  /dev/sda3  mongodb_1_p lvm2 a--  <88.00g 1020.00m
  /dev/sdb1              lvm2 ---  <10.00g  <10.00g
  /dev/sdc1              lvm2 ---  <10.00g  <10.00g
*/

-- Step 28 -->> On All Nodes (LVM Partition Configuration - Verify pvs)
root@mongodb-1-p/mongodb-1-s/mongodb-1-a:~# pvdisplay /dev/sdb1
/*
  "/dev/sdb1" is a new physical volume of "<10.00 GiB"
  --- NEW Physical volume ---
  PV Name               /dev/sdb1
  VG Name
  PV Size               <10.00 GiB
  Allocatable           NO
  PE Size               0
  Total PE              0
  Free PE               0
  Allocated PE          0
  Node-1-> PV UUID               uzIAQQ-qISP-o0jT-mLhN-rbV2-5G6I-RRrpvg
  Node-2-> PV UUID               qtONTo-Sqn1-918r-MkLG-AERw-lYJw-tAmRgr
  Node-3-> PV UUID               3Ro5Jg-EuLT-INXp-ZSLc-UwX9-ThRc-LETKcc
*/

-- Step 29 -->> On All Nodes (LVM Partition Configuration - Verify pvs)
root@mongodb-1-p/mongodb-1-s/mongodb-1-a:~# pvdisplay /dev/sdc1
/*
  "/dev/sdc1" is a new physical volume of "<10.00 GiB"
  --- NEW Physical volume ---
  PV Name               /dev/sdc1
  VG Name
  PV Size               <10.00 GiB
  Allocatable           NO
  PE Size               0
  Total PE              0
  Free PE               0
  Allocated PE          0
  Node-1-> PV UUID               AszBlT-87SP-Eo3j-Np8N-mBE3-aZYY-LJeqU3
  Node-2-> PV UUID               fBTEBU-1jiZ-WaC8-WNT7-111m-cF27-m6ifuO
  Node-3-> PV UUID               I6wkUa-RxYy-0L8X-qRdd-pMtT-i8ZG-q18i4r
*/

-- Step 30 -->> On All Nodes (LVM Partition Configuration - Create vgs)
root@mongodb-1-p/mongodb-1-s/mongodb-1-a:~# vgcreate data_vg /dev/sdb1
/*
  Volume group "data_vg" successfully created
*/

-- Step 31 -->> On All Nodes (LVM Partition Configuration - Create vgs)
root@mongodb-1-p/mongodb-1-s/mongodb-1-a:~# vgcreate backup_vg /dev/sdc1
/*
  Volume group "backup_vg" successfully created
*/

-- Step 31.1 -->> On All Nodes (LVM Partition Configuration - Create vgs)
root@mongodb-1-p/mongodb-1-s/mongodb-1-a:~# vgs
/*
  VG        #PV #LV #SN Attr   VSize   VFree
  backup_vg   1   0   0 wz--n- <10.00g  <10.00g
  data_vg     1   0   0 wz--n- <10.00g  <10.00g
  mongodb     1   8   0 wz--n- <88.00g 1020.00m
*/

-- Step 32 -->> On All Nodes (LVM Partition Configuration - Verify vgs)
root@mongodb-1-p/mongodb-1-s/mongodb-1-a:~# vgdisplay data_vg
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
  VG Size               <10.00 GiB
  PE Size               4.00 MiB
  Total PE              2559
  Alloc PE / Size       0 / 0
  Free  PE / Size       2559 / <10.00 GiB
  Node-1-> VG UUID               tS91q4-2eNO-EzX2-Jcmf-FD6p-sCwb-uKtFTC
  Node-2-> VG UUID               Kp2bGL-jkmE-GeyR-JiWQ-cIhl-NQGh-pXJCyf
  Node-3-> VG UUID               diqPfe-mixe-x5mW-HjVH-nLep-wQIf-Ibylza
*/

-- Step 33 -->> On All Nodes (LVM Partition Configuration - Verify vgs)
root@mongodb-1-p/mongodb-1-s/mongodb-1-a:~# vgdisplay backup_vg
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
  VG Size               <10.00 GiB
  PE Size               4.00 MiB
  Total PE              2559
  Alloc PE / Size       0 / 0
  Free  PE / Size       2559 / <10.00 GiB
  Node-1-> VG UUID               b8z080-iJ5p-L31z-Nui2-5pB0-AeVI-nQEEfW
  Node-2-> VG UUID               MuisVA-WtKV-jJxW-nj49-LhZs-IWH4-GKr1VE
  Node-3-> VG UUID               aPI4cT-a3mt-UJ3K-OCb0-dyic-cm9y-MKk7Lu
*/

-- Step 34 -->> On All Nodes (LVM Partition Configuration - Less Than VG Size)
root@mongodb-1-p/mongodb-1-s/mongodb-1-a:~# lvcreate -n data_lv -L 9.9GB data_vg
/*
  Rounding up size to full physical extent 9.90 GiB
  Logical volume "data_lv" created.
*/

-- Step 35 -->> On All Nodes (LVM Partition Configuration - Less Than VG Size)
root@mongodb-1-p/mongodb-1-s/mongodb-1-a:~# lvcreate -n backup_lv -L 9.9GB backup_vg
/*
  Rounding up size to full physical extent 9.90 GiB
  Logical volume "backup_lv" created.
*/

-- Step 36 -->> On All Nodes (LVM Partition Configuration - Verify)
root@mongodb-1-p/mongodb-1-s/mongodb-1-a:~# lvs
/*
  LV        VG        Attr       LSize  Pool Origin Data%  Meta%  Move Log Cpy%Sync Convert
  backup_lv backup_vg -wi-a-----  9.90g
  data_lv   data_vg   -wi-a-----  9.90g
  home      mongodb   -wi-ao----  8.00g
  root      mongodb   -wi-ao---- 31.00g
  srv       mongodb   -wi-ao----  8.00g
  swap      mongodb   -wi-ao----  8.00g
  tmp       mongodb   -wi-ao----  8.00g
  usr       mongodb   -wi-ao----  8.00g
  var       mongodb   -wi-ao----  8.00g
  var_lib   mongodb   -wi-ao----  8.00g
*/

-- Step 37 -->> On All Nodes (LVM Partition Configuration - Verify)
root@mongodb-1-p/mongodb-1-s/mongodb-1-a:~# fdisk -ll | grep lv
/*
Disk /dev/mapper/data_vg-data_lv: 9.9 GiB, 10632560640 bytes, 20766720 sectors
Disk /dev/mapper/backup_vg-backup_lv: 9.9 GiB, 10632560640 bytes, 20766720 sectors
*/

-- Step 38 -->> On Node 1 (LVM Partition Configuration - Verify)
root@mongodb-1-p:~# lvdisplay /dev/mapper/data_vg-data_lv
/*
  --- Logical volume ---
  LV Path                /dev/data_vg/data_lv
  LV Name                data_lv
  VG Name                data_vg
  LV UUID                qvSZeV-akwH-CovM-b9gm-5zyO-NT2Y-sTsatG
  LV Write Access        read/write
  LV Creation host, time mongodb-1-p.unidev39.org.np, 2024-03-10 08:07:12 +0000
  LV Status              available
  # open                 0
  LV Size                9.90 GiB
  Current LE             2535
  Segments               1
  Allocation             inherit
  Read ahead sectors     auto
  - currently set to     256
  Block device           252:8
*/

-- Step 38.1 -->> On Node 2 (LVM Partition Configuration - Verify)
root@mongodb-1-s:~# lvdisplay /dev/mapper/data_vg-data_lv
/*
  --- Logical volume ---
  LV Path                /dev/data_vg/data_lv
  LV Name                data_lv
  VG Name                data_vg
  LV UUID                a27Z0U-w8Wt-jN8c-isVx-g24p-sLhI-QyaV6R
  LV Write Access        read/write
  LV Creation host, time mongodb-1-s.unidev39.org.np, 2024-03-10 08:07:14 +0000
  LV Status              available
  # open                 0
  LV Size                9.90 GiB
  Current LE             2535
  Segments               1
  Allocation             inherit
  Read ahead sectors     auto
  - currently set to     256
  Block device           252:8
*/

-- Step 38.2 -->> On Node 3 (LVM Partition Configuration - Verify)
root@mongodb-1-a:~# lvdisplay /dev/mapper/data_vg-data_lv
/*
  --- Logical volume ---
  LV Path                /dev/data_vg/data_lv
  LV Name                data_lv
  VG Name                data_vg
  LV UUID                pzZSX3-MQHW-AUEP-Bnfk-D05D-uypT-qiZlN8
  LV Write Access        read/write
  LV Creation host, time mongodb-1-a.unidev39.org.np, 2024-03-10 08:07:15 +0000
  LV Status              available
  # open                 0
  LV Size                9.90 GiB
  Current LE             2535
  Segments               1
  Allocation             inherit
  Read ahead sectors     auto
  - currently set to     256
  Block device           252:8
*/

-- Step 39 -->> On Node 1 (LVM Partition Configuration - Verify)
root@mongodb-1-p:~# lvdisplay /dev/mapper/backup_vg-backup_lv
/*
  --- Logical volume ---
  LV Path                /dev/backup_vg/backup_lv
  LV Name                backup_lv
  VG Name                backup_vg
  LV UUID                pd7vfQ-wQWx-EGA2-41O3-A1LJ-pUqo-2jeOzq
  LV Write Access        read/write
  LV Creation host, time mongodb-1-p.unidev39.org.np, 2024-03-10 08:07:33 +0000
  LV Status              available
  # open                 0
  LV Size                9.90 GiB
  Current LE             2535
  Segments               1
  Allocation             inherit
  Read ahead sectors     auto
  - currently set to     256
  Block device           252:9
*/

-- Step 39.1 -->> On Node 1 (LVM Partition Configuration - Verify)
root@mongodb-1-s:~# lvdisplay /dev/mapper/backup_vg-backup_lv
/*
  --- Logical volume ---
  LV Path                /dev/backup_vg/backup_lv
  LV Name                backup_lv
  VG Name                backup_vg
  LV UUID                cEjyw0-evbu-3NKd-yJgO-0vNf-EucL-DcgB33
  LV Write Access        read/write
  LV Creation host, time mongodb-1-s.unidev39.org.np, 2024-03-10 08:07:34 +0000
  LV Status              available
  # open                 0
  LV Size                9.90 GiB
  Current LE             2535
  Segments               1
  Allocation             inherit
  Read ahead sectors     auto
  - currently set to     256
  Block device           252:9
*/

-- Step 39.2 -->> On Node 1 (LVM Partition Configuration - Verify)
root@mongodb-1-a:~# lvdisplay /dev/mapper/backup_vg-backup_lv
/*
  --- Logical volume ---
  LV Path                /dev/backup_vg/backup_lv
  LV Name                backup_lv
  VG Name                backup_vg
  LV UUID                6IZlHL-axJC-s7hC-SceA-vGdZ-AlPG-hZA6yM
  LV Write Access        read/write
  LV Creation host, time mongodb-1-a.unidev39.org.np, 2024-03-10 08:07:35 +0000
  LV Status              available
  # open                 0
  LV Size                9.90 GiB
  Current LE             2535
  Segments               1
  Allocation             inherit
  Read ahead sectors     auto
  - currently set to     256
  Block device           252:9
*/

-- Step 40 -->> On All Nodes (LVM Partition Configuration - Format LVM Partition)
root@mongodb-1-p/mongodb-1-s/mongodb-1-a:~# mkfs.xfs /dev/mapper/data_vg-data_lv
/*
meta-data=/dev/mapper/data_vg-data_lv isize=512    agcount=4, agsize=648960 blks
         =                       sectsz=512   attr=2, projid32bit=1
         =                       crc=1        finobt=1, sparse=1, rmapbt=0
         =                       reflink=1    bigtime=0 inobtcount=0
data     =                       bsize=4096   blocks=2595840, imaxpct=25
         =                       sunit=0      swidth=0 blks
naming   =version 2              bsize=4096   ascii-ci=0, ftype=1
log      =internal log           bsize=4096   blocks=2560, version=2
         =                       sectsz=512   sunit=0 blks, lazy-count=1
realtime =none                   extsz=4096   blocks=0, rtextents=0
*/

-- Step 41 -->> On All Nodes (LVM Partition Configuration - Format LVM Partition)
root@mongodb-1-p/mongodb-1-s/mongodb-1-a:~# mkfs.xfs /dev/mapper/backup_vg-backup_lv
/*
meta-data=/dev/mapper/backup_vg-backup_lv isize=512    agcount=4, agsize=648960 blks
         =                       sectsz=512   attr=2, projid32bit=1
         =                       crc=1        finobt=1, sparse=1, rmapbt=0
         =                       reflink=1    bigtime=0 inobtcount=0
data     =                       bsize=4096   blocks=2595840, imaxpct=25
         =                       sunit=0      swidth=0 blks
naming   =version 2              bsize=4096   ascii-ci=0, ftype=1
log      =internal log           bsize=4096   blocks=2560, version=2
         =                       sectsz=512   sunit=0 blks, lazy-count=1
realtime =none                   extsz=4096   blocks=0, rtextents=0
*/

-- Step 42 -->> On All Nodes (LVM Partition Configuration - Verify)
root@mongodb-1-p/mongodb-1-s/mongodb-1-a:~# lsblk
/*
NAME                    MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
loop0                     7:0    0 63.9M  1 loop /snap/core20/2105
loop1                     7:1    0   87M  1 loop /snap/lxd/27037
loop2                     7:2    0 40.4M  1 loop /snap/snapd/20671
sda                       8:0    0   90G  0 disk
├─sda1                    8:1    0    1M  0 part
├─sda2                    8:2    0    2G  0 part /boot
└─sda3                    8:3    0   88G  0 part
  ├─mongodb-root        252:0    0   31G  0 lvm  /
  ├─mongodb-home        252:1    0    8G  0 lvm  /home
  ├─mongodb-srv         252:2    0    8G  0 lvm  /srv
  ├─mongodb-usr         252:3    0    8G  0 lvm  /usr
  ├─mongodb-var         252:4    0    8G  0 lvm  /var
  ├─mongodb-var_lib     252:5    0    8G  0 lvm  /var/lib
  ├─mongodb-tmp         252:6    0    8G  0 lvm  /tmp
  └─mongodb-swap        252:7    0    8G  0 lvm  [SWAP]
sdb                       8:16   0   10G  0 disk
└─sdb1                    8:17   0   10G  0 part
  └─data_vg-data_lv     252:8    0  9.9G  0 lvm
sdc                       8:32   0   10G  0 disk
└─sdc1                    8:33   0   10G  0 part
  └─backup_vg-backup_lv 252:9    0  9.9G  0 lvm
sr0                      11:0    1    2G  0 rom
*/

-- Step 43 -->> On Node 1 (LVM Partition Configuration - Verify)
root@mongodb-1-p:~# blkid
/*
/dev/mapper/mongodb-home: UUID="4b9c2b5e-799f-4368-b7c1-d5c81daee418" BLOCK_SIZE="512" TYPE="xfs"
/dev/mapper/mongodb-tmp: UUID="cb85fe59-bfdf-4961-85b5-949160c4b242" BLOCK_SIZE="512" TYPE="xfs"
/dev/mapper/mongodb-var: UUID="8d48ce8c-56b5-4b17-970b-62000ee5ddd1" BLOCK_SIZE="512" TYPE="xfs"
/dev/sr0: BLOCK_SIZE="2048" UUID="2024-02-16-23-52-30-00" LABEL="Ubuntu-Server 22.04.4 LTS amd64" TYPE="iso9660" PTTYPE="PMBR"
/dev/mapper/mongodb-srv: UUID="af00ff68-fe95-4460-abd2-ecd207705500" BLOCK_SIZE="512" TYPE="xfs"
/dev/mapper/mongodb-root: UUID="45a3cf65-bfcc-40dd-99cd-4338bfcb2750" BLOCK_SIZE="512" TYPE="xfs"
/dev/mapper/mongodb-swap: UUID="2951c1d8-02f5-4f90-9641-17a862e45985" TYPE="swap"
/dev/sda2: UUID="682b2783-b60a-48d5-bbf8-9763182930fa" BLOCK_SIZE="512" TYPE="xfs" PARTUUID="9cfff297-8843-406e-bbf6-533850c16f79"
/dev/sda3: UUID="QBsdNh-LU9X-8Q9i-BsJA-Rl09-sqFD-LalfP5" TYPE="LVM2_member" PARTUUID="b690948e-387a-47d5-8e86-5f3641f5f1d5"
/dev/mapper/mongodb-var_lib: UUID="5bf89ca3-6712-43f2-bb83-8d15dfc0fdb0" BLOCK_SIZE="512" TYPE="xfs"
/dev/mapper/mongodb-usr: UUID="819321d4-26dc-48d7-a4b5-c728c127c9ae" BLOCK_SIZE="512" TYPE="xfs"
/dev/loop1: TYPE="squashfs"
/dev/mapper/data_vg-data_lv: UUID="f207b96f-597b-4391-9c05-307bd9102c9a" BLOCK_SIZE="512" TYPE="xfs"
/dev/sdb1: UUID="uzIAQQ-qISP-o0jT-mLhN-rbV2-5G6I-RRrpvg" TYPE="LVM2_member" PARTUUID="8ac75535-01"
/dev/loop2: TYPE="squashfs"
/dev/loop0: TYPE="squashfs"
/dev/mapper/backup_vg-backup_lv: UUID="42bfdeba-34e8-41e0-a6b1-113add0250cd" BLOCK_SIZE="512" TYPE="xfs"
/dev/sdc1: UUID="AszBlT-87SP-Eo3j-Np8N-mBE3-aZYY-LJeqU3" TYPE="LVM2_member" PARTUUID="1fd490e3-01"
/dev/sda1: PARTUUID="501f7fb7-ae44-4942-a999-33e09df25c39"
*/

-- Step 43.1 -->> On Node 2 (LVM Partition Configuration - Verify)
root@mongodb-1-s:~# blkid
/*
/dev/mapper/mongodb-home: UUID="25c44641-902f-4b5e-b0fb-7f00c27c91a4" BLOCK_SIZE="512" TYPE="xfs"
/dev/mapper/mongodb-tmp: UUID="2b9c0ca3-aa25-475c-8c52-b84df177bf3f" BLOCK_SIZE="512" TYPE="xfs"
/dev/mapper/mongodb-var: UUID="234a8821-aee5-4768-b700-04443df962c7" BLOCK_SIZE="512" TYPE="xfs"
/dev/sr0: BLOCK_SIZE="2048" UUID="2024-02-16-23-52-30-00" LABEL="Ubuntu-Server 22.04.4 LTS amd64" TYPE="iso9660" PTTYPE="PMBR"
/dev/mapper/mongodb-srv: UUID="16fd8d1d-ab55-44fd-9e13-19e652a3d10d" BLOCK_SIZE="512" TYPE="xfs"
/dev/mapper/mongodb-root: UUID="b33938e6-6b3b-484c-a19c-59c4ae97163c" BLOCK_SIZE="512" TYPE="xfs"
/dev/mapper/mongodb-swap: UUID="9ea1915f-0e56-4b66-84cf-47d196a3e25a" TYPE="swap"
/dev/sda2: UUID="fe48d77e-d1b4-4d7d-b6f8-2be3cea13606" BLOCK_SIZE="512" TYPE="xfs" PARTUUID="7c49e542-bb1f-4f31-934b-5a6bb46753bb"
/dev/sda3: UUID="jhdfV4-CcTP-RIti-JvIc-WX8l-t23c-6vDdzT" TYPE="LVM2_member" PARTUUID="713b692d-906a-4e48-a01b-9e2a7479f8bf"
/dev/mapper/mongodb-var_lib: UUID="80e773e4-6b77-4320-a07f-2d7abe0ce9cf" BLOCK_SIZE="512" TYPE="xfs"
/dev/mapper/mongodb-usr: UUID="134aa80a-a30d-4d88-b8fd-94f4c85435b7" BLOCK_SIZE="512" TYPE="xfs"
/dev/loop1: TYPE="squashfs"
/dev/mapper/data_vg-data_lv: UUID="b760b0dd-9aaf-4438-a2c2-df7f9ec8f709" BLOCK_SIZE="512" TYPE="xfs"
/dev/sdb1: UUID="qtONTo-Sqn1-918r-MkLG-AERw-lYJw-tAmRgr" TYPE="LVM2_member" PARTUUID="ba3126c2-01"
/dev/loop0: TYPE="squashfs"
/dev/mapper/backup_vg-backup_lv: UUID="907a69eb-65ce-4310-868d-14edfcfa2485" BLOCK_SIZE="512" TYPE="xfs"
/dev/sdc1: UUID="fBTEBU-1jiZ-WaC8-WNT7-111m-cF27-m6ifuO" TYPE="LVM2_member" PARTUUID="c70c0712-01"
/dev/sda1: PARTUUID="324199db-c21e-4526-9766-7d4bcf9f0758"
*/

-- Step 43.2 -->> On Node 3 (LVM Partition Configuration - Verify)
root@mongodb-1-a:~# blkid
/*
/dev/mapper/mongodb-home: UUID="6a16debc-6a5a-47c5-9e2b-5bff3712fc57" BLOCK_SIZE="512" TYPE="xfs"
/dev/mapper/mongodb-tmp: UUID="45aec1c9-f73d-4cea-b767-600be37dd2b1" BLOCK_SIZE="512" TYPE="xfs"
/dev/mapper/mongodb-var: UUID="3b7473bf-9178-4203-b777-b89ab78168dc" BLOCK_SIZE="512" TYPE="xfs"
/dev/sr0: BLOCK_SIZE="2048" UUID="2024-02-16-23-52-30-00" LABEL="Ubuntu-Server 22.04.4 LTS amd64" TYPE="iso9660" PTTYPE="PMBR"
/dev/mapper/mongodb-srv: UUID="a600a565-b6e0-464c-ade1-1f52f2966c04" BLOCK_SIZE="512" TYPE="xfs"
/dev/mapper/mongodb-root: UUID="9e2c1bc1-2881-44e8-bebe-51c5e621b5a8" BLOCK_SIZE="512" TYPE="xfs"
/dev/mapper/mongodb-swap: UUID="5bc5c449-29b2-4c01-ad58-8493c896a032" TYPE="swap"
/dev/sda2: UUID="cdcd428c-7d2c-4dac-980b-56d9881ad81f" BLOCK_SIZE="512" TYPE="xfs" PARTUUID="43b9b7be-e1a5-415d-bb48-e22339b590bc"
/dev/sda3: UUID="5DPx0G-iCpd-29mH-zWb2-NwHj-YkOP-kqp2Ix" TYPE="LVM2_member" PARTUUID="63af3972-5987-483a-b600-bc8387e715a2"
/dev/mapper/mongodb-var_lib: UUID="4ef7ff20-930c-4540-90b9-d63f6d79a207" BLOCK_SIZE="512" TYPE="xfs"
/dev/mapper/mongodb-usr: UUID="5f4993dd-4c59-4c24-a8bb-39d075fb14a1" BLOCK_SIZE="512" TYPE="xfs"
/dev/mapper/data_vg-data_lv: UUID="bba9bd5b-8ec0-4933-ba67-d0b8c797defe" BLOCK_SIZE="512" TYPE="xfs"
/dev/sdb1: UUID="3Ro5Jg-EuLT-INXp-ZSLc-UwX9-ThRc-LETKcc" TYPE="LVM2_member" PARTUUID="9028b316-01"
/dev/mapper/backup_vg-backup_lv: UUID="88f2aaa0-7d89-4bf7-bcda-24e07f2a4d44" BLOCK_SIZE="512" TYPE="xfs"
/dev/sdc1: UUID="I6wkUa-RxYy-0L8X-qRdd-pMtT-i8ZG-q18i4r" TYPE="LVM2_member" PARTUUID="dc68ba62-01"
/dev/sda1: PARTUUID="01dd607c-e61f-4d3b-89a9-3e246d0b1f13"
*/

-- Step 44 -->> On All Nodes (LVM Partition Configuration - Before)
root@mongodb-1-p/mongodb-1-s/mongodb-1-a:~# df -Th
/*
Filesystem                                                                                   Type   Size  Used Avail Use% Mounted on
tmpfs                                                                                        tmpfs  388M  1.5M  386M   1% /run
/dev/mapper/mongodb-root                                                                     xfs     31G  259M   31G   1% /
/dev/disk/by-id/dm-uuid-LVM-3ptCeLXDFgsxMn412K5qwRMotc1eqWRhYVA9bhAXVnBn98NZplLdnF5JkdxNYsOC xfs    8.0G  2.7G  5.4G  33% /usr
tmpfs                                                                                        tmpfs  1.9G     0  1.9G   0% /dev/shm
tmpfs                                                                                        tmpfs  5.0M     0  5.0M   0% /run/lock
/dev/mapper/mongodb-tmp                                                                      xfs    8.0G   90M  8.0G   2% /tmp
/dev/mapper/mongodb-var                                                                      xfs    8.0G  231M  7.8G   3% /var
/dev/mapper/mongodb-srv                                                                      xfs    8.0G   90M  8.0G   2% /srv
/dev/mapper/mongodb-home                                                                     xfs    8.0G   90M  8.0G   2% /home
/dev/mapper/mongodb-var_lib                                                                  xfs    8.0G  674M  7.4G   9% /var/lib
/dev/sda2                                                                                    xfs    2.0G  196M  1.8G  10% /boot
tmpfs                                                                                        tmpfs  388M  4.0K  388M   1% /run/user/1000
*/

-- Step 45 -->> On All Nodes (LVM Partition Configuration - Mount Additional LVM)
root@mongodb-1-p/mongodb-1-s/mongodb-1-a:~# mkdir -p /data
root@mongodb-1-p/mongodb-1-s/mongodb-1-a:~# mkdir -p /backup
root@mongodb-1-p/mongodb-1-s/mongodb-1-a:~# mount /dev/mapper/data_vg-data_lv /data
root@mongodb-1-p/mongodb-1-s/mongodb-1-a:~# mount /dev/mapper/backup_vg-backup_lv /backup
root@mongodb-1-p/mongodb-1-s/mongodb-1-a:~# df -Th
/*
Filesystem                                                                                   Type   Size  Used Avail Use% Mounted on
tmpfs                                                                                        tmpfs  388M  1.5M  386M   1% /run
/dev/mapper/mongodb-root                                                                     xfs     31G  259M   31G   1% /
/dev/disk/by-id/dm-uuid-LVM-3ptCeLXDFgsxMn412K5qwRMotc1eqWRhYVA9bhAXVnBn98NZplLdnF5JkdxNYsOC xfs    8.0G  2.7G  5.4G  33% /usr
tmpfs                                                                                        tmpfs  1.9G     0  1.9G   0% /dev/shm
tmpfs                                                                                        tmpfs  5.0M     0  5.0M   0% /run/lock
/dev/mapper/mongodb-tmp                                                                      xfs    8.0G   90M  8.0G   2% /tmp
/dev/mapper/mongodb-var                                                                      xfs    8.0G  231M  7.8G   3% /var
/dev/mapper/mongodb-srv                                                                      xfs    8.0G   90M  8.0G   2% /srv
/dev/mapper/mongodb-home                                                                     xfs    8.0G   90M  8.0G   2% /home
/dev/mapper/mongodb-var_lib                                                                  xfs    8.0G  674M  7.4G   9% /var/lib
/dev/sda2                                                                                    xfs    2.0G  196M  1.8G  10% /boot
tmpfs                                                                                        tmpfs  388M  4.0K  388M   1% /run/user/1000
/dev/mapper/data_vg-data_lv                                                                  xfs    9.9G  103M  9.8G   2% /data
/dev/mapper/backup_vg-backup_lv                                                              xfs    9.9G  103M  9.8G   2% /backup
*/

-- Step 46 -->> On All Nodes (LVM Partition Configuration - UMount Additional LVM)
root@mongodb-1-p/mongodb-1-s/mongodb-1-a:~# umount /data/

-- Step 47 -->> On All Nodes (LVM Partition Configuration - UMount Additional LVM)
root@mongodb-1-p/mongodb-1-s/mongodb-1-a:~# umount /backup

-- Step 48 -->> On All Nodes (LVM Partition Configuration - Verify)
root@mongodb-1-p/mongodb-1-s/mongodb-1-a:~# df -Th
/*
Filesystem                                                                                   Type   Size  Used Avail Use% Mounted on
tmpfs                                                                                        tmpfs  388M  1.5M  386M   1% /run
/dev/mapper/mongodb-root                                                                     xfs     31G  259M   31G   1% /
/dev/disk/by-id/dm-uuid-LVM-3ptCeLXDFgsxMn412K5qwRMotc1eqWRhYVA9bhAXVnBn98NZplLdnF5JkdxNYsOC xfs    8.0G  2.7G  5.4G  33% /usr
tmpfs                                                                                        tmpfs  1.9G     0  1.9G   0% /dev/shm
tmpfs                                                                                        tmpfs  5.0M     0  5.0M   0% /run/lock
/dev/mapper/mongodb-tmp                                                                      xfs    8.0G   90M  8.0G   2% /tmp
/dev/mapper/mongodb-var                                                                      xfs    8.0G  231M  7.8G   3% /var
/dev/mapper/mongodb-srv                                                                      xfs    8.0G   90M  8.0G   2% /srv
/dev/mapper/mongodb-home                                                                     xfs    8.0G   90M  8.0G   2% /home
/dev/mapper/mongodb-var_lib                                                                  xfs    8.0G  674M  7.4G   9% /var/lib
/dev/sda2                                                                                    xfs    2.0G  196M  1.8G  10% /boot
tmpfs                                                                                        tmpfs  388M  4.0K  388M   1% /run/user/1000
*/

-- Step 49 -->> On Node 1 (LVM Partition Configuration - Verify)
root@mongodb-1-p:~# blkid
/*
/dev/mapper/mongodb-home: UUID="4b9c2b5e-799f-4368-b7c1-d5c81daee418" BLOCK_SIZE="512" TYPE="xfs"
/dev/mapper/mongodb-tmp: UUID="cb85fe59-bfdf-4961-85b5-949160c4b242" BLOCK_SIZE="512" TYPE="xfs"
/dev/mapper/mongodb-var: UUID="8d48ce8c-56b5-4b17-970b-62000ee5ddd1" BLOCK_SIZE="512" TYPE="xfs"
/dev/sr0: BLOCK_SIZE="2048" UUID="2024-02-16-23-52-30-00" LABEL="Ubuntu-Server 22.04.4 LTS amd64" TYPE="iso9660" PTTYPE="PMBR"
/dev/mapper/mongodb-srv: UUID="af00ff68-fe95-4460-abd2-ecd207705500" BLOCK_SIZE="512" TYPE="xfs"
/dev/mapper/mongodb-root: UUID="45a3cf65-bfcc-40dd-99cd-4338bfcb2750" BLOCK_SIZE="512" TYPE="xfs"
/dev/mapper/mongodb-swap: UUID="2951c1d8-02f5-4f90-9641-17a862e45985" TYPE="swap"
/dev/sda2: UUID="682b2783-b60a-48d5-bbf8-9763182930fa" BLOCK_SIZE="512" TYPE="xfs" PARTUUID="9cfff297-8843-406e-bbf6-533850c16f79"
/dev/sda3: UUID="QBsdNh-LU9X-8Q9i-BsJA-Rl09-sqFD-LalfP5" TYPE="LVM2_member" PARTUUID="b690948e-387a-47d5-8e86-5f3641f5f1d5"
/dev/mapper/mongodb-var_lib: UUID="5bf89ca3-6712-43f2-bb83-8d15dfc0fdb0" BLOCK_SIZE="512" TYPE="xfs"
/dev/mapper/mongodb-usr: UUID="819321d4-26dc-48d7-a4b5-c728c127c9ae" BLOCK_SIZE="512" TYPE="xfs"
/dev/loop1: TYPE="squashfs"
/dev/mapper/data_vg-data_lv: UUID="f207b96f-597b-4391-9c05-307bd9102c9a" BLOCK_SIZE="512" TYPE="xfs"
/dev/sdb1: UUID="uzIAQQ-qISP-o0jT-mLhN-rbV2-5G6I-RRrpvg" TYPE="LVM2_member" PARTUUID="8ac75535-01"
/dev/loop2: TYPE="squashfs"
/dev/loop0: TYPE="squashfs"
/dev/mapper/backup_vg-backup_lv: UUID="42bfdeba-34e8-41e0-a6b1-113add0250cd" BLOCK_SIZE="512" TYPE="xfs"
/dev/sdc1: UUID="AszBlT-87SP-Eo3j-Np8N-mBE3-aZYY-LJeqU3" TYPE="LVM2_member" PARTUUID="1fd490e3-01"
/dev/sda1: PARTUUID="501f7fb7-ae44-4942-a999-33e09df25c39"
*/

-- Step 49.1 -->> On Node 2 (LVM Partition Configuration - Verify)
root@mongodb-1-s:~# blkid
/*
/dev/mapper/mongodb-home: UUID="25c44641-902f-4b5e-b0fb-7f00c27c91a4" BLOCK_SIZE="512" TYPE="xfs"
/dev/mapper/mongodb-tmp: UUID="2b9c0ca3-aa25-475c-8c52-b84df177bf3f" BLOCK_SIZE="512" TYPE="xfs"
/dev/mapper/mongodb-var: UUID="234a8821-aee5-4768-b700-04443df962c7" BLOCK_SIZE="512" TYPE="xfs"
/dev/sr0: BLOCK_SIZE="2048" UUID="2024-02-16-23-52-30-00" LABEL="Ubuntu-Server 22.04.4 LTS amd64" TYPE="iso9660" PTTYPE="PMBR"
/dev/mapper/mongodb-srv: UUID="16fd8d1d-ab55-44fd-9e13-19e652a3d10d" BLOCK_SIZE="512" TYPE="xfs"
/dev/mapper/mongodb-root: UUID="b33938e6-6b3b-484c-a19c-59c4ae97163c" BLOCK_SIZE="512" TYPE="xfs"
/dev/mapper/mongodb-swap: UUID="9ea1915f-0e56-4b66-84cf-47d196a3e25a" TYPE="swap"
/dev/sda2: UUID="fe48d77e-d1b4-4d7d-b6f8-2be3cea13606" BLOCK_SIZE="512" TYPE="xfs" PARTUUID="7c49e542-bb1f-4f31-934b-5a6bb46753bb"
/dev/sda3: UUID="jhdfV4-CcTP-RIti-JvIc-WX8l-t23c-6vDdzT" TYPE="LVM2_member" PARTUUID="713b692d-906a-4e48-a01b-9e2a7479f8bf"
/dev/mapper/mongodb-var_lib: UUID="80e773e4-6b77-4320-a07f-2d7abe0ce9cf" BLOCK_SIZE="512" TYPE="xfs"
/dev/mapper/mongodb-usr: UUID="134aa80a-a30d-4d88-b8fd-94f4c85435b7" BLOCK_SIZE="512" TYPE="xfs"
/dev/loop1: TYPE="squashfs"
/dev/mapper/data_vg-data_lv: UUID="b760b0dd-9aaf-4438-a2c2-df7f9ec8f709" BLOCK_SIZE="512" TYPE="xfs"
/dev/sdb1: UUID="qtONTo-Sqn1-918r-MkLG-AERw-lYJw-tAmRgr" TYPE="LVM2_member" PARTUUID="ba3126c2-01"
/dev/loop0: TYPE="squashfs"
/dev/mapper/backup_vg-backup_lv: UUID="907a69eb-65ce-4310-868d-14edfcfa2485" BLOCK_SIZE="512" TYPE="xfs"
/dev/sdc1: UUID="fBTEBU-1jiZ-WaC8-WNT7-111m-cF27-m6ifuO" TYPE="LVM2_member" PARTUUID="c70c0712-01"
/dev/sda1: PARTUUID="324199db-c21e-4526-9766-7d4bcf9f0758"
*/

-- Step 49.2 -->> On Node 3 (LVM Partition Configuration - Verify)
root@mongodb-1-a:~# blkid
/*
/dev/mapper/mongodb-home: UUID="6a16debc-6a5a-47c5-9e2b-5bff3712fc57" BLOCK_SIZE="512" TYPE="xfs"
/dev/mapper/mongodb-tmp: UUID="45aec1c9-f73d-4cea-b767-600be37dd2b1" BLOCK_SIZE="512" TYPE="xfs"
/dev/mapper/mongodb-var: UUID="3b7473bf-9178-4203-b777-b89ab78168dc" BLOCK_SIZE="512" TYPE="xfs"
/dev/sr0: BLOCK_SIZE="2048" UUID="2024-02-16-23-52-30-00" LABEL="Ubuntu-Server 22.04.4 LTS amd64" TYPE="iso9660" PTTYPE="PMBR"
/dev/mapper/mongodb-srv: UUID="a600a565-b6e0-464c-ade1-1f52f2966c04" BLOCK_SIZE="512" TYPE="xfs"
/dev/mapper/mongodb-root: UUID="9e2c1bc1-2881-44e8-bebe-51c5e621b5a8" BLOCK_SIZE="512" TYPE="xfs"
/dev/mapper/mongodb-swap: UUID="5bc5c449-29b2-4c01-ad58-8493c896a032" TYPE="swap"
/dev/sda2: UUID="cdcd428c-7d2c-4dac-980b-56d9881ad81f" BLOCK_SIZE="512" TYPE="xfs" PARTUUID="43b9b7be-e1a5-415d-bb48-e22339b590bc"
/dev/sda3: UUID="5DPx0G-iCpd-29mH-zWb2-NwHj-YkOP-kqp2Ix" TYPE="LVM2_member" PARTUUID="63af3972-5987-483a-b600-bc8387e715a2"
/dev/mapper/mongodb-var_lib: UUID="4ef7ff20-930c-4540-90b9-d63f6d79a207" BLOCK_SIZE="512" TYPE="xfs"
/dev/mapper/mongodb-usr: UUID="5f4993dd-4c59-4c24-a8bb-39d075fb14a1" BLOCK_SIZE="512" TYPE="xfs"
/dev/mapper/data_vg-data_lv: UUID="bba9bd5b-8ec0-4933-ba67-d0b8c797defe" BLOCK_SIZE="512" TYPE="xfs"
/dev/sdb1: UUID="3Ro5Jg-EuLT-INXp-ZSLc-UwX9-ThRc-LETKcc" TYPE="LVM2_member" PARTUUID="9028b316-01"
/dev/mapper/backup_vg-backup_lv: UUID="88f2aaa0-7d89-4bf7-bcda-24e07f2a4d44" BLOCK_SIZE="512" TYPE="xfs"
/dev/sdc1: UUID="I6wkUa-RxYy-0L8X-qRdd-pMtT-i8ZG-q18i4r" TYPE="LVM2_member" PARTUUID="dc68ba62-01"
/dev/sda1: PARTUUID="01dd607c-e61f-4d3b-89a9-3e246d0b1f13"
*/

-- Step 50 -->> On Node 1 (LVM Partition Configuration - Add the id's of LVM to make permanent mount)
root@mongodb-1-p/mongodb-1-s/mongodb-1-a:~# vi /etc/fstab
/*
# /etc/fstab: static file system information.
#
# Use 'blkid' to print the universally unique identifier for a
# device; this may be used with UUID= as a more robust way to name devices
# that works even if disks are added and removed. See fstab(5).
#
# <file system> <mount point>   <type>  <options>       <dump>  <pass>
/dev/disk/by-id/dm-uuid-LVM-3ptCeLXDFgsxMn412K5qwRMotc1eqWRhV90Cr9phhH7DGVFE4mB84aBsFsN5myvr none swap sw 0 0
# / was on /dev/mongodb_1_p/root during curtin installation
/dev/disk/by-id/dm-uuid-LVM-3ptCeLXDFgsxMn412K5qwRMotc1eqWRh49L15chgkda6mVsp2MW143GHrAxkwg41 / xfs defaults 0 1
# /boot was on /dev/sda2 during curtin installation
/dev/disk/by-uuid/682b2783-b60a-48d5-bbf8-9763182930fa /boot xfs defaults 0 1
# /home was on /dev/mongodb_1_p/home during curtin installation
/dev/disk/by-id/dm-uuid-LVM-3ptCeLXDFgsxMn412K5qwRMotc1eqWRhd38yTQA0ijRGrw3hi9y1no4P6vJ7d2yc /home xfs defaults 0 1
# /srv was on /dev/mongodb_1_p/srv during curtin installation
/dev/disk/by-id/dm-uuid-LVM-3ptCeLXDFgsxMn412K5qwRMotc1eqWRhtQ7QUnK3EhEhvZBhVSlGJi3qa6eZnglV /srv xfs defaults 0 1
# /usr was on /dev/mongodb_1_p/usr during curtin installation
/dev/disk/by-id/dm-uuid-LVM-3ptCeLXDFgsxMn412K5qwRMotc1eqWRhYVA9bhAXVnBn98NZplLdnF5JkdxNYsOC /usr xfs defaults 0 1
# /var was on /dev/mongodb_1_p/var during curtin installation
/dev/disk/by-id/dm-uuid-LVM-3ptCeLXDFgsxMn412K5qwRMotc1eqWRhQvQGF7G38QQT7W1l9AizATgZrDXzUWHJ /var xfs defaults 0 1
# /var/lib was on /dev/mongodb_1_p/var_lib during curtin installation
/dev/disk/by-id/dm-uuid-LVM-3ptCeLXDFgsxMn412K5qwRMotc1eqWRhB12gPksBZQxnQNE3fTBTUWrCpDVbbg7l /var/lib xfs defaults 0 1
# /tmp was on /dev/mongodb_1_p/tmp during curtin installation
/dev/disk/by-id/dm-uuid-LVM-3ptCeLXDFgsxMn412K5qwRMotc1eqWRhmmqGtgFwf5u8l65xi0AN5c3H9F1gpwXc /tmp xfs defaults 0 1
#data
/dev/mapper/data_vg-data_lv /data xfs defaults 0 1
#backup
/dev/mapper/backup_vg-backup_lv /backup xfs defaults 0 1
*/

-- Step 51 -->> On All Nodes (LVM Partition Configuration - Verify)
root@mongodb-1-p/mongodb-1-s/mongodb-1-a:~# df -Th
/*
Filesystem                                                                                   Type   Size  Used Avail Use% Mounted on
tmpfs                                                                                        tmpfs  388M  1.5M  386M   1% /run
/dev/mapper/mongodb-root                                                                     xfs     31G  259M   31G   1% /
/dev/disk/by-id/dm-uuid-LVM-3ptCeLXDFgsxMn412K5qwRMotc1eqWRhYVA9bhAXVnBn98NZplLdnF5JkdxNYsOC xfs    8.0G  2.7G  5.4G  33% /usr
tmpfs                                                                                        tmpfs  1.9G     0  1.9G   0% /dev/shm
tmpfs                                                                                        tmpfs  5.0M     0  5.0M   0% /run/lock
/dev/mapper/mongodb-tmp                                                                      xfs    8.0G   90M  8.0G   2% /tmp
/dev/mapper/mongodb-var                                                                      xfs    8.0G  231M  7.8G   3% /var
/dev/mapper/mongodb-srv                                                                      xfs    8.0G   90M  8.0G   2% /srv
/dev/mapper/mongodb-home                                                                     xfs    8.0G   90M  8.0G   2% /home
/dev/mapper/mongodb-var_lib                                                                  xfs    8.0G  674M  7.4G   9% /var/lib
/dev/sda2                                                                                    xfs    2.0G  196M  1.8G  10% /boot
tmpfs                                                                                        tmpfs  388M  4.0K  388M   1% /run/user/1000
*/

-- Step 52 -->> On All Nodes (LVM Partition Configuration - Make permanent mount)
root@mongodb-1-p/mongodb-1-s/mongodb-1-a:~# mount -a

-- Step 53 -->> On All Nodes (LVM Partition Configuration - Verify)
root@mongodb-1-p/mongodb-1-s/mongodb-1-a:~# df -Th
/*
Filesystem                                                                                   Type   Size  Used Avail Use% Mounted on
tmpfs                                                                                        tmpfs  388M  1.5M  386M   1% /run
/dev/mapper/mongodb-root                                                                     xfs     31G  259M   31G   1% /
/dev/disk/by-id/dm-uuid-LVM-3ptCeLXDFgsxMn412K5qwRMotc1eqWRhYVA9bhAXVnBn98NZplLdnF5JkdxNYsOC xfs    8.0G  2.7G  5.4G  33% /usr
tmpfs                                                                                        tmpfs  1.9G     0  1.9G   0% /dev/shm
tmpfs                                                                                        tmpfs  5.0M     0  5.0M   0% /run/lock
/dev/mapper/mongodb-tmp                                                                      xfs    8.0G   90M  8.0G   2% /tmp
/dev/mapper/mongodb-var                                                                      xfs    8.0G  231M  7.8G   3% /var
/dev/mapper/mongodb-srv                                                                      xfs    8.0G   90M  8.0G   2% /srv
/dev/mapper/mongodb-home                                                                     xfs    8.0G   90M  8.0G   2% /home
/dev/mapper/mongodb-var_lib                                                                  xfs    8.0G  674M  7.4G   9% /var/lib
/dev/sda2                                                                                    xfs    2.0G  196M  1.8G  10% /boot
tmpfs                                                                                        tmpfs  388M  4.0K  388M   1% /run/user/1000
/dev/mapper/data_vg-data_lv                                                                  xfs    9.9G  103M  9.8G   2% /data
/dev/mapper/backup_vg-backup_lv                                                              xfs    9.9G  103M  9.8G   2% /backup
*/

-- Step 54 -->> On All Nodes (LVM Partition Configuration - Reboot)
root@mongodb-1-p/mongodb-1-s/mongodb-1-a:~# init 6

-- Step 55 -->> On All Nodes (LVM Partition Configuration - Verify)
root@mongodb-1-p/mongodb-1-s/mongodb-1-a:~# df -Th
/*
Filesystem                                                                                   Type   Size  Used Avail Use% Mounted on
tmpfs                                                                                        tmpfs  388M  1.5M  386M   1% /run
/dev/mapper/mongodb-root                                                                     xfs     31G  269M   31G   1% /
/dev/disk/by-id/dm-uuid-LVM-3ptCeLXDFgsxMn412K5qwRMotc1eqWRhYVA9bhAXVnBn98NZplLdnF5JkdxNYsOC xfs    8.0G  3.5G  4.6G  43% /usr
tmpfs                                                                                        tmpfs  1.9G     0  1.9G   0% /dev/shm
tmpfs                                                                                        tmpfs  5.0M     0  5.0M   0% /run/lock
/dev/mapper/backup_vg-backup_lv                                                              xfs    9.9G  103M  9.8G   2% /backup
/dev/mapper/data_vg-data_lv                                                                  xfs    9.9G  103M  9.8G   2% /data
/dev/mapper/mongodb-srv                                                                      xfs    8.0G   90M  8.0G   2% /srv
/dev/mapper/mongodb-home                                                                     xfs    8.0G   90M  8.0G   2% /home
/dev/mapper/mongodb-tmp                                                                      xfs    8.0G   90M  8.0G   2% /tmp
/dev/sda2                                                                                    xfs    2.0G  338M  1.7G  17% /boot
/dev/mapper/mongodb-var                                                                      xfs    8.0G  258M  7.8G   4% /var
/dev/mapper/mongodb-var_lib                                                                  xfs    8.0G  711M  7.3G   9% /var/lib
tmpfs                                                                                        tmpfs  388M  4.0K  388M   1% /run/user/1000

*/

-- Step 56 -->> On All Nodes (LVM Partition Configuration - Verify)
root@mongodb-1-p/mongodb-1-s/mongodb-1-a:~# lsblk
/*
NAME                    MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
loop0                     7:0    0 63.9M  1 loop /snap/core20/2105
loop1                     7:1    0   87M  1 loop /snap/lxd/27037
loop2                     7:2    0 40.4M  1 loop /snap/snapd/20671
sda                       8:0    0   90G  0 disk
├─sda1                    8:1    0    1M  0 part
├─sda2                    8:2    0    2G  0 part /boot
└─sda3                    8:3    0   88G  0 part
  ├─mongodb-root        252:0    0   31G  0 lvm  /
  ├─mongodb-home        252:1    0    8G  0 lvm  /home
  ├─mongodb-srv         252:2    0    8G  0 lvm  /srv
  ├─mongodb-usr         252:3    0    8G  0 lvm  /usr
  ├─mongodb-var         252:4    0    8G  0 lvm  /var
  ├─mongodb-var_lib     252:5    0    8G  0 lvm  /var/lib
  ├─mongodb-tmp         252:6    0    8G  0 lvm  /tmp
  └─mongodb-swap        252:7    0    8G  0 lvm  [SWAP]
sdb                       8:16   0   10G  0 disk
└─sdb1                    8:17   0   10G  0 part
  └─data_vg-data_lv     252:9    0  9.9G  0 lvm  /data
sdc                       8:32   0   10G  0 disk
└─sdc1                    8:33   0   10G  0 part
  └─backup_vg-backup_lv 252:8    0  9.9G  0 lvm  /backup
sr0                      11:0    1    2G  0 rom

*/

-- Step 57 -->> On All Nodes (Create Backup Directories)
root@mongodb-1-p/mongodb-1-s/mongodb-1-a:/# mkdir -p /backup/mongodbFullBackup
root@mongodb-1-p/mongodb-1-s/mongodb-1-a:/# chown -R mongodb:mongodb /backup/
root@mongodb-1-p/mongodb-1-s/mongodb-1-a:/# chmod -R 775 /backup/

-- Step 58 -->> On All Nodes
root@mongodb-1-p/mongodb-1-s/mongodb-1-a:/# ll | grep backup
/*
drwxrwxr-x.   3 mongodb mongodb   31 Mar 10 08:46 backup/
*/

-- Step 59 -->> On All Nodes
root@mongodb-1-p/mongodb-1-s/mongodb-1-a:/# ll  backup/
/*
drwxrwxr-x.  3 mongodb mongodb   31 Mar 10 08:46 ./
drwxr-xr-x. 21 root    root    4096 Mar 10 08:32 ../
drwxrwxr-x.  2 mongodb mongodb    6 Mar 10 08:46 mongodbFullBackup/
*/

-- Step 60 -->> On All Nodes (Create Data/Log Directories)
root@mongodb-1-p/mongodb-1-s/mongodb-1-a:/# mkdir -p /data/mongodb
root@mongodb-1-p/mongodb-1-s/mongodb-1-a:/# mkdir -p /data/log
root@mongodb-1-p/mongodb-1-s/mongodb-1-a:/# chown -R mongodb:mongodb /data/
root@mongodb-1-p/mongodb-1-s/mongodb-1-a:/# chmod -R 777 /data/

-- Step 61 -->> On All Nodes
root@mongodb-1-p/mongodb-1-s/mongodb-1-a:/# ll | grep data
/*
drwxrwxrwx.   4 mongodb mongodb   32 Mar 10 08:47 data/
*/

-- Step 62 -->> On All Nodes
root@mongodb-1-p/mongodb-1-s/mongodb-1-a:/# ll  data/
/*
drwxrwxrwx.  4 mongodb mongodb   32 Mar 10 08:47 ./
drwxr-xr-x. 21 root    root    4096 Mar 10 08:32 ../
drwxrwxrwx.  2 mongodb mongodb    6 Mar 10 08:47 log/
drwxrwxrwx.  2 mongodb mongodb    6 Mar 10 08:47 mongodb/
*/

-- Step 63 -->> On Node 1 (Verfy the ssh connection)
root@mongodb-1-p:~# ssh mongodb@192.168.56.159

-- Step 63.1 -->> On Node 2 (Verfy the ssh connection)
root@mongodb-1-s:~# ssh mongodb@192.168.56.160

-- Step 63.2 -->> On Node 3 (Verfy the ssh connection)
root@mongodb-1-a:~# ssh mongodb@192.168.56.161


-- Step 64 -->> On All Nodes (Install gnupg and curl)
mongodb@mongodb-1-p/mongodb-1-s/mongodb-1-a:~$ sudo apt-get install gnupg curl
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

-- Step 65 -->> On All Nodes (To import the MongoDB public GPG key)
mongodb@mongodb-1-p/mongodb-1-s/mongodb-1-a:~$ curl -fsSL https://www.mongodb.org/static/pgp/server-7.0.asc | \
   sudo gpg -o /usr/share/keyrings/mongodb-server-7.0.gpg \
   --dearmor

-- Step 66 -->> On All Nodes (Verification)
mongodb@mongodb-1-p/mongodb-1-s/mongodb-1-a:~$ apt-key list
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

-- Step 67 -->> On All Nodes (Create the repo-list file /etc/apt/sources.list.d/mongodb-org-7.0.list)
mongodb@mongodb-1-p/mongodb-1-s/mongodb-1-a:~$ echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-7.0.gpg ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-7.0.list
/*
deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-7.0.gpg ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 multiverse
*/

-- Step 68 -->> On All Nodes (Update the Local RPM's)
mongodb@mongodb-1-p/mongodb-1-s/mongodb-1-a:~$ sudo apt-get update
/*
Get:1 http://security.ubuntu.com/ubuntu jammy-security InRelease [110 kB]
Ign:2 https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 InRelease
Hit:3 http://np.archive.ubuntu.com/ubuntu jammy InRelease
Get:4 http://np.archive.ubuntu.com/ubuntu jammy-updates InRelease [119 kB]
Get:5 https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 Release [2,090 B]
Get:6 https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 Release.gpg [866 B]
Hit:7 http://np.archive.ubuntu.com/ubuntu jammy-backports InRelease
Get:8 http://np.archive.ubuntu.com/ubuntu jammy-updates/main amd64 Packages [1,458 kB]
Get:9 https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0/multiverse arm64 Packages [27.6 kB]
Get:10 https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0/multiverse amd64 Packages [28.6 kB]
Get:11 http://np.archive.ubuntu.com/ubuntu jammy-updates/universe amd64 Packages [1,054 kB]
Fetched 2,800 kB in 8s (363 kB/s)
Reading package lists... Done
*/

-- Step 69 -->> On All Nodes (Verification)
mongodb@mongodb-1-p/mongodb-1-s/mongodb-1-a:~$ sudo apt list --upgradable
/*
Listing... Done
*/

-- Step 70 -->> On All Nodes (Install the MongoDB packages)
mongodb@mongodb-1-p/mongodb-1-s/mongodb-1-a:~$ sudo apt-get install -y mongodb-org
/*
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
The following additional packages will be installed:
  mongodb-database-tools mongodb-mongosh mongodb-org-database mongodb-org-database-tools-extra mongodb-org-mongos mongodb-org-server mongodb-org-shell mongodb-org-tools
The following NEW packages will be installed:
  mongodb-database-tools mongodb-mongosh mongodb-org mongodb-org-database mongodb-org-database-tools-extra mongodb-org-mongos mongodb-org-server mongodb-org-shell mongodb-org-tools
0 upgraded, 9 newly installed, 0 to remove and 0 not upgraded.
Need to get 163 MB of archives.
After this operation, 537 MB of additional disk space will be used.
Get:1 https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0/multiverse amd64 mongodb-database-tools amd64 100.9.4 [51.9 MB]
Get:2 https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0/multiverse amd64 mongodb-mongosh amd64 2.1.5 [48.7 MB]
Get:3 https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0/multiverse amd64 mongodb-org-shell amd64 7.0.6 [2,986 B]
Get:4 https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0/multiverse amd64 mongodb-org-server amd64 7.0.6 [36.7 MB]
Get:5 https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0/multiverse amd64 mongodb-org-mongos amd64 7.0.6 [25.6 MB]
Get:6 https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0/multiverse amd64 mongodb-org-database-tools-extra amd64 7.0.6 [7,786 B]
Get:7 https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0/multiverse amd64 mongodb-org-database amd64 7.0.6 [3,422 B]
Get:8 https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0/multiverse amd64 mongodb-org-tools amd64 7.0.6 [2,770 B]
Get:9 https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0/multiverse amd64 mongodb-org amd64 7.0.6 [2,804 B]
Fetched 163 MB in 9s (18.6 MB/s)
Selecting previously unselected package mongodb-database-tools.
(Reading database ... 117534 files and directories currently installed.)
Preparing to unpack .../0-mongodb-database-tools_100.9.4_amd64.deb ...
Unpacking mongodb-database-tools (100.9.4) ...
Selecting previously unselected package mongodb-mongosh.
Preparing to unpack .../1-mongodb-mongosh_2.1.5_amd64.deb ...
Unpacking mongodb-mongosh (2.1.5) ...
Selecting previously unselected package mongodb-org-shell.
Preparing to unpack .../2-mongodb-org-shell_7.0.6_amd64.deb ...
Unpacking mongodb-org-shell (7.0.6) ...
Selecting previously unselected package mongodb-org-server.
Preparing to unpack .../3-mongodb-org-server_7.0.6_amd64.deb ...
Unpacking mongodb-org-server (7.0.6) ...
Selecting previously unselected package mongodb-org-mongos.
Preparing to unpack .../4-mongodb-org-mongos_7.0.6_amd64.deb ...
Unpacking mongodb-org-mongos (7.0.6) ...
Selecting previously unselected package mongodb-org-database-tools-extra.
Preparing to unpack .../5-mongodb-org-database-tools-extra_7.0.6_amd64.deb ...
Unpacking mongodb-org-database-tools-extra (7.0.6) ...
Selecting previously unselected package mongodb-org-database.
Preparing to unpack .../6-mongodb-org-database_7.0.6_amd64.deb ...
Unpacking mongodb-org-database (7.0.6) ...
Selecting previously unselected package mongodb-org-tools.
Preparing to unpack .../7-mongodb-org-tools_7.0.6_amd64.deb ...
Unpacking mongodb-org-tools (7.0.6) ...
Selecting previously unselected package mongodb-org.
Preparing to unpack .../8-mongodb-org_7.0.6_amd64.deb ...
Unpacking mongodb-org (7.0.6) ...
Setting up mongodb-mongosh (2.1.5) ...
Setting up mongodb-org-server (7.0.6) ...
Setting up mongodb-org-shell (7.0.6) ...
Setting up mongodb-database-tools (100.9.4) ...
Setting up mongodb-org-mongos (7.0.6) ...
Setting up mongodb-org-database-tools-extra (7.0.6) ...
Setting up mongodb-org-database (7.0.6) ...
Setting up mongodb-org-tools (7.0.6) ...
Setting up mongodb-org (7.0.6) ...
Processing triggers for man-db (2.10.2-1) ...
Scanning processes...
Scanning linux images...

Running kernel seems to be up-to-date.

No services need to be restarted.

No containers need to be restarted.

No user sessions are running outdated binaries.

No VM guests are running outdated hypervisor (qemu) binaries on this host.
*/

-- Step 71 -->> On All Nodes (MongoDB Configuration)
root@mongodb-1-p/mongodb-1-s/mongodb-1-a:/# cp -r /etc/mongod.conf /etc/mongod.conf.backup

-- Step 72 -->> On All Nodes (MongoDB Configuration)
root@mongodb-1-p/mongodb-1-s/mongodb-1-a:/# ll /etc/ | grep mongo
/*
-rw-r--r--.  1 root root        578 Dec 19  2013 mongod.conf
-rw-r--r--.  1 root root        578 Mar 10 09:13 mongod.conf.backup
*/

-- Step 73 -->> On All Nodes (MongoDB Configuration)
root@mongodb-1-p/mongodb-1-s/mongodb-1-a:/# vi /etc/mongod.conf
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
  bindIp: 127.0.0.1


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
root@mongodb-1-p:/# vi /etc/mongod.conf
/*
# network interfaces
net:
  port: 27017
  bindIp: 127.0.0.1,192.168.56.159
  maxIncomingConnections: 999999
*/

-- Step 74.1 -->> On Node 2 (Tuning For MongoDB)
root@mongodb-1-s:/# vi /etc/mongod.conf
/*
# network interfaces
net:
  port: 27017
  bindIp: 127.0.0.1,192.168.56.160
  maxIncomingConnections: 999999
*/

-- Step 74.2 -->> On Node 3 (Tuning For MongoDB)
root@mongodb-1-a:/# vi /etc/mongod.conf
/*
# network interfaces
net:
  port: 27017
  bindIp: 127.0.0.1,192.168.56.161
  maxIncomingConnections: 999999
*/

-- Step 75 -->> On All Nodes (Tuning For MongoDB)
root@mongodb-1-p/mongodb-1-s/mongodb-1-a:/# ulimit -a
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

-- Step 76 -->> On All Nodes (Tuning For MongoDB)
root@mongodb-1-p/mongodb-1-s/mongodb-1-a:/# ulimit -n 64000

-- Step 77 -->> On All Nodes (Tuning For MongoDB)
root@mongodb-1-p/mongodb-1-s/mongodb-1-a:/# ulimit -a
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

-- Step 78 -->> On All Nodes (Tuning For MongoDB)
root@mongodb-1-p/mongodb-1-s/mongodb-1-a:/# echo "mongodb           soft    nofile          9999999" | tee -a /etc/security/limits.conf
root@mongodb-1-p/mongodb-1-s/mongodb-1-a:/# echo "mongodb           hard    nofile          9999999" | tee -a /etc/security/limits.conf
root@mongodb-1-p/mongodb-1-s/mongodb-1-a:/# echo "mongodb           soft    nproc           9999999" | tee -a /etc/security/limits.conf
root@mongodb-1-p/mongodb-1-s/mongodb-1-a:/# echo "mongodb           hard    nproc           9999999" | tee -a /etc/security/limits.conf
root@mongodb-1-p/mongodb-1-s/mongodb-1-a:/# echo "mongodb           soft    stack           9999999" | tee -a /etc/security/limits.conf
root@mongodb-1-p/mongodb-1-s/mongodb-1-a:/# echo "mongodb           hard    stack           9999999" | tee -a /etc/security/limits.conf
root@mongodb-1-p/mongodb-1-s/mongodb-1-a:/# echo 9999999 > /proc/sys/vm/max_map_count
root@mongodb-1-p/mongodb-1-s/mongodb-1-a:/# echo "vm.max_map_count=9999999" | tee -a /etc/sysctl.conf
root@mongodb-1-p/mongodb-1-s/mongodb-1-a:/# echo 1024 65530 > /proc/sys/net/ipv4/ip_local_port_range
root@mongodb-1-p/mongodb-1-s/mongodb-1-a:/# echo "net.ipv4.ip_local_port_range = 1024 65530" | tee -a /etc/sysctl.conf

-- Step 79 -->> On All Nodes (Enable MongoDB)
root@mongodb-1-p/mongodb-1-s/mongodb-1-a:/# systemctl enable mongod --now
/*
Created symlink /etc/systemd/system/multi-user.target.wants/mongod.service → /lib/systemd/system/mongod.service.
*/

-- Step 80 -->> On All Nodes (Start MongoDB)
root@mongodb-1-p/mongodb-1-s/mongodb-1-a:/# systemctl start mongod

-- Step 81 -->> On All Nodes (Verify MongoDB)
root@mongodb-1-p/mongodb-1-s/mongodb-1-a:/# systemctl status mongod
/*
● mongod.service - MongoDB Database Server
     Loaded: loaded (/lib/systemd/system/mongod.service; enabled; vendor preset: enabled)
     Active: active (running) since Sun 2024-03-10 09:22:50 UTC; 3min 15s ago
       Docs: https://docs.mongodb.org/manual
   Main PID: 3141 (mongod)
     Memory: 75.5M
        CPU: 3.908s
     CGroup: /system.slice/mongod.service
             └─3141 /usr/bin/mongod --config /etc/mongod.conf

Mar 10 09:22:50 mongodb-1-p.unidev39.org.np systemd[1]: Started MongoDB Database Server.
Mar 10 09:22:50 mongodb-1-p.unidev39.org.np mongod[3141]: {"t":{"$date":"2024-03-10T09:22:50.578Z"},"s":"I",  "c":"CONTROL",  "id":7484500, "ctx":"main","msg":"Environment variable MONGODB>
*/

-- Step 82 -->> On All Nodes (Begin using MongoDB)
root@mongodb-1-p/mongodb-1-s/mongodb-1-a:/# mongosh
/*
Current Mongosh Log ID: 65ed7ce22c9f59148aa78a1b
Connecting to:          mongodb://127.0.0.1:27017/?directConnection=true&serverSelectionTimeoutMS=2000&appName=mongosh+2.1.5
Using MongoDB:          7.0.6
Using Mongosh:          2.1.5

For mongosh info see: https://docs.mongodb.com/mongodb-shell/


To help improve our products, anonymous usage data is collected and sent to MongoDB periodically (https://www.mongodb.com/legal/privacy-policy).
You can opt-out by running the disableTelemetry() command.

------
   The server generated these startup warnings when booting
   2024-03-10T09:22:51.333+00:00: Access control is not enabled for the database. Read andwrite access to data and configuration is unrestricted
------

test> db.version()
7.0.6
test> show dbs
admin   40.00 KiB
config  12.00 KiB
local   40.00 KiB
test> quit()
*/

-- Step 83 -->> On All Nodes (Default DBPath)
root@mongodb-1-p/mongodb-1-s/mongodb-1-a:~# ll /var/lib/mongodb/
/*
drwxr-xr-x.  2 mongodb mongodb    6 Mar 10 08:55 ./
drwxr-xr-x. 43 root    root    4096 Mar 10 08:55 ../
*/

-- Step 84 -->> On All Nodes (Default LogPath)
root@mongodb-1-p/mongodb-1-s/mongodb-1-a:~# ll /var/log/mongodb/
/*
drwxr-xr-x.  2 mongodb mongodb    6 Mar 10 08:55 ./
drwxrwxr-x. 10 root    syslog  4096 Mar 10 08:55 ../
*/

-- Step 85 -->> On All Nodes (Manuall DBPath)
root@mongodb-1-p/mongodb-1-s/mongodb-1-a:~# ll /data/mongodb/
/*
drwxrwxrwx. 4 mongodb mongodb  4096 Mar 10 09:29 ./
drwxrwxrwx. 4 mongodb mongodb    32 Mar 10 08:47 ../
-rw-------. 1 mongodb mongodb 20480 Mar 10 09:23 collection-0--6093854163827268446.wt
-rw-------. 1 mongodb mongodb 20480 Mar 10 09:23 collection-2--6093854163827268446.wt
-rw-------. 1 mongodb mongodb  4096 Mar 10 09:22 collection-4--6093854163827268446.wt
drwx------. 2 mongodb mongodb    71 Mar 10 09:30 diagnostic.data/
-rw-------. 1 mongodb mongodb 20480 Mar 10 09:23 index-1--6093854163827268446.wt
-rw-------. 1 mongodb mongodb 20480 Mar 10 09:23 index-3--6093854163827268446.wt
-rw-------. 1 mongodb mongodb  4096 Mar 10 09:22 index-5--6093854163827268446.wt
-rw-------. 1 mongodb mongodb  4096 Mar 10 09:22 index-6--6093854163827268446.wt
drwx------. 2 mongodb mongodb   110 Mar 10 09:22 journal/
-rw-------. 1 mongodb mongodb 20480 Mar 10 09:23 _mdb_catalog.wt
-rw-------. 1 mongodb mongodb     5 Mar 10 09:22 mongod.lock
-rw-------. 1 mongodb mongodb 20480 Mar 10 09:23 sizeStorer.wt
-rw-------. 1 mongodb mongodb   114 Mar 10 09:22 storage.bson
-rw-------. 1 mongodb mongodb    50 Mar 10 09:22 WiredTiger
-rw-------. 1 mongodb mongodb  4096 Mar 10 09:22 WiredTigerHS.wt
-rw-------. 1 mongodb mongodb    21 Mar 10 09:22 WiredTiger.lock
-rw-------. 1 mongodb mongodb  1465 Mar 10 09:29 WiredTiger.turtle
-rw-------. 1 mongodb mongodb 69632 Mar 10 09:29 WiredTiger.wt
*/

-- Step 86 -->> On All Nodes (Manuall LogPath)
root@mongodb-1-p/mongodb-1-s/mongodb-1-a:~# tail -f /data/log/mongod.log
/*
{"t":{"$date":"2024-03-10T09:26:58.970+00:00"},"s":"I",  "c":"NETWORK",  "id":6788700, "ctx":"conn4","msg":"Received first command on ingress connection since session start or auth handshake","attr":{"elapsedMillis":2}}
{"t":{"$date":"2024-03-10T09:26:59.135+00:00"},"s":"I",  "c":"NETWORK",  "id":6788700, "ctx":"conn3","msg":"Received first command on ingress connection since session start or auth handshake","attr":{"elapsedMillis":177}}
{"t":{"$date":"2024-03-10T09:27:09.450+00:00"},"s":"I",  "c":"NETWORK",  "id":22943,   "ctx":"listener","msg":"Connection accepted","attr":{"remote":"127.0.0.1:4270","uuid":{"uuid":{"$uuid":"46d3abe8-b5aa-43a1-9c02-6f18b6918038"}},"connectionId":5,"connectionCount":5}}
{"t":{"$date":"2024-03-10T09:27:09.461+00:00"},"s":"I",  "c":"NETWORK",  "id":51800,   "ctx":"conn5","msg":"client metadata","attr":{"remote":"127.0.0.1:4270","client":"conn5","negotiatedCompressors":[],"doc":{"application":{"name":"mongosh 2.1.5"},"driver":{"name":"nodejs|mongosh","version":"6.3.0|2.1.5"},"platform":"Node.js v20.11.1, LE","os":{"name":"linux","architecture":"x64","version":"6.5.0-25-generic","type":"Linux"}}}}
{"t":{"$date":"2024-03-10T09:27:25.088+00:00"},"s":"I",  "c":"NETWORK",  "id":22944,   "ctx":"conn5","msg":"Connection ended","attr":{"remote":"127.0.0.1:4270","uuid":{"uuid":{"$uuid":"46d3abe8-b5aa-43a1-9c02-6f18b6918038"}},"connectionId":5,"connectionCount":4}}
{"t":{"$date":"2024-03-10T09:27:25.088+00:00"},"s":"I",  "c":"-",        "id":20883,   "ctx":"conn1","msg":"Interrupted operation as its client disconnected","attr":{"opId":3274}}
{"t":{"$date":"2024-03-10T09:27:25.089+00:00"},"s":"I",  "c":"NETWORK",  "id":22944,   "ctx":"conn1","msg":"Connection ended","attr":{"remote":"127.0.0.1:21420","uuid":{"uuid":{"$uuid":"fd65bdd4-0660-4606-9d1e-a7bc597a4348"}},"connectionId":1,"connectionCount":3}}
{"t":{"$date":"2024-03-10T09:27:25.090+00:00"},"s":"I",  "c":"NETWORK",  "id":22944,   "ctx":"conn3","msg":"Connection ended","attr":{"remote":"127.0.0.1:21434","uuid":{"uuid":{"$uuid":"11d9b59d-8db8-4957-880f-4483311803f5"}},"connectionId":3,"connectionCount":2}}
{"t":{"$date":"2024-03-10T09:27:25.091+00:00"},"s":"I",  "c":"NETWORK",  "id":22944,   "ctx":"conn4","msg":"Connection ended","attr":{"remote":"127.0.0.1:21450","uuid":{"uuid":{"$uuid":"d5f5ea11-c130-4390-a9ff-f3bda1b81bd7"}},"connectionId":4,"connectionCount":1}}
{"t":{"$date":"2024-03-10T09:27:25.092+00:00"},"s":"I",  "c":"NETWORK",  "id":22944,   "ctx":"conn2","msg":"Connection ended","attr":{"remote":"127.0.0.1:21430","uuid":{"uuid":{"$uuid":"2dca940f-d866-4d3f-be30-d4d6e6c4489e"}},"connectionId":2,"connectionCount":0}}
*/

-- Step 87 -->> On All Nodes (Stop MongoDB)
root@mongodb-1-p/mongodb-1-s/mongodb-1-a:/# systemctl stop mongod

-- Step 88 -->> On All Nodes (Find the location of MongoDB)
root@mongodb-1-p/mongodb-1-s/mongodb-1-a:/# which mongosh
/*
/usr/bin/mongosh
*/

-- Step 89 -->> On All Nodes (After MongoDB Version 4.4 the "mongo" shell is not avilable)
root@mongodb-1-p/mongodb-1-s/mongodb-1-a:/# cd /usr/bin/

-- Step 90 -->> On All Nodes
root@mongodb-1-p/mongodb-1-s/mongodb-1-a:/usr/bin# ll | grep mongo
/*
-rwxr-xr-x.  1 mongodb mongodb  13740784 Dec  7 16:17 bsondump*
-rwxr-xr-x.  1 root    root    182587240 Dec 19  2013 mongod*
-rwxr-xr-x.  1 mongodb mongodb  16185776 Dec  7 16:17 mongodump*
-rwxr-xr-x.  1 mongodb mongodb  15877000 Dec  7 16:17 mongoexport*
-rwxr-xr-x.  1 mongodb mongodb  16725592 Dec  7 16:17 mongofiles*
-rwxr-xr-x.  1 mongodb mongodb  16128496 Dec  7 16:17 mongoimport*
-rwxr-xr-x.  1 mongodb mongodb  16517352 Dec  7 16:17 mongorestore*
-rwxr-xr-x.  1 root    root    130003632 Dec 19  2013 mongos*
-rwxr-xr-x.  1 root    root    112757240 Feb 19 11:00 mongosh*
-rwxr-xr-x.  1 mongodb mongodb  15746288 Dec  7 16:17 mongostat*
-rwxr-xr-x.  1 mongodb mongodb  15317640 Dec  7 16:17 mongotop*
*/

-- Step 91 -->> On All Nodes (Make a copy of mongosh as mongo)
root@mongodb-1-p/mongodb-1-s/mongodb-1-a:/usr/bin# cp mongosh mongo

-- Step 92 -->> On All Nodes
root@mongodb-1-p/mongodb-1-s/mongodb-1-a:/usr/bin# ll | grep mongo
/*
-rwxr-xr-x.  1 mongodb mongodb  13740784 Dec  7 16:17 bsondump*
-rwxr-xr-x.  1 root    root    112757240 Mar 10 09:31 mongo*
-rwxr-xr-x.  1 root    root    182587240 Dec 19  2013 mongod*
-rwxr-xr-x.  1 mongodb mongodb  16185776 Dec  7 16:17 mongodump*
-rwxr-xr-x.  1 mongodb mongodb  15877000 Dec  7 16:17 mongoexport*
-rwxr-xr-x.  1 mongodb mongodb  16725592 Dec  7 16:17 mongofiles*
-rwxr-xr-x.  1 mongodb mongodb  16128496 Dec  7 16:17 mongoimport*
-rwxr-xr-x.  1 mongodb mongodb  16517352 Dec  7 16:17 mongorestore*
-rwxr-xr-x.  1 root    root    130003632 Dec 19  2013 mongos*
-rwxr-xr-x.  1 root    root    112757240 Feb 19 11:00 mongosh*
-rwxr-xr-x.  1 mongodb mongodb  15746288 Dec  7 16:17 mongostat*
-rwxr-xr-x.  1 mongodb mongodb  15317640 Dec  7 16:17 mongotop*
*/

-- Step 93 -->> On All Nodes (Start MongoDB)
root@mongodb-1-p/mongodb-1-s/mongodb-1-a:~# systemctl start mongod

-- Step 94 -->> On All Nodes (Verify MongoDB)
root@mongodb-1-p/mongodb-1-s/mongodb-1-a:~# systemctl status mongod
/*
● mongod.service - MongoDB Database Server
     Loaded: loaded (/lib/systemd/system/mongod.service; enabled; vendor preset: enabled)
     Active: active (running) since Sun 2024-03-10 09:32:03 UTC; 13s ago
       Docs: https://docs.mongodb.org/manual
   Main PID: 3246 (mongod)
     Memory: 169.9M
        CPU: 1.994s
     CGroup: /system.slice/mongod.service
             └─3246 /usr/bin/mongod --config /etc/mongod.conf

Mar 10 09:32:03 mongodb-1-p.unidev39.org.np systemd[1]: Started MongoDB Database Server.
Mar 10 09:32:03 mongodb-1-p.unidev39.org.np mongod[3246]: {"t":{"$date":"2024-03-10T09:32:03.163Z"},"s":"I",  "c":"CONTROL",  "id":7484500, "ctx":"main","msg":"Environment variable MONGODB>
*/

-- Step 95 -->> On All Nodes (Begin with MongoDB)
root@mongodb-1-p/mongodb-1-s/mongodb-1-a:~# mongosh
/*
Current Mongosh Log ID: 65ed7e375197f4b768597c12
Connecting to:          mongodb://127.0.0.1:27017/?directConnection=true&serverSelectionTimeoutMS=2000&appName=mongosh+2.1.5
Using MongoDB:          7.0.6
Using Mongosh:          2.1.5

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

------
   The server generated these startup warnings when booting
   2024-03-10T09:32:04.938+00:00: Access control is not enabled for the database. Read and write access to data and configuration is unrestricted
------

test> db.version()
7.0.6
test> show dbs
admin   40.00 KiB
config  12.00 KiB
local   40.00 KiB
test> exit
*/

-- Step 96 -->> On All Nodes (Begin with MongoDB)
root@mongodb-1-p/mongodb-1-s/mongodb-1-a:~# mongo
/*
Current Mongosh Log ID: 65ed7e735248daebaedda212
Connecting to:          mongodb://127.0.0.1:27017/?directConnection=true&serverSelectionTimeoutMS=2000&appName=mongosh+2.1.5
Using MongoDB:          7.0.6
Using Mongosh:          2.1.5

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

------
   The server generated these startup warnings when booting
   2024-03-10T09:32:04.938+00:00: Access control is not enabled for the database. Read and write access to data and configuration is unrestricted
------

test> db.version()
7.0.6
test> show dbs
admin   40.00 KiB
config  12.00 KiB
local   72.00 KiB
test> exit
*/

-- Step 97 -->> On Node 1 (Switch user into MongoDB)
root@mongodb-1-p:~# su - mongodb
mongodb@mongodb-1-p:~$ sudo systemctl status mongod
/*
● mongod.service - MongoDB Database Server
     Loaded: loaded (/lib/systemd/system/mongod.service; enabled; vendor preset: enabled)
     Active: active (running) since Tue 2024-03-12 04:34:39 UTC; 8min ago
       Docs: https://docs.mongodb.org/manual
   Main PID: 1433 (mongod)
     Memory: 261.7M
        CPU: 11.210s
     CGroup: /system.slice/mongod.service
             └─1433 /usr/bin/mongod --config /etc/mongod.conf

Mar 12 04:34:39 mongodb-1-p.unidev39.org.np systemd[1]: Started MongoDB Database Server.
Mar 12 04:34:39 mongodb-1-p.unidev39.org.np mongod[1433]: {"t":{"$date":"2024-03-12T04:34:39.663Z"},"s":"I",  "c":"CONTROL",  "id":7484500, "ctx":"main","msg":"Environment variable MONGODB>
*/

-- Step 98 -->> On Node 1 (Verify MongoDB)
mongodb@mongodb-1-p:~$ mongosh --eval 'db.runCommand({ connectionStatus: 1 })'
/*
Current Mongosh Log ID: 65efdd80b3c1bfd610df9309
Connecting to:          mongodb://127.0.0.1:27017/?directConnection=true&serverSelectionTimeoutMS=2000&appName=mongosh+2.1.5
Using MongoDB:          7.0.6
Using Mongosh:          2.1.5

For mongosh info see: https://docs.mongodb.com/mongodb-shell/


To help improve our products, anonymous usage data is collected and sent to MongoDB periodically (https://www.mongodb.com/legal/privacy-policy).
You can opt-out by running the disableTelemetry() command.

------
   The server generated these startup warnings when booting
   2024-03-12T04:34:40.746+00:00: Access control is not enabled for the database. Read and write access to data and configuration is unrestricted
------

{
  authInfo: { authenticatedUsers: [], authenticatedUserRoles: [] },
  ok: 1
}
*/

-- Step 99 -->> On Node 1 (Begin with MongoDB - Create user for Authorized)
mongodb@mongodb-1-p:~$ mongosh
/*
Current Mongosh Log ID: 65efde06e3e122e8320cc29e
Connecting to:          mongodb://127.0.0.1:27017/?directConnection=true&serverSelectionTimeoutMS=2000&appName=mongosh+2.1.5
Using MongoDB:          7.0.6
Using Mongosh:          2.1.5

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

------
   The server generated these startup warnings when booting
   2024-03-12T04:34:40.746+00:00: Access control is not enabled for the database. Read and write access to data and configuration is unrestricted
------

test> db.version()
7.0.6

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
      userId: UUID('5e077bd7-d5eb-46b1-93bc-fca28beb5286'),
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
  ok: 1
}

admin> db.auth('admin','P#ssw0rd');
{ ok: 1 }

admin> quit()
*/

-- Step 100 -->> On Node 1 (Stop MongoDB)
mongodb@mongodb-1-p:~$ sudo systemctl stop mongod

-- Step 101 -->> On Node 1 (Access control is enabled for the database)
mongodb@mongodb-1-p:~$ sudo vi /etc/mongod.conf
/*
#security:
security:
 authorization: enabled
*/

-- Step 102 -->> On Node 1 (Start MongoDB)
mongodb@mongodb-1-p:~$ sudo systemctl start mongod

-- Step 103 -->> On Node 1 (Verify MongoDB)
mongodb@mongodb-1-p/mongodb-1-s/mongodb-1-a:~$ sudo systemctl status mongod
/*
● mongod.service - MongoDB Database Server
     Loaded: loaded (/lib/systemd/system/mongod.service; enabled; vendor preset: enabled)
     Active: active (running) since Tue 2024-03-12 04:53:31 UTC; 4s ago
       Docs: https://docs.mongodb.org/manual
   Main PID: 1873 (mongod)
     Memory: 169.6M
        CPU: 1.130s
     CGroup: /system.slice/mongod.service
             └─1873 /usr/bin/mongod --config /etc/mongod.conf

Mar 12 04:53:31 mongodb-1-p.unidev39.org.np systemd[1]: Started MongoDB Database Server.
Mar 12 04:53:31 mongodb-1-p.unidev39.org.np mongod[1873]: {"t":{"$date":"2024-03-12T04:53:31.363Z"},"s":"I",  "c":"CONTROL",  "id":7484500, "ctx":"main","msg":"Environment variable MONGODB>
*/

-- Step 104 -->> On Node 1 (Begin with MongoDB)
mongodb@mongodb-1-p:~$ mongosh
/*
Current Mongosh Log ID: 65efdff33f99b53fcd025711
Connecting to:          mongodb://127.0.0.1:27017/?directConnection=true&serverSelectionTimeoutMS=2000&appName=mongosh+2.1.5
Using MongoDB:          7.0.6
Using Mongosh:          2.1.5

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

test> db.version()
7.0.6

test> show dbs
MongoServerError[Unauthorized]: Command listDatabases requires authentication

test> quit()
*/

-- Step 105 -->> On Node 1 (Begin with MongoDB)
mongodb@mongodb-1-p/mongodb-1-s/mongodb-1-a:~$ mongo
/*
Current Mongosh Log ID: 65efe0292e4fc5bab3f2c39a
Connecting to:          mongodb://127.0.0.1:27017/?directConnection=true&serverSelectionTimeoutMS=2000&appName=mongosh+2.1.5
Using MongoDB:          7.0.6
Using Mongosh:          2.1.5

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

test> db.version()
7.0.6

test> show dbs
MongoServerError[Unauthorized]: Command listDatabases requires authentication

test> exit
*/

-- Step 106 -->> On Node 1 (Begin with MongoDB using Access Details)
mongodb@mongodb-1-p:~$ mongo --host 127.0.0.1 --port 27017 -u admin -p P#ssw0rd --authenticationDatabase admin
/*
Current Mongosh Log ID: 65efe06e83684911f349cb7f
Connecting to:          mongodb://<credentials>@127.0.0.1:27017/?directConnection=true&serverSelectionTimeoutMS=2000&authSource=admin&appName=mongosh+2.1.5
Using MongoDB:          7.0.6
Using Mongosh:          2.1.5

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

test> db.version()
7.0.6

test> show dbs
admin   132.00 KiB
config   60.00 KiB
local    72.00 KiB

test> quit()
*/

-- Step 107 -->> On Node 1 (Begin with MongoDB using Access Details)
mongodb@mongodb-1-p:~$ mongosh --host 192.168.56.159 --port 27017 -u admin -p P#ssw0rd --authenticationDatabase admin
/*
Current Mongosh Log ID: 65efe0d35f91f5d80833f269
Connecting to:          mongodb://<credentials>@192.168.56.159:27017/?directConnection=true&authSource=admin&appName=mongosh+2.1.5
Using MongoDB:          7.0.6
Using Mongosh:          2.1.5

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

test> db.version()
7.0.6

test> show dbs
admin   132.00 KiB
config   60.00 KiB
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
      userId: UUID('5e077bd7-d5eb-46b1-93bc-fca28beb5286'),
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
  ok: 1
}

admin> exit
*/

-- Step 108 -->> On Node 2 (Begin with MongoDB)
root@mongodb-1-s:~# su - mongodb
mongodb@mongodb-1-s:~$ sudo systemctl status mongod
/*
● mongod.service - MongoDB Database Server
     Loaded: loaded (/lib/systemd/system/mongod.service; enabled; vendor preset: enabled)
     Active: active (running) since Tue 2024-03-12 04:32:06 UTC; 48min ago
       Docs: https://docs.mongodb.org/manual
   Main PID: 1430 (mongod)
     Memory: 257.2M
        CPU: 57.752s
     CGroup: /system.slice/mongod.service
             └─1430 /usr/bin/mongod --config /etc/mongod.conf

Mar 12 04:32:06 mongodb-1-s.unidev39.org.np systemd[1]: Started MongoDB Database Server.
Mar 12 04:32:06 mongodb-1-s.unidev39.org.np mongod[1430]: {"t":{"$date":"2024-03-12T04:32:06.006Z"},"s":"I",  "c":"CONTROL",  "id":7484500, "ctx":"main","msg":"Environment variable MONGODB>
*/

-- Step 109 -->> On Node 2 (Begin with MongoDB - Access control is enabled for the database)
mongodb@mongodb-1-s:~$ sudo systemctl stop mongod

-- Step 110 -->> On Node 2 (Begin with MongoDB - Access control is enabled for the database)
mongodb@mongodb-1-s:~$ sudo vi /etc/mongod.conf
/*
#security:
security:
 authorization: enabled
*/

-- Step 111 -->> On Node 2
mongodb@mongodb-1-s:~$ sudo systemctl start mongod

-- Step 112 -->> On Node 2
mongodb@mongodb-1-s:~$ sudo systemctl status mongod
/*
● mongod.service - MongoDB Database Server
     Loaded: loaded (/lib/systemd/system/mongod.service; enabled; vendor preset: enabled)
     Active: active (running) since Tue 2024-03-12 05:24:13 UTC; 3s ago
       Docs: https://docs.mongodb.org/manual
   Main PID: 2196 (mongod)
     Memory: 169.7M
        CPU: 921ms
     CGroup: /system.slice/mongod.service
             └─2196 /usr/bin/mongod --config /etc/mongod.conf

Mar 12 05:24:13 mongodb-1-s.unidev39.org.np systemd[1]: Started MongoDB Database Server.
Mar 12 05:24:13 mongodb-1-s.unidev39.org.np mongod[2196]: {"t":{"$date":"2024-03-12T05:24:13.995Z"},"s":"I",  "c":"CONTROL",  "id":7484500, "ctx":"main","msg":"Environment variable MONGODB>
*/

-- Step 113 -->> On Node 3
root@mongodb-1-a:~# su - mongodb
mongodb@mongodb-1-a:~$ sudo systemctl status mongod
/*
● mongod.service - MongoDB Database Server
     Loaded: loaded (/lib/systemd/system/mongod.service; enabled; vendor preset: enabled)
     Active: active (running) since Tue 2024-03-12 04:32:01 UTC; 1h 1min ago
       Docs: https://docs.mongodb.org/manual
   Main PID: 1429 (mongod)
     Memory: 262.7M
        CPU: 1min 13.489s
     CGroup: /system.slice/mongod.service
             └─1429 /usr/bin/mongod --config /etc/mongod.conf

Mar 12 04:32:01 mongodb-1-a.unidev39.org.np systemd[1]: Started MongoDB Database Server.
Mar 12 04:32:02 mongodb-1-a.unidev39.org.np mongod[1429]: {"t":{"$date":"2024-03-12T04:32:02.159Z"},"s":"I",  "c":"CONTROL",  "id":7484500, "ctx":"main","msg":"Environment variable MONGODB>
*/

-- Step 114 -->> On Node 3 (Begin with MongoDB - Access control is enabled for the database)
mongodb@mongodb-1-a:~$ sudo systemctl stop mongod

-- Step 115 -->> On Node 3 (Begin with MongoDB - Access control is enabled for the database)
mongodb@mongodb-1-a:~$ sudo vi /etc/mongod.conf
/*
#security:
security:
  authorization: enabled
*/

-- Step 116 -->> On Node 3
mongodb@mongodb-1-a:~$ sudo systemctl start mongod

-- Step 117 -->> On Node 3
mongodb@mongodb-1-a:~$ sudo systemctl status mongod
/*
● mongod.service - MongoDB Database Server
     Loaded: loaded (/lib/systemd/system/mongod.service; enabled; vendor preset: enabled)
     Active: active (running) since Tue 2024-03-12 05:36:32 UTC; 3s ago
       Docs: https://docs.mongodb.org/manual
   Main PID: 2176 (mongod)
     Memory: 169.6M
        CPU: 1.050s
     CGroup: /system.slice/mongod.service
             └─2176 /usr/bin/mongod --config /etc/mongod.conf

Mar 12 05:36:32 mongodb-1-a.unidev39.org.np systemd[1]: Started MongoDB Database Server.
Mar 12 05:36:32 mongodb-1-a.unidev39.org.np mongod[2176]: {"t":{"$date":"2024-03-12T05:36:32.716Z"},"s":"I",  "c":"CONTROL",  "id":7484500, "ctx":"main","msg":"Environment variable MONGODB>
*/

-- Step 118 -->> On All Nodes (Verify the Status of MongoDB)
mongodb@mongodb-1-p/mongodb-1-s/mongodb-1-a:~$ sudo systemctl status mongod
/*
● mongod.service - MongoDB Database Server
     Loaded: loaded (/lib/systemd/system/mongod.service; enabled; vendor preset: enabled)
     Active: active (running) since Tue 2024-03-12 07:47:49 UTC; 3s ago
       Docs: https://docs.mongodb.org/manual
   Main PID: 2685 (mongod)
     Memory: 169.5M
        CPU: 1.292s
     CGroup: /system.slice/mongod.service
             └─2685 /usr/bin/mongod --config /etc/mongod.conf

Mar 12 07:47:49 mongodb-1-p.unidev39.org.np systemd[1]: Started MongoDB Database Server.
Mar 12 07:47:50 mongodb-1-p.unidev39.org.np mongod[2685]: {"t":{"$date":"2024-03-12T07:47:50>
*/

-- Step 119 -->> On All Nodes (Configure ReplicaSets)
mongodb@mongodb-1-p/mongodb-1-s/mongodb-1-a:~$ sudo vi /etc/mongod.conf
/*
#replication:
replication:
  replSetName: rs0
*/

-- Step 120 -->> On Node 1 (Configure ReplicaSets)
mongodb@mongodb-1-p:~$ cd /data/mongodb/

-- Step 121 -->> On Node 1 (Configure ReplicaSets)
mongodb@mongodb-1-p:/data/mongodb$ ll
/*
drwxrwxrwx. 4 mongodb mongodb  4096 Mar 12 07:50 ./
drwxrwxrwx. 4 mongodb mongodb    32 Mar 10 08:47 ../
-rw-------. 1 mongodb mongodb 20480 Mar 12 07:44 collection-0--4771704940815101693.wt
-rw-------. 1 mongodb mongodb 36864 Mar 12 07:47 collection-0--6093854163827268446.wt
-rw-------. 1 mongodb mongodb 36864 Mar 12 07:48 collection-2--6093854163827268446.wt
-rw-------. 1 mongodb mongodb 24576 Mar 12 07:44 collection-4--6093854163827268446.wt
drwx------. 2 mongodb mongodb  4096 Mar 12 07:50 diagnostic.data/
-rw-------. 1 mongodb mongodb 20480 Mar 12 04:50 index-1--4771704940815101693.wt
-rw-------. 1 mongodb mongodb 36864 Mar 12 07:47 index-1--6093854163827268446.wt
-rw-------. 1 mongodb mongodb 20480 Mar 12 07:44 index-2--4771704940815101693.wt
-rw-------. 1 mongodb mongodb 36864 Mar 12 07:48 index-3--6093854163827268446.wt
-rw-------. 1 mongodb mongodb 24576 Mar 12 07:44 index-5--6093854163827268446.wt
-rw-------. 1 mongodb mongodb 24576 Mar 12 07:48 index-6--6093854163827268446.wt
drwx------. 2 mongodb mongodb   110 Mar 12 07:47 journal/
-rw-------. 1 mongodb mongodb 36864 Mar 12 07:47 _mdb_catalog.wt
-rw-------. 1 mongodb mongodb     5 Mar 12 07:47 mongod.lock
-rw-------. 1 mongodb mongodb 36864 Mar 12 07:48 sizeStorer.wt
-rw-------. 1 mongodb mongodb   114 Mar 10 09:22 storage.bson
-rw-------. 1 mongodb mongodb    50 Mar 10 09:22 WiredTiger
-rw-------. 1 mongodb mongodb  4096 Mar 12 07:47 WiredTigerHS.wt
-rw-------. 1 mongodb mongodb    21 Mar 10 09:22 WiredTiger.lock
-rw-------. 1 mongodb mongodb  1473 Mar 12 07:50 WiredTiger.turtle
-rw-------. 1 mongodb mongodb 77824 Mar 12 07:50 WiredTiger.wt
*/

-- Step 122 -->> On Node 1 (Configure ReplicaSets)
mongodb@mongodb-1-p:/data/mongodb$ openssl rand -base64 756 > keyfile

-- Step 123 -->> On Node 1 (Configure ReplicaSets)
mongodb@mongodb-1-p:/data/mongodb$ chmod 400 keyfile

-- Step 124 -->> On Node 1 (Configure ReplicaSets)
mongodb@mongodb-1-p:/data/mongodb$ ll
/*
drwxrwxrwx. 4 mongodb mongodb  4096 Mar 12 07:51 ./
drwxrwxrwx. 4 mongodb mongodb    32 Mar 10 08:47 ../
-rw-------. 1 mongodb mongodb 20480 Mar 12 07:44 collection-0--4771704940815101693.wt
-rw-------. 1 mongodb mongodb 36864 Mar 12 07:47 collection-0--6093854163827268446.wt
-rw-------. 1 mongodb mongodb 36864 Mar 12 07:48 collection-2--6093854163827268446.wt
-rw-------. 1 mongodb mongodb 24576 Mar 12 07:44 collection-4--6093854163827268446.wt
drwx------. 2 mongodb mongodb  4096 Mar 12 07:51 diagnostic.data/
-rw-------. 1 mongodb mongodb 20480 Mar 12 04:50 index-1--4771704940815101693.wt
-rw-------. 1 mongodb mongodb 36864 Mar 12 07:47 index-1--6093854163827268446.wt
-rw-------. 1 mongodb mongodb 20480 Mar 12 07:44 index-2--4771704940815101693.wt
-rw-------. 1 mongodb mongodb 36864 Mar 12 07:48 index-3--6093854163827268446.wt
-rw-------. 1 mongodb mongodb 24576 Mar 12 07:44 index-5--6093854163827268446.wt
-rw-------. 1 mongodb mongodb 24576 Mar 12 07:48 index-6--6093854163827268446.wt
drwx------. 2 mongodb mongodb   110 Mar 12 07:47 journal/
-r--------. 1 mongodb mongodb  1024 Mar 12 07:51 keyfile
-rw-------. 1 mongodb mongodb 36864 Mar 12 07:47 _mdb_catalog.wt
-rw-------. 1 mongodb mongodb     5 Mar 12 07:47 mongod.lock
-rw-------. 1 mongodb mongodb 36864 Mar 12 07:48 sizeStorer.wt
-rw-------. 1 mongodb mongodb   114 Mar 10 09:22 storage.bson
-rw-------. 1 mongodb mongodb    50 Mar 10 09:22 WiredTiger
-rw-------. 1 mongodb mongodb  4096 Mar 12 07:47 WiredTigerHS.wt
-rw-------. 1 mongodb mongodb    21 Mar 10 09:22 WiredTiger.lock
-rw-------. 1 mongodb mongodb  1473 Mar 12 07:50 WiredTiger.turtle
-rw-------. 1 mongodb mongodb 77824 Mar 12 07:50 WiredTiger.wt
*/

-- Step 125 -->> On Node 1 (Configure ReplicaSets)
mongodb@mongodb-1-p:/data/mongodb$ ll | grep keyfile
/*
-r--------. 1 mongodb mongodb  1024 Mar 12 07:51 keyfile
*/

-- Step 126 -->> On Node 1 (Copy the KeyFile from Primary to Secondary Node)
mongodb@mongodb-1-p:/data/mongodb$ scp -r keyfile mongodb@mongodb-1-s:/data/mongodb
/*
The authenticity of host 'mongodb-1-s (192.168.56.160)' can't be established.
ED25519 key fingerprint is SHA256:3tGmlNux80t5hktdbDNbiazkT3KSeUMIrWHs3Xv7T/c.
This key is not known by any other names
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added 'mongodb-1-s' (ED25519) to the list of known hosts.
mongodb@mongodb-1-s's password:
keyfile                                                                                                                                                    100% 1024   341.6KB/s   00:00
*/

-- Step 127 -->> On Node 1 (Copy the KeyFile from Primary to Arbiter  Node)
mongodb@mongodb-1-p:/data/mongodb$ scp -r keyfile mongodb@mongodb-1-a:/data/mongodb
/*
The authenticity of host 'mongodb-1-a (192.168.56.161)' can't be established.
ED25519 key fingerprint is SHA256:f1Mvb7yw4WPMgOaudGwbDrXVMXAUhgqnSfI51nt6vRQ.
This key is not known by any other names
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added 'mongodb-1-a' (ED25519) to the list of known hosts.
mongodb@mongodb-1-a's password:
keyfile                                                                                                                                                    100% 1024   747.8KB/s   00:00
*/

-- Step 128 -->> On Node 2 (Verify the KeyFile on Secondary Node)
mongodb@mongodb-1-s:~$ cd /data/mongodb/

-- Step 129 -->> On Node 2 (Verify the KeyFile on Secondary Node)
mongodb@mongodb-1-s:/data/mongodb$ ll | grep keyfile
/*
-r--------. 1 mongodb mongodb  1024 Mar 12 07:53 keyfile
*/

-- Step 130 -->> On Node 3 (Verify the KeyFile on Arbiter Node)
mongodb@mongodb-1-a:~$ cd /data/mongodb/

-- Step 131 -->> On Node 3 (Verify the KeyFile on Arbiter Node)
mongodb@mongodb-1-a:/data/mongodb$ ll | grep keyfile
/*
-r--------. 1 mongodb mongodb  1024 Mar 12 07:55 keyfile
*/

-- Step 132 -->> On All Nodes (Add the KeyFile on Each Nodes)
mongodb@mongodb-1-p/mongodb-1-s/mongodb-1-a:/data/mongodb$ sudo vi /etc/mongod.conf
/*
#security:
security:
  authorization: enabled
  keyFile: /data/mongodb/keyfile
*/

-- Step 133 -->> On All Nodes (Restart the MongoDB on Each Nodes)
mongodb@mongodb-1-p/mongodb-1-s/mongodb-1-a:~$ sudo systemctl restart mongod

-- Step 134 -->> On All Nodes (Verify the MongoDB Status on Each Nodes)
mongodb@mongodb-1-p/mongodb-1-s/mongodb-1-a:~$ sudo systemctl status mongod
/*
● mongod.service - MongoDB Database Server
     Loaded: loaded (/lib/systemd/system/mongod.service; enabled; vendor preset: enabled)
     Active: active (running) since Tue 2024-03-12 08:00:20 UTC; 11s ago
       Docs: https://docs.mongodb.org/manual
   Main PID: 2888 (mongod)
     Memory: 174.7M
        CPU: 1.965s
     CGroup: /system.slice/mongod.service
             └─2888 /usr/bin/mongod --config /etc/mongod.conf

Mar 12 08:00:20 mongodb-1-p.unidev39.org.np systemd[1]: Started MongoDB Database Server.
Mar 12 08:00:20 mongodb-1-p.unidev39.org.np mongod[2888]: {"t":{"$date":"2024-03-12T08:00:20.785Z"},"s":"I",  "c":"CONTROL",  "id":7484500, "ctx":"main","msg":"Environment variable MONGODB>
*/

-- Step 135 -->> On Node 1 (Configure the Primary Node for Secondary Replica Sets)
mongodb@mongodb-1-p:~$ mongosh --host 192.168.56.159  --port 27017 -u admin -p P#ssw0rd --authenticationDatabase admin
/*
Current Mongosh Log ID: 65f00c1715b5ae601afb8c81
Connecting to:          mongodb://<credentials>@192.168.56.159:27017/?directConnection=true&authSource=admin&appName=mongosh+2.1.5
Using MongoDB:          7.0.6
Using Mongosh:          2.1.5

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

test> db.version()
7.0.6

test> show dbs
MongoServerError[NotPrimaryOrSecondary]: node is not in primary or recovering state

test> use admin
switched to db admin

admin> db
admin

admin> db.auth('admin','P#ssw0rd');
{ ok: 1 }

admin> rs.initiate(
...     {
...        _id: "rs0",
...        version: 1,
...        members: [
...           { _id: 0, host : "mongodb-1-p:27017" }
...        ]
...     }
...  )
{ ok: 1 }

rs0 [direct: other] admin> rs.add("mongodb-1-s:27017");
{
  ok: 1,
  '$clusterTime': {
    clusterTime: Timestamp({ t: 1710230674, i: 1 }),
    signature: {
      hash: Binary.createFromBase64('z8eZehdVFHsC8akz4GnVGwZmmc4=', 0),
      keyId: Long('7345384714661789702')
    }
  },
  operationTime: Timestamp({ t: 1710230674, i: 1 })
}

rs0 [direct: primary] admin> quit()
*/

-- Step 136 -->> On Node 1 (Verify the Primary Node)
mongodb@mongodb-1-p:~$ mongosh --host 192.168.56.159  --port 27017 -u admin -p P#ssw0rd --authenticationDatabase admin
/*
Current Mongosh Log ID: 65f00d1c0fe173e75f081a1d
Connecting to:          mongodb://<credentials>@192.168.56.159:27017/?directConnection=true&authSource=admin&appName=mongosh+2.1.5
Using MongoDB:          7.0.6
Using Mongosh:          2.1.5

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

rs0 [direct: primary] test> show dbs
admin   172.00 KiB
config  176.00 KiB
local   436.00 KiB

rs0 [direct: primary] test> use admin
switched to db admin

rs0 [direct: primary] admin> db.version()
7.0.6

rs0 [direct: primary] admin> rs.status()
{
  set: 'rs0',
  date: ISODate('2024-03-12T08:07:24.781Z'),
  myState: 1,
  term: Long('1'),
  syncSourceHost: '',
  syncSourceId: -1,
  heartbeatIntervalMillis: Long('2000'),
  majorityVoteCount: 2,
  writeMajorityCount: 2,
  votingMembersCount: 2,
  writableVotingMembersCount: 2,
  optimes: {
    lastCommittedOpTime: { ts: Timestamp({ t: 1710230841, i: 1 }), t: Long('1') },
    lastCommittedWallTime: ISODate('2024-03-12T08:07:21.771Z'),
    readConcernMajorityOpTime: { ts: Timestamp({ t: 1710230841, i: 1 }), t: Long('1') },
    appliedOpTime: { ts: Timestamp({ t: 1710230841, i: 1 }), t: Long('1') },
    durableOpTime: { ts: Timestamp({ t: 1710230841, i: 1 }), t: Long('1') },
    lastAppliedWallTime: ISODate('2024-03-12T08:07:21.771Z'),
    lastDurableWallTime: ISODate('2024-03-12T08:07:21.771Z')
  },
  lastStableRecoveryTimestamp: Timestamp({ t: 1710230821, i: 1 }),
  electionCandidateMetrics: {
    lastElectionReason: 'electionTimeout',
    lastElectionDate: ISODate('2024-03-12T08:04:11.677Z'),
    electionTerm: Long('1'),
    lastCommittedOpTimeAtElection: { ts: Timestamp({ t: 1710230651, i: 1 }), t: Long('-1') },
    lastSeenOpTimeAtElection: { ts: Timestamp({ t: 1710230651, i: 1 }), t: Long('-1') },
    numVotesNeeded: 1,
    priorityAtElection: 1,
    electionTimeoutMillis: Long('10000'),
    newTermStartDate: ISODate('2024-03-12T08:04:11.713Z'),
    wMajorityWriteAvailabilityDate: ISODate('2024-03-12T08:04:11.737Z')
  },
  members: [
    {
      _id: 0,
      name: 'mongodb-1-p:27017',
      health: 1,
      state: 1,
      stateStr: 'PRIMARY',
      uptime: 424,
      optime: { ts: Timestamp({ t: 1710230841, i: 1 }), t: Long('1') },
      optimeDate: ISODate('2024-03-12T08:07:21.000Z'),
      lastAppliedWallTime: ISODate('2024-03-12T08:07:21.771Z'),
      lastDurableWallTime: ISODate('2024-03-12T08:07:21.771Z'),
      syncSourceHost: '',
      syncSourceId: -1,
      infoMessage: '',
      electionTime: Timestamp({ t: 1710230651, i: 2 }),
      electionDate: ISODate('2024-03-12T08:04:11.000Z'),
      configVersion: 3,
      configTerm: 1,
      self: true,
      lastHeartbeatMessage: ''
    },
    {
      _id: 1,
      name: 'mongodb-1-s:27017',
      health: 1,
      state: 2,
      stateStr: 'SECONDARY',
      uptime: 170,
      optime: { ts: Timestamp({ t: 1710230841, i: 1 }), t: Long('1') },
      optimeDurable: { ts: Timestamp({ t: 1710230841, i: 1 }), t: Long('1') },
      optimeDate: ISODate('2024-03-12T08:07:21.000Z'),
      optimeDurableDate: ISODate('2024-03-12T08:07:21.000Z'),
      lastAppliedWallTime: ISODate('2024-03-12T08:07:21.771Z'),
      lastDurableWallTime: ISODate('2024-03-12T08:07:21.771Z'),
      lastHeartbeat: ISODate('2024-03-12T08:07:23.197Z'),
      lastHeartbeatRecv: ISODate('2024-03-12T08:07:23.695Z'),
      pingMs: Long('1'),
      lastHeartbeatMessage: '',
      syncSourceHost: 'mongodb-1-p:27017',
      syncSourceId: 0,
      infoMessage: '',
      configVersion: 3,
      configTerm: 1
    }
  ],
  ok: 1,
  '$clusterTime': {
    clusterTime: Timestamp({ t: 1710230841, i: 1 }),
    signature: {
      hash: Binary.createFromBase64('AmkZVh5s5J7124OeSP6t4Y4L6vE=', 0),
      keyId: Long('7345384714661789702')
    }
  },
  operationTime: Timestamp({ t: 1710230841, i: 1 })
}

rs0 [direct: primary] admin> quit()
*/

-- Step 137 -->> On Node 1 (Configure the Primary Node for Arbiter)
mongodb@mongodb-1-p:~$ mongosh --host 192.168.56.159  --port 27017 -u admin -p P#ssw0rd --authenticationDatabase admin
/*
Current Mongosh Log ID: 65f04a523e90c9d2ec64ac5d
Connecting to:          mongodb://<credentials>@192.168.56.159:27017/?directConnection=true&authSource=admin&appName=mongosh+2.1.5
Using MongoDB:          7.0.6
Using Mongosh:          2.1.5

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

rs0 [direct: primary] test> db.version()
7.0.6

rs0 [direct: primary] test> show dbs
admin   172.00 KiB
config  176.00 KiB
local   492.00 KiB

rs0 [direct: primary] test> use admin
switched to db admin

rs0 [direct: primary] admin> db
admin

rs0 [direct: primary] admin> db.getUsers()
{
  users: [
    {
      _id: 'admin.admin',
      userId: UUID('5e077bd7-d5eb-46b1-93bc-fca28beb5286'),
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
    clusterTime: Timestamp({ t: 1710246505, i: 1 }),
    signature: {
      hash: Binary.createFromBase64('9O/kWOBoictY6ewFIPHzNL9hoFo=', 0),
      keyId: Long('7345384714661789702')
    }
  },
  operationTime: Timestamp({ t: 1710246505, i: 1 })
}

rs0 [direct: primary] admin> rs.addArb("mongodb-1-a:27017");

MongoServerError[NewReplicaSetConfigurationIncompatible]: Reconfig attempted to install a config that would change the implicit default write concern. Use the setDefaultRWConcern command to set a cluster-wide write concern and try the reconfig again.

-- To fix the above issue (MongoServerError: Reconfig attempted to install a config that would change the implicit default write concern. Use the setDefaultRWConcern command to set a cluster-wide write concern and try the reconfig again.)

rs0 [direct: primary] admin> db.adminCommand({
... setDefaultRWConcern: 1,
... defaultWriteConcern: { w: 1 }
... })
{
  defaultReadConcern: { level: 'local' },
  defaultWriteConcern: { w: 1, wtimeout: 0 },
  updateOpTime: Timestamp({ t: 1710246555, i: 1 }),
  updateWallClockTime: ISODate('2024-03-12T12:29:15.903Z'),
  defaultWriteConcernSource: 'global',
  defaultReadConcernSource: 'implicit',
  localUpdateWallClockTime: ISODate('2024-03-12T12:29:15.913Z'),
  ok: 1,
  '$clusterTime': {
    clusterTime: Timestamp({ t: 1710246555, i: 3 }),
    signature: {
      hash: Binary.createFromBase64('f89F/35lipiGNzASgvP0AwOTUW4=', 0),
      keyId: Long('7345384714661789702')
    }
  },
  operationTime: Timestamp({ t: 1710246555, i: 3 })
}

rs0 [direct: primary] admin> rs.addArb("mongodb-1-a:27017");
{
  ok: 1,
  '$clusterTime': {
    clusterTime: Timestamp({ t: 1710246629, i: 1 }),
    signature: {
      hash: Binary.createFromBase64('wrhO7WY4mhHcE3G490Pro6gRycU=', 0),
      keyId: Long('7345384714661789702')
    }
  },
  operationTime: Timestamp({ t: 1710246629, i: 1 })
}

rs0 [direct: primary] admin>  rs.status()
{
  set: 'rs0',
  date: ISODate('2024-03-12T12:30:45.784Z'),
  myState: 1,
  term: Long('1'),
  syncSourceHost: '',
  syncSourceId: -1,
  heartbeatIntervalMillis: Long('2000'),
  majorityVoteCount: 2,
  writeMajorityCount: 2,
  votingMembersCount: 3,
  writableVotingMembersCount: 2,
  optimes: {
    lastCommittedOpTime: { ts: Timestamp({ t: 1710246629, i: 1 }), t: Long('1') },
    lastCommittedWallTime: ISODate('2024-03-12T12:30:29.659Z'),
    readConcernMajorityOpTime: { ts: Timestamp({ t: 1710246629, i: 1 }), t: Long('1') },
    appliedOpTime: { ts: Timestamp({ t: 1710246629, i: 1 }), t: Long('1') },
    durableOpTime: { ts: Timestamp({ t: 1710246629, i: 1 }), t: Long('1') },
    lastAppliedWallTime: ISODate('2024-03-12T12:30:29.659Z'),
    lastDurableWallTime: ISODate('2024-03-12T12:30:29.659Z')
  },
  lastStableRecoveryTimestamp: Timestamp({ t: 1710246615, i: 1 }),
  electionCandidateMetrics: {
    lastElectionReason: 'electionTimeout',
    lastElectionDate: ISODate('2024-03-12T08:04:11.677Z'),
    electionTerm: Long('1'),
    lastCommittedOpTimeAtElection: { ts: Timestamp({ t: 1710230651, i: 1 }), t: Long('-1') },
    lastSeenOpTimeAtElection: { ts: Timestamp({ t: 1710230651, i: 1 }), t: Long('-1') },
    numVotesNeeded: 1,
    priorityAtElection: 1,
    electionTimeoutMillis: Long('10000'),
    newTermStartDate: ISODate('2024-03-12T08:04:11.713Z'),
    wMajorityWriteAvailabilityDate: ISODate('2024-03-12T08:04:11.737Z')
  },
  members: [
    {
      _id: 0,
      name: 'mongodb-1-p:27017',
      health: 1,
      state: 1,
      stateStr: 'PRIMARY',
      uptime: 16225,
      optime: { ts: Timestamp({ t: 1710246629, i: 1 }), t: Long('1') },
      optimeDate: ISODate('2024-03-12T12:30:29.000Z'),
      lastAppliedWallTime: ISODate('2024-03-12T12:30:29.659Z'),
      lastDurableWallTime: ISODate('2024-03-12T12:30:29.659Z'),
      syncSourceHost: '',
      syncSourceId: -1,
      infoMessage: '',
      electionTime: Timestamp({ t: 1710230651, i: 2 }),
      electionDate: ISODate('2024-03-12T08:04:11.000Z'),
      configVersion: 4,
      configTerm: 1,
      self: true,
      lastHeartbeatMessage: ''
    },
    {
      _id: 1,
      name: 'mongodb-1-s:27017',
      health: 1,
      state: 2,
      stateStr: 'SECONDARY',
      uptime: 15971,
      optime: { ts: Timestamp({ t: 1710246629, i: 1 }), t: Long('1') },
      optimeDurable: { ts: Timestamp({ t: 1710246629, i: 1 }), t: Long('1') },
      optimeDate: ISODate('2024-03-12T12:30:29.000Z'),
      optimeDurableDate: ISODate('2024-03-12T12:30:29.000Z'),
      lastAppliedWallTime: ISODate('2024-03-12T12:30:29.659Z'),
      lastDurableWallTime: ISODate('2024-03-12T12:30:29.659Z'),
      lastHeartbeat: ISODate('2024-03-12T12:30:45.715Z'),
      lastHeartbeatRecv: ISODate('2024-03-12T12:30:45.714Z'),
      pingMs: Long('1'),
      lastHeartbeatMessage: '',
      syncSourceHost: 'mongodb-1-p:27017',
      syncSourceId: 0,
      infoMessage: '',
      configVersion: 4,
      configTerm: 1
    },
    {
      _id: 2,
      name: 'mongodb-1-a:27017',
      health: 1,
      state: 7,
      stateStr: 'ARBITER',
      uptime: 16,
      lastHeartbeat: ISODate('2024-03-12T12:30:45.714Z'),
      lastHeartbeatRecv: ISODate('2024-03-12T12:30:43.895Z'),
      pingMs: Long('0'),
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
    clusterTime: Timestamp({ t: 1710246629, i: 1 }),
    signature: {
      hash: Binary.createFromBase64('wrhO7WY4mhHcE3G490Pro6gRycU=', 0),
      keyId: Long('7345384714661789702')
    }
  },
  operationTime: Timestamp({ t: 1710246629, i: 1 })
}

rs0 [direct: primary] admin> quit()
*/

-- Step 138 -->> On Node 1 (Verify the Primary Node And Make the Primary Node High Priority)
mongodb@mongodb-1-p:~$ mongosh --host 192.168.56.159  --port 27017 -u admin -p P#ssw0rd --authenticationDatabase admin
/*
Current Mongosh Log ID: 65f04b342f1fba45de33a845
Connecting to:          mongodb://<credentials>@192.168.56.159:27017/?directConnection=true&authSource=admin&appName=mongosh+2.1.5
Using MongoDB:          7.0.6
Using Mongosh:          2.1.5

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

rs0 [direct: primary] test> show databases
admin   172.00 KiB
config  216.00 KiB
local   492.00 KiB

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
      host: 'mongodb-1-p:27017',
      arbiterOnly: false,
      buildIndexes: true,
      hidden: false,
      priority: 1,
      tags: {},
      secondaryDelaySecs: Long('0'),
      votes: 1
    },
    {
      _id: 1,
      host: 'mongodb-1-s:27017',
      arbiterOnly: false,
      buildIndexes: true,
      hidden: false,
      priority: 1,
      tags: {},
      secondaryDelaySecs: Long('0'),
      votes: 1
    },
    {
      _id: 2,
      host: 'mongodb-1-a:27017',
      arbiterOnly: true,
      buildIndexes: true,
      hidden: false,
      priority: 0,
      tags: {},
      secondaryDelaySecs: Long('0'),
      votes: 1
    }
  ],
  protocolVersion: Long('1'),
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
    replicaSetId: ObjectId('65f00c7b3d67bb5378f096c9')
  }
}

rs0 [direct: primary] admin> rs.isMaster()
{
  topologyVersion: {
    processId: ObjectId('65f00b943d67bb5378f09658'),
    counter: Long('9')
  },
  hosts: [ 'mongodb-1-p:27017', 'mongodb-1-s:27017' ],
  arbiters: [ 'mongodb-1-a:27017' ],
  setName: 'rs0',
  setVersion: 4,
  ismaster: true,
  secondary: false,
  primary: 'mongodb-1-p:27017',
  me: 'mongodb-1-p:27017',
  electionId: ObjectId('7fffffff0000000000000001'),
  lastWrite: {
    opTime: { ts: Timestamp({ t: 1710246765, i: 1 }), t: Long('1') },
    lastWriteDate: ISODate('2024-03-12T12:32:45.000Z'),
    majorityOpTime: { ts: Timestamp({ t: 1710246765, i: 1 }), t: Long('1') },
    majorityWriteDate: ISODate('2024-03-12T12:32:45.000Z')
  },
  maxBsonObjectSize: 16777216,
  maxMessageSizeBytes: 48000000,
  maxWriteBatchSize: 100000,
  localTime: ISODate('2024-03-12T12:32:46.878Z'),
  logicalSessionTimeoutMinutes: 30,
  connectionId: 48,
  minWireVersion: 0,
  maxWireVersion: 21,
  readOnly: false,
  ok: 1,
  '$clusterTime': {
    clusterTime: Timestamp({ t: 1710246765, i: 1 }),
    signature: {
      hash: Binary.createFromBase64('aqsHGD4Fqdla3OJz6EmotU1NFpI=', 0),
      keyId: Long('7345384714661789702')
    }
  },
  operationTime: Timestamp({ t: 1710246765, i: 1 }),
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
      host: 'mongodb-1-p:27017',
      arbiterOnly: false,
      buildIndexes: true,
      hidden: false,
      priority: 1,
      tags: {},
      secondaryDelaySecs: Long('0'),
      votes: 1
    },
    {
      _id: 1,
      host: 'mongodb-1-s:27017',
      arbiterOnly: false,
      buildIndexes: true,
      hidden: false,
      priority: 1,
      tags: {},
      secondaryDelaySecs: Long('0'),
      votes: 1
    },
    {
      _id: 2,
      host: 'mongodb-1-a:27017',
      arbiterOnly: true,
      buildIndexes: true,
      hidden: false,
      priority: 0,
      tags: {},
      secondaryDelaySecs: Long('0'),
      votes: 1
    }
  ],
  protocolVersion: Long('1'),
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
    replicaSetId: ObjectId('65f00c7b3d67bb5378f096c9')
  }
}

-- Step B - To make it High Primary Always (By chaging the priority => 10)

rs0 [direct: primary] admin> cfg.members[0].priority = 10
10

rs0 [direct: primary] admin> rs.reconfig(cfg)
{
  ok: 1,
  '$clusterTime': {
    clusterTime: Timestamp({ t: 1710246902, i: 1 }),
    signature: {
      hash: Binary.createFromBase64('Z+oXr0aFEtl7PV77GqpWRiujsj0=', 0),
      keyId: Long('7345384714661789702')
    }
  },
  operationTime: Timestamp({ t: 1710246902, i: 1 })
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
      host: 'mongodb-1-p:27017',
      arbiterOnly: false,
      buildIndexes: true,
      hidden: false,
      priority: 10,
      tags: {},
      secondaryDelaySecs: Long('0'),
      votes: 1
    },
    {
      _id: 1,
      host: 'mongodb-1-s:27017',
      arbiterOnly: false,
      buildIndexes: true,
      hidden: false,
      priority: 1,
      tags: {},
      secondaryDelaySecs: Long('0'),
      votes: 1
    },
    {
      _id: 2,
      host: 'mongodb-1-a:27017',
      arbiterOnly: true,
      buildIndexes: true,
      hidden: false,
      priority: 0,
      tags: {},
      secondaryDelaySecs: Long('0'),
      votes: 1
    }
  ],
  protocolVersion: Long('1'),
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
    replicaSetId: ObjectId('65f00c7b3d67bb5378f096c9')
  }
}

rs0 [direct: primary] admin> rs.isMaster()
{
  topologyVersion: {
    processId: ObjectId('65f00b943d67bb5378f09658'),
    counter: Long('10')
  },
  hosts: [ 'mongodb-1-p:27017', 'mongodb-1-s:27017' ],
  arbiters: [ 'mongodb-1-a:27017' ],
  setName: 'rs0',
  setVersion: 5,
  ismaster: true,
  secondary: false,
  primary: 'mongodb-1-p:27017',
  me: 'mongodb-1-p:27017',
  electionId: ObjectId('7fffffff0000000000000001'),
  lastWrite: {
    opTime: { ts: Timestamp({ t: 1710247016, i: 1 }), t: Long('1') },
    lastWriteDate: ISODate('2024-03-12T12:36:56.000Z'),
    majorityOpTime: { ts: Timestamp({ t: 1710247016, i: 1 }), t: Long('1') },
    majorityWriteDate: ISODate('2024-03-12T12:36:56.000Z')
  },
  maxBsonObjectSize: 16777216,
  maxMessageSizeBytes: 48000000,
  maxWriteBatchSize: 100000,
  localTime: ISODate('2024-03-12T12:36:57.228Z'),
  logicalSessionTimeoutMinutes: 30,
  connectionId: 48,
  minWireVersion: 0,
  maxWireVersion: 21,
  readOnly: false,
  ok: 1,
  '$clusterTime': {
    clusterTime: Timestamp({ t: 1710247016, i: 1 }),
    signature: {
      hash: Binary.createFromBase64('JaadoklOLE74bkR5bIPlwmVVbhE=', 0),
      keyId: Long('7345384714661789702')
    }
  },
  operationTime: Timestamp({ t: 1710247016, i: 1 }),
  isWritablePrimary: true
}

rs0 [direct: primary] admin> quit()
*/

-- Step 139 -->> On Node 2 (Verify the Secondary Node)
mongodb@mongodb-1-s:~$ mongosh --host 192.168.56.160 --port 27017 -u admin -p P#ssw0rd --authenticationDatabase admin
/*
Current Mongosh Log ID: 65f04cbcb376bda1aed4026c
Connecting to:          mongodb://<credentials>@192.168.56.160:27017/?directConnection=true&authSource=admin&appName=mongosh+2.1.5
Using MongoDB:          7.0.6
Using Mongosh:          2.1.5

For mongosh info see: https://docs.mongodb.com/mongodb-shell/


To help improve our products, anonymous usage data is collected and sent to MongoDB periodically (https://www.mongodb.com/legal/privacy-policy).
You can opt-out by running the disableTelemetry() command.

rs0 [direct: secondary] test> show dbs
admin   140.00 KiB
config  316.00 KiB
local   492.00 KiB

rs0 [direct: secondary] test> use admin
switched to db admin

rs0 [direct: secondary] admin> db
admin

rs0 [direct: secondary] admin> rs.isMaster()
{
  topologyVersion: {
    processId: ObjectId('65f00bd4010c7b9e7b32a2d3'),
    counter: Long('6')
  },
  hosts: [ 'mongodb-1-p:27017', 'mongodb-1-s:27017' ],
  arbiters: [ 'mongodb-1-a:27017' ],
  setName: 'rs0',
  setVersion: 5,
  ismaster: false,
  secondary: true,
  primary: 'mongodb-1-p:27017',
  me: 'mongodb-1-s:27017',
  lastWrite: {
    opTime: { ts: Timestamp({ t: 1710247116, i: 1 }), t: Long('1') },
    lastWriteDate: ISODate('2024-03-12T12:38:36.000Z'),
    majorityOpTime: { ts: Timestamp({ t: 1710247116, i: 1 }), t: Long('1') },
    majorityWriteDate: ISODate('2024-03-12T12:38:36.000Z')
  },
  maxBsonObjectSize: 16777216,
  maxMessageSizeBytes: 48000000,
  maxWriteBatchSize: 100000,
  localTime: ISODate('2024-03-12T12:38:43.686Z'),
  logicalSessionTimeoutMinutes: 30,
  connectionId: 32,
  minWireVersion: 0,
  maxWireVersion: 21,
  readOnly: false,
  ok: 1,
  '$clusterTime': {
    clusterTime: Timestamp({ t: 1710247116, i: 1 }),
    signature: {
      hash: Binary.createFromBase64('L3Fiw8ZeJ+ySu7voKze6vUcS1Uk=', 0),
      keyId: Long('7345384714661789702')
    }
  },
  operationTime: Timestamp({ t: 1710247116, i: 1 }),
  isWritablePrimary: false
}

rs0 [direct: secondary] admin> rs.status()
{
  set: 'rs0',
  date: ISODate('2024-03-12T12:39:35.163Z'),
  myState: 2,
  term: Long('1'),
  syncSourceHost: 'mongodb-1-p:27017',
  syncSourceId: 0,
  heartbeatIntervalMillis: Long('2000'),
  majorityVoteCount: 2,
  writeMajorityCount: 2,
  votingMembersCount: 3,
  writableVotingMembersCount: 2,
  optimes: {
    lastCommittedOpTime: { ts: Timestamp({ t: 1710247166, i: 1 }), t: Long('1') },
    lastCommittedWallTime: ISODate('2024-03-12T12:39:26.052Z'),
    readConcernMajorityOpTime: { ts: Timestamp({ t: 1710247166, i: 1 }), t: Long('1') },
    appliedOpTime: { ts: Timestamp({ t: 1710247166, i: 1 }), t: Long('1') },
    durableOpTime: { ts: Timestamp({ t: 1710247166, i: 1 }), t: Long('1') },
    lastAppliedWallTime: ISODate('2024-03-12T12:39:26.052Z'),
    lastDurableWallTime: ISODate('2024-03-12T12:39:26.052Z')
  },
  lastStableRecoveryTimestamp: Timestamp({ t: 1710247116, i: 1 }),
  members: [
    {
      _id: 0,
      name: 'mongodb-1-p:27017',
      health: 1,
      state: 1,
      stateStr: 'PRIMARY',
      uptime: 16500,
      optime: { ts: Timestamp({ t: 1710247166, i: 1 }), t: Long('1') },
      optimeDurable: { ts: Timestamp({ t: 1710247166, i: 1 }), t: Long('1') },
      optimeDate: ISODate('2024-03-12T12:39:26.000Z'),
      optimeDurableDate: ISODate('2024-03-12T12:39:26.000Z'),
      lastAppliedWallTime: ISODate('2024-03-12T12:39:26.052Z'),
      lastDurableWallTime: ISODate('2024-03-12T12:39:26.052Z'),
      lastHeartbeat: ISODate('2024-03-12T12:39:33.558Z'),
      lastHeartbeatRecv: ISODate('2024-03-12T12:39:33.705Z'),
      pingMs: Long('1'),
      lastHeartbeatMessage: '',
      syncSourceHost: '',
      syncSourceId: -1,
      infoMessage: '',
      electionTime: Timestamp({ t: 1710230651, i: 2 }),
      electionDate: ISODate('2024-03-12T08:04:11.000Z'),
      configVersion: 5,
      configTerm: 1
    },
    {
      _id: 1,
      name: 'mongodb-1-s:27017',
      health: 1,
      state: 2,
      stateStr: 'SECONDARY',
      uptime: 16691,
      optime: { ts: Timestamp({ t: 1710247166, i: 1 }), t: Long('1') },
      optimeDate: ISODate('2024-03-12T12:39:26.000Z'),
      lastAppliedWallTime: ISODate('2024-03-12T12:39:26.052Z'),
      lastDurableWallTime: ISODate('2024-03-12T12:39:26.052Z'),
      syncSourceHost: 'mongodb-1-p:27017',
      syncSourceId: 0,
      infoMessage: '',
      configVersion: 5,
      configTerm: 1,
      self: true,
      lastHeartbeatMessage: ''
    },
    {
      _id: 2,
      name: 'mongodb-1-a:27017',
      health: 1,
      state: 7,
      stateStr: 'ARBITER',
      uptime: 545,
      lastHeartbeat: ISODate('2024-03-12T12:39:33.558Z'),
      lastHeartbeatRecv: ISODate('2024-03-12T12:39:33.468Z'),
      pingMs: Long('1'),
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
    clusterTime: Timestamp({ t: 1710247166, i: 1 }),
    signature: {
      hash: Binary.createFromBase64('YyUcwuRgtmxh2BQRjegSQ+Tw6gA=', 0),
      keyId: Long('7345384714661789702')
    }
  },
  operationTime: Timestamp({ t: 1710247166, i: 1 })
}

rs0 [direct: secondary] admin> rs.conf()
{
  _id: 'rs0',
  version: 5,
  term: 1,
  members: [
    {
      _id: 0,
      host: 'mongodb-1-p:27017',
      arbiterOnly: false,
      buildIndexes: true,
      hidden: false,
      priority: 10,
      tags: {},
      secondaryDelaySecs: Long('0'),
      votes: 1
    },
    {
      _id: 1,
      host: 'mongodb-1-s:27017',
      arbiterOnly: false,
      buildIndexes: true,
      hidden: false,
      priority: 1,
      tags: {},
      secondaryDelaySecs: Long('0'),
      votes: 1
    },
    {
      _id: 2,
      host: 'mongodb-1-a:27017',
      arbiterOnly: true,
      buildIndexes: true,
      hidden: false,
      priority: 0,
      tags: {},
      secondaryDelaySecs: Long('0'),
      votes: 1
    }
  ],
  protocolVersion: Long('1'),
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
    replicaSetId: ObjectId('65f00c7b3d67bb5378f096c9')
  }
}

rs0 [direct: secondary] admin> quit()
*/

-- Step 140 -->> On Node 3 (Verify the Arbiter Node)
mongodb@mongodb-1-a:~$ mongo --host 192.168.56.161 --port 27017 -u admin -p P#ssw0rd --authenticationDatabase admin
/*
Current Mongosh Log ID: 65f04d4a6e232774db0dc18f
Connecting to:          mongodb://<credentials>@192.168.56.161:27017/?directConnection=true&authSource=admin&appName=mongosh+2.1.5
Using MongoDB:          7.0.6
Using Mongosh:          2.1.5

For mongosh info see: https://docs.mongodb.com/mongodb-shell/


To help improve our products, anonymous usage data is collected and sent to MongoDB periodically (https://www.mongodb.com/legal/privacy-policy).
You can opt-out by running the disableTelemetry() command.

rs0 [direct: arbiter] test> show dbs
MongoServerError[Unauthorized]: Command listDatabases requires authentication

rs0 [direct: arbiter] test> use admin
switched to db admin

rs0 [direct: arbiter] admin> db
admin

rs0 [direct: arbiter] admin> show dbs
MongoServerError[Unauthorized]: Command listDatabases requires authentication

rs0 [direct: arbiter] admin> rs.isMaster()
{
  topologyVersion: {
    processId: ObjectId('65f00be3bfde8afa7394ab70'),
    counter: Long('2')
  },
  hosts: [ 'mongodb-1-p:27017', 'mongodb-1-s:27017' ],
  arbiters: [ 'mongodb-1-a:27017' ],
  setName: 'rs0',
  setVersion: 5,
  ismaster: false,
  secondary: false,
  primary: 'mongodb-1-p:27017',
  arbiterOnly: true,
  me: 'mongodb-1-a:27017',
  lastWrite: {
    opTime: { ts: Timestamp({ t: 1710247266, i: 1 }), t: Long('1') },
    lastWriteDate: ISODate('2024-03-12T12:41:06.000Z'),
    majorityOpTime: { ts: Timestamp({ t: 1710247266, i: 1 }), t: Long('1') },
    majorityWriteDate: ISODate('2024-03-12T12:41:06.000Z')
  },
  maxBsonObjectSize: 16777216,
  maxMessageSizeBytes: 48000000,
  maxWriteBatchSize: 100000,
  localTime: ISODate('2024-03-12T12:41:15.979Z'),
  logicalSessionTimeoutMinutes: 30,
  connectionId: 19,
  minWireVersion: 0,
  maxWireVersion: 21,
  readOnly: false,
  ok: 1,
  isWritablePrimary: false
}

rs0 [direct: arbiter] admin> rs.status()
MongoServerError[Unauthorized]: Command replSetGetStatus requires authentication

rs0 [direct: arbiter] admin> quit()
*/

-- Step 141 -->> On Node 1 (Verify the Primary and Secondary Replication)
mongodb@mongodb-1-p:~$ mongosh --host 192.168.56.159  --port 27017 -u admin -p P#ssw0rd --authenticationDatabase admin
/*
Current Mongosh Log ID: 65f04e3f2f92a080f16c833a
Connecting to:          mongodb://<credentials>@192.168.56.159:27017/?directConnection=true&authSource=admin&appName=mongosh+2.1.5
Using MongoDB:          7.0.6
Using Mongosh:          2.1.5

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

rs0 [direct: primary] test> show dbs
admin   172.00 KiB
config  252.00 KiB
local   500.00 KiB

rs0 [direct: primary] test> use admin
switched to db admin

rs0 [direct: primary] admin> db
admin

rs0 [direct: primary] admin> db.getUsers()
{
  users: [
    {
      _id: 'admin.admin',
      userId: UUID('5e077bd7-d5eb-46b1-93bc-fca28beb5286'),
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
    clusterTime: Timestamp({ t: 1710247496, i: 1 }),
    signature: {
      hash: Binary.createFromBase64('RJqxt9SxHVnlokGklgLrHnoMvAc=', 0),
      keyId: Long('7345384714661789702')
    }
  },
  operationTime: Timestamp({ t: 1710247496, i: 1 })
}

rs0 [direct: primary] admin> use devesh
switched to db devesh

rs0 [direct: primary] devesh> db
devesh

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
    clusterTime: Timestamp({ t: 1710247625, i: 1 }),
    signature: {
      hash: Binary.createFromBase64('Eo2gHpqtPgujIIjc8BHxmrR4W74=', 0),
      keyId: Long('7345384714661789702')
    }
  },
  operationTime: Timestamp({ t: 1710247625, i: 1 })
}

rs0 [direct: primary] devesh> db.auth("devesh","P@ssw0rD")
{ ok: 1 }

rs0 [direct: primary] devesh> db.createCollection('tbl_cib')
{ ok: 1 }

rs0 [direct: primary] devesh> show collections
tbl_cib

rs0 [direct: primary] devesh> db.getCollectionNames()
[ 'tbl_cib' ]

rs0 [direct: primary] devesh> quit()
*/

-- Step 142 -->> On Node 1 (Verify the Primary and Secondary Replication)
mongodb@mongodb-1-p:~$ mongo --host 192.168.56.159  --port 27017 -u devesh -p P@ssw0rD --authenticationDatabase devesh
/*
Current Mongosh Log ID: 65f04f20d42e4bfe8ee925f8
Connecting to:          mongodb://<credentials>@192.168.56.159:27017/?directConnection=true&authSource=devesh&appName=mongosh+2.1.5
Using MongoDB:          7.0.6
Using Mongosh:          2.1.5

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

rs0 [direct: primary] test> show dbs
devesh  8.00 KiB

rs0 [direct: primary] test> use devesh
switched to db devesh

rs0 [direct: primary] devesh> db.getCollectionNames()
[ 'tbl_cib' ]

rs0 [direct: primary] devesh> quit()
*/

-- Step 143 -->> On Node 2 (Verify the Primary and Secondary Replication)
mongodb@mongodb-1-s:~$ mongo --host 192.168.56.160  --port 27017 -u devesh -p P@ssw0rD --authenticationDatabase devesh
/*
Current Mongosh Log ID: 65f04f61f2cee351adbc1d79
Connecting to:          mongodb://<credentials>@192.168.56.160:27017/?directConnection=true&authSource=devesh&appName=mongosh+2.1.5
Using MongoDB:          7.0.6
Using Mongosh:          2.1.5

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
MongoServerError[NotPrimaryNoSecondaryOk]: not primary - consider using db.getMongo().setReadPref() or readPreference in the connection string

rs0 [direct: secondary] devesh> quit()
*/


-- Failed Over Test
-- Step 144 -->> On Node 1 (Stop the MongoDB Serivice at Primary Node i.e. Node 1)
mongodb@mongodb-1-p:~$ sudo systemctl stop mongod.service

-- Step 145 -->> On Node 1 (Verify the MongoDB Serivice at Primary Node i.e. Node 1)
mongodb@mongodb-1-p:~$ sudo systemctl status mongod.service
/*
○ mongod.service - MongoDB Database Server
     Loaded: loaded (/lib/systemd/system/mongod.service; enabled; vendor preset: enabled)
     Active: inactive (dead) since Tue 2024-03-12 12:56:50 UTC; 9s ago
       Docs: https://docs.mongodb.org/manual
    Process: 2888 ExecStart=/usr/bin/mongod --config /etc/mongod.conf (code=exited, status=0>
   Main PID: 2888 (code=exited, status=0/SUCCESS)
        CPU: 7min 35.060s

Mar 12 08:00:20 mongodb-1-p.unidev39.org.np systemd[1]: Started MongoDB Database Server.
Mar 12 08:00:20 mongodb-1-p.unidev39.org.np mongod[2888]: {"t":{"$date":"2024-03-12T08:00:20>
Mar 12 12:56:34 mongodb-1-p.unidev39.org.np systemd[1]: Stopping MongoDB Database Server...
Mar 12 12:56:50 mongodb-1-p.unidev39.org.np systemd[1]: mongod.service: Deactivated successf>
Mar 12 12:56:50 mongodb-1-p.unidev39.org.np systemd[1]: Stopped MongoDB Database Server.
Mar 12 12:56:50 mongodb-1-p.unidev39.org.np systemd[1]: mongod.service: Consumed 7min 35.060>
*/
.
-- Step 146 -->> On Node 2 (Verify the MongoDB Serivice at Secondary Node i.e. Node 2)
mongodb@mongodb-1-s:~$ sudo systemctl status mongod.service
/*
● mongod.service - MongoDB Database Server
     Loaded: loaded (/lib/systemd/system/mongod.service; enabled; vendor preset: enabled)
     Active: active (running) since Tue 2024-03-12 08:01:24 UTC; 4h 57min ago
       Docs: https://docs.mongodb.org/manual
   Main PID: 2888 (mongod)
     Memory: 198.6M
        CPU: 8min 8.324s
     CGroup: /system.slice/mongod.service
             └─2888 /usr/bin/mongod --config /etc/mongod.conf

Mar 12 08:01:24 mongodb-1-s.unidev39.org.np systemd[1]: Started MongoDB Database Server.
Mar 12 08:01:24 mongodb-1-s.unidev39.org.np mongod[2888]: {"t":{"$date":"2024-03-12T08:01:24.161Z"},"s":"I",  "c":"CONTROL",  "id":7484500, "ctx":"main","msg":"Environment variable MONGODB>
*/

-- Step 147 -->> On Node 2 (Verify the MongoDB Serivice at Secondary Node i.e. Node 2)
mongodb@mongodb-1-s:~$ mongosh --host 192.168.56.160 --port 27017 -u admin -p P#ssw0rd --authenticationDatabase admin
/*
Current Mongosh Log ID: 65f051a7c33b5c98f57d7812
Connecting to:          mongodb://<credentials>@192.168.56.160:27017/?directConnection=true&authSource=admin&appName=mongosh+2.1.5
Using MongoDB:          7.0.6
Using Mongosh:          2.1.5

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

rs0 [direct: primary] test> show dbs
admin   188.00 KiB
config  296.00 KiB
devesh    8.00 KiB
local   516.00 KiB

rs0 [direct: primary] test> use admin
switched to db admin

rs0 [direct: primary] admin> db
admin

rs0 [direct: primary] admin> rs.isMaster()
{
  topologyVersion: {
    processId: ObjectId('65f00bd4010c7b9e7b32a2d3'),
    counter: Long('9')
  },
  hosts: [ 'mongodb-1-p:27017', 'mongodb-1-s:27017' ],
  arbiters: [ 'mongodb-1-a:27017' ],
  setName: 'rs0',
  setVersion: 5,
  ismaster: true,
  secondary: false,
  primary: 'mongodb-1-s:27017',
  me: 'mongodb-1-s:27017',
  electionId: ObjectId('7fffffff0000000000000003'),
  lastWrite: {
    opTime: { ts: Timestamp({ t: 1710248375, i: 1 }), t: Long('3') },
    lastWriteDate: ISODate('2024-03-12T12:59:35.000Z'),
    majorityOpTime: { ts: Timestamp({ t: 1710248205, i: 2 }), t: Long('3') },
    majorityWriteDate: ISODate('2024-03-12T12:56:45.000Z')
  },
  maxBsonObjectSize: 16777216,
  maxMessageSizeBytes: 48000000,
  maxWriteBatchSize: 100000,
  localTime: ISODate('2024-03-12T12:59:36.838Z'),
  logicalSessionTimeoutMinutes: 30,
  connectionId: 56,
  minWireVersion: 0,
  maxWireVersion: 21,
  readOnly: false,
  ok: 1,
  '$clusterTime': {
    clusterTime: Timestamp({ t: 1710248375, i: 1 }),
    signature: {
      hash: Binary.createFromBase64('4rvBCuu0j/xzFwjEbD7GrUtDoBo=', 0),
      keyId: Long('7345384714661789702')
    }
  },
  operationTime: Timestamp({ t: 1710248375, i: 1 }),
  isWritablePrimary: true
}

rs0 [direct: primary] admin> rs.status()
{
  set: 'rs0',
  date: ISODate('2024-03-12T13:00:26.216Z'),
  myState: 1,
  term: Long('3'),
  syncSourceHost: '',
  syncSourceId: -1,
  heartbeatIntervalMillis: Long('2000'),
  majorityVoteCount: 2,
  writeMajorityCount: 2,
  votingMembersCount: 3,
  writableVotingMembersCount: 2,
  optimes: {
    lastCommittedOpTime: { ts: Timestamp({ t: 1710248205, i: 2 }), t: Long('3') },
    lastCommittedWallTime: ISODate('2024-03-12T12:56:45.387Z'),
    readConcernMajorityOpTime: { ts: Timestamp({ t: 1710248205, i: 2 }), t: Long('3') },
    appliedOpTime: { ts: Timestamp({ t: 1710248425, i: 1 }), t: Long('3') },
    durableOpTime: { ts: Timestamp({ t: 1710248425, i: 1 }), t: Long('3') },
    lastAppliedWallTime: ISODate('2024-03-12T13:00:25.460Z'),
    lastDurableWallTime: ISODate('2024-03-12T13:00:25.460Z')
  },
  lastStableRecoveryTimestamp: Timestamp({ t: 1710248205, i: 2 }),
  electionCandidateMetrics: {
    lastElectionReason: 'electionTimeout',
    lastElectionDate: ISODate('2024-03-12T12:56:45.361Z'),
    electionTerm: Long('3'),
    lastCommittedOpTimeAtElection: { ts: Timestamp({ t: 1710248186, i: 1 }), t: Long('1') },
    lastSeenOpTimeAtElection: { ts: Timestamp({ t: 1710248186, i: 1 }), t: Long('1') },
    numVotesNeeded: 2,
    priorityAtElection: 1,
    electionTimeoutMillis: Long('10000'),
    numCatchUpOps: Long('0'),
    newTermStartDate: ISODate('2024-03-12T12:56:45.387Z'),
    wMajorityWriteAvailabilityDate: ISODate('2024-03-12T12:56:45.438Z')
  },
  members: [
    {
      _id: 0,
      name: 'mongodb-1-p:27017',
      health: 0,
      state: 8,
      stateStr: '(not reachable/healthy)',
      uptime: 0,
      optime: { ts: Timestamp({ t: 0, i: 0 }), t: Long('-1') },
      optimeDurable: { ts: Timestamp({ t: 0, i: 0 }), t: Long('-1') },
      optimeDate: ISODate('1970-01-01T00:00:00.000Z'),
      optimeDurableDate: ISODate('1970-01-01T00:00:00.000Z'),
      lastAppliedWallTime: ISODate('2024-03-12T12:56:45.387Z'),
      lastDurableWallTime: ISODate('2024-03-12T12:56:45.387Z'),
      lastHeartbeat: ISODate('2024-03-12T13:00:24.698Z'),
      lastHeartbeatRecv: ISODate('2024-03-12T12:56:49.926Z'),
      pingMs: Long('1'),
      lastHeartbeatMessage: 'Error connecting to mongodb-1-p:27017 (192.168.56.159:27017) :: caused by :: onInvoke :: caused by :: Connection refused',
      syncSourceHost: '',
      syncSourceId: -1,
      infoMessage: '',
      configVersion: 5,
      configTerm: 3
    },
    {
      _id: 1,
      name: 'mongodb-1-s:27017',
      health: 1,
      state: 1,
      stateStr: 'PRIMARY',
      uptime: 17942,
      optime: { ts: Timestamp({ t: 1710248425, i: 1 }), t: Long('3') },
      optimeDate: ISODate('2024-03-12T13:00:25.000Z'),
      lastAppliedWallTime: ISODate('2024-03-12T13:00:25.460Z'),
      lastDurableWallTime: ISODate('2024-03-12T13:00:25.460Z'),
      syncSourceHost: '',
      syncSourceId: -1,
      infoMessage: '',
      electionTime: Timestamp({ t: 1710248205, i: 1 }),
      electionDate: ISODate('2024-03-12T12:56:45.000Z'),
      configVersion: 5,
      configTerm: 3,
      self: true,
      lastHeartbeatMessage: ''
    },
    {
      _id: 2,
      name: 'mongodb-1-a:27017',
      health: 1,
      state: 7,
      stateStr: 'ARBITER',
      uptime: 1796,
      lastHeartbeat: ISODate('2024-03-12T13:00:24.253Z'),
      lastHeartbeatRecv: ISODate('2024-03-12T13:00:26.116Z'),
      pingMs: Long('1'),
      lastHeartbeatMessage: '',
      syncSourceHost: '',
      syncSourceId: -1,
      infoMessage: '',
      configVersion: 5,
      configTerm: 3
    }
  ],
  ok: 1,
  '$clusterTime': {
    clusterTime: Timestamp({ t: 1710248425, i: 1 }),
    signature: {
      hash: Binary.createFromBase64('lALrqOoIlcolll/8ajLjb/B31Pw=', 0),
      keyId: Long('7345384714661789702')
    }
  },
  operationTime: Timestamp({ t: 1710248425, i: 1 })
}

rs0 [direct: primary] admin> rs.conf()
{
  _id: 'rs0',
  version: 5,
  term: 3,
  members: [
    {
      _id: 0,
      host: 'mongodb-1-p:27017',
      arbiterOnly: false,
      buildIndexes: true,
      hidden: false,
      priority: 10,
      tags: {},
      secondaryDelaySecs: Long('0'),
      votes: 1
    },
    {
      _id: 1,
      host: 'mongodb-1-s:27017',
      arbiterOnly: false,
      buildIndexes: true,
      hidden: false,
      priority: 1,
      tags: {},
      secondaryDelaySecs: Long('0'),
      votes: 1
    },
    {
      _id: 2,
      host: 'mongodb-1-a:27017',
      arbiterOnly: true,
      buildIndexes: true,
      hidden: false,
      priority: 0,
      tags: {},
      secondaryDelaySecs: Long('0'),
      votes: 1
    }
  ],
  protocolVersion: Long('1'),
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
    replicaSetId: ObjectId('65f00c7b3d67bb5378f096c9')
  }
}

rs0 [direct: primary] admin> db.getUsers()
{
  users: [
    {
      _id: 'admin.admin',
      userId: UUID('5e077bd7-d5eb-46b1-93bc-fca28beb5286'),
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
    clusterTime: Timestamp({ t: 1710248495, i: 1 }),
    signature: {
      hash: Binary.createFromBase64('a3Qux1nNDG7s/kLzuRAZlFMXs7s=', 0),
      keyId: Long('7345384714661789702')
    }
  },
  operationTime: Timestamp({ t: 1710248495, i: 1 })
}

rs0 [direct: primary] admin> use devesh
switched to db devesh

rs0 [direct: primary] devesh> db
devesh

rs0 [direct: primary] devesh> db.getCollectionNames()
[ 'tbl_cib' ]

rs0 [direct: primary] devesh> quit()

*/

-- Step 148 -->> On Node 2 (Stop the MongoDB Serivice at Secondary Node i.e. Node 2)
mongodb@mongodb-1-s:~$ sudo systemctl stop mongod.service

-- Step 149 -->> On Node 2 (Verify the MongoDB Serivice at Secondary Node i.e. Node 2)
mongodb@mongodb-1-s:~$ sudo systemctl status mongod.service
/*
○ mongod.service - MongoDB Database Server
     Loaded: loaded (/lib/systemd/system/mongod.service; enabled; vendor preset: enabled)
     Active: inactive (dead) since Tue 2024-03-12 13:04:24 UTC; 6s ago
       Docs: https://docs.mongodb.org/manual
    Process: 2888 ExecStart=/usr/bin/mongod --config /etc/mongod.conf (code=exited, status=0/SUCCESS)
   Main PID: 2888 (code=exited, status=0/SUCCESS)
        CPU: 8min 24.386s

Mar 12 08:01:24 mongodb-1-s.unidev39.org.np systemd[1]: Started MongoDB Database Server.
Mar 12 08:01:24 mongodb-1-s.unidev39.org.np mongod[2888]: {"t":{"$date":"2024-03-12T08:01:24.161Z"},"s":"I",  "c":"CONTROL",  "id":7484500, "ctx":"main","msg":"Environment variable MONGODB>
Mar 12 13:04:08 mongodb-1-s.unidev39.org.np systemd[1]: Stopping MongoDB Database Server...
Mar 12 13:04:24 mongodb-1-s.unidev39.org.np systemd[1]: mongod.service: Deactivated successfully.
Mar 12 13:04:24 mongodb-1-s.unidev39.org.np systemd[1]: Stopped MongoDB Database Server.
Mar 12 13:04:24 mongodb-1-s.unidev39.org.np systemd[1]: mongod.service: Consumed 8min 24.386s CPU time.
*/

-- Step 150 -->> On Node 3 (Verify the MongoDB Serivice at Arbiter Node i.e. Node 3)
mongodb@mongodb-1-a:~$ mongo --host 192.168.56.161 --port 27017 -u admin -p P#ssw0rd --authenticationDatabase admin
/*
Current Mongosh Log ID: 65f052f13abc3931bb702487
Connecting to:          mongodb://<credentials>@192.168.56.161:27017/?directConnection=true&authSource=admin&appName=mongosh+2.1.5
Using MongoDB:          7.0.6
Using Mongosh:          2.1.5

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

rs0 [direct: arbiter] test> use admin
switched to db admin

rs0 [direct: arbiter] admin> db
admin

rs0 [direct: arbiter] admin> show dbs
MongoServerError[Unauthorized]: Command listDatabases requires authentication

rs0 [direct: arbiter] admin> rs.isMaster()
{
  topologyVersion: {
    processId: ObjectId('65f00be3bfde8afa7394ab70'),
    counter: Long('3')
  },
  hosts: [ 'mongodb-1-p:27017', 'mongodb-1-s:27017' ],
  arbiters: [ 'mongodb-1-a:27017' ],
  setName: 'rs0',
  setVersion: 5,
  ismaster: false,
  secondary: false,
  arbiterOnly: true,
  me: 'mongodb-1-a:27017',
  lastWrite: {
    opTime: { ts: Timestamp({ t: 1710248205, i: 2 }), t: Long('3') },
    lastWriteDate: ISODate('2024-03-12T12:56:45.000Z'),
    majorityOpTime: { ts: Timestamp({ t: 1710248205, i: 2 }), t: Long('3') },
    majorityWriteDate: ISODate('2024-03-12T12:56:45.000Z')
  },
  maxBsonObjectSize: 16777216,
  maxMessageSizeBytes: 48000000,
  maxWriteBatchSize: 100000,
  localTime: ISODate('2024-03-12T13:05:15.809Z'),
  logicalSessionTimeoutMinutes: 30,
  connectionId: 70,
  minWireVersion: 0,
  maxWireVersion: 21,
  readOnly: false,
  ok: 1,
  isWritablePrimary: false
}

rs0 [direct: arbiter] admin> quit()
*/

-- Step 151 -->> On Node 1 (Start the MongoDB Serivice at Primary Node i.e. Node 1)
mongodb@mongodb-1-p:~$ sudo systemctl start mongod.service

-- Step 152 -->> On Node 1 (Verify the MongoDB Serivice at Primary Node i.e. Node 1)
mongodb@mongodb-1-p:~$ sudo systemctl status mongod.service
/*
● mongod.service - MongoDB Database Server
     Loaded: loaded (/lib/systemd/system/mongod.service; enabled; vendor preset: enabled)
     Active: active (running) since Tue 2024-03-12 13:05:54 UTC; 2s ago
       Docs: https://docs.mongodb.org/manual
   Main PID: 4606 (mongod)
     Memory: 186.2M
        CPU: 1.346s
     CGroup: /system.slice/mongod.service
             └─4606 /usr/bin/mongod --config /etc/mongod.conf

Mar 12 13:05:54 mongodb-1-p.unidev39.org.np systemd[1]: Started MongoDB Database Server.
Mar 12 13:05:54 mongodb-1-p.unidev39.org.np mongod[4606]: {"t":{"$date":"2024-03-12T13:05:54>
*/

-- Step 153 -->> On Node 1 (Verify the MongoDB Serivice at Primary Node i.e. Node 1)
mongodb@mongodb-1-p:~$ mongosh --host 192.168.56.159  --port 27017 -u admin -p P#ssw0rd --authenticationDatabase admin
/*
Current Mongosh Log ID: 65f053650ecdb6f5cd4192b0
Connecting to:          mongodb://<credentials>@192.168.56.159:27017/?directConnection=true&authSource=admin&appName=mongosh+2.1.5
Using MongoDB:          7.0.6
Using Mongosh:          2.1.5

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

rs0 [direct: primary] test> show dbs
admin   220.00 KiB
config  240.00 KiB
devesh    8.00 KiB
local   500.00 KiB

rs0 [direct: primary] test> use admin
switched to db admin

rs0 [direct: primary] admin> db
admin

rs0 [direct: primary] admin> db.getUsers()
{
  users: [
    {
      _id: 'admin.admin',
      userId: UUID('5e077bd7-d5eb-46b1-93bc-fca28beb5286'),
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
    clusterTime: Timestamp({ t: 1710248816, i: 1 }),
    signature: {
      hash: Binary.createFromBase64('18umDoZwq29exVVqjccJngj62v8=', 0),
      keyId: Long('7345384714661789702')
    }
  },
  operationTime: Timestamp({ t: 1710248816, i: 1 })
}

rs0 [direct: primary] admin> rs.isMaster()
{
  topologyVersion: {
    processId: ObjectId('65f053329f02a4565a621e58'),
    counter: Long('6')
  },
  hosts: [ 'mongodb-1-p:27017', 'mongodb-1-s:27017' ],
  arbiters: [ 'mongodb-1-a:27017' ],
  setName: 'rs0',
  setVersion: 5,
  ismaster: true,
  secondary: false,
  primary: 'mongodb-1-p:27017',
  me: 'mongodb-1-p:27017',
  electionId: ObjectId('7fffffff0000000000000004'),
  lastWrite: {
    opTime: { ts: Timestamp({ t: 1710248826, i: 1 }), t: Long('4') },
    lastWriteDate: ISODate('2024-03-12T13:07:06.000Z'),
    majorityOpTime: { ts: Timestamp({ t: 1710248205, i: 2 }), t: Long('3') },
    majorityWriteDate: ISODate('2024-03-12T12:56:45.000Z')
  },
  maxBsonObjectSize: 16777216,
  maxMessageSizeBytes: 48000000,
  maxWriteBatchSize: 100000,
  localTime: ISODate('2024-03-12T13:07:16.339Z'),
  logicalSessionTimeoutMinutes: 30,
  connectionId: 31,
  minWireVersion: 0,
  maxWireVersion: 21,
  readOnly: false,
  ok: 1,
  '$clusterTime': {
    clusterTime: Timestamp({ t: 1710248826, i: 1 }),
    signature: {
      hash: Binary.createFromBase64('pmOgwa2NCpOOnEJ0JiYKsIrqpeA=', 0),
      keyId: Long('7345384714661789702')
    }
  },
  operationTime: Timestamp({ t: 1710248826, i: 1 }),
  isWritablePrimary: true
}

rs0 [direct: primary] admin> rs.conf()
{
  _id: 'rs0',
  version: 5,
  term: 4,
  members: [
    {
      _id: 0,
      host: 'mongodb-1-p:27017',
      arbiterOnly: false,
      buildIndexes: true,
      hidden: false,
      priority: 10,
      tags: {},
      secondaryDelaySecs: Long('0'),
      votes: 1
    },
    {
      _id: 1,
      host: 'mongodb-1-s:27017',
      arbiterOnly: false,
      buildIndexes: true,
      hidden: false,
      priority: 1,
      tags: {},
      secondaryDelaySecs: Long('0'),
      votes: 1
    },
    {
      _id: 2,
      host: 'mongodb-1-a:27017',
      arbiterOnly: true,
      buildIndexes: true,
      hidden: false,
      priority: 0,
      tags: {},
      secondaryDelaySecs: Long('0'),
      votes: 1
    }
  ],
  protocolVersion: Long('1'),
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
    replicaSetId: ObjectId('65f00c7b3d67bb5378f096c9')
  }
}

rs0 [direct: primary] admin> rs.status()
{
  set: 'rs0',
  date: ISODate('2024-03-12T13:08:16.230Z'),
  myState: 1,
  term: Long('4'),
  syncSourceHost: '',
  syncSourceId: -1,
  heartbeatIntervalMillis: Long('2000'),
  majorityVoteCount: 2,
  writeMajorityCount: 2,
  votingMembersCount: 3,
  writableVotingMembersCount: 2,
  optimes: {
    lastCommittedOpTime: { ts: Timestamp({ t: 1710248205, i: 2 }), t: Long('3') },
    lastCommittedWallTime: ISODate('2024-03-12T12:56:45.387Z'),
    readConcernMajorityOpTime: { ts: Timestamp({ t: 1710248205, i: 2 }), t: Long('3') },
    appliedOpTime: { ts: Timestamp({ t: 1710248886, i: 1 }), t: Long('4') },
    durableOpTime: { ts: Timestamp({ t: 1710248886, i: 1 }), t: Long('4') },
    lastAppliedWallTime: ISODate('2024-03-12T13:08:06.398Z'),
    lastDurableWallTime: ISODate('2024-03-12T13:08:06.398Z')
  },
  lastStableRecoveryTimestamp: Timestamp({ t: 1710248205, i: 2 }),
  electionCandidateMetrics: {
    lastElectionReason: 'electionTimeout',
    lastElectionDate: ISODate('2024-03-12T13:06:06.295Z'),
    electionTerm: Long('4'),
    lastCommittedOpTimeAtElection: { ts: Timestamp({ t: 1710248205, i: 2 }), t: Long('3') },
    lastSeenOpTimeAtElection: { ts: Timestamp({ t: 1710248205, i: 2 }), t: Long('3') },
    numVotesNeeded: 2,
    priorityAtElection: 10,
    electionTimeoutMillis: Long('10000'),
    numCatchUpOps: Long('0'),
    newTermStartDate: ISODate('2024-03-12T13:06:06.357Z')
  },
  members: [
    {
      _id: 0,
      name: 'mongodb-1-p:27017',
      health: 1,
      state: 1,
      stateStr: 'PRIMARY',
      uptime: 142,
      optime: { ts: Timestamp({ t: 1710248886, i: 1 }), t: Long('4') },
      optimeDate: ISODate('2024-03-12T13:08:06.000Z'),
      lastAppliedWallTime: ISODate('2024-03-12T13:08:06.398Z'),
      lastDurableWallTime: ISODate('2024-03-12T13:08:06.398Z'),
      syncSourceHost: '',
      syncSourceId: -1,
      infoMessage: '',
      electionTime: Timestamp({ t: 1710248766, i: 1 }),
      electionDate: ISODate('2024-03-12T13:06:06.000Z'),
      configVersion: 5,
      configTerm: 4,
      self: true,
      lastHeartbeatMessage: ''
    },
    {
      _id: 1,
      name: 'mongodb-1-s:27017',
      health: 0,
      state: 8,
      stateStr: '(not reachable/healthy)',
      uptime: 0,
      optime: { ts: Timestamp({ t: 0, i: 0 }), t: Long('-1') },
      optimeDurable: { ts: Timestamp({ t: 0, i: 0 }), t: Long('-1') },
      optimeDate: ISODate('1970-01-01T00:00:00.000Z'),
      optimeDurableDate: ISODate('1970-01-01T00:00:00.000Z'),
      lastAppliedWallTime: ISODate('1970-01-01T00:00:00.000Z'),
      lastDurableWallTime: ISODate('1970-01-01T00:00:00.000Z'),
      lastHeartbeat: ISODate('2024-03-12T13:08:15.204Z'),
      lastHeartbeatRecv: ISODate('1970-01-01T00:00:00.000Z'),
      pingMs: Long('0'),
      lastHeartbeatMessage: 'Error connecting to mongodb-1-s:27017 (192.168.56.160:27017) :: caused by :: onInvoke :: caused by :: Connection refused',
      syncSourceHost: '',
      syncSourceId: -1,
      infoMessage: '',
      configVersion: -1,
      configTerm: -1
    },
    {
      _id: 2,
      name: 'mongodb-1-a:27017',
      health: 1,
      state: 7,
      stateStr: 'ARBITER',
      uptime: 140,
      lastHeartbeat: ISODate('2024-03-12T13:08:14.853Z'),
      lastHeartbeatRecv: ISODate('2024-03-12T13:08:15.029Z'),
      pingMs: Long('1'),
      lastHeartbeatMessage: '',
      syncSourceHost: '',
      syncSourceId: -1,
      infoMessage: '',
      configVersion: 5,
      configTerm: 4
    }
  ],
  ok: 1,
  '$clusterTime': {
    clusterTime: Timestamp({ t: 1710248886, i: 1 }),
    signature: {
      hash: Binary.createFromBase64('ON8X2EKo80FR24DKkLCNOUDMv6g=', 0),
      keyId: Long('7345384714661789702')
    }
  },
  operationTime: Timestamp({ t: 1710248886, i: 1 })
}

rs0 [direct: primary] admin> quit()

*/

-- Step 154 -->> On Node 2 (Start the MongoDB Serivice at Secondary Node i.e. Node 2)
mongodb@mongodb-1-s:~$ sudo systemctl start mongod.service

-- Step 155 -->> On Node 2 (Verify the MongoDB Serivice at Secondary Node i.e. Node 2)
mongodb@mongodb-1-s:~$ sudo systemctl status mongod.service
/*
● mongod.service - MongoDB Database Server
     Loaded: loaded (/lib/systemd/system/mongod.service; enabled; vendor preset: enabled)
     Active: active (running) since Tue 2024-03-12 13:08:53 UTC; 4s ago
       Docs: https://docs.mongodb.org/manual
   Main PID: 4539 (mongod)
     Memory: 187.3M
        CPU: 1.865s
     CGroup: /system.slice/mongod.service
             └─4539 /usr/bin/mongod --config /etc/mongod.conf

Mar 12 13:08:53 mongodb-1-s.unidev39.org.np systemd[1]: Started MongoDB Database Server.
Mar 12 13:08:53 mongodb-1-s.unidev39.org.np mongod[4539]: {"t":{"$date":"2024-03-12T13:08:53.513Z"},"s":"I",  "c":"CONTROL",  "id":7484500, "ctx":"main","msg":"Environment variable MONGODB>
*/

-- Step 156 -->> On Node 2 (Verify the MongoDB Serivice at Secondary Node i.e. Node 2)
mongodb@mongodb-1-s:~$ mongosh --host 192.168.56.160 --port 27017 -u admin -p P#ssw0rd --authenticationDatabase admin
/*
Current Mongosh Log ID: 65f05400d49e5d51f76c6c0a
Connecting to:          mongodb://<credentials>@192.168.56.160:27017/?directConnection=true&authSource=admin&appName=mongosh+2.1.5
Using MongoDB:          7.0.6
Using Mongosh:          2.1.5

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

rs0 [direct: secondary] test> show dbs
admin   224.00 KiB
config  268.00 KiB
devesh    8.00 KiB
local   568.00 KiB

rs0 [direct: secondary] test> use admin
switched to db admin

rs0 [direct: secondary] admin> db.getUsers()
MongoServerError[NotPrimaryNoSecondaryOk]: not primary - consider using db.getMongo().setReadPref() or readPreference in the connection string

rs0 [direct: secondary] admin> rs.conf()
{
  _id: 'rs0',
  version: 5,
  term: 4,
  members: [
    {
      _id: 0,
      host: 'mongodb-1-p:27017',
      arbiterOnly: false,
      buildIndexes: true,
      hidden: false,
      priority: 10,
      tags: {},
      secondaryDelaySecs: Long('0'),
      votes: 1
    },
    {
      _id: 1,
      host: 'mongodb-1-s:27017',
      arbiterOnly: false,
      buildIndexes: true,
      hidden: false,
      priority: 1,
      tags: {},
      secondaryDelaySecs: Long('0'),
      votes: 1
    },
    {
      _id: 2,
      host: 'mongodb-1-a:27017',
      arbiterOnly: true,
      buildIndexes: true,
      hidden: false,
      priority: 0,
      tags: {},
      secondaryDelaySecs: Long('0'),
      votes: 1
    }
  ],
  protocolVersion: Long('1'),
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
    replicaSetId: ObjectId('65f00c7b3d67bb5378f096c9')
  }
}

rs0 [direct: secondary] admin> rs.status()
{
  set: 'rs0',
  date: ISODate('2024-03-12T13:10:03.042Z'),
  myState: 2,
  term: Long('4'),
  syncSourceHost: 'mongodb-1-p:27017',
  syncSourceId: 0,
  heartbeatIntervalMillis: Long('2000'),
  majorityVoteCount: 2,
  writeMajorityCount: 2,
  votingMembersCount: 3,
  writableVotingMembersCount: 2,
  optimes: {
    lastCommittedOpTime: { ts: Timestamp({ t: 1710248996, i: 1 }), t: Long('4') },
    lastCommittedWallTime: ISODate('2024-03-12T13:09:56.432Z'),
    readConcernMajorityOpTime: { ts: Timestamp({ t: 1710248996, i: 1 }), t: Long('4') },
    appliedOpTime: { ts: Timestamp({ t: 1710248996, i: 1 }), t: Long('4') },
    durableOpTime: { ts: Timestamp({ t: 1710248996, i: 1 }), t: Long('4') },
    lastAppliedWallTime: ISODate('2024-03-12T13:09:56.432Z'),
    lastDurableWallTime: ISODate('2024-03-12T13:09:56.432Z')
  },
  lastStableRecoveryTimestamp: Timestamp({ t: 1710248986, i: 1 }),
  members: [
    {
      _id: 0,
      name: 'mongodb-1-p:27017',
      health: 1,
      state: 1,
      stateStr: 'PRIMARY',
      uptime: 68,
      optime: { ts: Timestamp({ t: 1710248996, i: 1 }), t: Long('4') },
      optimeDurable: { ts: Timestamp({ t: 1710248996, i: 1 }), t: Long('4') },
      optimeDate: ISODate('2024-03-12T13:09:56.000Z'),
      optimeDurableDate: ISODate('2024-03-12T13:09:56.000Z'),
      lastAppliedWallTime: ISODate('2024-03-12T13:09:56.432Z'),
      lastDurableWallTime: ISODate('2024-03-12T13:09:56.432Z'),
      lastHeartbeat: ISODate('2024-03-12T13:10:01.915Z'),
      lastHeartbeatRecv: ISODate('2024-03-12T13:10:01.777Z'),
      pingMs: Long('1'),
      lastHeartbeatMessage: '',
      syncSourceHost: '',
      syncSourceId: -1,
      infoMessage: '',
      electionTime: Timestamp({ t: 1710248766, i: 1 }),
      electionDate: ISODate('2024-03-12T13:06:06.000Z'),
      configVersion: 5,
      configTerm: 4
    },
    {
      _id: 1,
      name: 'mongodb-1-s:27017',
      health: 1,
      state: 2,
      stateStr: 'SECONDARY',
      uptime: 70,
      optime: { ts: Timestamp({ t: 1710248996, i: 1 }), t: Long('4') },
      optimeDate: ISODate('2024-03-12T13:09:56.000Z'),
      lastAppliedWallTime: ISODate('2024-03-12T13:09:56.432Z'),
      lastDurableWallTime: ISODate('2024-03-12T13:09:56.432Z'),
      syncSourceHost: 'mongodb-1-p:27017',
      syncSourceId: 0,
      infoMessage: '',
      configVersion: 5,
      configTerm: 4,
      self: true,
      lastHeartbeatMessage: ''
    },
    {
      _id: 2,
      name: 'mongodb-1-a:27017',
      health: 1,
      state: 7,
      stateStr: 'ARBITER',
      uptime: 68,
      lastHeartbeat: ISODate('2024-03-12T13:10:01.916Z'),
      lastHeartbeatRecv: ISODate('2024-03-12T13:10:01.915Z'),
      pingMs: Long('1'),
      lastHeartbeatMessage: '',
      syncSourceHost: '',
      syncSourceId: -1,
      infoMessage: '',
      configVersion: 5,
      configTerm: 4
    }
  ],
  ok: 1,
  '$clusterTime': {
    clusterTime: Timestamp({ t: 1710248996, i: 1 }),
    signature: {
      hash: Binary.createFromBase64('YoQj0jv+uj1JNTEpuhqHU1cwNqI=', 0),
      keyId: Long('7345384714661789702')
    }
  },
  operationTime: Timestamp({ t: 1710248996, i: 1 })
}

rs0 [direct: secondary] admin> rs.isMaster()
{
  topologyVersion: {
    processId: ObjectId('65f053e5c5150d12f469fd79'),
    counter: Long('6')
  },
  hosts: [ 'mongodb-1-p:27017', 'mongodb-1-s:27017' ],
  arbiters: [ 'mongodb-1-a:27017' ],
  setName: 'rs0',
  setVersion: 5,
  ismaster: false,
  secondary: true,
  primary: 'mongodb-1-p:27017',
  me: 'mongodb-1-s:27017',
  lastWrite: {
    opTime: { ts: Timestamp({ t: 1710249016, i: 1 }), t: Long('4') },
    lastWriteDate: ISODate('2024-03-12T13:10:16.000Z'),
    majorityOpTime: { ts: Timestamp({ t: 1710249016, i: 1 }), t: Long('4') },
    majorityWriteDate: ISODate('2024-03-12T13:10:16.000Z')
  },
  maxBsonObjectSize: 16777216,
  maxMessageSizeBytes: 48000000,
  maxWriteBatchSize: 100000,
  localTime: ISODate('2024-03-12T13:10:19.958Z'),
  logicalSessionTimeoutMinutes: 30,
  connectionId: 30,
  minWireVersion: 0,
  maxWireVersion: 21,
  readOnly: false,
  ok: 1,
  '$clusterTime': {
    clusterTime: Timestamp({ t: 1710249016, i: 1 }),
    signature: {
      hash: Binary.createFromBase64('7YPEQsKxMH8KdBuYyvtATxtrTwo=', 0),
      keyId: Long('7345384714661789702')
    }
  },
  operationTime: Timestamp({ t: 1710249016, i: 1 }),
  isWritablePrimary: false
}

rs0 [direct: secondary] admin> quit()
*/

-- Step 157 -->> On Node 3 (Verify the MongoDB Serivice at Arbiter Node i.e. Node 3)
mongodb@mongodb-1-a:~$ mongo --host 192.168.56.161 --port 27017 -u admin -p P#ssw0rd --authenticationDatabase admin
/*
Current Mongosh Log ID: 65f054869cc3b45f366beb3f
Connecting to:          mongodb://<credentials>@192.168.56.161:27017/?directConnection=true&authSource=admin&appName=mongosh+2.1.5
Using MongoDB:          7.0.6
Using Mongosh:          2.1.5

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

rs0 [direct: arbiter] test> show dbs
MongoServerError[Unauthorized]: Command listDatabases requires authentication
rs0 [direct: arbiter] test> use admin
switched to db admin
rs0 [direct: arbiter] admin> db
admin
rs0 [direct: arbiter] admin> rs.isMaster()
{
  topologyVersion: {
    processId: ObjectId('65f00be3bfde8afa7394ab70'),
    counter: Long('4')
  },
  hosts: [ 'mongodb-1-p:27017', 'mongodb-1-s:27017' ],
  arbiters: [ 'mongodb-1-a:27017' ],
  setName: 'rs0',
  setVersion: 5,
  ismaster: false,
  secondary: false,
  primary: 'mongodb-1-p:27017',
  arbiterOnly: true,
  me: 'mongodb-1-a:27017',
  lastWrite: {
    opTime: { ts: Timestamp({ t: 1710249106, i: 1 }), t: Long('4') },
    lastWriteDate: ISODate('2024-03-12T13:11:46.000Z'),
    majorityOpTime: { ts: Timestamp({ t: 1710249106, i: 1 }), t: Long('4') },
    majorityWriteDate: ISODate('2024-03-12T13:11:46.000Z')
  },
  maxBsonObjectSize: 16777216,
  maxMessageSizeBytes: 48000000,
  maxWriteBatchSize: 100000,
  localTime: ISODate('2024-03-12T13:11:52.399Z'),
  logicalSessionTimeoutMinutes: 30,
  connectionId: 91,
  minWireVersion: 0,
  maxWireVersion: 21,
  readOnly: false,
  ok: 1,
  isWritablePrimary: false
}

rs0 [direct: arbiter] admin> quit()
*/

-- Data verification
-- Step 158 -->> On Node 1 (Verify the DB SIze of MongoDB at Primary Node)
mongodb@mongodb-1-p:~$ du -sh /data/mongodb/
/*
507M    /data/mongodb/
*/

-- Step 159 -->> On Node 1 (Verify the Files Count (Of DbPath) of MongoDB at Primary Node)
mongodb@mongodb-1-p:~$ ls /data/mongodb/ -1 | wc -l
/*
81
*/

-- Step 160 -->> On Node 2 (Verify the DB SIze of MongoDB at Secondary Node)
mongodb@mongodb-1-s:~$ du -sh /data/mongodb/
/*
507M    /data/mongodb/
*/

-- Step 161 -->> On Node 2 (Verify the Files Count (Of DbPath) of MongoDB at Secondary Node)
mongodb@mongodb-1-s:~$ ls /data/mongodb/ -1 | wc -l
/*
81
*/

-- Step 162 -->> On Node 3 (Verify the DB SIze of MongoDB at Arbiter Node)
mongodb@mongodb-1-a:~$ du -sh /data/mongodb/
/*
305M    /data/mongodb/
*/

-- Step 163 -->> On Node 3 (Verify the Files Count (Of DbPath) of MongoDB at Arbiter Node)
mongodb@mongodb-1-a:~$ ls /data/mongodb/ -1 | wc -l
/*
31
*/

-- Step 164 -->> On Node 1 (Verify the Files List (Of DbPath) of MongoDB at Primary Node)
mongodb@mongodb-1-p:~$ ll /data/mongodb/
/*
drwxrwxrwx. 4 mongodb mongodb   4096 Mar 12 13:22 ./
drwxrwxrwx. 4 mongodb mongodb     32 Mar 10 08:47 ../
-rw-------. 1 mongodb mongodb  36864 Mar 12 13:22 collection-0-2297715484495139214.wt
-rw-------. 1 mongodb mongodb  36864 Mar 12 13:06 collection-0--4771704940815101693.wt
-rw-------. 1 mongodb mongodb   4096 Mar 12 13:15 collection-0-5826204018805516367.wt
-rw-------. 1 mongodb mongodb  36864 Mar 12 13:05 collection-0--6093854163827268446.wt
-rw-------. 1 mongodb mongodb 102400 Mar 12 13:22 collection-10-2297715484495139214.wt
-rw-------. 1 mongodb mongodb  20480 Mar 12 13:18 collection-10-5826204018805516367.wt
-rw-------. 1 mongodb mongodb  36864 Mar 12 13:06 collection-11-2297715484495139214.wt
-rw-------. 1 mongodb mongodb  20480 Mar 12 13:05 collection-13-2297715484495139214.wt
-rw-------. 1 mongodb mongodb  36864 Mar 12 13:18 collection-15-2297715484495139214.wt
-rw-------. 1 mongodb mongodb   4096 Mar 12 12:56 collection-18-2297715484495139214.wt
-rw-------. 1 mongodb mongodb   4096 Mar 12 12:56 collection-20-2297715484495139214.wt
-rw-------. 1 mongodb mongodb   4096 Mar 12 13:06 collection-22-2297715484495139214.wt
-rw-------. 1 mongodb mongodb  20480 Mar 12 13:05 collection-2-2297715484495139214.wt
-rw-------. 1 mongodb mongodb  20480 Mar 12 13:05 collection-23-2297715484495139214.wt
-rw-------. 1 mongodb mongodb   4096 Mar 12 12:56 collection-24-2297715484495139214.wt
-rw-------. 1 mongodb mongodb  36864 Mar 12 13:16 collection-2-5826204018805516367.wt
-rw-------. 1 mongodb mongodb  40960 Mar 12 13:06 collection-2--6093854163827268446.wt
-rw-------. 1 mongodb mongodb   4096 Mar 12 13:05 collection-27-2297715484495139214.wt
-rw-------. 1 mongodb mongodb   4096 Mar 12 13:05 collection-28-2297715484495139214.wt
-rw-------. 1 mongodb mongodb   4096 Mar 12 12:56 collection-32-2297715484495139214.wt
-rw-------. 1 mongodb mongodb   4096 Mar 12 13:05 collection-37-2297715484495139214.wt
-rw-------. 1 mongodb mongodb   4096 Mar 12 12:56 collection-38-2297715484495139214.wt
-rw-------. 1 mongodb mongodb  36864 Mar 12 13:06 collection-4-2297715484495139214.wt
-rw-------. 1 mongodb mongodb  20480 Mar 12 13:05 collection-43-2297715484495139214.wt
-rw-------. 1 mongodb mongodb   4096 Mar 12 12:56 collection-45-2297715484495139214.wt
-rw-------. 1 mongodb mongodb  20480 Mar 12 13:17 collection-4-5826204018805516367.wt
-rw-------. 1 mongodb mongodb  36864 Mar 12 13:20 collection-4--6093854163827268446.wt
-rw-------. 1 mongodb mongodb  20480 Mar 12 13:05 collection-6-2297715484495139214.wt
-rw-------. 1 mongodb mongodb  20480 Mar 12 13:17 collection-6-5826204018805516367.wt
-rw-------. 1 mongodb mongodb  20480 Mar 12 13:05 collection-8-2297715484495139214.wt
-rw-------. 1 mongodb mongodb  20480 Mar 12 13:18 collection-8-5826204018805516367.wt
drwx------. 2 mongodb mongodb   4096 Mar 12 13:23 diagnostic.data/
-rw-------. 1 mongodb mongodb  20480 Mar 12 13:18 index-11-5826204018805516367.wt
-rw-------. 1 mongodb mongodb  20480 Mar 12 12:56 index-12-2297715484495139214.wt
-rw-------. 1 mongodb mongodb  20480 Mar 12 13:05 index-1-2297715484495139214.wt
-rw-------. 1 mongodb mongodb  20480 Mar 12 12:56 index-14-2297715484495139214.wt
-rw-------. 1 mongodb mongodb  36864 Mar 12 12:56 index-1--4771704940815101693.wt
-rw-------. 1 mongodb mongodb   4096 Mar 12 13:15 index-1-5826204018805516367.wt
-rw-------. 1 mongodb mongodb  36864 Mar 12 13:05 index-1--6093854163827268446.wt
-rw-------. 1 mongodb mongodb  36864 Mar 12 13:18 index-16-2297715484495139214.wt
-rw-------. 1 mongodb mongodb   4096 Mar 12 13:15 index-17-2297715484495139214.wt
-rw-------. 1 mongodb mongodb   4096 Mar 12 12:56 index-19-2297715484495139214.wt
-rw-------. 1 mongodb mongodb   4096 Mar 12 12:56 index-21-2297715484495139214.wt
-rw-------. 1 mongodb mongodb  36864 Mar 12 13:06 index-2--4771704940815101693.wt
-rw-------. 1 mongodb mongodb  20480 Mar 12 12:56 index-25-2297715484495139214.wt
-rw-------. 1 mongodb mongodb   4096 Mar 12 12:56 index-26-2297715484495139214.wt
-rw-------. 1 mongodb mongodb   4096 Mar 12 13:06 index-29-2297715484495139214.wt
-rw-------. 1 mongodb mongodb   4096 Mar 12 12:56 index-30-2297715484495139214.wt
-rw-------. 1 mongodb mongodb   4096 Mar 12 12:56 index-31-2297715484495139214.wt
-rw-------. 1 mongodb mongodb  20480 Mar 12 12:56 index-3-2297715484495139214.wt
-rw-------. 1 mongodb mongodb   4096 Mar 12 13:06 index-33-2297715484495139214.wt
-rw-------. 1 mongodb mongodb   4096 Mar 12 12:56 index-34-2297715484495139214.wt
-rw-------. 1 mongodb mongodb   4096 Mar 12 13:06 index-35-2297715484495139214.wt
-rw-------. 1 mongodb mongodb  36864 Mar 12 13:16 index-3-5826204018805516367.wt
-rw-------. 1 mongodb mongodb  36864 Mar 12 13:06 index-3--6093854163827268446.wt
-rw-------. 1 mongodb mongodb   4096 Mar 12 13:06 index-36-2297715484495139214.wt
-rw-------. 1 mongodb mongodb   4096 Mar 12 12:56 index-39-2297715484495139214.wt
-rw-------. 1 mongodb mongodb   4096 Mar 12 12:56 index-40-2297715484495139214.wt
-rw-------. 1 mongodb mongodb   4096 Mar 12 13:06 index-41-2297715484495139214.wt
-rw-------. 1 mongodb mongodb   4096 Mar 12 13:06 index-42-2297715484495139214.wt
-rw-------. 1 mongodb mongodb  20480 Mar 12 13:05 index-44-2297715484495139214.wt
-rw-------. 1 mongodb mongodb   4096 Mar 12 12:56 index-46-2297715484495139214.wt
-rw-------. 1 mongodb mongodb  20480 Mar 12 12:56 index-5-2297715484495139214.wt
-rw-------. 1 mongodb mongodb  20480 Mar 12 13:17 index-5-5826204018805516367.wt
-rw-------. 1 mongodb mongodb  36864 Mar 12 13:20 index-5--6093854163827268446.wt
-rw-------. 1 mongodb mongodb  36864 Mar 12 13:20 index-6--6093854163827268446.wt
-rw-------. 1 mongodb mongodb  20480 Mar 12 13:05 index-7-2297715484495139214.wt
-rw-------. 1 mongodb mongodb  20480 Mar 12 13:17 index-7-5826204018805516367.wt
-rw-------. 1 mongodb mongodb  20480 Mar 12 12:56 index-9-2297715484495139214.wt
-rw-------. 1 mongodb mongodb  20480 Mar 12 13:18 index-9-5826204018805516367.wt
drwx------. 2 mongodb mongodb    110 Mar 12 13:05 journal/
-r--------. 1 mongodb mongodb   1024 Mar 12 07:51 keyfile
-rw-------. 1 mongodb mongodb  36864 Mar 12 13:18 _mdb_catalog.wt
-rw-------. 1 mongodb mongodb      5 Mar 12 13:05 mongod.lock
-rw-------. 1 mongodb mongodb  36864 Mar 12 13:22 sizeStorer.wt
-rw-------. 1 mongodb mongodb    114 Mar 10 09:22 storage.bson
-rw-------. 1 mongodb mongodb     50 Mar 10 09:22 WiredTiger
-rw-------. 1 mongodb mongodb  32768 Mar 12 13:22 WiredTigerHS.wt
-rw-------. 1 mongodb mongodb     21 Mar 10 09:22 WiredTiger.lock
-rw-------. 1 mongodb mongodb   1482 Mar 12 13:22 WiredTiger.turtle
-rw-------. 1 mongodb mongodb 315392 Mar 12 13:22 WiredTiger.wt
*/

-- Step 165 -->> On Node 2 (Verify the Files List (Of DbPath) of MongoDB at Secondary Node)
mongodb@mongodb-1-s:~$ ll /data/mongodb/
/*
drwxrwxrwx. 5 mongodb mongodb   4096 Mar 12 13:22 ./
drwxrwxrwx. 4 mongodb mongodb     32 Mar 10 08:47 ../
-rw-------. 1 mongodb mongodb  36864 Mar 12 13:22 collection-0-2568731052185939232.wt
-rw-------. 1 mongodb mongodb   4096 Mar 12 13:15 collection-0--7252205013504519049.wt
-rw-------. 1 mongodb mongodb  36864 Mar 12 13:08 collection-10-2568731052185939232.wt
-rw-------. 1 mongodb mongodb  20480 Mar 12 13:18 collection-10--7252205013504519049.wt
-rw-------. 1 mongodb mongodb  90112 Mar 12 13:22 collection-14-2568731052185939232.wt
-rw-------. 1 mongodb mongodb  36864 Mar 12 13:08 collection-15-2568731052185939232.wt
-rw-------. 1 mongodb mongodb  32768 Mar 12 13:08 collection-18-2568731052185939232.wt
-rw-------. 1 mongodb mongodb  32768 Mar 12 13:08 collection-20-2568731052185939232.wt
-rw-------. 1 mongodb mongodb   4096 Mar 12 13:08 collection-22-2568731052185939232.wt
-rw-------. 1 mongodb mongodb  32768 Mar 12 13:08 collection-2-2568731052185939232.wt
-rw-------. 1 mongodb mongodb   4096 Mar 12 13:08 collection-23-2568731052185939232.wt
-rw-------. 1 mongodb mongodb   4096 Mar 12 13:08 collection-25-2568731052185939232.wt
-rw-------. 1 mongodb mongodb  36864 Mar 12 13:08 collection-2--5406765279454875330.wt
-rw-------. 1 mongodb mongodb  36864 Mar 12 13:16 collection-2--7252205013504519049.wt
-rw-------. 1 mongodb mongodb   4096 Mar 12 13:08 collection-28-2568731052185939232.wt
-rw-------. 1 mongodb mongodb   4096 Mar 12 13:08 collection-31-2568731052185939232.wt
-rw-------. 1 mongodb mongodb   4096 Mar 12 13:08 collection-34-2568731052185939232.wt
-rw-------. 1 mongodb mongodb  36864 Mar 12 13:18 collection-37-2568731052185939232.wt
-rw-------. 1 mongodb mongodb  36864 Mar 12 13:20 collection-40-2568731052185939232.wt
-rw-------. 1 mongodb mongodb  32768 Mar 12 13:08 collection-4-2568731052185939232.wt
-rw-------. 1 mongodb mongodb   4096 Mar 12 13:08 collection-43-2568731052185939232.wt
-rw-------. 1 mongodb mongodb   4096 Mar 12 13:08 collection-45-2568731052185939232.wt
-rw-------. 1 mongodb mongodb  20480 Mar 12 13:17 collection-4--7252205013504519049.wt
-rw-------. 1 mongodb mongodb   4096 Mar 12 13:08 collection-48-2568731052185939232.wt
-rw-------. 1 mongodb mongodb  32768 Mar 12 13:08 collection-51-2568731052185939232.wt
-rw-------. 1 mongodb mongodb  32768 Mar 12 13:08 collection-53-2568731052185939232.wt
-rw-------. 1 mongodb mongodb   4096 Mar 12 13:08 collection-55-2568731052185939232.wt
-rw-------. 1 mongodb mongodb  36864 Mar 12 13:08 collection-6-2568731052185939232.wt
-rw-------. 1 mongodb mongodb  20480 Mar 12 13:17 collection-6--7252205013504519049.wt
-rw-------. 1 mongodb mongodb  32768 Mar 12 13:08 collection-8-2568731052185939232.wt
-rw-------. 1 mongodb mongodb  20480 Mar 12 13:18 collection-8--7252205013504519049.wt
drwx------. 2 mongodb mongodb   4096 Mar 12 13:23 diagnostic.data/
-rw-------. 1 mongodb mongodb  20480 Mar 12 13:04 index-11-2568731052185939232.wt
-rw-------. 1 mongodb mongodb  20480 Mar 12 13:18 index-11--7252205013504519049.wt
-rw-------. 1 mongodb mongodb  32768 Mar 12 13:08 index-1-2568731052185939232.wt
-rw-------. 1 mongodb mongodb  36864 Mar 12 13:09 index-16-2568731052185939232.wt
-rw-------. 1 mongodb mongodb   4096 Mar 12 13:15 index-1--7252205013504519049.wt
-rw-------. 1 mongodb mongodb  36864 Mar 12 13:04 index-17-2568731052185939232.wt
-rw-------. 1 mongodb mongodb  32768 Mar 12 13:08 index-19-2568731052185939232.wt
-rw-------. 1 mongodb mongodb  20480 Mar 12 08:04 index-21-2568731052185939232.wt
-rw-------. 1 mongodb mongodb   8192 Mar 12 08:04 index-24-2568731052185939232.wt
-rw-------. 1 mongodb mongodb   8192 Mar 12 13:04 index-26-2568731052185939232.wt
-rw-------. 1 mongodb mongodb   8192 Mar 12 08:04 index-27-2568731052185939232.wt
-rw-------. 1 mongodb mongodb   8192 Mar 12 13:04 index-29-2568731052185939232.wt
-rw-------. 1 mongodb mongodb   8192 Mar 12 08:04 index-30-2568731052185939232.wt
-rw-------. 1 mongodb mongodb   8192 Mar 12 13:04 index-32-2568731052185939232.wt
-rw-------. 1 mongodb mongodb  20480 Mar 12 13:04 index-3-2568731052185939232.wt
-rw-------. 1 mongodb mongodb   8192 Mar 12 08:04 index-33-2568731052185939232.wt
-rw-------. 1 mongodb mongodb   8192 Mar 12 13:04 index-35-2568731052185939232.wt
-rw-------. 1 mongodb mongodb  36864 Mar 12 13:08 index-3--5406765279454875330.wt
-rw-------. 1 mongodb mongodb   8192 Mar 12 08:04 index-36-2568731052185939232.wt
-rw-------. 1 mongodb mongodb  36864 Mar 12 13:16 index-3--7252205013504519049.wt
-rw-------. 1 mongodb mongodb   8192 Mar 12 08:04 index-38-2568731052185939232.wt
-rw-------. 1 mongodb mongodb  36864 Mar 12 13:18 index-39-2568731052185939232.wt
-rw-------. 1 mongodb mongodb  36864 Mar 12 13:20 index-41-2568731052185939232.wt
-rw-------. 1 mongodb mongodb  36864 Mar 12 13:20 index-42-2568731052185939232.wt
-rw-------. 1 mongodb mongodb   8192 Mar 12 08:04 index-44-2568731052185939232.wt
-rw-------. 1 mongodb mongodb   8192 Mar 12 13:04 index-46-2568731052185939232.wt
-rw-------. 1 mongodb mongodb   8192 Mar 12 08:04 index-47-2568731052185939232.wt
-rw-------. 1 mongodb mongodb   8192 Mar 12 13:04 index-49-2568731052185939232.wt
-rw-------. 1 mongodb mongodb   8192 Mar 12 08:04 index-50-2568731052185939232.wt
-rw-------. 1 mongodb mongodb  20480 Mar 12 13:04 index-52-2568731052185939232.wt
-rw-------. 1 mongodb mongodb  20480 Mar 12 13:04 index-5-2568731052185939232.wt
-rw-------. 1 mongodb mongodb  32768 Mar 12 13:08 index-54-2568731052185939232.wt
-rw-------. 1 mongodb mongodb   4096 Mar 12 13:04 index-56-2568731052185939232.wt
-rw-------. 1 mongodb mongodb  20480 Mar 12 13:17 index-5--7252205013504519049.wt
-rw-------. 1 mongodb mongodb  32768 Mar 12 13:08 index-7-2568731052185939232.wt
-rw-------. 1 mongodb mongodb  20480 Mar 12 13:17 index-7--7252205013504519049.wt
-rw-------. 1 mongodb mongodb  20480 Mar 12 13:04 index-9-2568731052185939232.wt
-rw-------. 1 mongodb mongodb  20480 Mar 12 13:18 index-9--7252205013504519049.wt
drwx------. 2 mongodb mongodb    110 Mar 12 13:08 journal/
-r--------. 1 mongodb mongodb   1024 Mar 12 07:53 keyfile
-rw-------. 1 mongodb mongodb  36864 Mar 12 13:18 _mdb_catalog.wt
-rw-------. 1 mongodb mongodb      5 Mar 12 13:08 mongod.lock
drwx------. 3 mongodb mongodb     50 Mar 12 13:08 rollback/
-rw-------. 1 mongodb mongodb  36864 Mar 12 13:22 sizeStorer.wt
-rw-------. 1 mongodb mongodb    114 Mar 10 09:22 storage.bson
-rw-------. 1 mongodb mongodb     50 Mar 10 09:22 WiredTiger
-rw-------. 1 mongodb mongodb  32768 Mar 12 13:22 WiredTigerHS.wt
-rw-------. 1 mongodb mongodb     21 Mar 10 09:22 WiredTiger.lock
-rw-------. 1 mongodb mongodb   1481 Mar 12 13:22 WiredTiger.turtle
-rw-------. 1 mongodb mongodb 335872 Mar 12 13:22 WiredTiger.wt
*/

-- Step 166 -->> On Node 3 (Verify the Files List (Of DbPath) of MongoDB at Arbiter Node)
mongodb@mongodb-1-a:~$ ll /data/mongodb/
/*
drwxrwxrwx. 4 mongodb mongodb   4096 Mar 12 13:19 ./
drwxrwxrwx. 4 mongodb mongodb     32 Mar 10 08:47 ../
-rw-------. 1 mongodb mongodb   4096 Mar 12 08:01 collection-0--4184843527416813853.wt
-rw-------. 1 mongodb mongodb  20480 Mar 12 08:01 collection-0-4469256666167194147.wt
-rw-------. 1 mongodb mongodb  36864 Mar 12 13:06 collection-10--4184843527416813853.wt
-rw-------. 1 mongodb mongodb  20480 Mar 12 08:02 collection-2--4184843527416813853.wt
-rw-------. 1 mongodb mongodb  36864 Mar 12 08:02 collection-2-4469256666167194147.wt
-rw-------. 1 mongodb mongodb  36864 Mar 12 13:06 collection-4--4184843527416813853.wt
-rw-------. 1 mongodb mongodb   4096 Mar 10 09:31 collection-4-4469256666167194147.wt
-rw-------. 1 mongodb mongodb  20480 Mar 12 08:02 collection-6--4184843527416813853.wt
-rw-------. 1 mongodb mongodb  20480 Mar 12 08:02 collection-8--4184843527416813853.wt
drwx------. 2 mongodb mongodb   4096 Mar 12 13:20 diagnostic.data/
-rw-------. 1 mongodb mongodb  20480 Mar 12 12:30 index-11--4184843527416813853.wt
-rw-------. 1 mongodb mongodb   4096 Mar 12 08:01 index-1--4184843527416813853.wt
-rw-------. 1 mongodb mongodb  20480 Mar 12 08:01 index-1-4469256666167194147.wt
-rw-------. 1 mongodb mongodb  20480 Mar 12 08:02 index-3--4184843527416813853.wt
-rw-------. 1 mongodb mongodb  36864 Mar 12 08:02 index-3-4469256666167194147.wt
-rw-------. 1 mongodb mongodb  20480 Mar 12 08:02 index-5--4184843527416813853.wt
-rw-------. 1 mongodb mongodb   4096 Mar 10 11:09 index-5-4469256666167194147.wt
-rw-------. 1 mongodb mongodb   4096 Mar 12 08:01 index-6-4469256666167194147.wt
-rw-------. 1 mongodb mongodb  20480 Mar 12 08:02 index-7--4184843527416813853.wt
-rw-------. 1 mongodb mongodb  20480 Mar 12 08:02 index-9--4184843527416813853.wt
drwx------. 2 mongodb mongodb    110 Mar 12 08:01 journal/
-r--------. 1 mongodb mongodb   1024 Mar 12 07:55 keyfile
-rw-------. 1 mongodb mongodb  36864 Mar 12 12:30 _mdb_catalog.wt
-rw-------. 1 mongodb mongodb      5 Mar 12 08:01 mongod.lock
-rw-------. 1 mongodb mongodb  36864 Mar 12 12:31 sizeStorer.wt
-rw-------. 1 mongodb mongodb    114 Mar 10 09:22 storage.bson
-rw-------. 1 mongodb mongodb     50 Mar 10 09:22 WiredTiger
-rw-------. 1 mongodb mongodb   4096 Mar 12 08:01 WiredTigerHS.wt
-rw-------. 1 mongodb mongodb     21 Mar 10 09:22 WiredTiger.lock
-rw-------. 1 mongodb mongodb   1477 Mar 12 13:19 WiredTiger.turtle
-rw-------. 1 mongodb mongodb 110592 Mar 12 13:19 WiredTiger.wt
*/