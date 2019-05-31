OS Level add your VM IP with certification name
C:\Windows\System32\drivers\etc\hosts
/*
192.168.159.130 localhost_ssl 
*/

[root@localhost ~]# vi /etc/hosts
/*
192.168.159.130 localhost_ssl
*/

[root@localhost /]# mkdir -p /etc/ssl/mongossl
[root@localhost /]# cd /etc/ssl/mongossl
[root@localhost mongossl]# ls
[root@localhost mongossl]# openssl genrsa -des3 -out server.key 2048
/*
Generating RSA private key, 2048 bit long modulus
...................................+++
...............................................................+++
e is 65537 (0x10001)
Enter pass phrase for server.key:
Verifying - Enter pass phrase for server.key:
*/
[root@localhost mongossl]# ls
/*
server.key
*/
[root@localhost mongossl]# openssl rsa -in server.key -out server.key
/*
Enter pass phrase for server.key:
writing RSA key
*/
[root@localhost mongossl]# ls
/*
server.key
*/
[root@localhost mongossl]# openssl req -sha256 -new -key server.key -out server.csr -subj "/CN=localhost_ssl"
[root@localhost mongossl]# openssl x509 -req -sha256 -days 365 -in server.csr -signkey server.key -out server.crt
/*
Signature ok
subject=/CN=localhost_ssl
Getting Private key
*/
[root@localhost mongossl]# ls
/*
server.crt  server.csr  server.key
*/
[root@localhost mongossl]# cat server.crt server.key > cert.pem
[root@localhost mongossl]# ls
/*
cert.pem  server.crt  server.csr  server.key
*/
[root@localhost mongossl]# openssl genrsa -out mongodb.key 2048
/*
Generating RSA private key, 2048 bit long modulus
.......................................................................................................................................................................+++
...................+++
e is 65537 (0x10001)
*/
[root@localhost mongossl]# openssl req -new -key mongodb.key -out mongodb.csr
/*
You are about to be asked to enter information that will be incorporated
into your certificate request.
What you are about to enter is what is called a Distinguished Name or a DN.
There are quite a few fields but you can leave some blank
For some fields there will be a default value,
If you enter '.', the field will be left blank.
-----
Country Name (2 letter code) [XX]:
State or Province Name (full name) []:
Locality Name (eg, city) [Default City]:
Organization Name (eg, company) [Default Company Ltd]:
Organizational Unit Name (eg, section) []:
Common Name (eg, your name or your server's hostname) []:localhost_ssl
Email Address []:

Please enter the following 'extra' attributes
to be sent with your certificate request
A challenge password []:
An optional company name []:
*/
[root@localhost mongossl]# ls
/*
cert.pem  mongodb.csr  mongodb.key  server.crt  server.csr  server.key
*/
[root@localhost mongossl]# openssl x509 -req -in mongodb.csr -CA cert.pem -CAkey server.key -CAcreateserial -out mongodb.crt -days 500 -sha256
/*
Signature ok
subject=/C=XX/L=Default City/O=Default Company Ltd/CN=localhost_ssl
Getting CA Private Key
*/
[root@localhost mongossl]# ls
/*
cert.pem  mongodb.crt  mongodb.key  server.csr
cert.srl  mongodb.csr  server.crt   server.key
*/
[root@localhost mongossl]# cat mongodb.key mongodb.crt > mongodb.pem
[root@localhost mongossl]# systemctl stop mongod
[root@localhost mongossl]# systemctl status mongod
[root@localhost mongossl]# vi /etc/mongod.conf
/*
net:
  port: 27017
  bindIp: localhost_ssl
  ssl:
    mode: requireSSL
    PEMKeyFile: /etc/ssl/mongossl/mongodb.pem
    PEMKeyPassword: abc123
    CAFile: /etc/ssl/mongossl/cert.pem
    allowInvalidCertificates: true
    allowInvalidHostnames: true
*/
[root@localhost mongossl]# systemctl start mongod
[root@localhost mongossl]# systemctl status mongod
--Disable_Authentication_on_MongoDB
[root@localhost ~]# mongo --ssl --sslCAFile /etc/ssl/mongossl/cert.pem --sslPEMKeyFile /etc/ssl/mongossl/mongodb.pem --host localhost_ssl

--Enable_Authentication_on_MongoDB with admin user
[root@localhost ~]#mongo --ssl --sslCAFile /etc/ssl/mongossl/cert.pem --sslPEMKeyFile /etc/ssl/mongossl/mongodb.pem --host localhost_ssl --port 27017 -u admin -p Admin@P@55w0rd --authenticationDatabase admin
--Enable_Authentication_on_MongoDB with chatbox user
[root@localhost ~]#mongo --ssl --sslCAFile /etc/ssl/mongossl/cert.pem --sslPEMKeyFile /etc/ssl/mongossl/mongodb.pem --host localhost_ssl --port 27017 -u chatbox -p Ch@tB0x@P@55w0rd --authenticationDatabase chatbox

--Backup
--FullBackup
[root@localhost ~]#mongodump --ssl --sslCAFile /etc/ssl/mongossl/cert.pem --sslPEMKeyFile /etc/ssl/mongossl/mongodb.pem --host localhost_ssl --port 27017 -u admin -p Admin@P@55w0rd --authenticationDatabase admin --out /home/BackUpMongoDB/MongoFullBackup/dump/
--ParticularBackup
[root@localhost ~]#mongodump --ssl --sslCAFile /etc/ssl/mongossl/cert.pem --sslPEMKeyFile /etc/ssl/mongossl/mongodb.pem --host localhost_ssl --port 27017 -u admin -p Admin@P@55w0rd --authenticationDatabase admin -d chatbox --out /home/BackUpMongoDB/MongoFullBackup/dump/


--Restore
--FullBackupRestore
[root@localhost ~]#mongorestore --ssl --sslCAFile /etc/ssl/mongossl/cert.pem --sslPEMKeyFile /etc/ssl/mongossl/mongodb.pem --host localhost_ssl:27017 -u admin -p Admin@P@55w0rd --authenticationDatabase admin /home/BackUpMongoDB/MongoFullBackup/dump/
--ParticularBackupRestore
[root@localhost ~]#mongorestore --ssl --sslCAFile /etc/ssl/mongossl/cert.pem --sslPEMKeyFile /etc/ssl/mongossl/mongodb.pem --host localhost_ssl:27017 -u admin -p Admin@P@55w0rd --authenticationDatabase admin -d chatbox /home/BackUpMongoDB/MongoFullBackup/dump/chatbox

--To Connect Mongodb using Compass
Hostname                : localhost_ssl
Port                    : 27017
Authentication          : Username / Password
Username                : chatbox
Password                : Ch@tB0x@P@55w0rd
Authentication Database : chatbox
Read Preference         : Primary
SSL                     : Server and Client Validation
Certificate Authority   : D:\mongossl\server.crt
Client Certificate      : D:\mongossl\mongodb.crt
Client Private Key      : D:\mongossl\mongodb.key
