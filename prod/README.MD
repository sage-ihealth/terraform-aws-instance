# Create EC2
  terraform init
  terraform apply  

# Connect EC2
  ssh -i ~/Documents/GitHub/pem/prod_keypair.pem ubuntu@40.0.1.238
  ssh -i ~/Documents/GitHub/pem/prod_keypair.pem ubuntu@40.0.1.214
  ssh -i ~/Documents/GitHub/pem/prod_keypair.pem ubuntu@40.0.1.160

# Volume
  prod-mongodb-sage-volume-2022-6-8 from snap-0985c28f5c650702b
  vol-0433af527a1669111.
vol-01630e42117c0c0ae
vol-0b5a76183c50c234e

sudo umount /data
sudo rm -rf /data
sudo mkdir -p /data
sudo mount /dev/nvme1n1 /data


node1.prod-mongo.ihealth-eng.com,node2.prod-mongo.ihealth-eng.com,node3.prod-mongo.ihealth-eng.com
scp  -i ~/Documents/GitHub/pem/prod_keypair.pem ca.pem  ubuntu@40.0.1.238:/efs
scp  -i ~/Documents/GitHub/pem/prod_keypair.pem mongodb_node_1.pem  ubuntu@40.0.1.238:~/
scp  -i ~/Documents/GitHub/pem/prod_keypair.pem mongodb_node_2.pem  ubuntu@40.0.1.238:~/
scp  -i ~/Documents/GitHub/pem/prod_keypair.pem mongodb_node_3.pem  ubuntu@40.0.1.238:~/
scp  -i ~/Documents/GitHub/pem/prod_keypair.pem mongodb_client.pem  ubuntu@40.0.1.238:~/

# Audit
sudo mkdir -p /percona/logs/
cd /percona/logs/
sudo touch mongodb_audit.json
sudo chmod 777 /percona/logs/mongodb_audit.json
sudo cat mongodb_audit.json
sudo chown -R 1001 /percona/logs/ 

# efs
sudo apt-get update
sudo apt-get -y install git binutils
cd ~; git clone https://github.com/aws/efs-utils; cd efs-utils/
./build-deb.sh
sudo apt-get -y install ./build/amazon-efs-utils*deb
sudo mkdir  -p /efs
sudo mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport fs-0393226792b624a6f.efs.us-west-2.amazonaws.com:/ /efs


# Create a keyfile
sudo touch  mongodb-keyfile
sudo chmod 777 mongodb-keyfile
sudo openssl rand -base64 756 > mongodb-keyfile
sudo chmod 400  mongodb-keyfile

# Set replica
1. start with /data , standalone, change the hostname to new ones. then restart with replicasets.
sudo docker stop mongo
sudo docker rm -f mongo 
sudo docker run --name mongo --privileged=true -v /efs:/etc/ssl/mongodb -v /data/mongodb:/data/db -v /percona/logs/mongodb_audit.json:/var/log/psmdb/audit.json -p 27017:27017 -d percona/percona-server-mongodb:3.4 --replSet rs0.prod  --bind_ip 0.0.0.0  --keyFile /etc/ssl/mongodb/mongodb-keyfile  --sslMode requireSSL --sslPEMKeyFile /etc/ssl/mongodb/mongodb_node_3.pem --sslCAFile /etc/ssl/mongodb/ca.pem --auditDestination=file --auditFormat JSON --auditPath /var/log/psmdb/audit.json --auth 
docker ps -a
docker logs mongo 


mongo -u admin -p iHealth.Next --authenticationDatabase admin


use local
cfg = db.system.replset.findOne( { "_id": "rs0.prod" } )

cfg.members[0].host = "node1.prod-mongo.ihealth-eng.com:27017"
cfg.members[1].host = "node2.prod-mongo.ihealth-eng.com:27017"
cfg.members[2].host = "node3.prod-mongo.ihealth-eng.com:27017"

db.system.replset.update( { "_id": "rs0.prod" }, { $set: cfg } )
db.system.replset.find( {}, { "members.host": 1 } )

### replica 2 
sudo mkdir -p /data/mongodb
sudo chown -R 1001 /data/mongodb
 --hostname=node2.prod-mongo.ihealth-eng.com  --add-host node1.prod-mongo.ihealth-eng.com:40.0.1.238  --add-host node2.prod-mongo.ihealth-eng.com:40.0.1.214  --add-host node3.prod-mongo.ihealth-eng.com:40.0.1.106

PEM=/etc/ssl/mongodb/mongodb_node_3.pem
echo $PEM
sudo docker stop mongo
sudo docker rm -f mongo 
sudo docker run --name mongo --privileged=true -v /efs:/etc/ssl/mongodb -v /data/mongodb:/data/db -v /percona/logs/mongodb_audit.json:/var/log/psmdb/audit.json -p 27017:27017 -d percona/percona-server-mongodb:4.4 --replSet rs0.prod  --bind_ip 0.0.0.0  --keyFile /etc/ssl/mongodb/mongodb-keyfile  --sslMode allowSSL --sslPEMKeyFile $PEM --sslCAFile /etc/ssl/mongodb/ca.pem --auditDestination=file --auditFormat JSON --auditPath /var/log/psmdb/audit.json --auth 
docker ps -a

docker logs mongo


# connect
mongo --ssl --sslCAFile /efs/ca.pem  --sslPEMKeyFile /efs/mongodb_client.pem --host rs0.prod/node1.prod-mongo.ihealth-eng.com:27017,node2.prod-mongo.ihealth-eng.com:27017,node3.prod-mongo.ihealth-eng.com:27017 -u admin -p iHealth.Next --authenticationDatabase admin

mongo --ssl --sslCAFile /efs/ca.pem  --sslPEMKeyFile /efs/mongodb_node_1.pem --host  node1.prod-mongo.ihealth-eng.com -u admin -p iHealth.Next --authenticationDatabase admin

mongo -u admin -p iHealth.Next --authenticationDatabase admin


------
  prod-mongodb44-volume-2022-6-10-1 from snap-07b68927c65e95bbd

k -n backend scale deployment sharecare-gql-cron --replicas=0
k -n backend scale deployment sharecare-chs   --replicas=0
k -n backend scale deployment sharecare-chs-subscriber   --replicas=0


# Installing the Database Tools on Linux
```
wget  https://fastdl.mongodb.org/tools/db/mongodb-database-tools-ubuntu1604-x86_64-100.5.3.deb
sudo dpkg -i --force-all ./mongodb-database-tools-ubuntu1604-x86_64-100.5.3.deb 
sudo apt-get install -f
mongodump --version
```
