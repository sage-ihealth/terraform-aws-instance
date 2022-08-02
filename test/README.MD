

* Config EC2
----------------------------------------------------------------

t2.medium
terraform apply  



* Config Mongo
  ssh -i '/Users/sagegu/Documents/GitHub/test_keypair.pem' ubuntu@30.0.1.243

rs.initiate( { _id: "rs0.test", members: [ { _id: 0, host: "30.0.1.83:27017" }, { _id: 1, host: "30.0.1.238:27017" }, { _id: 2, host: "30.0.1.136:27017" } ] })

cfg = rs.conf()
cfg.members[0].priority = 1
cfg.members[1].priority = 0
cfg.members[2].priority = 2
rs.reconfig(cfg)


cfg = rs.conf()
cfg.members[0].priority = 2
rs.reconfig(cfg)


cfg = rs.conf()
cfg.members[0].host = "node1.prod-mongo.ihealth-eng.com"
cfg.members[1].host = "node2.prod-mongo.ihealth-eng.com"
cfg.members[2].host = "node3.prod-mongo.ihealth-eng.com"
rs.reconfig(cfg,  {force: true})

snap-0cd1152e5c057b8db
Started
Sun Feb 27 2022 15:55:47 GMT+0800 (China Standard Time)
现在数据库貌似是2021年7月之前的


从mongo_test_2022-02-21T07:55:46.958074 创建一个volume
test-mongodb-sage-2022-3-7-5
Device name /dev/sdh
 sudo mount /dev/xvdh /data
sudo docker run --name mongo -v /data/mongodb:/data/db -p 27017:27017 -d percona/percona-server-mongodb:3.4


mongo_test_2022-03-08T07:55:47.415235创建一个volume
Test-mongodb-sage-2022-3-7-6

sudo umount /data
sudo lsblk
sudo rm -rf /data
sudo mkdir -p /data
sudo mount /dev/xvdi /data

还是不对

去现在的test secondary 看 
mongo -u app_user -p ihealth99 --authenticationDatabase Sharecare
rs.slaveOk()
use Sharecare
db.getCollection('accounts').find({}, { createdAt: 1 }).sort({createdAt: -1}).limit(200)

返回的确是
{ "_id" : ObjectId("620fe9f955b18e0012655b11"), "createdAt" : ISODate("2022-02-18T18:48:25.714Z") }

可是snapshot恢复的数据不行啊


那我 test node3 volume 重新snapshot -》 column -> attach
test_readmission_mongodb_us_node3  30.0.1.202 vol-091b24eecf05f92f3  并没有mount。。。


--------------------------------------------------
用他root的
vol-0a0f0dcdeb9bb9849
Test-mongodb-sage-snapshot-2022-3-8
Create volume
Test-mongodb-sage-volume-2022-3-8
Attach


sudo docker run --name mongo -v /data/data/mongodb:/data/db -p 27017:27017 -d percona/percona-server-mongodb:3.4

这个是对的

所以明天
都用 Test-mongodb-sage-volume-2022-3-8 再来一遍
Test-mongodb-sage-volume-2022-3-9-2  == sage_test_mongodb_node2 i-0e813e1de2ddccf9e /dev/sdg

Test-mongodb-sage-volume-2022-3-9-3 == sage_test_mongodb_node3 i-0a937725b7f46db99 /dev/sdg


sudo umount /data
sudo lsblk
sudo rm -rf /data
sudo mkdir -p /data
sudo mount /dev/xvdg1 /data

----------------------

--------------------------------------------------
test node3  用他root的
vol-0a0f0dcdeb9bb9849 
Test-mongodb-sage-volume-2022-4-18

attach到这里了
Node2
/dev/sdh

Node3
/dev/sdh

ssh -i '/Users/sagegu/Documents/GitHub/test_keypair.pem' ubuntu@30.0.1.125
执行下面的命令
sudo docker stop mongo
sudo docker rm -f mongo 

sudo umount /data
sudo lsblk
sudo rm -rf /data
sudo mkdir -p /data
sudo mount /dev/xvdf1 /data

sudo docker run --name mongo  -v /data/data/mongodb:/data/db  --hostname=sage2  --add-host sage1:30.0.1.243  --add-host sage2:30.0.1.125  --add-host sage3:30.0.1.153  -p 27017:27017 -d percona/percona-server-mongodb:3.4 --replSet rs0.test --bind_ip 0.0.0.0
cfg = rs.conf()
cfg.members[0].host = "30.0.1.243"
cfg.members[1].host = "30.0.1.125"
cfg.members[2].host = "30.0.1.153"
rs.reconfig(cfg,  {force: true})


在第二台机器----
sudo docker stop mongo
sudo docker rm -f mongo 
sudo docker run --name mongo  -v /data/data/mongodb:/data/db  --hostname=sage2  --add-host sage1:30.0.1.243  --add-host sage2:30.0.1.125  --add-host sage3:30.0.1.153  -p 27017:27017 -d percona/percona-server-mongodb:3.6 --replSet rs0.test --bind_ip 0.0.0.0
db.adminCommand( { getParameter: 1, featureCompatibilityVersion: 1 } )
db.adminCommand( {setFeatureCompatibilityVersion: "3.6"} )

sudo docker stop mongo
sudo docker rm -f mongo 
sudo docker run --name mongo  -v /data/data/mongodb:/data/db  --hostname=sage2  --add-host sage1:30.0.1.243  --add-host sage2:30.0.1.125  --add-host sage3:30.0.1.153  -p 27017:27017 -d percona/percona-server-mongodb:4.0 --replSet rs0.test --bind_ip 0.0.0.0
mongo
db.adminCommand( { getParameter: 1, featureCompatibilityVersion: 1 } )
db.adminCommand( {setFeatureCompatibilityVersion: "4.0"} )

sudo docker stop mongo
sudo docker rm -f mongo 
sudo docker run --name mongo  -v /data/data/mongodb:/data/db  --hostname=sage2  --add-host sage1:30.0.1.243  --add-host sage2:30.0.1.125  --add-host sage3:30.0.1.153  -p 27017:27017 -d percona/percona-server-mongodb:4.2 --replSet rs0.test --bind_ip 0.0.0.0
docker ps -a
sleep 10; mongo
db.adminCommand( { getParameter: 1, featureCompatibilityVersion: 1 } )
db.adminCommand( {setFeatureCompatibilityVersion: "4.2"} )

sudo docker stop mongo
sudo docker rm -f mongo 
sudo docker run --name mongo  -v /data/data/mongodb:/data/db  --hostname=sage2  --add-host sage1:30.0.1.243  --add-host sage2:30.0.1.125  --add-host sage3:30.0.1.153  -p 27017:27017 -d percona/percona-server-mongodb:4.4 --replSet rs0.test --bind_ip 0.0.0.0
docker ps -a
sleep 10; mongo
db.adminCommand( { getParameter: 1, featureCompatibilityVersion: 1 } )
db.adminCommand( {setFeatureCompatibilityVersion: "4.4"} )

在第三台机器----
sudo docker run --name mongo  -v /data/data/mongodb:/data/db  --hostname=sage3  --add-host sage1:30.0.1.243  --add-host sage2:30.0.1.125  --add-host sage3:30.0.1.153  -p 27017:27017 -d percona/percona-server-mongodb:4.4 --replSet rs0.test --bind_ip 0.0.0.0

cfg = rs.conf()
cfg.members[0].host = "30.0.1.243"
cfg.members[1].host = "30.0.1.125"
cfg.members[2].host = "30.0.1.153"
rs.reconfig(cfg,  {force: true})

sudo docker stop mongo
sudo docker rm -f mongo 
sudo docker run --name mongo  -v /data/data/mongodb:/data/db  --hostname=sage3  --add-host sage1:30.0.1.243  --add-host sage2:30.0.1.125  --add-host sage3:30.0.1.153  -p 27017:27017 -d percona/percona-server-mongodb:3.6 --replSet rs0.test --bind_ip 0.0.0.0

mongo

db.adminCommand( { getParameter: 1, featureCompatibilityVersion: 1 } )

use admin
db.adminCommand({authSchemaUpgrade: 1});


sudo docker stop mongo
sudo docker rm -f mongo 
sudo docker run --name mongo  -v /data/data/mongodb:/data/db  --hostname=sage3  --add-host sage1:30.0.1.243  --add-host sage2:30.0.1.125  --add-host sage3:30.0.1.153  -p 27017:27017 -d percona/percona-server-mongodb:4.0 --replSet rs0.test --bind_ip 0.0.0.0
sleep 10; mongo
db.adminCommand( { getParameter: 1, featureCompatibilityVersion: 1 } )
db.adminCommand( {setFeatureCompatibilityVersion: "4.0"} )

sudo docker stop mongo
sudo docker rm -f mongo 
sudo docker run --name mongo  -v /data/data/mongodb:/data/db  --hostname=sage3  --add-host sage1:30.0.1.243  --add-host sage2:30.0.1.125  --add-host sage3:30.0.1.153  -p 27017:27017 -d percona/percona-server-mongodb:4.2 --replSet rs0.test --bind_ip 0.0.0.0
sleep 10; mongo
db.adminCommand( { getParameter: 1, featureCompatibilityVersion: 1 } )
db.adminCommand( {setFeatureCompatibilityVersion: "4.2"} )

sudo docker stop mongo
sudo docker rm -f mongo 
sudo docker run --name mongo  -v /data/data/mongodb:/data/db  --hostname=sage3  --add-host sage1:30.0.1.243  --add-host sage2:30.0.1.125  --add-host sage3:30.0.1.153  -p 27017:27017 -d percona/percona-server-mongodb:4.4 --replSet rs0.test --bind_ip 0.0.0.0
docker ps -a
sleep 10; mongo
db.adminCommand( { getParameter: 1, featureCompatibilityVersion: 1 } )
db.adminCommand( {setFeatureCompatibilityVersion: "4.4"} )


在第一台机器--------
 /dev/sdm (attached)
 df -hT

sudo umount /data
sudo rm -rf /data
sudo mkdir -p /data
sudo mount /dev/nvme1n1p1 /data


sudo docker stop mongo
sudo docker rm -f mongo 
sudo docker run --name mongo  -v /data/data/mongodb:/data/db  --hostname=sage1  --add-host sage1:30.0.1.243    -p 27017:27017 -d percona/percona-server-mongodb:3.6 --replSet rs0.test --bind_ip 0.0.0.0
docker ps -a
sleep 10; mongo

因为前2台机器先升级了。这个试试变成primary升级试试
cfg = rs.conf()
cfg.members.splice(1,1)
rs.reconfig(cfg,  {force: true})

db.adminCommand( { getParameter: 1, featureCompatibilityVersion: 1 } )
db.adminCommand( {setFeatureCompatibilityVersion: "3.6"} ) 
use admin
db.adminCommand({authSchemaUpgrade: 1});


sudo docker stop mongo
sudo docker rm -f mongo 
sudo docker run --name mongo  -v /data/data/mongodb:/data/db  --hostname=sage1  --add-host sage1:30.0.1.243   -p 27017:27017 -d percona/percona-server-mongodb:4.0 --replSet rs0.test --bind_ip 0.0.0.0
sleep 10; mongo
db.adminCommand( { getParameter: 1, featureCompatibilityVersion: 1 } )
db.adminCommand( {setFeatureCompatibilityVersion: "4.0"} )
exit

sudo docker stop mongo
sudo docker rm -f mongo 
sudo docker run --name mongo  -v /data/data/mongodb:/data/db  --hostname=sage1  --add-host sage1:30.0.1.243   -p 27017:27017 -d percona/percona-server-mongodb:4.2 --replSet rs0.test --bind_ip 0.0.0.0
sleep 10; mongo
db.adminCommand( { getParameter: 1, featureCompatibilityVersion: 1 } )
db.adminCommand( {setFeatureCompatibilityVersion: "4.2"} )
exit

sudo docker stop mongo
sudo docker rm -f mongo 
sudo docker run --name mongo  -v /data/data/mongodb:/data/db  --hostname=sage1 --add-host sage1:30.0.1.243  --add-host sage2:30.0.1.125  --add-host sage3:30.0.1.153 -p 27017:27017 -d percona/percona-server-mongodb:4.4 --replSet rs0.test --bind_ip 0.0.0.0
docker ps -a
sleep 10; mongo
db.adminCommand( { getParameter: 1, featureCompatibilityVersion: 1 } )
db.adminCommand( {setFeatureCompatibilityVersion: "4.4"} )
exit


rs.add( {_id: 0, host: "30.0.1.243:27017" } )
不mount data是可以的

----
docker volume ls
docker volume rm 


sudo umount /data
sudo rm -rf /data
sudo mkdir -p /data
ls -lat /data/data/mongodb/

最终4.4 4月18号的数据，volume建新snapshot
Test-mongodb44-sage-snapshot-2022-4-25 snap-061cface07fe3467d

----
4-25重新做了243一个instance。因为误删patients
从snap-07f8728f975dc2d14重新建了volume

现在加replica。 不用-v是可以的。在primary上加member。member会startup
rs.add( {_id: 1,  host: "30.0.1.125:27017" } )
STARTUP2

rs.add( {_id: 2,  host: "30.0.1.153:27017" } )


---- 4-26 ---- hostname
从mong44 snap-061cface07fe3467d 建
Test-mongodb44-sage-volume-2022-4-28

sudo docker stop mongo
sudo docker rm -f mongo 
sudo docker run --name mongo  -v /data/data/mongodb:/data/db  --hostname=sage1  --add-host sage1:30.0.1.243  --add-host sage2:30.0.1.125  --add-host sage3:30.0.1.153  -p 27017:27017 -d percona/percona-server-mongodb:4.4 --replSet rs0.test --bind_ip 0.0.0.0
docker ps -a
sleep 10; mongo

sudo umount /data
sudo rm -rf /data
sudo mkdir -p /data
sudo mount /dev/xvdf1 /data
sudo docker stop mongo
sudo docker rm -f mongo 
sudo docker run --name mongo  -v /data/data/mongodb:/data/db  --hostname=sage2  --add-host sage1:30.0.1.243  --add-host sage2:30.0.1.125  --add-host sage3:30.0.1.153  -p 27017:27017 -d percona/percona-server-mongodb:4.4 --replSet rs0.test --bind_ip 0.0.0.0
docker ps -a
sleep 10; mongo



sudo umount /data
sudo rm -rf /data
sudo mkdir -p /data
sudo mount /dev/xvdf1 /data
sudo docker stop mongo
sudo docker rm -f mongo 
sudo docker run --name mongo  -v /data/data/mongodb:/data/db  --hostname=sage3  --add-host sage1:30.0.1.243  --add-host sage2:30.0.1.125  --add-host sage3:30.0.1.153  -p 27017:27017 -d percona/percona-server-mongodb:4.4 --replSet rs0.test --bind_ip 0.0.0.0
docker ps -a
sleep 10; mongo
------

mongo admin -u admin -p iHealth.Next 
sudo docker stop mongo
sudo docker rm -f mongo 
sudo docker run --name mongo  -v /data/data/mongodb:/data/db   -p 37017:27017 -d percona/percona-server-mongodb:4.4    --bind_ip 0.0.0.0
docker ps -a
mongo --port 37017 -u admin -p iHealth.Next --authenticationDatabase=admin  



mongo -u admin -p iHealth.Next --authenticationDatabase=admin  

use local
cfg = db.system.replset.findOne( { "_id": "rs0.test" } )

cfg.members[0].host = "node1.test-mongo.ihealth-eng.com:27017"
cfg.members[1].host = "node2.test-mongo.ihealth-eng.com:27017"
cfg.members[2].host = "node3.test-mongo.ihealth-eng.com:27017"

db.system.replset.updateOne( { "_id": "rs0.test" }, { $set: cfg } )
db.system.replset.find( {}, { "members.host": 1 } )


重新在27017启动就行。
sudo docker stop mongo
sudo docker rm -f mongo 
sudo docker run --name mongo  -v /data/data/mongodb:/data/db -p 27017:27017 -d percona/percona-server-mongodb:4.4  --replSet rs0.test  --bind_ip 0.0.0.0
docker ps -a
sleep 10; mongo

## terraform

### Manually installing the Amazon EFS client
sudo apt-get update
sudo apt-get -y install git binutils
git clone https://github.com/aws/efs-utils
cd efs-utils/
./build-deb.sh
sudo apt-get -y install ./build/amazon-efs-utils*deb

### Mounting EFS file systems
Go to EFS 
Choose Attach
Mount via DNS
Using the EFS mount helper:
 


### create a new EFS 
the new EFS:test_new_efs; subnet-6126b318 (test_private_us-west-2a) 
sudo mkdir -p /efs
sudo mount -t efs -o tls fs-0e05d0a154af21cc5:/ /efs
df -hT

Enter pass phrase for mongoCA.key: 123qwe456

Country Name (2 letter code) [AU]:US
State or Province Name (full name) [Some-State]:CA
Locality Name (eg, city) []:Bay
Organization Name (eg, company) [Internet Widgits Pty Ltd]:iHealth
Organizational Unit Name (eg, section) []:iHealth
Common Name (e.g. server FQDN or YOUR name) []: node1.test-mongo.ihealth-eng.com
Email Address []: sage.gu@ihealthlabs.com
 chanllenge psw 123qwe456
 
sudo chmod 600 /efs/mongodb/keys/mongodb-keyfile
sudo chown -R 1001 /efs/mongodb/keys
sudo chown -R 1001 /efs/mongodb

# Connect to one of the hosts and generate a new private key using openssl
sudo openssl genrsa -out mongoCA.key -aes256 8192

# Sign a new CA certificate
sudo openssl req -x509 -new -extensions v3_ca -key mongoCA.key -days 365 -out mongoCA.crt

# Issue self-signed certificates for all the nodes
### 1
sudo openssl req -new -nodes -newkey rsa:4096 -keyout psmdb1.key -out psmdb1.csr
sudo openssl x509 -CA mongoCA.crt -CAkey mongoCA.key -CAcreateserial -req -days 365 -in psmdb1.csr -out psmdb1.crt
sudo cat psmdb1.key psmdb1.crt > psmdb1.pem

### 2
sudo openssl req -new -nodes -newkey rsa:4096 -keyout psmdb2.key -out psmdb2.csr 
sudo openssl x509 -CA mongoCA.crt -CAkey mongoCA.key -CAcreateserial -req -days 365 -in psmdb2.csr -out psmdb2.crt 
sudo cat psmdb2.key psmdb2.crt > psmdb2.pem

### 3
sudo openssl req -new -nodes -newkey rsa:4096 -keyout psmdb3.key -out psmdb3.csr 
sudo openssl x509 -CA mongoCA.crt -CAkey mongoCA.key -CAcreateserial -req -days 365 -in psmdb3.csr -out psmdb3.crt 
sudo cat psmdb3.key psmdb3.crt > psmdb3.pem

#### Connect
mongo admin --tls --tlsCAFile /efs/mongoCA.crt -u dba -p ntWe4k1b1WNTHV7ou4m5sXryFZsuudJk --host node1.test-mongo.ihealth-eng.com:27017,node2.test-mongo.ihealth-eng.com:27017,node3.test-mongo.ihealth-eng.com:27017

mongo --host node1.test-mongo.ihealth-eng.com --tls --tlsCAFile /efs/mongoCA.pem --tlsCertificateKeyFile /efs/psmdb1.pem --tlsCertificateKeyFilePassword '123qwe456' \
-u dba -p ntWe4k1b1WNTHV7ou4m5sXryFZsuudJk 
 
mongo admin --ssl --sslCAFile /efs/mongoCA.crt \
--sslPEMKeyFile /efs/psmdb2.pem \
-u dba -p ntWe4k1b1WNTHV7ou4m5sXryFZsuudJk --host node2.test-mongo.ihealth-eng.com
 
 mongo admin --ssl --sslCAFile /efs/mongoCA.crt \
--sslPEMKeyFile /efs/psmdb3.pem \
-u dba -p ntWe4k1b1WNTHV7ou4m5sXryFZsuudJk --host node3.test-mongo.ihealth-eng.com

# Create a keyfile
sudo openssl rand -base64 756 > mongodb-keyfile
sudo chmod 400  mongodb-keyfile

# Start each member of the replica set with access control enabled.

  ./usr/bin/percona-server-mongodb-enable-auth.sh
We have detected authentication is not enabled.
Would you like help creating your first user?
Please note that mongodb service could be restarted during this action
Would you like to proceed?(y/n)y
Percona Server for MongoDB shell version v4.4.13-13
connecting to: mongodb://localhost:27017/admin?compressors=disabled&gssapiServiceName=mongodb
Implicit session: session { "id" : UUID("a5c3a1f4-79d5-4d37-b2da-b06441f08ea7") }
Percona Server for MongoDB server version: v4.4.13-13
Successfully added user: { "user" : "dba", "roles" : [ "root" ] }
bye
User has been created successfully!
User:dba
Password:ntWe4k1b1WNTHV7ou4m5sXryFZsuudJk
Redirecting to /bin/systemctl stop mongod.service
System has not been booted with systemd as init system (PID 1). Can't operate.
Failed to connect to bus: Host is down
Redirecting to /bin/systemctl start mongod.service
System has not been booted with systemd as init system (PID 1). Can't operate.
Failed to connect to bus: Host is down

mongo -u dba -p ntWe4k1b1WNTHV7ou4m5sXryFZsuudJk --authenticationDatabase admin

We don't use config file
docker exec -it -u 0  mongo bash
cat /etc/mongod.conf

# Audit
sudo mkdir -p /percona/logs/
cd /percona/logs/
sudo touch mongodb_audit.json
sudo chmod 777 /percona/logs/mongodb_audit.json
sudo cat mongodb_audit.json
 
 # Encryption
Exception in EncryptionKeyDB::init: {e}","attr":{"e":"encryption key length should be 32 bytes"}}
## create keys 
sudo mkdir key
cd key
sudo touch mongodb.key 
sudo chmod 777 mongodb.key 
sudo openssl rand -base64 32 > mongodb.key
sudo chmod 600 mongodb.key
sudo chown -R 1001 key

sudo mkdir -p /data/encrypt
sudo chmod 700 /data/encrypt
sudo chown -R 1001 /data/encrypt
 

## issues
sudo service docker restart
docker system prune

## Final
sudo docker stop mongo
sudo docker rm -f mongo 
sudo docker run --name mongo --privileged=true -v /efs:/etc/ssl/mongodb -v /data/data/mongodb:/data/db -v /percona/logs/mongodb_audit.json:/var/log/psmdb/audit.json -p 27017:27017 -d percona/percona-server-mongodb:4.4  --replSet rs0.test --bind_ip 0.0.0.0  --keyFile /etc/ssl/mongodb/mongodb/keys/mongodb-keyfile  --sslMode allowSSL --sslPEMKeyFile /etc/ssl/mongodb/psmdb1.pem --sslCAFile /etc/ssl/mongodb/mongoCA.crt   --setParameter rollbackTimeLimitSecs=2147483647 --auditDestination=file --auditFormat JSON --auditPath /var/log/psmdb/audit.json   --auth
docker ps -a
docker logs mongo 

sudo docker stop mongo
sudo docker rm -f mongo 
sudo docker run --name mongo --privileged=true -v /efs:/etc/ssl/mongodb -v /data/data/mongodb:/data/db -v /percona/logs/mongodb_audit.json:/var/log/psmdb/audit.json -p 27017:27017 -d percona/percona-server-mongodb:4.4  --replSet rs0.test --bind_ip 0.0.0.0  --keyFile /etc/ssl/mongodb/mongodb/keys/mongodb-keyfile  --sslMode allowSSL --sslPEMKeyFile /etc/ssl/mongodb/psmdb2.pem --sslCAFile /etc/ssl/mongodb/mongoCA.crt   --setParameter rollbackTimeLimitSecs=2147483647 --auditDestination=file --auditFormat JSON --auditPath /var/log/psmdb/audit.json   --auth
docker ps -a
docker logs mongo 

sudo docker stop mongo
sudo docker rm -f mongo 
sudo docker run --name mongo --privileged=true -v /efs:/etc/ssl/mongodb -v /data/data/mongodb:/data/db -v /percona/logs/mongodb_audit.json:/var/log/psmdb/audit.json -p 27017:27017 -d percona/percona-server-mongodb:4.4  --replSet rs0.test --bind_ip 0.0.0.0  --keyFile /etc/ssl/mongodb/mongodb/keys/mongodb-keyfile  --sslMode allowSSL --sslPEMKeyFile /etc/ssl/mongodb/psmdb3.pem --sslCAFile /etc/ssl/mongodb/mongoCA.crt   --setParameter rollbackTimeLimitSecs=2147483647 --auditDestination=file --auditFormat JSON --auditPath /var/log/psmdb/audit.json   --auth
docker ps -a
docker logs mongo 


