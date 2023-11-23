--Continue steps After Installation_Step_Of_1_Primary_2_Secondary_Mongodb_On_Centos_8.sql
-- Step 77 -->> On All Nodes (FailOver Test)
--If you have no primary node up and need to make the secondary node as the primary node in MongoDB. 
--This is a tricky situation, because normally you need a majority of the replica set members to be available 
--to elect a new primary node. However, there are some possible ways to force a secondary node to become the primary node in this case.

-- Step 77.1 -->> On Node 1 (FailOver Test)
[root@mongodb_1_p ~]# init 0

-- Step 77.2 -->> On Node 2 (FailOver Test)
[root@mongodb_1_s ~]# init 0

-- Step 77.3 -->> On Node 3 (FailOver Test)
[root@mongodb_2_s ~]# mongo --host 192.168.56.151 --port 27017 -u admin -p P#ssw0rd --authenticationDatabase admin
/*
Current Mongosh Log ID: 655db90dc9081cbc0938d24b
Connecting to:          mongodb://<credentials>@192.168.56.151:27017/?directConnection=true&authSource=admin&appName=mongosh+2.0.2
Using MongoDB:          7.0.3
Using Mongosh:          2.0.2
mongosh 2.1.0 is available for download: https://www.mongodb.com/try/download/shell

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

rs0 [direct: secondary] test> db.version()
7.0.3

rs0 [direct: secondary] test> show dbs
admin   188.00 KiB
config  352.00 KiB
devesh   40.00 KiB
local   492.00 KiB

rs0 [direct: secondary] test> rs.conf()
{
  _id: 'rs0',
  version: 7,
  term: 11,
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

rs0 [direct: secondary] test> cfg = rs.conf()
{
  _id: 'rs0',
  version: 7,
  term: 11,
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

-- use the same hostname or IP address as the node
rs0 [direct: secondary] test> cfg.members[0].host = "192.168.56.151:27017"
192.168.56.151:27017

-- apply the new configuration with force option
rs0 [direct: secondary] test> rs.reconfig(cfg, {force: true})
{
  ok: 1,
  '$clusterTime': {
    clusterTime: Timestamp({ t: 1700641012, i: 2 }),
    signature: {
      hash: Binary.createFromBase64("VG0Tuku+Xo6XCedbpITXT53X36o=", 0),
      keyId: Long("7303422038071312391")
    }
  },
  operationTime: Timestamp({ t: 1700641012, i: 2 })
}

rs0 [direct: secondary] test> rs.conf()
{
  _id: 'rs0',
  version: 89644,
  members: [
    {
      _id: 0,
      host: '192.168.56.151:27017',
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

rs0 [direct: secondary] test> cfg = rs.conf()
{
  _id: 'rs0',
  version: 74521,
  members: [
    {
      _id: 0,
      host: '192.168.56.151:27017',
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

rs0 [direct: secondary] test> cfg.members[2].host = "192.168.56.149:27017"
192.168.56.149:27017

rs0 [direct: secondary] test> rs.reconfig(cfg, {force: true})
{
  ok: 1,
  '$clusterTime': {
    clusterTime: Timestamp({ t: 1700643020, i: 3 }),
    signature: {
      hash: Binary.createFromBase64("y6v4bkE6k409qFDcglzqZ6LNb/o=", 0),
      keyId: Long("7303422038071312391")
    }
  },
  operationTime: Timestamp({ t: 0, i: 0 })
}

rs0 [direct: secondary] test> rs.conf()
{
  _id: 'rs0',
  version: 135277,
  members: [
    {
      _id: 0,
      host: '192.168.56.151:27017',
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
      host: '192.168.56.149:27017',
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

rs0 [direct: secondary] test> cfg = rs.conf();
{
  _id: 'rs0',
  version: 135277,
  members: [
    {
      _id: 0,
      host: '192.168.56.151:27017',
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
      host: '192.168.56.149:27017',
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

-- remove 2 servers starting at index 1
rs0 [direct: secondary] test> cfg.members.splice(1,2);
[
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
    host: '192.168.56.149:27017',
    arbiterOnly: false,
    buildIndexes: true,
    hidden: false,
    priority: 1,
    tags: {},
    secondaryDelaySecs: Long("0"),
    votes: 1
  }
]

rs0 [direct: secondary] test> rs.reconfig(cfg, {force: true});
{
  ok: 1,
  '$clusterTime': {
    clusterTime: Timestamp({ t: 1700643020, i: 3 }),
    signature: {
      hash: Binary.createFromBase64("y6v4bkE6k409qFDcglzqZ6LNb/o=", 0),
      keyId: Long("7303422038071312391")
    }
  },
  operationTime: Timestamp({ t: 0, i: 0 })
}

rs0 [direct: secondary] test> rs.conf()
{
  _id: 'rs0',
  version: 162647,
  members: [
    {
      _id: 0,
      host: '192.168.56.151:27017',
      arbiterOnly: false,
      buildIndexes: true,
      hidden: false,
      priority: 20,
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

rs0 [direct: secondary] test> exit;
*/

-- Step 77.4 -->> On Node 3 (FailOver Test)
[root@mongodb_2_s ~]# systemctl stop mongod
-- Step 77.5 -->> On Node 3 (FailOver Test)
[root@mongodb_2_s ~]# systemctl start mongod
-- Step 77.6 -->> On Node 3 (FailOver Test)
[root@mongodb_2_s ~]# systemctl status mongod
/*
● mongod.service - MongoDB Database Server
   Loaded: loaded (/usr/lib/systemd/system/mongod.service; enabled; vendor preset: disabled)
   Active: active (running) since Wed 2023-11-22 14:40:38 +0545; 3s ago
     Docs: https://docs.mongodb.org/manual
 Main PID: 5061 (mongod)
   Memory: 182.6M
   CGroup: /system.slice/mongod.service
           └─5061 /usr/bin/mongod -f /etc/mongod.conf

Nov 22 14:40:38 mongodb_2_s.cibnepal.org.np systemd[1]: Started MongoDB Database Server.
Nov 22 14:40:38 mongodb_2_s.cibnepal.org.np mongod[5061]: {"t":{"$date":"2023-11-22T08:55:38.277Z"},"s":"I",  "c":"CONTROL",  "id":7484500, "ctx":"main","msg":"Environment variable MONGODB>
*/

-- Step 78 -->> On Node 3 (FailOver Test)
[root@mongodb_2_s ~]# mongo --host 192.168.56.151 --port 27017 -u admin -p P#ssw0rd --authenticationDatabase admin
/*
Current Mongosh Log ID: 655dc2120fad2d17baceb4cd
Connecting to:          mongodb://<credentials>@192.168.56.151:27017/?directConnection=true&authSource=admin&appName=mongosh+2.0.2
Using MongoDB:          7.0.3
Using Mongosh:          2.0.2
mongosh 2.1.0 is available for download: https://www.mongodb.com/try/download/shell

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

rs0 [direct: primary] test> rs.conf()
{
  _id: 'rs0',
  version: 162647,
  members: [
    {
      _id: 0,
      host: '192.168.56.151:27017',
      arbiterOnly: false,
      buildIndexes: true,
      hidden: false,
      priority: 20,
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

rs0 [direct: primary] test> cfg = rs.conf()
{
  _id: 'rs0',
  version: 162647,
  members: [
    {
      _id: 0,
      host: '192.168.56.151:27017',
      arbiterOnly: false,
      buildIndexes: true,
      hidden: false,
      priority: 20,
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

rs0 [direct: primary] test> cfg.members[0].host = "mongodb_2_s:27017"
mongodb_2_s:27017

rs0 [direct: primary] test> rs.reconfig(cfg)
{
  ok: 1,
  '$clusterTime': {
    clusterTime: Timestamp({ t: 1700643522, i: 1 }),
    signature: {
      hash: Binary.createFromBase64("4nIr+6sQFrN3e42QTKX40ulAlPw=", 0),
      keyId: Long("7303422038071312391")
    }
  },
  operationTime: Timestamp({ t: 1700643522, i: 1 })
}

rs0 [direct: primary] test> rs.conf()
{
  _id: 'rs0',
  version: 162648,
  term: 17,
  members: [
    {
      _id: 0,
      host: 'mongodb_2_s:27017',
      arbiterOnly: false,
      buildIndexes: true,
      hidden: false,
      priority: 20,
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

rs0 [direct: primary] test> use admin
switched to db admin

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
    clusterTime: Timestamp({ t: 1700643579, i: 1 }),
    signature: {
      hash: Binary.createFromBase64("FX4cGxyZzKX0NK8o+azHjljdqyo=", 0),
      keyId: Long("7303422038071312391")
    }
  },
  operationTime: Timestamp({ t: 1700643579, i: 1 })
}

--Assume that we need to run for Couple of Weeks to become nomral state
rs0 [direct: primary] admin> show dbs
admin   188.00 KiB
config  352.00 KiB
devesh   40.00 KiB
local   500.00 KiB

rs0 [direct: primary] admin> use devesh
switched to db devesh

rs0 [direct: primary] devesh> db.createCollection('tbl_cib_2');
{ ok: 1 }

rs0 [direct: primary] devesh> db.createCollection('tbl_cib_3');
{ ok: 1 }

rs0 [direct: primary] devesh> db.createCollection('tbl_cib_4');
{ ok: 1 }

rs0 [direct: primary] devesh> db.createCollection('tbl_cib_5');
{ ok: 1 }

rs0 [direct: primary] devesh> show collections
tbl_cib
tbl_cib_2
tbl_cib_3
tbl_cib_4
tbl_cib_5

rs0 [direct: primary] devesh> db.tbl_cib_5.insertOne({name: "Devesh", age: 44})
{
  acknowledged: true,
  insertedId: ObjectId("655dc3acf41af313621aafef")
}

rs0 [direct: primary] devesh>

rs0 [direct: primary] devesh> db.tbl_cib_5.insertMany([{name: "Devesh", age: 44}, {name: "Madhu", age: 44}])
{
  acknowledged: true,
  insertedIds: {
    '0': ObjectId("655dc3acf41af313621aaff0"),
    '1': ObjectId("655dc3acf41af313621aaff1")
  }
}

rs0 [direct: primary] devesh>

rs0 [direct: primary] devesh> db.tbl_cib_5.bulkWrite([
... { insertOne : { document : { name: "Devesh", age: 25 } } },
... { updateOne : { filter : { name: "Madhu" }, update : { $set : { age: 40 } } } },
... { deleteOne : { filter : { name: "Manish" } } }
... ])
{
  acknowledged: true,
  insertedCount: 1,
  insertedIds: { '0': ObjectId("655dc3aef41af313621aaff2") },
  matchedCount: 1,
  modifiedCount: 1,
  deletedCount: 0,
  upsertedCount: 0,
  upsertedIds: {}
}

rs0 [direct: primary] devesh> quit()
*/

-- Step 79 -->> On Node 1 (FailOver Test - Prepare Node1 & Node2)
-- 79.1 All Nodes
[root@mongodb_1_p/mongodb_1_s ~]# df -Th
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

-- 79.1 All Nodes (FailOver Test - Prepare Node1 & Node2)
[root@mongodb_1_p/mongodb_1_s ~]# cat /etc/os-release
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

-- Step 79.1 -->> On All Nodes (FailOver Test - Prepare Node1 & Node2)
[root@mongodb_1_p/mongodb_1_s ~]# vi /etc/hosts
/*
127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
::1         localhost localhost.localdomain localhost6 localhost6.localdomain6

# Public
192.168.56.149 mongodb_1_p.cibnepal.org.np mongodb_1_p
192.168.56.150 mongodb_1_s.cibnepal.org.np mongodb_1_s
192.168.56.151 mongodb_2_s.cibnepal.org.np mongodb_2_s
*/

-- Step 79.2 -->> On All Nodes (FailOver Test - Prepare Node1 & Node2)
-- Disable secure linux by editing the "/etc/selinux/config" file, making sure the SELINUX flag is set as follows.
[root@mongodb_1_p/mongodb_1_s ~]# vi /etc/selinux/config
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

-- Step 79.3 -->> On Node 1 (FailOver Test - Prepare Node1 & Node2)
[root@mongodb_1_p ~]# vi /etc/sysconfig/network
/*
NETWORKING=yes
HOSTNAME=mongodb_1_p.cibnepal.org.np
*/

-- Step 79.3.1 -->> On Node 2 (FailOver Test - Prepare Node1 & Node2)
[root@mongodb_1_s ~]# vi /etc/sysconfig/network
/*
# Created by anaconda
NETWORKING=yes
HOSTNAME=mongodb_1_s.cibnepal.org.np
*/

-- Step 79.4 -->> On Node 1 (FailOver Test - Prepare Node1 & Node2)
[root@mongodb_1_p ~]# nmtui
--OR--
-- Step 79.4 -->> On Node 1 (FailOver Test - Prepare Node1 & Node2)
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

-- Step 79.4.1 -->> On Node 2 (FailOver Test - Prepare Node1 & Node2)
[root@mongodb_1_s ~]# nmtui
--OR--
-- Step 79.4.1 -->> On Node 2 (FailOver Test - Prepare Node1 & Node2)
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

-- Step 79.5 -->> On All Nodes (FailOver Test - Prepare Node1 & Node2)
[root@mongodb_1_p/mongodb_1_s ~]# systemctl restart network-online.target

-- Step 79.6.0 -->> On Node 1 (FailOver Test - Prepare Node1 & Node2)
[root@mongodb_1_p ~]# hostnamectl set-hostname mongodb_1_p.cibnepal.org.np

-- Step 79.6.1 -->> On Node 1 (FailOver Test - Prepare Node1 & Node2)
[root@mongodb_1_p ~]# cat /etc/hostname
/*
mongodb_1_p.cibnepal.org.np
*/

-- Step 79.6.2 -->> On Node 1 (FailOver Test - Prepare Node1 & Node2)
[root@mongodb_1_p ~]# hostnamectl | grep hostname
/*
  Static hostname: mongodb_1_p.cibnepal.org.np
*/

-- Step 79.6.3 -->> On Node 1 (FailOver Test - Prepare Node1 & Node2)
[root@mongodb_1_p ~]# hostnamectl --static
/*
mongodb_1_p.cibnepal.org.np
*/

-- Step 79.6.4 -->> On Node 1 (FailOver Test - Prepare Node1 & Node2)
[root@mongodb_1_p ~]# hostnamectl
/*
   Static hostname: mongodb_1_p.cibnepal.org.np
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

-- Step 79.6.0.1 -->> On Node 2 (FailOver Test - Prepare Node1 & Node2)
[root@mongodb_1_s ~]# hostnamectl set-hostname mongodb_1_s.cibnepal.org.np

-- Step 79.6.1.1 -->> On Node 2 (FailOver Test - Prepare Node1 & Node2)
[root@mongodb_1_s ~]# cat /etc/hostname
/*
mongodb_1_s.cibnepal.org.np
*/

-- Step 79.6.2.1 -->> On Node 2 (FailOver Test - Prepare Node1 & Node2)
[root@mongodb_1_s ~]# hostnamectl | grep hostname
/*
  Static hostname: mongodb_1_s.cibnepal.org.np
*/

-- Step 79.6.3.1 -->> On Node 2 (FailOver Test - Prepare Node1 & Node2)
[root@mongodb_1_s ~]# hostnamectl --static
/*
mongodb_1_s.cibnepal.org.np
*/

-- Step 79.6.4.1 -->> On Node 2 (FailOver Test - Prepare Node1 & Node2)
[root@mongodb_1_s ~]# hostnamectl
/*
   Static hostname: mongodb_1_s.cibnepal.org.np
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

-- Step 79.7 -->> On All Nodes (FailOver Test - Prepare Node1 & Node2)
[root@mongodb_1_p/mongodb_1_s ~]# systemctl stop firewalld
[root@mongodb_1_p/mongodb_1_s ~]# systemctl disable firewalld
/*
Removed "/etc/systemd/system/multi-user.target.wants/firewalld.service".
Removed "/etc/systemd/system/dbus-org.fedoraproject.FirewallD1.service".
*/

-- Step 79.8 -->> On All Nodes (FailOver Test - Prepare Node1 & Node2)
[root@mongodb_1_p/mongodb_1_s ~]# iptables -F
[root@mongodb_1_p/mongodb_1_s ~]# iptables -X
[root@mongodb_1_p/mongodb_1_s ~]# iptables -t nat -F
[root@mongodb_1_p/mongodb_1_s ~]# iptables -t nat -X
[root@mongodb_1_p/mongodb_1_s ~]# iptables -t mangle -F
[root@mongodb_1_p/mongodb_1_s ~]# iptables -t mangle -X
[root@mongodb_1_p/mongodb_1_s ~]# iptables -P INPUT ACCEPT
[root@mongodb_1_p/mongodb_1_s ~]# iptables -P FORWARD ACCEPT
[root@mongodb_1_p/mongodb_1_s ~]# iptables -P OUTPUT ACCEPT
[root@mongodb_1_p/mongodb_1_s ~]# iptables -L -nv
/*
Chain INPUT (policy ACCEPT 13 packets, 1372 bytes)
 pkts bytes target     prot opt in     out     source               destination

Chain FORWARD (policy ACCEPT 0 packets, 0 bytes)
 pkts bytes target     prot opt in     out     source               destination

Chain OUTPUT (policy ACCEPT 4 packets, 468 bytes)
 pkts bytes target     prot opt in     out     source               destination
*/

-- Step 79.9 -->> On All Nodes (FailOver Test - Prepare Node1 & Node2)
--To Remove virbr0 and lxcbr0 Network Interfac
[root@mongodb_1_p/mongodb_1_s ~]# systemctl stop libvirtd.service
[root@mongodb_1_p/mongodb_1_s ~]# systemctl disable libvirtd.service
[root@mongodb_1_p/mongodb_1_s ~]# virsh net-list
[root@mongodb_1_p/mongodb_1_s ~]# virsh net-destroy default

-- Step 79.10 -->> On Node 1 (FailOver Test - Prepare Node1 & Node2)
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

-- Step 79.10.1 -->> On Node 2 (FailOver Test - Prepare Node1 & Node2)
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

-- Step 79.11 -->> On All Nodes (FailOver Test - Prepare Node1 & Node2)
[root@mongodb_1_p/mongodb_1_s ~]# init 6

-- Step 79.12 -->> On All Nodes (FailOver Test - Prepare Node1 & Node2)
[root@mongodb_1_p/mongodb_1_s ~]# firewall-cmd --list-all
/*
FirewallD is not running
*/

-- Step 79.13 -->> On All Nodes (FailOver Test - Prepare Node1 & Node2)
[root@mongodb_1_p/mongodb_1_s ~]# systemctl status firewalld
/*
● firewalld.service - firewalld - dynamic firewall daemon
   Loaded: loaded (/usr/lib/systemd/system/firewalld.service; disabled; vendor preset: enabled)
   Active: inactive (dead)
     Docs: man:firewalld(1)
*/

-- Step 79.14 -->> On All Nodes (FailOver Test - Prepare Node1 & Node2)
[root@mongodb_1_p/mongodb_1_s ~]# cd /run/media/root/CentOS-Stream-8-BaseOS-x86_64/AppStream/Packages
[root@mongodb_1_p/mongodb_1_s ~]# yum -y update

-- Step 79.15 -->> On All Nodes (FailOver Test - Prepare Node1 & Node2)
[root@mongodb_1_p/mongodb_1_s ~]# usermod -aG wheel mongodb
[root@mongodb_1_p/mongodb_1_s ~]# usermod -aG root mongodb

-- Step 79.16 -->> On All Nodes (FailOver Test - Prepare Node1 & Node2)
[root@mongodb_1_p/mongodb_1_s ~]# cd /etc/yum.repos.d/
[root@mongodb_1_p/mongodb_1_s yum.repos.d]# ll
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

-- Step 79.17 -->> On All Nodes (FailOver Test - Prepare Node1 & Node2)
[root@mongodb_1_p/mongodb_1_s yum.repos.d]# vi /etc/yum.repos.d/mongodb-org.repo
/*
[mongodb-org-7.0]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/8/mongodb-org/7.0/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-7.0.asc
*/ 

-- Step 79.18 -->> On All Nodes (FailOver Test - Prepare Node1 & Node2)
[root@mongodb_1_p/mongodb_1_s yum.repos.d]# ll | grep mongo
/*
-rw-r--r--  1 root root  190 Nov 18 14:10 mongodb-org.repo
*/
[root@mongodb_1_p/mongodb_1_s yum.repos.d]# yum repolist
/*
repo id                                                                           repo name
appstream                                                                         CentOS Stream 8 - AppStream
baseos                                                                            CentOS Stream 8 - BaseOS
extras                                                                            CentOS Stream 8 - Extras
extras-common                                                                     CentOS Stream 8 - Extras common packages
mongodb-org-7.0                                                                   MongoDB Repository
*/

-- Step 79.19 -->> On All Nodes (FailOver Test - Prepare Node1 & Node2)
[root@mongodb_1_p/mongodb_1_s ~]# yum install -y mongodb-org
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

-- Step 79.20 -->> On All Nodes (FailOver Test - Prepare Node1 & Node2)
[root@mongodb_1_p/mongodb_1_s ~]# ll /var/lib/ | grep mongo
/*
drwxr-xr-x   2 mongod         mongod            6 Oct  6 01:52 mongo
*/

-- Step 79.21 -->> On All Nodes (Create a MongoDB Data and Log directory) (FailOver Test - Prepare Node1 & Node2)
[root@mongodb_1_p/mongodb_1_s ~]# mkdir -p /data/mongodb
[root@mongodb_1_p/mongodb_1_s ~]# mkdir -p /data/log
[root@mongodb_1_p/mongodb_1_s ~]# chown -R mongod:mongod /data/
[root@mongodb_1_p/mongodb_1_s ~]# chown -R mongod:mongod /data
[root@mongodb_1_p/mongodb_1_s ~]# chmod -R 777 /data/
[root@mongodb_1_p/mongodb_1_s ~]# chmod -R 777 /data
[root@mongodb_1_p/mongodb_1_s ~]# ll / | grep data
/*
drwxrwxrwx.   4 mongod mongod    32 Nov 18 14:16 data
*/

-- Step 79.22 -->> On All Nodes (FailOver Test - Prepare Node1 & Node2)
[root@mongodb_1_p/mongodb_1_s ~]# ll /data/
/*
drwxrwxrwx 2 mongod mongod 6 Nov 18 14:16 log
drwxrwxrwx 2 mongod mongod 6 Nov 18 14:16 mongodb
*/

-- Step 79.23 -->> On All Nodes (FailOver Test - Prepare Node1 & Node2)
[root@mongodb_1_p/mongodb_1_s ~]# cp -r /etc/mongod.conf /etc/mongod.conf.backup
[root@mongodb_1_p/mongodb_1_s ~]# ll /etc/mongod*
/*
-rw-r--r-- 1 root root 658 Oct 31 05:37 /etc/mongod.conf
-rw-r--r-- 1 root root 658 Nov 17 11:28 /etc/mongod.conf.backup
*/

-- Step 79.24 -->> On All Nodes (FailOver Test - Prepare Node1 & Node2)
[root@mongodb_1_p/mongodb_1_s ~]# vi /etc/mongod.conf
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

-- Step 79.25 -->> On All Nodes (Tuning For MongoDB) (FailOver Test - Prepare Node1 & Node2)
-- Step 79.25.1 -->> On Node 1 (FailOver Test - Prepare Node1 & Node2)
[root@mongodb_1_p ~]# vi /etc/mongod.conf
/*
# network interfaces
net:
  port: 27017
  bindIp: 127.0.0.1,192.168.56.149
  maxIncomingConnections: 999999
*/

-- Step 79.25.2 -->> On Node 2 (FailOver Test - Prepare Node1 & Node2)
[root@mongodb_1_s ~]# vi /etc/mongod.conf
/*
# network interfaces
net:
  port: 27017
  bindIp: 127.0.0.1,192.168.56.150
  maxIncomingConnections: 999999
*/

-- Step 79.25.3 -->> On All Nodes (FailOver Test - Prepare Node1 & Node2)
[root@mongodb_1_p/mongodb_1_s ~]# ulimit -a
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

-- Step 79.25.4 -->> On All Nodes (FailOver Test - Prepare Node1 & Node2)
[root@mongodb_1_p/mongodb_1_s ~]# ulimit -n 64000
[root@mongodb_1_p/mongodb_1_s ~]# ulimit -a
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

-- Step 79.25.5 -->> On All Nodes (FailOver Test - Prepare Node1 & Node2)
[root@mongodb_1_p/mongodb_1_s ~]# cat /etc/group | grep mongo
/*
root:x:0:mongodb
wheel:x:10:mongodb
mongodb:x:1000:
mongod:x:969:
*/

-- Step 79.25.6 -->> On All Nodes (FailOver Test - Prepare Node1 & Node2)
[root@mongodb_1_p/mongodb_1_s ~]# echo "mongod           soft    nofile          9999999" | tee -a /etc/security/limits.conf
[root@mongodb_1_p/mongodb_1_s ~]# echo "mongod           hard    nofile          9999999" | tee -a /etc/security/limits.conf
[root@mongodb_1_p/mongodb_1_s ~]# echo "mongod           soft    nproc           9999999" | tee -a /etc/security/limits.conf
[root@mongodb_1_p/mongodb_1_s ~]# echo "mongod           hard    nproc           9999999" | tee -a /etc/security/limits.conf
[root@mongodb_1_p/mongodb_1_s ~]# echo "mongod           soft    stack           9999999" | tee -a /etc/security/limits.conf
[root@mongodb_1_p/mongodb_1_s ~]# echo "mongod           hard    stack           9999999" | tee -a /etc/security/limits.conf
[root@mongodb_1_p/mongodb_1_s ~]# echo 9999999 > /proc/sys/vm/max_map_count
[root@mongodb_1_p/mongodb_1_s ~]# echo "vm.max_map_count=9999999" | tee -a /etc/sysctl.conf
[root@mongodb_1_p/mongodb_1_s ~]# echo 1024 65530 > /proc/sys/net/ipv4/ip_local_port_range
[root@mongodb_1_p/mongodb_1_s ~]# echo "net.ipv4.ip_local_port_range = 1024 65530" | tee -a /etc/sysctl.conf
 
-- Step 79.25.7 -->> On All Nodes (FailOver Test - Prepare Node1 & Node2)
[root@mongodb_1_p/mongodb_1_s ~]# systemctl enable mongod --now
[root@mongodb_1_p/mongodb_1_s ~]# systemctl start mongod
[root@mongodb_1_p/mongodb_1_s ~]# systemctl status mongod
/*
● mongod.service - MongoDB Database Server
   Loaded: loaded (/usr/lib/systemd/system/mongod.service; enabled; vendor preset: disabled)
   Active: active (running) since Wed 2023-11-22 15:18:26 +0545; 11s ago
     Docs: https://docs.mongodb.org/manual
 Main PID: 6739 (mongod)
   Memory: 204.7M
   CGroup: /system.slice/mongod.service
           └─6739 /usr/bin/mongod -f /etc/mongod.conf

Nov 22 15:18:26 mongodb_1_p.cibnepal.org.np systemd[1]: Started MongoDB Database Server.
Nov 22 15:18:26 mongodb_1_p.cibnepal.org.np mongod[6739]: {"t":{"$date":"2023-11-22T09:33:26>
*/

-- Step 79.26 -->> On All Nodes (FailOver Test - Prepare Node1 & Node2)
[root@mongodb_1_p/mongodb_1_s ~]# mongosh
/*
Current Mongosh Log ID: 655dcafd7200dec632860b5d
Connecting to:          mongodb://127.0.0.1:27017/?directConnection=true&serverSelectionTimeoutMS=2000&appName=mongosh+2.1.0
Using MongoDB:          7.0.3
Using Mongosh:          2.1.0

For mongosh info see: https://docs.mongodb.com/mongodb-shell/


To help improve our products, anonymous usage data is collected and sent to MongoDB periodically (https://www.mongodb.com/legal/privacy-policy).
You can opt-out by running the disableTelemetry() command.

------
   The server generated these startup warnings when booting
   2023-11-22T15:18:27.347+05:45: Access control is not enabled for the database. Read and write access to data and configuration is unrestricted
   2023-11-22T15:18:27.347+05:45: /sys/kernel/mm/transparent_hugepage/enabled is 'always'. We suggest setting it to 'never'
------

test> db.version()
7.0.3

test> show databases;
admin   40.00 KiB
config  12.00 KiB
local   40.00 KiB

test> quit()
*/

-- Step 79.27 -->> On All Nodes (FailOver Test - Prepare Node1 & Node2)
[root@mongodb_1_p/mongodb_1_s ~]# systemctl stop mongod

-- Step 79.28 -->> On All Nodes (FailOver Test - Prepare Node1 & Node2)
[root@mongodb_1_p/mongodb_1_s ~]# which mongosh
/*
/usr/bin/mongosh
*/

-- Step 79.28.1 -->> On All Nodes (After MongoDB Version 4.4 the "mongo" shell is not avilable) (FailOver Test - Prepare Node1 & Node2)
[root@mongodb_1_p/mongodb_1_s ~]# cd /usr/bin/
[root@mongodb_1_p/mongodb_1_s bin]# ll | grep mongo
/*
-rwxr-xr-x  1 root root    181975272 Oct 31 05:37 mongod
-rwxr-xr-x  1 root root     16188208 Nov 17 23:14 mongodump
-rwxr-xr-x  1 root root     15879336 Nov 17 23:14 mongoexport
-rwxr-xr-x  1 root root     16728016 Nov 17 23:14 mongofiles
-rwxr-xr-x  1 root root     16130752 Nov 17 23:14 mongoimport
-rwxr-xr-x  1 root root     16519184 Nov 17 23:15 mongorestore
-rwxr-xr-x  1 root root    129588096 Oct 31 05:37 mongos
-rwxr-xr-x  1 root root    106665984 Nov 21 00:12 mongosh
-rwxr-xr-x  1 root root     15748480 Nov 17 23:15 mongostat
-rwxr-xr-x  1 root root     15319776 Nov 17 23:15 mongotop
*/

-- Step 79.28.2 -->> On All Nodes (FailOver Test - Prepare Node1 & Node2)
[root@mongodb_1_p/mongodb_1_s bin]# cp mongosh mongo
[root@mongodb_1_p/mongodb_1_s bin]# ll | grep mongo
/*
-rwxr-xr-x  1 root root    106665984 Nov 22 15:21 mongo
-rwxr-xr-x  1 root root    181975272 Oct 31 05:37 mongod
-rwxr-xr-x  1 root root     16188208 Nov 17 23:14 mongodump
-rwxr-xr-x  1 root root     15879336 Nov 17 23:14 mongoexport
-rwxr-xr-x  1 root root     16728016 Nov 17 23:14 mongofiles
-rwxr-xr-x  1 root root     16130752 Nov 17 23:14 mongoimport
-rwxr-xr-x  1 root root     16519184 Nov 17 23:15 mongorestore
-rwxr-xr-x  1 root root    129588096 Oct 31 05:37 mongos
-rwxr-xr-x  1 root root    106665984 Nov 21 00:12 mongosh
-rwxr-xr-x  1 root root     15748480 Nov 17 23:15 mongostat
-rwxr-xr-x  1 root root     15319776 Nov 17 23:15 mongotop
*/

-- Step 79.28.3 -->> On All Nodes (FailOver Test - Prepare Node1 & Node2)
[root@mongodb_1_p/mongodb_1_s ~]# systemctl start mongod
[root@mongodb_1_p/mongodb_1_s ~]# systemctl status mongod
/*
● mongod.service - MongoDB Database Server
   Loaded: loaded (/usr/lib/systemd/system/mongod.service; enabled; vendor preset: disabled)
   Active: active (running) since Wed 2023-11-22 15:21:27 +0545; 4s ago
     Docs: https://docs.mongodb.org/manual
 Main PID: 6878 (mongod)
   Memory: 176.3M
   CGroup: /system.slice/mongod.service
           └─6878 /usr/bin/mongod -f /etc/mongod.conf

Nov 22 15:21:27 mongodb_1_p.cibnepal.org.np systemd[1]: Started MongoDB Database Server.
Nov 22 15:21:27 mongodb_1_p.cibnepal.org.np mongod[6878]: {"t":{"$date":"2023-11-22T09:36:27>
*/

-- Step 79.29 -->> On All Nodes (FailOver Test - Prepare Node1 & Node2)
[root@mongodb_1_p/mongodb_1_s ~]# mongosh
/*
Current Mongosh Log ID: 655dcbb1596706efb6550fa1
Connecting to:          mongodb://127.0.0.1:27017/?directConnection=true&serverSelectionTimeoutMS=2000&appName=mongosh+2.1.0
Using MongoDB:          7.0.3
Using Mongosh:          2.1.0

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

------
   The server generated these startup warnings when booting
   2023-11-22T15:21:28.856+05:45: Access control is not enabled for the database. Read and write access to data and configuration is unrestricted
   2023-11-22T15:21:28.856+05:45: /sys/kernel/mm/transparent_hugepage/enabled is 'always'. We suggest setting it to 'never'
------

test> db.version()
7.0.3

test> show databases
admin   40.00 KiB
config  12.00 KiB
local   72.00 KiB

test> quit()

*/

-- Step 79.30 -->> On All Nodes (FailOver Test - Prepare Node1 & Node2)
[root@mongodb_1_p/mongodb_1_s ~]# mongo
/*
Current Mongosh Log ID: 655dcbd25d5c3ce86d4d2a18
Connecting to:          mongodb://127.0.0.1:27017/?directConnection=true&serverSelectionTimeoutMS=2000&appName=mongosh+2.1.0
Using MongoDB:          7.0.3
Using Mongosh:          2.1.0

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

------
   The server generated these startup warnings when booting
   2023-11-22T15:21:28.856+05:45: Access control is not enabled for the database. Read and write access to data and configuration is unrestricted
   2023-11-22T15:21:28.856+05:45: /sys/kernel/mm/transparent_hugepage/enabled is 'always'. We suggest setting it to 'never'
------

test> db.version()
7.0.3

test> show dbs
admin   40.00 KiB
config  12.00 KiB
local   72.00 KiB

test> quit()
*/

-- Step 79.31 -->> On All Nodes (Fixing The MongoDB Warnings - /sys/kernel/mm/transparent_hugepage/enabled is 'always'. We suggest setting it to 'never') (FailOver Test - Prepare Node1 & Node2)
[root@mongodb_1_p/mongodb_1_s ~]# vi /etc/systemd/system/disable-mogodb-warnig.service
/*
[Unit]
Description=Disable Transparent Huge Pages (THP)
[Service]
Type=simple
ExecStart=/bin/sh -c "echo 'never' > /sys/kernel/mm/transparent_hugepage/enabled && echo 'never' > /sys/kernel/mm/transparent_hugepage/defrag"
[Install]
WantedBy=multi-user.target
*/

-- Step 79.31.1 -->> On All Nodes (FailOver Test - Prepare Node1 & Node2)
[root@mongodb_1_p/mongodb_1_s ~]# systemctl daemon-reload
-- Step 79.31.2 -->> On All Nodes (FailOver Test - Prepare Node1 & Node2)
[root@mongodb_1_p/mongodb_1_s ~]# systemctl start disable-mogodb-warnig.service
-- Step 79.1.3 -->> On All Nodes (FailOver Test - Prepare Node1 & Node2)
[root@mongodb_1_p/mongodb_1_s ~]# systemctl enable disable-mogodb-warnig.service
/*
Created symlink /etc/systemd/system/multi-user.target.wants/disable-mogodb-warnig.service → /etc/systemd/system/disable-mogodb-warnig.service.
*/

-- Step 79.31.4 -->> On All Nodes (FailOver Test - Prepare Node1 & Node2)
[root@mongodb_1_p/mongodb_1_s ~]# systemctl restart mongod
-- Step 79.31.5 -->> On All Nodes (FailOver Test - Prepare Node1 & Node2)
[root@mongodb_1_p/mongodb_1_s ~]# systemctl status mongod
/*
● mongod.service - MongoDB Database Server
   Loaded: loaded (/usr/lib/systemd/system/mongod.service; enabled; vendor preset: disabled)
   Active: active (running) since Wed 2023-11-22 15:23:56 +0545; 4s ago
     Docs: https://docs.mongodb.org/manual
 Main PID: 7087 (mongod)
   Memory: 169.1M
   CGroup: /system.slice/mongod.service
           └─7087 /usr/bin/mongod -f /etc/mongod.conf

Nov 22 15:23:56 mongodb_1_p.cibnepal.org.np systemd[1]: Started MongoDB Database Server.
Nov 22 15:23:56 mongodb_1_p.cibnepal.org.np mongod[7087]: {"t":{"$date":"2023-11-22T09:38:56>
*/

-- Step 79.32 -->> On All Nodes (FailOver Test - Prepare Node1 & Node2)
[root@mongodb_1_p/mongodb_1_s ~]# mongo
/*
Current Mongosh Log ID: 655dcc49956cc08551c61253
Connecting to:          mongodb://127.0.0.1:27017/?directConnection=true&serverSelectionTimeoutMS=2000&appName=mongosh+2.1.0
Using MongoDB:          7.0.3
Using Mongosh:          2.1.0

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

------
   The server generated these startup warnings when booting
   2023-11-22T15:23:58.311+05:45: Access control is not enabled for the database. Read and write access to data and configuration is unrestricted
------

test> db.version()
7.0.3

test> show dbs
admin   40.00 KiB
config  12.00 KiB
local   72.00 KiB

test> quit()
*/

-- Step 79.33 -->> On All Nodes (FailOver Test - Prepare Node1 & Node2)
[root@mongodb_1_p/mongodb_1_s ~]# mongosh
/*
Current Mongosh Log ID: 655dcc6cf83c5d94ebcdf8d8
Connecting to:          mongodb://127.0.0.1:27017/?directConnection=true&serverSelectionTimeoutMS=2000&appName=mongosh+2.1.0
Using MongoDB:          7.0.3
Using Mongosh:          2.1.0

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

------
   The server generated these startup warnings when booting
   2023-11-22T15:23:58.311+05:45: Access control is not enabled for the database. Read and write access to data and configuration is unrestricted
------

test> db.version()
7.0.3

test> show dbs
admin   40.00 KiB
config  12.00 KiB
local   72.00 KiB

test> exit;
*/

-- Step 79.34 -->> On Node 1 (FailOver Test - Prepare Node1 & Node2)
[root@mongodb_1_p ~]# systemctl stop mongod

-- Step 79.35 -->> On Node 1 (Access control is enabled for the database) (FailOver Test - Prepare Node1 & Node2)
[root@mongodb_1_p ~]# vi /etc/mongod.conf
/*
#security:
security:
 authorization: enabled
*/

-- Step 79.36 -->> On Node 1 (FailOver Test - Prepare Node1 & Node2)
[root@mongodb_1_p ~]# systemctl start mongod

-- Step 79.37 -->> On Node 1 (FailOver Test - Prepare Node1 & Node2)
[root@mongodb_1_p ~]# systemctl status mongod
/*
● mongod.service - MongoDB Database Server
   Loaded: loaded (/usr/lib/systemd/system/mongod.service; enabled; vendor preset: disabled)
   Active: active (running) since Wed 2023-11-22 15:31:35 +0545; 6s ago
     Docs: https://docs.mongodb.org/manual
 Main PID: 7972 (mongod)
   Memory: 171.0M
   CGroup: /system.slice/mongod.service
           └─7972 /usr/bin/mongod -f /etc/mongod.conf

Nov 22 15:31:35 mongodb_1_p.cibnepal.org.np systemd[1]: Started MongoDB Database Server.
Nov 22 15:31:35 mongodb_1_p.cibnepal.org.np mongod[7972]: {"t":{"$date":"2023-11-22T09:46:35>
*/

-- Step 79.38 -->> On Node 2 (FailOver Test - Prepare Node1 & Node2)
[root@mongodb_1_s ~]# systemctl stop mongod

-- Step 79.39 -->> On Node 2 (Access control is enabled for the database) (FailOver Test - Prepare Node1 & Node2)
[root@mongodb_1_s ~]# vi /etc/mongod.conf
/*
#security:
security:
 authorization: enabled
*/

-- Step 79.40 -->> On Node 2 (FailOver Test - Prepare Node1 & Node2)
[root@mongodb_1_s ~]# systemctl start mongod

-- Step 79.41 -->> On Node 2 (FailOver Test - Prepare Node1 & Node2)
[root@mongodb_1_s ~]# systemctl status mongod
/*
● mongod.service - MongoDB Database Server
   Loaded: loaded (/usr/lib/systemd/system/mongod.service; enabled; vendor preset: disabled)
   Active: active (running) since Wed 2023-11-22 15:31:37 +0545; 5s ago
     Docs: https://docs.mongodb.org/manual
 Main PID: 53559 (mongod)
   Memory: 171.0M
   CGroup: /system.slice/mongod.service
           └─53559 /usr/bin/mongod -f /etc/mongod.conf

Nov 22 15:31:37 mongodb_1_s.cibnepal.org.np systemd[1]: Started MongoDB Database Server.
Nov 22 15:31:37 mongodb_1_s.cibnepal.org.np mongod[53559]: {"t":{"$date":"2023-11-22T09:46:3>
*/

-- Step 79.42 -->> On All Nodes (Replication Configuration) (FailOver Test - Prepare Node1 & Node2)
[root@mongodb_1_p/mongodb_1_s ~] vi /etc/mongod.conf
/*
#replication:
replication:
 replSetName: rs0
*/

-- Step 79.43 -->> On Node 3 (FailOver Test - Prepare Node1 & Node2)
[root@mongodb_2_s ~]# cd /data/mongodb/

-- Step 79.44 -->> On Node 3 (FailOver Test - Prepare Node1 & Node2)
[root@mongodb_2_s mongodb]# ll | grep keyfile
/*
-r-------- 1 mongod mongod  1024 Nov 18 14:57 keyfile
*/

-- Step 79.45 -->> On Node 3 (FailOver Test - Prepare Node1 & Node2)
[root@mongodb_2_s mongodb]# scp -r keyfile root@mongodb_1_p:/data/mongodb
/*
The authenticity of host 'mongodb_1_p (192.168.56.149)' can't be established.
ECDSA key fingerprint is SHA256:8LSecKw8+L5LHTrspajxlzJvHbKd6BttSMepKXCBTvw.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added 'mongodb_1_p,192.168.56.149' (ECDSA) to the list of known hosts.
root@mongodb_1_p's password:
keyfile                                                    100% 1024   503.6KB/s   00:00
*/

-- Step 79.46 -->> On Node 3 (FailOver Test - Prepare Node1 & Node2)
[root@mongodb_2_s mongodb]# scp -r keyfile root@mongodb_1_s:/data/mongodb
/*
The authenticity of host 'mongodb_1_s (192.168.56.150)' can't be established.
ECDSA key fingerprint is SHA256:8LSecKw8+L5LHTrspajxlzJvHbKd6BttSMepKXCBTvw.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added 'mongodb_1_s,192.168.56.150' (ECDSA) to the list of known hosts.
root@mongodb_1_s's password:
keyfile                                                    100% 1024   588.0KB/s   00:00
*/

-- Step 79.47 -->> On Node 1 (FailOver Test - Prepare Node1 & Node2)
[root@mongodb_1_p ~]# cd /data/mongodb/
-- Step 79.48 -->> On Node 1 (FailOver Test - Prepare Node1 & Node2)
[root@mongodb_1_p mongodb]# ll | grep keyfile
/*
-r-------- 1 root   root    1024 Nov 22 15:33 keyfile
*/

-- Step 79.49 -->> On Node 1 (FailOver Test - Prepare Node1 & Node2)
[root@mongodb_1_p mongodb]# chmod 400 keyfile
-- Step 79.50 -->> On Node 1 (FailOver Test - Prepare Node1 & Node2)
[root@mongodb_1_p mongodb]# chown mongod:mongod keyfile
-- Step 79.51 -->> On Node 1 (FailOver Test - Prepare Node1 & Node2)
[root@mongodb_1_p mongodb]# ll | grep keyfile
/*
-r-------- 1 mongod mongod  1024 Nov 22 15:33 keyfile
*/

-- Step 79.52 -->> On Node 2 (FailOver Test - Prepare Node1 & Node2)
[root@mongodb_1_s ~]# cd /data/mongodb/
-- Step 79.53 -->> On Node 2 (FailOver Test - Prepare Node1 & Node2)
[root@mongodb_1_s mongodb]# ll | grep keyfile
/*
-r-------- 1 root   root    1024 Nov 22 15:33 keyfile
*/

-- Step 79.54 -->> On Node 2 (FailOver Test - Prepare Node1 & Node2)
[root@mongodb_1_s mongodb]# chmod 400 keyfile
-- Step 79.55 -->> On Node 2 (FailOver Test - Prepare Node1 & Node2)
[root@mongodb_1_s mongodb]# chown mongod:mongod keyfile
-- Step 79.56 -->> On Node 2 (FailOver Test - Prepare Node1 & Node2)
[root@mongodb_1_s mongodb]# ll | grep keyfile
/*
-r-------- 1 mongod mongod  1024 Nov 22 15:33 keyfile
*/

-- Step 79.57 -->> On All Nodes (FailOver Test - Prepare Node1 & Node2)
[root@mongodb_1_p/mongodb_1_s ~]# vi /etc/mongod.conf
/*
#security:
security:
 authorization: enabled
 keyFile: /data/mongodb/keyfile
*/

-- Step 79.58 -->> On All Nodes (FailOver Test - Prepare Node1 & Node2)
[root@mongodb_1_p/mongodb_1_s ~]# systemctl restart mongod
-- Step 79.59 -->> On All Nodes (FailOver Test - Prepare Node1 & Node2)
[root@mongodb_1_p/mongodb_1_s ~]# systemctl status mongod
/*
● mongod.service - MongoDB Database Server
   Loaded: loaded (/usr/lib/systemd/system/mongod.service; enabled; vendor preset: disabled)
   Active: active (running) since Wed 2023-11-22 15:36:06 +0545; 6s ago
     Docs: https://docs.mongodb.org/manual
 Main PID: 8172 (mongod)
   Memory: 173.7M
   CGroup: /system.slice/mongod.service
           └─8172 /usr/bin/mongod -f /etc/mongod.conf

Nov 22 15:36:06 mongodb_1_p.cibnepal.org.np systemd[1]: mongod.service: Succeeded.
Nov 22 15:36:06 mongodb_1_p.cibnepal.org.np systemd[1]: Stopped MongoDB Database Server.
Nov 22 15:36:06 mongodb_1_p.cibnepal.org.np systemd[1]: Started MongoDB Database Server.
Nov 22 15:36:06 mongodb_1_p.cibnepal.org.np mongod[8172]: {"t":{"$date":"2023-11-22T09:51:06>
*/

-- Step 80 -->> On Node 3 (FailOver Test)
[root@mongodb_2_s ~]# mongo --host 192.168.56.151  --port 27017 -u admin -p P#ssw0rd --authenticationDatabase admin
/*
Current Mongosh Log ID: 655dcf60e408c09f4820ef2e
Connecting to:          mongodb://<credentials>@192.168.56.151:27017/?directConnection=true&authSource=admin&appName=mongosh+2.0.2
Using MongoDB:          7.0.3
Using Mongosh:          2.0.2
mongosh 2.1.0 is available for download: https://www.mongodb.com/try/download/shell

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

rs0 [direct: primary] test> use admin
switched to db admin

rs0 [direct: primary] admin> db
admin

rs0 [direct: primary] admin> rs.add("mongodb_1_p:27017");
{
  ok: 1,
  '$clusterTime': {
    clusterTime: Timestamp({ t: 1700646799, i: 1 }),
    signature: {
      hash: Binary.createFromBase64("mZme31IRIuearMJlV8HhYfpjoDI=", 0),
      keyId: Long("7303422038071312391")
    }
  },
  operationTime: Timestamp({ t: 1700646799, i: 1 })
}

rs0 [direct: primary] admin> rs.add("mongodb_1_s:27017");
{
  ok: 1,
  '$clusterTime': {
    clusterTime: Timestamp({ t: 1700646804, i: 1 }),
    signature: {
      hash: Binary.createFromBase64("O5IGXm2GSX3cLQAYh4J+2N3NOf4=", 0),
      keyId: Long("7303422038071312391")
    }
  },
  operationTime: Timestamp({ t: 1700646804, i: 1 })
}

rs0 [direct: primary] admin> rs.conf()
{
  _id: 'rs0',
  version: 162652,
  term: 17,
  members: [
    {
      _id: 0,
      host: 'mongodb_2_s:27017',
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
      _id: 2,
      host: 'mongodb_1_s:27017',
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

rs0 [direct: primary] admin> cfg = rs.conf()
{
  _id: 'rs0',
  version: 162652,
  term: 17,
  members: [
    {
      _id: 0,
      host: 'mongodb_2_s:27017',
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
      _id: 2,
      host: 'mongodb_1_s:27017',
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

--Set a high priority for the remaining member
rs0 [direct: primary] admin> cfg.members[0].priority = 30
30

rs0 [direct: primary] admin> cfg.members[1].priority = 20
20

rs0 [direct: primary] admin> cfg.members[2].priority = 10
10

rs0 [direct: primary] admin> rs.reconfig(cfg)
{
  ok: 1,
  '$clusterTime': {
    clusterTime: Timestamp({ t: 1700646945, i: 1 }),
    signature: {
      hash: Binary.createFromBase64("DeJCtu3E0vgMbetoB1hLAIUgxxo=", 0),
      keyId: Long("7303422038071312391")
    }
  },
  operationTime: Timestamp({ t: 1700646945, i: 1 })
}

--Rollback the Changed the members name

rs0 [direct: primary] admin> cfg = rs.conf()
{
  _id: 'rs0',
  version: 162653,
  term: 17,
  members: [
    {
      _id: 0,
      host: 'mongodb_2_s:27017',
      arbiterOnly: false,
      buildIndexes: true,
      hidden: false,
      priority: 30,
      tags: {},
      secondaryDelaySecs: Long("0"),
      votes: 1
    },
    {
      _id: 1,
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
      _id: 2,
      host: 'mongodb_1_s:27017',
      arbiterOnly: false,
      buildIndexes: true,
      hidden: false,
      priority: 10,
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

rs0 [direct: primary] admin> cfg.members[0].host = "192.168.56.149:27017"
192.168.56.149:27017

rs0 [direct: primary] admin> cfg.members[1].host = "192.168.56.150:27017"
192.168.56.150:27017

rs0 [direct: primary] admin> cfg.members[2].host = "192.168.56.151:27017"
192.168.56.151:27017

rs0 [direct: primary] admin> rs.reconfig(cfg, {force: true})
{
  ok: 1,
  '$clusterTime': {
    clusterTime: Timestamp({ t: 1700646990, i: 1 }),
    signature: {
      hash: Binary.createFromBase64("2aeAmMC0fnapF6DypS6j6b5ItPQ=", 0),
      keyId: Long("7303422038071312391")
    }
  },
  operationTime: Timestamp({ t: 1700646990, i: 1 })
}

rs0 [direct: primary] admin> rs.conf()
{
  _id: 'rs0',
  version: 179940,
  members: [
    {
      _id: 0,
      host: '192.168.56.149:27017',
      arbiterOnly: false,
      buildIndexes: true,
      hidden: false,
      priority: 30,
      tags: {},
      secondaryDelaySecs: Long("0"),
      votes: 1
    },
    {
      _id: 1,
      host: '192.168.56.150:27017',
      arbiterOnly: false,
      buildIndexes: true,
      hidden: false,
      priority: 20,
      tags: {},
      secondaryDelaySecs: Long("0"),
      votes: 1
    },
    {
      _id: 2,
      host: '192.168.56.151:27017',
      arbiterOnly: false,
      buildIndexes: true,
      hidden: false,
      priority: 10,
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

rs0 [direct: secondary] admin> cfg = rs.conf()
{
  _id: 'rs0',
  version: 179940,
  members: [
    {
      _id: 0,
      host: '192.168.56.149:27017',
      arbiterOnly: false,
      buildIndexes: true,
      hidden: false,
      priority: 30,
      tags: {},
      secondaryDelaySecs: Long("0"),
      votes: 1
    },
    {
      _id: 1,
      host: '192.168.56.150:27017',
      arbiterOnly: false,
      buildIndexes: true,
      hidden: false,
      priority: 20,
      tags: {},
      secondaryDelaySecs: Long("0"),
      votes: 1
    },
    {
      _id: 2,
      host: '192.168.56.151:27017',
      arbiterOnly: false,
      buildIndexes: true,
      hidden: false,
      priority: 10,
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

rs0 [direct: secondary] admin> cfg.members[0].host = "mongodb_1_p:27017"
mongodb_1_p:27017

rs0 [direct: secondary] admin> cfg.members[1].host = "mongodb_1_s:27017"
mongodb_1_s:27017

rs0 [direct: secondary] admin> cfg.members[2].host = "mongodb_2_s:27017"
mongodb_2_s:27017

rs0 [direct: secondary] admin> rs.reconfig(cfg, {force: true})
{
  ok: 1,
  '$clusterTime': {
    clusterTime: Timestamp({ t: 1700647059, i: 1 }),
    signature: {
      hash: Binary.createFromBase64("m1dgc4Y6WePr/k4b4dIASkuhWJI=", 0),
      keyId: Long("7303422038071312391")
    }
  },
  operationTime: Timestamp({ t: 1700647059, i: 1 })
}

rs0 [direct: secondary] admin> exit
*/

-- Step 81 -->> On Node 1 (FailOver Test)
[root@mongodb_1_p ~]# systemctl restart mongod
-- Step 82 -->> On Node 1 (FailOver Test)
[root@mongodb_1_p ~]# systemctl status mongod
/*
● mongod.service - MongoDB Database Server
   Loaded: loaded (/usr/lib/systemd/system/mongod.service; enabled; vendor preset: disabled)
   Active: active (running) since Wed 2023-11-22 15:45:26 +0545; 27s ago
     Docs: https://docs.mongodb.org/manual
 Main PID: 8575 (mongod)
   Memory: 188.0M
   CGroup: /system.slice/mongod.service
           └─8575 /usr/bin/mongod -f /etc/mongod.conf

Nov 22 15:45:26 mongodb_1_p.cibnepal.org.np systemd[1]: Started MongoDB Database Server.
Nov 22 15:45:26 mongodb_1_p.cibnepal.org.np mongod[8575]: {"t":{"$date":"2023-11-22T10:00:26>
*/

-- Step 82 -->> On Node 2 (FailOver Test)
[root@mongodb_1_s ~]# systemctl restart mongod
-- Step 83 -->> On Node 2 (FailOver Test)
[root@mongodb_1_s ~]# systemctl status mongod
/*
● mongod.service - MongoDB Database Server
   Loaded: loaded (/usr/lib/systemd/system/mongod.service; enabled; vendor preset: disabled)
   Active: active (running) since Wed 2023-11-22 15:45:47 +0545; 31s ago
     Docs: https://docs.mongodb.org/manual
 Main PID: 54101 (mongod)
   Memory: 185.8M
   CGroup: /system.slice/mongod.service
           └─54101 /usr/bin/mongod -f /etc/mongod.conf

Nov 22 15:45:47 mongodb_1_s.cibnepal.org.np systemd[1]: mongod.service: Succeeded.
Nov 22 15:45:47 mongodb_1_s.cibnepal.org.np systemd[1]: Stopped MongoDB Database Server.
Nov 22 15:45:47 mongodb_1_s.cibnepal.org.np systemd[1]: Started MongoDB Database Server.
Nov 22 15:45:47 mongodb_1_s.cibnepal.org.np mongod[54101]: {"t":{"$date":"2023-11-22T10:00:47>
*/

-- Step 84 -->> On Node 3 (FailOver Test)
[root@mongodb_2_s ~]#  systemctl restart mongod
-- Step 85 -->> On Node 3 (FailOver Test)
[root@mongodb_2_s ~]#  systemctl status mongod
/*
● mongod.service - MongoDB Database Server
   Loaded: loaded (/usr/lib/systemd/system/mongod.service; enabled; vendor preset: disabled)
   Active: active (running) since Wed 2023-11-22 15:46:46 +0545; 6s ago
     Docs: https://docs.mongodb.org/manual
 Main PID: 8053 (mongod)
   Memory: 181.9M
   CGroup: /system.slice/mongod.service
           └─8053 /usr/bin/mongod -f /etc/mongod.conf

Nov 22 15:46:46 mongodb_2_s.cibnepal.org.np systemd[1]: mongod.service: Succeeded.
Nov 22 15:46:46 mongodb_2_s.cibnepal.org.np systemd[1]: Stopped MongoDB Database Server.
Nov 22 15:46:46 mongodb_2_s.cibnepal.org.np systemd[1]: Started MongoDB Database Server.
Nov 22 15:46:46 mongodb_2_s.cibnepal.org.np mongod[8053]: {"t":{"$date":"2023-11-22T10:01:46>
*/

-- Step 86 -->> On Node 1 (FailOver Test)
[root@mongodb_1_p ~]# mongo --host 192.168.56.149  --port 27017 -u admin -p P#ssw0rd --authenticationDatabase admin
/*
Current Mongosh Log ID: 655dd1cb1077e927cdb3c076
Connecting to:          mongodb://<credentials>@192.168.56.149:27017/?directConnection=true&authSource=admin&appName=mongosh+2.1.0
Using MongoDB:          7.0.3
Using Mongosh:          2.1.0

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

rs0 [direct: primary] test> db.version()
7.0.3

rs0 [direct: primary] test> use admin
switched to db admin

rs0 [direct: primary] admin> db
admin

rs0 [direct: primary] admin> db.getUsers()
{
  users: [
    {
      _id: 'admin.admin',
      userId: UUID('b9228be9-e730-4f47-988f-d98e5152b2d4'),
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
    clusterTime: Timestamp({ t: 1700647382, i: 1 }),
    signature: {
      hash: Binary.createFromBase64('2saQPPW8nH+J5+FxAdk1vpWoWiU=', 0),
      keyId: Long('7303422038071312391')
    }
  },
  operationTime: Timestamp({ t: 1700647382, i: 1 })
}

rs0 [direct: primary] admin> rs.conf()
{
  _id: 'rs0',
  version: 196215,
  members: [
    {
      _id: 0,
      host: 'mongodb_1_p:27017',
      arbiterOnly: false,
      buildIndexes: true,
      hidden: false,
      priority: 30,
      tags: {},
      secondaryDelaySecs: Long('0'),
      votes: 1
    },
    {
      _id: 1,
      host: 'mongodb_1_s:27017',
      arbiterOnly: false,
      buildIndexes: true,
      hidden: false,
      priority: 20,
      tags: {},
      secondaryDelaySecs: Long('0'),
      votes: 1
    },
    {
      _id: 2,
      host: 'mongodb_2_s:27017',
      arbiterOnly: false,
      buildIndexes: true,
      hidden: false,
      priority: 10,
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
    replicaSetId: ObjectId('655af7a64c8b1dfa072b3da8')
  }
}

rs0 [direct: primary] admin> rs.isMaster()
{
  topologyVersion: {
    processId: ObjectId('655dd13aee0adf116345a70d'),
    counter: Long('5')
  },
  hosts: [ 'mongodb_1_p:27017', 'mongodb_1_s:27017', 'mongodb_2_s:27017' ],
  setName: 'rs0',
  setVersion: 196215,
  ismaster: true,
  secondary: false,
  primary: 'mongodb_1_p:27017',
  me: 'mongodb_1_p:27017',
  electionId: ObjectId('7fffffff0000000000000015'),
  lastWrite: {
    opTime: { ts: Timestamp({ t: 1700647422, i: 1 }), t: Long('21') },
    lastWriteDate: ISODate('2023-11-22T10:03:42.000Z'),
    majorityOpTime: { ts: Timestamp({ t: 1700647422, i: 1 }), t: Long('21') },
    majorityWriteDate: ISODate('2023-11-22T10:03:42.000Z')
  },
  maxBsonObjectSize: 16777216,
  maxMessageSizeBytes: 48000000,
  maxWriteBatchSize: 100000,
  localTime: ISODate('2023-11-22T10:03:46.740Z'),
  logicalSessionTimeoutMinutes: 30,
  connectionId: 67,
  minWireVersion: 0,
  maxWireVersion: 21,
  readOnly: false,
  ok: 1,
  '$clusterTime': {
    clusterTime: Timestamp({ t: 1700647422, i: 1 }),
    signature: {
      hash: Binary.createFromBase64('54GsVvGRC9IQk6T6kOkI0wqmKRI=', 0),
      keyId: Long('7303422038071312391')
    }
  },
  operationTime: Timestamp({ t: 1700647422, i: 1 }),
  isWritablePrimary: true
}

rs0 [direct: primary] admin> rs.status()
{
  set: 'rs0',
  date: ISODate('2023-11-22T10:04:01.268Z'),
  myState: 1,
  term: Long('21'),
  syncSourceHost: '',
  syncSourceId: -1,
  heartbeatIntervalMillis: Long('2000'),
  majorityVoteCount: 2,
  writeMajorityCount: 2,
  votingMembersCount: 3,
  writableVotingMembersCount: 3,
  optimes: {
    lastCommittedOpTime: { ts: Timestamp({ t: 1700647432, i: 1 }), t: Long('21') },
    lastCommittedWallTime: ISODate('2023-11-22T10:03:52.765Z'),
    readConcernMajorityOpTime: { ts: Timestamp({ t: 1700647432, i: 1 }), t: Long('21') },
    appliedOpTime: { ts: Timestamp({ t: 1700647432, i: 1 }), t: Long('21') },
    durableOpTime: { ts: Timestamp({ t: 1700647432, i: 1 }), t: Long('21') },
    lastAppliedWallTime: ISODate('2023-11-22T10:03:52.765Z'),
    lastDurableWallTime: ISODate('2023-11-22T10:03:52.765Z')
  },
  lastStableRecoveryTimestamp: Timestamp({ t: 1700647402, i: 1 }),
  electionCandidateMetrics: {
    lastElectionReason: 'priorityTakeover',
    lastElectionDate: ISODate('2023-11-22T10:00:42.718Z'),
    electionTerm: Long('21'),
    lastCommittedOpTimeAtElection: { ts: Timestamp({ t: 1700647239, i: 4 }), t: Long('20') },
    lastSeenOpTimeAtElection: { ts: Timestamp({ t: 1700647239, i: 4 }), t: Long('20') },
    numVotesNeeded: 2,
    priorityAtElection: 30,
    electionTimeoutMillis: Long('10000'),
    priorPrimaryMemberId: 2,
    numCatchUpOps: Long('0'),
    newTermStartDate: ISODate('2023-11-22T10:00:42.729Z'),
    wMajorityWriteAvailabilityDate: ISODate('2023-11-22T10:00:43.242Z')
  },
  electionParticipantMetrics: {
    votedForCandidate: true,
    electionTerm: Long('20'),
    lastVoteDate: ISODate('2023-11-22T10:00:31.685Z'),
    electionCandidateMemberId: 2,
    voteReason: '',
    lastAppliedOpTimeAtElection: { ts: Timestamp({ t: 1700647221, i: 1 }), t: Long('19') },
    maxAppliedOpTimeInSet: { ts: Timestamp({ t: 1700647221, i: 1 }), t: Long('19') },
    priorityAtElection: 30
  },
  members: [
    {
      _id: 0,
      name: 'mongodb_1_p:27017',
      health: 1,
      state: 1,
      stateStr: 'PRIMARY',
      uptime: 215,
      optime: { ts: Timestamp({ t: 1700647432, i: 1 }), t: Long('21') },
      optimeDate: ISODate('2023-11-22T10:03:52.000Z'),
      lastAppliedWallTime: ISODate('2023-11-22T10:03:52.765Z'),
      lastDurableWallTime: ISODate('2023-11-22T10:03:52.765Z'),
      syncSourceHost: '',
      syncSourceId: -1,
      infoMessage: '',
      electionTime: Timestamp({ t: 1700647242, i: 1 }),
      electionDate: ISODate('2023-11-22T10:00:42.000Z'),
      configVersion: 196215,
      configTerm: -1,
      self: true,
      lastHeartbeatMessage: ''
    },
    {
      _id: 1,
      name: 'mongodb_1_s:27017',
      health: 1,
      state: 2,
      stateStr: 'SECONDARY',
      uptime: 213,
      optime: { ts: Timestamp({ t: 1700647432, i: 1 }), t: Long('21') },
      optimeDurable: { ts: Timestamp({ t: 1700647432, i: 1 }), t: Long('21') },
      optimeDate: ISODate('2023-11-22T10:03:52.000Z'),
      optimeDurableDate: ISODate('2023-11-22T10:03:52.000Z'),
      lastAppliedWallTime: ISODate('2023-11-22T10:03:52.765Z'),
      lastDurableWallTime: ISODate('2023-11-22T10:03:52.765Z'),
      lastHeartbeat: ISODate('2023-11-22T10:04:00.981Z'),
      lastHeartbeatRecv: ISODate('2023-11-22T10:03:59.439Z'),
      pingMs: Long('0'),
      lastHeartbeatMessage: '',
      syncSourceHost: 'mongodb_1_p:27017',
      syncSourceId: 0,
      infoMessage: '',
      configVersion: 196215,
      configTerm: -1
    },
    {
      _id: 2,
      name: 'mongodb_2_s:27017',
      health: 1,
      state: 2,
      stateStr: 'SECONDARY',
      uptime: 132,
      optime: { ts: Timestamp({ t: 1700647432, i: 1 }), t: Long('21') },
      optimeDurable: { ts: Timestamp({ t: 1700647432, i: 1 }), t: Long('21') },
      optimeDate: ISODate('2023-11-22T10:03:52.000Z'),
      optimeDurableDate: ISODate('2023-11-22T10:03:52.000Z'),
      lastAppliedWallTime: ISODate('2023-11-22T10:03:52.765Z'),
      lastDurableWallTime: ISODate('2023-11-22T10:03:52.765Z'),
      lastHeartbeat: ISODate('2023-11-22T10:04:00.982Z'),
      lastHeartbeatRecv: ISODate('2023-11-22T10:03:59.665Z'),
      pingMs: Long('0'),
      lastHeartbeatMessage: '',
      syncSourceHost: 'mongodb_1_s:27017',
      syncSourceId: 1,
      infoMessage: '',
      configVersion: 196215,
      configTerm: -1
    }
  ],
  ok: 1,
  '$clusterTime': {
    clusterTime: Timestamp({ t: 1700647432, i: 1 }),
    signature: {
      hash: Binary.createFromBase64('Hes6jxcNoyOP4GMsgOTevXXZcLw=', 0),
      keyId: Long('7303422038071312391')
    }
  },
  operationTime: Timestamp({ t: 1700647432, i: 1 })
}

rs0 [direct: primary] admin> use devesh
switched to db devesh

rs0 [direct: primary] devesh> show collections
tbl_cib
tbl_cib_2
tbl_cib_3
tbl_cib_4
tbl_cib_5

rs0 [direct: primary] devesh> db.tbl_cib_5.find().pretty()
[
  {
    _id: ObjectId('655dc3acf41af313621aafef'),
    name: 'Devesh',
    age: 44
  },
  {
    _id: ObjectId('655dc3acf41af313621aaff0'),
    name: 'Devesh',
    age: 44
  },
  { _id: ObjectId('655dc3acf41af313621aaff1'), name: 'Madhu', age: 40 },
  {
    _id: ObjectId('655dc3aef41af313621aaff2'),
    name: 'Devesh',
    age: 25
  }
]

rs0 [direct: primary] devesh> rs.printSecondaryReplicationInfo()
source: mongodb_1_s:27017
{
  syncedTo: 'Wed Nov 22 2023 15:50:27 GMT+0545 (Nepal Time)',
  replLag: '0 secs (0 hrs) behind the primary '
}
---
source: mongodb_2_s:27017
{
  syncedTo: 'Wed Nov 22 2023 15:50:27 GMT+0545 (Nepal Time)',
  replLag: '0 secs (0 hrs) behind the primary '
}

rs0 [direct: primary] devesh> quit()
*/

-- Step 87 -->> On Node 2 (FailOver Test)
[root@mongodb_1_s ~]# mongo --host 192.168.56.150  --port 27017 -u admin -p P#ssw0rd --authenticationDatabase admin
/*
Current Mongosh Log ID: 655dd2aeb2f7482bc6411653
Connecting to:          mongodb://<credentials>@192.168.56.150:27017/?directConnection=true&authSource=admin&appName=mongosh+2.1.0
Using MongoDB:          7.0.3
Using Mongosh:          2.1.0

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

rs0 [direct: secondary] test> db.version()
7.0.3

rs0 [direct: secondary] test> use admin
switched to db admin

rs0 [direct: secondary] admin> db
admin

rs0 [direct: secondary] admin> rs.secondaryOk()
DeprecationWarning: .setSecondaryOk() is deprecated. Use .setReadPref("primaryPreferred") instead
Setting read preference from "primary" to "primaryPreferred"

rs0 [direct: secondary] admin> db.getUsers()
{
  users: [
    {
      _id: 'admin.admin',
      userId: UUID('b9228be9-e730-4f47-988f-d98e5152b2d4'),
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
    clusterTime: Timestamp({ t: 1700647622, i: 1 }),
    signature: {
      hash: Binary.createFromBase64('8RSNOIwDURPaUwyJa0KBoGC6Hzc=', 0),
      keyId: Long('7303422038071312391')
    }
  },
  operationTime: Timestamp({ t: 1700647622, i: 1 })
}

rs0 [direct: secondary] admin> rs.conf()
{
  _id: 'rs0',
  version: 196215,
  members: [
    {
      _id: 0,
      host: 'mongodb_1_p:27017',
      arbiterOnly: false,
      buildIndexes: true,
      hidden: false,
      priority: 30,
      tags: {},
      secondaryDelaySecs: Long('0'),
      votes: 1
    },
    {
      _id: 1,
      host: 'mongodb_1_s:27017',
      arbiterOnly: false,
      buildIndexes: true,
      hidden: false,
      priority: 20,
      tags: {},
      secondaryDelaySecs: Long('0'),
      votes: 1
    },
    {
      _id: 2,
      host: 'mongodb_2_s:27017',
      arbiterOnly: false,
      buildIndexes: true,
      hidden: false,
      priority: 10,
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
    replicaSetId: ObjectId('655af7a64c8b1dfa072b3da8')
  }
}

rs0 [direct: secondary] admin> rs.isMaster()
{
  topologyVersion: {
    processId: ObjectId('655dd14fdefa5bafbb74aa17'),
    counter: Long('3')
  },
  hosts: [ 'mongodb_1_p:27017', 'mongodb_1_s:27017', 'mongodb_2_s:27017' ],
  setName: 'rs0',
  setVersion: 196215,
  ismaster: false,
  secondary: true,
  primary: 'mongodb_1_p:27017',
  me: 'mongodb_1_s:27017',
  lastWrite: {
    opTime: { ts: Timestamp({ t: 1700647662, i: 1 }), t: Long('21') },
    lastWriteDate: ISODate('2023-11-22T10:07:42.000Z'),
    majorityOpTime: { ts: Timestamp({ t: 1700647662, i: 1 }), t: Long('21') },
    majorityWriteDate: ISODate('2023-11-22T10:07:42.000Z')
  },
  maxBsonObjectSize: 16777216,
  maxMessageSizeBytes: 48000000,
  maxWriteBatchSize: 100000,
  localTime: ISODate('2023-11-22T10:07:46.277Z'),
  logicalSessionTimeoutMinutes: 30,
  connectionId: 46,
  minWireVersion: 0,
  maxWireVersion: 21,
  readOnly: false,
  ok: 1,
  '$clusterTime': {
    clusterTime: Timestamp({ t: 1700647662, i: 1 }),
    signature: {
      hash: Binary.createFromBase64('jFCx9sBDJgbzylencoxXrfr1NKE=', 0),
      keyId: Long('7303422038071312391')
    }
  },
  operationTime: Timestamp({ t: 1700647662, i: 1 }),
  isWritablePrimary: false
}

rs0 [direct: secondary] admin> rs.status()
{
  set: 'rs0',
  date: ISODate('2023-11-22T10:08:24.682Z'),
  myState: 2,
  term: Long('21'),
  syncSourceHost: 'mongodb_1_p:27017',
  syncSourceId: 0,
  heartbeatIntervalMillis: Long('2000'),
  majorityVoteCount: 2,
  writeMajorityCount: 2,
  votingMembersCount: 3,
  writableVotingMembersCount: 3,
  optimes: {
    lastCommittedOpTime: { ts: Timestamp({ t: 1700647702, i: 1 }), t: Long('21') },
    lastCommittedWallTime: ISODate('2023-11-22T10:08:22.834Z'),
    readConcernMajorityOpTime: { ts: Timestamp({ t: 1700647702, i: 1 }), t: Long('21') },
    appliedOpTime: { ts: Timestamp({ t: 1700647702, i: 1 }), t: Long('21') },
    durableOpTime: { ts: Timestamp({ t: 1700647702, i: 1 }), t: Long('21') },
    lastAppliedWallTime: ISODate('2023-11-22T10:08:22.834Z'),
    lastDurableWallTime: ISODate('2023-11-22T10:08:22.834Z')
  },
  lastStableRecoveryTimestamp: Timestamp({ t: 1700647662, i: 1 }),
  members: [
    {
      _id: 0,
      name: 'mongodb_1_p:27017',
      health: 1,
      state: 1,
      stateStr: 'PRIMARY',
      uptime: 456,
      optime: { ts: Timestamp({ t: 1700647702, i: 1 }), t: Long('21') },
      optimeDurable: { ts: Timestamp({ t: 1700647702, i: 1 }), t: Long('21') },
      optimeDate: ISODate('2023-11-22T10:08:22.000Z'),
      optimeDurableDate: ISODate('2023-11-22T10:08:22.000Z'),
      lastAppliedWallTime: ISODate('2023-11-22T10:08:22.834Z'),
      lastDurableWallTime: ISODate('2023-11-22T10:08:22.834Z'),
      lastHeartbeat: ISODate('2023-11-22T10:08:23.830Z'),
      lastHeartbeatRecv: ISODate('2023-11-22T10:08:23.399Z'),
      pingMs: Long('0'),
      lastHeartbeatMessage: '',
      syncSourceHost: '',
      syncSourceId: -1,
      infoMessage: '',
      electionTime: Timestamp({ t: 1700647242, i: 1 }),
      electionDate: ISODate('2023-11-22T10:00:42.000Z'),
      configVersion: 196215,
      configTerm: -1
    },
    {
      _id: 1,
      name: 'mongodb_1_s:27017',
      health: 1,
      state: 2,
      stateStr: 'SECONDARY',
      uptime: 457,
      optime: { ts: Timestamp({ t: 1700647702, i: 1 }), t: Long('21') },
      optimeDate: ISODate('2023-11-22T10:08:22.000Z'),
      lastAppliedWallTime: ISODate('2023-11-22T10:08:22.834Z'),
      lastDurableWallTime: ISODate('2023-11-22T10:08:22.834Z'),
      syncSourceHost: 'mongodb_1_p:27017',
      syncSourceId: 0,
      infoMessage: '',
      configVersion: 196215,
      configTerm: -1,
      self: true,
      lastHeartbeatMessage: ''
    },
    {
      _id: 2,
      name: 'mongodb_2_s:27017',
      health: 1,
      state: 2,
      stateStr: 'SECONDARY',
      uptime: 396,
      optime: { ts: Timestamp({ t: 1700647702, i: 1 }), t: Long('21') },
      optimeDurable: { ts: Timestamp({ t: 1700647702, i: 1 }), t: Long('21') },
      optimeDate: ISODate('2023-11-22T10:08:22.000Z'),
      optimeDurableDate: ISODate('2023-11-22T10:08:22.000Z'),
      lastAppliedWallTime: ISODate('2023-11-22T10:08:22.834Z'),
      lastDurableWallTime: ISODate('2023-11-22T10:08:22.834Z'),
      lastHeartbeat: ISODate('2023-11-22T10:08:23.399Z'),
      lastHeartbeatRecv: ISODate('2023-11-22T10:08:24.052Z'),
      pingMs: Long('0'),
      lastHeartbeatMessage: '',
      syncSourceHost: 'mongodb_1_s:27017',
      syncSourceId: 1,
      infoMessage: '',
      configVersion: 196215,
      configTerm: -1
    }
  ],
  ok: 1,
  '$clusterTime': {
    clusterTime: Timestamp({ t: 1700647702, i: 1 }),
    signature: {
      hash: Binary.createFromBase64('cc4GKemAgt9qun3oIcDMR7p3P1U=', 0),
      keyId: Long('7303422038071312391')
    }
  },
  operationTime: Timestamp({ t: 1700647702, i: 1 })
}

rs0 [direct: secondary] admin> show dbs
admin   140.00 KiB
config  316.00 KiB
devesh  116.00 KiB
local   452.00 KiB

rs0 [direct: secondary] admin> use devesh
switched to db devesh

rs0 [direct: secondary] devesh> show collections
tbl_cib
tbl_cib_2
tbl_cib_3
tbl_cib_4
tbl_cib_5

rs0 [direct: secondary] devesh> db.tbl_cib_4.find().pretty()

rs0 [direct: secondary] devesh> db.tbl_cib_5.find().pretty()
[
  {
    _id: ObjectId('655dc3acf41af313621aafef'),
    name: 'Devesh',
    age: 44
  },
  {
    _id: ObjectId('655dc3acf41af313621aaff0'),
    name: 'Devesh',
    age: 44
  },
  { _id: ObjectId('655dc3acf41af313621aaff1'), name: 'Madhu', age: 40 },
  {
    _id: ObjectId('655dc3aef41af313621aaff2'),
    name: 'Devesh',
    age: 25
  }
]

rs0 [direct: secondary] devesh> rs.printSecondaryReplicationInfo()
source: mongodb_1_s:27017
{
  syncedTo: 'Wed Nov 22 2023 15:54:22 GMT+0545 (Nepal Time)',
  replLag: '0 secs (0 hrs) behind the primary '
}
---
source: mongodb_2_s:27017
{
  syncedTo: 'Wed Nov 22 2023 15:54:22 GMT+0545 (Nepal Time)',
  replLag: '0 secs (0 hrs) behind the primary '
}

rs0 [direct: secondary] devesh> quit()
*/

-- Step 88 -->> On Node 3 (FailOver Test)
[root@mongodb_2_s ~]# mongo --host 192.168.56.151 --port 27017 -u admin -p P#ssw0rd --authenticationDatabase admin
/*
Current Mongosh Log ID: 655dd3871d80981831474c17
Connecting to:          mongodb://<credentials>@192.168.56.151:27017/?directConnection=true&authSource=admin&appName=mongosh+2.0.2
Using MongoDB:          7.0.3
Using Mongosh:          2.0.2
mongosh 2.1.0 is available for download: https://www.mongodb.com/try/download/shell

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

rs0 [direct: secondary] test> db.version()
7.0.3

rs0 [direct: secondary] test> use admin
switched to db admin

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
    clusterTime: Timestamp({ t: 1700647872, i: 1 }),
    signature: {
      hash: Binary.createFromBase64("tqWWjKx0bxQ9FEbY/LaKWVonxrs=", 0),
      keyId: Long("7303422038071312391")
    }
  },
  operationTime: Timestamp({ t: 1700647872, i: 1 })
}

rs0 [direct: secondary] admin> rs.conf()
{
  _id: 'rs0',
  version: 196215,
  members: [
    {
      _id: 0,
      host: 'mongodb_1_p:27017',
      arbiterOnly: false,
      buildIndexes: true,
      hidden: false,
      priority: 30,
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
      priority: 20,
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
      priority: 10,
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

rs0 [direct: secondary] admin> rs.isMaster()
{
  topologyVersion: {
    processId: ObjectId("655dd18a2cc735e10e0e917b"),
    counter: Long("3")
  },
  hosts: [ 'mongodb_1_p:27017', 'mongodb_1_s:27017', 'mongodb_2_s:27017' ],
  setName: 'rs0',
  setVersion: 196215,
  ismaster: false,
  secondary: true,
  primary: 'mongodb_1_p:27017',
  me: 'mongodb_2_s:27017',
  lastWrite: {
    opTime: { ts: Timestamp({ t: 1700647922, i: 1 }), t: Long("21") },
    lastWriteDate: ISODate("2023-11-22T10:12:02.000Z"),
    majorityOpTime: { ts: Timestamp({ t: 1700647922, i: 1 }), t: Long("21") },
    majorityWriteDate: ISODate("2023-11-22T10:12:02.000Z")
  },
  maxBsonObjectSize: 16777216,
  maxMessageSizeBytes: 48000000,
  maxWriteBatchSize: 100000,
  localTime: ISODate("2023-11-22T10:12:06.891Z"),
  logicalSessionTimeoutMinutes: 30,
  connectionId: 33,
  minWireVersion: 0,
  maxWireVersion: 21,
  readOnly: false,
  ok: 1,
  '$clusterTime': {
    clusterTime: Timestamp({ t: 1700647922, i: 1 }),
    signature: {
      hash: Binary.createFromBase64("jDNB1vjsKFdh/ITXYmc7hlSL/QQ=", 0),
      keyId: Long("7303422038071312391")
    }
  },
  operationTime: Timestamp({ t: 1700647922, i: 1 }),
  isWritablePrimary: false
}

rs0 [direct: secondary] admin> rs.status()
{
  set: 'rs0',
  date: ISODate("2023-11-22T10:12:19.220Z"),
  myState: 2,
  term: Long("21"),
  syncSourceHost: 'mongodb_1_s:27017',
  syncSourceId: 1,
  heartbeatIntervalMillis: Long("2000"),
  majorityVoteCount: 2,
  writeMajorityCount: 2,
  votingMembersCount: 3,
  writableVotingMembersCount: 3,
  optimes: {
    lastCommittedOpTime: { ts: Timestamp({ t: 1700647932, i: 1 }), t: Long("21") },
    lastCommittedWallTime: ISODate("2023-11-22T10:12:12.904Z"),
    readConcernMajorityOpTime: { ts: Timestamp({ t: 1700647932, i: 1 }), t: Long("21") },
    appliedOpTime: { ts: Timestamp({ t: 1700647932, i: 1 }), t: Long("21") },
    durableOpTime: { ts: Timestamp({ t: 1700647932, i: 1 }), t: Long("21") },
    lastAppliedWallTime: ISODate("2023-11-22T10:12:12.904Z"),
    lastDurableWallTime: ISODate("2023-11-22T10:12:12.904Z")
  },
  lastStableRecoveryTimestamp: Timestamp({ t: 1700647907, i: 1 }),
  members: [
    {
      _id: 0,
      name: 'mongodb_1_p:27017',
      health: 1,
      state: 1,
      stateStr: 'PRIMARY',
      uptime: 631,
      optime: { ts: Timestamp({ t: 1700647932, i: 1 }), t: Long("21") },
      optimeDurable: { ts: Timestamp({ t: 1700647932, i: 1 }), t: Long("21") },
      optimeDate: ISODate("2023-11-22T10:12:12.000Z"),
      optimeDurableDate: ISODate("2023-11-22T10:12:12.000Z"),
      lastAppliedWallTime: ISODate("2023-11-22T10:12:12.904Z"),
      lastDurableWallTime: ISODate("2023-11-22T10:12:12.904Z"),
      lastHeartbeat: ISODate("2023-11-22T10:12:18.419Z"),
      lastHeartbeatRecv: ISODate("2023-11-22T10:12:17.738Z"),
      pingMs: Long("0"),
      lastHeartbeatMessage: '',
      syncSourceHost: '',
      syncSourceId: -1,
      infoMessage: '',
      electionTime: Timestamp({ t: 1700647242, i: 1 }),
      electionDate: ISODate("2023-11-22T10:00:42.000Z"),
      configVersion: 196215,
      configTerm: -1
    },
    {
      _id: 1,
      name: 'mongodb_1_s:27017',
      health: 1,
      state: 2,
      stateStr: 'SECONDARY',
      uptime: 631,
      optime: { ts: Timestamp({ t: 1700647932, i: 1 }), t: Long("21") },
      optimeDurable: { ts: Timestamp({ t: 1700647932, i: 1 }), t: Long("21") },
      optimeDate: ISODate("2023-11-22T10:12:12.000Z"),
      optimeDurableDate: ISODate("2023-11-22T10:12:12.000Z"),
      lastAppliedWallTime: ISODate("2023-11-22T10:12:12.904Z"),
      lastDurableWallTime: ISODate("2023-11-22T10:12:12.904Z"),
      lastHeartbeat: ISODate("2023-11-22T10:12:18.418Z"),
      lastHeartbeatRecv: ISODate("2023-11-22T10:12:17.738Z"),
      pingMs: Long("0"),
      lastHeartbeatMessage: '',
      syncSourceHost: 'mongodb_1_p:27017',
      syncSourceId: 0,
      infoMessage: '',
      configVersion: 196215,
      configTerm: -1
    },
    {
      _id: 2,
      name: 'mongodb_2_s:27017',
      health: 1,
      state: 2,
      stateStr: 'SECONDARY',
      uptime: 633,
      optime: { ts: Timestamp({ t: 1700647932, i: 1 }), t: Long("21") },
      optimeDate: ISODate("2023-11-22T10:12:12.000Z"),
      lastAppliedWallTime: ISODate("2023-11-22T10:12:12.904Z"),
      lastDurableWallTime: ISODate("2023-11-22T10:12:12.904Z"),
      syncSourceHost: 'mongodb_1_s:27017',
      syncSourceId: 1,
      infoMessage: '',
      configVersion: 196215,
      configTerm: -1,
      self: true,
      lastHeartbeatMessage: ''
    }
  ],
  ok: 1,
  '$clusterTime': {
    clusterTime: Timestamp({ t: 1700647932, i: 1 }),
    signature: {
      hash: Binary.createFromBase64("dc5ZgyQBMbv8XjwDHq5ZasO+Ero=", 0),
      keyId: Long("7303422038071312391")
    }
  },
  operationTime: Timestamp({ t: 1700647932, i: 1 })
}

rs0 [direct: secondary] admin> show dbs
admin   188.00 KiB
config  348.00 KiB
devesh  104.00 KiB
local   504.00 KiB

rs0 [direct: secondary] admin> use devesh
switched to db devesh

rs0 [direct: secondary] devesh> show collections
tbl_cib
tbl_cib_2
tbl_cib_3
tbl_cib_4
tbl_cib_5

rs0 [direct: secondary] devesh> db.tbl_cib_5.find().pretty()
[
  {
    _id: ObjectId("655dc3acf41af313621aafef"),
    name: 'Devesh',
    age: 44
  },
  {
    _id: ObjectId("655dc3acf41af313621aaff0"),
    name: 'Devesh',
    age: 44
  },
  { _id: ObjectId("655dc3acf41af313621aaff1"), name: 'Madhu', age: 40 },
  {
    _id: ObjectId("655dc3aef41af313621aaff2"),
    name: 'Devesh',
    age: 25
  }
]

rs0 [direct: secondary] devesh> rs.printSecondaryReplicationInfo()
source: mongodb_1_s:27017
{
  syncedTo: 'Wed Nov 22 2023 15:58:02 GMT+0545 (Nepal Time)',
  replLag: '0 secs (0 hrs) behind the primary '
}
---
source: mongodb_2_s:27017
{
  syncedTo: 'Wed Nov 22 2023 15:58:02 GMT+0545 (Nepal Time)',
  replLag: '0 secs (0 hrs) behind the primary '
}

rs0 [direct: secondary] devesh> quit()
*/


--END
-------------------------Use Full----------------------------
/*
cfg = rs.conf()
--Remove the other members from the configuration
cfg.members = [cfg.members[0]]
--Set a high priority for the remaining member
cfg.members[0].priority = 20
--Apply the new configuration with force option
rs.reconfig(cfg, {force: true})

--Remove the replica member
rs.remove("mongodb_1_s:27017")
--Add the replica member
rs.add("mongodb_1_s:27017");

--To check the hostname or IP address
db.adminCommand({ getCmdLineOpts: 1 }).parsed.net.bindIp

--Remove 2 servers starting at index 1 - documentation here
cfg = rs.conf();
cfg.members.splice(1,2); 
rs.reconfig(cfg, {force: true});

--In this way you will be able to accesso in read-only mode the data. In order to navigate dbs you will need to run the following command first:
rs.secondaryOk()
db.getMongo().setReadPref("secondary")
db.getMongo().setReadPref("secondaryPreferred")

--Run the rs.printSecondaryReplicationInfo() method to determine if any nodes are lagging:
rs.printSecondaryReplicationInfo()

cfg = rs.conf()
cfg.members[0].priority = 30
cfg.members[1].priority = 20
cfg.members[2].priority = 10
rs.reconfig(cfg)

cfg = rs.conf()
cfg.members[0].host = "192.168.56.149:27017"
cfg.members[1].host = "192.168.56.150:27017"
cfg.members[2].host = "192.168.56.151:27017"
rs.reconfig(cfg, {force: true})

cfg = rs.conf()
cfg.members[0].host = "mongodb_1_p:27017"
cfg.members[1].host = "mongodb_1_s:27017"
cfg.members[2].host = "mongodb_2_s:27017"
rs.reconfig(cfg, {force: true})

db.createCollection('tbl_cib_1')

db.tbl_cib_5.insertOne({name: "Devesh", age: 44})

db.tbl_cib_5.insertMany([{name: "Devesh", age: 44}, {name: "Madhu", age: 44}])

db.tbl_cib_5.bulkWrite([
{ insertOne : { document : { name: "Devesh", age: 25 } } },
{ updateOne : { filter : { name: "Madhu" }, update : { $set : { age: 40 } } } },
{ deleteOne : { filter : { name: "Manish" } } }
])

cursor = db.tbl_cib.find();
while ( cursor.hasNext() ) {
   printjson( cursor.next() );
}
*/
-------------------------Use Full----------------------------