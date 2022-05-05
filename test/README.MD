

* Config EC2
----------------------------------------------------------------

t2.medium

 terraform apply  



* Config Mongo
----------------------------------------------------------------
sudo apt install mongodb-clients
sudo service docker restart
 docker system prune

ssh -i '/Users/sagegu/Documents/GitHub/test_keypair.pem' ubuntu@30.0.1.243

----node1----------------  30.0.1.243  125primary
sudo docker stop mongo
sudo docker rm -f mongo
sudo docker run --name mongo -v /data/data/mongodb:/data/db \
 --hostname=sage1 \
 --add-host sage1:30.0.1.243 \
 --add-host sage2:30.0.1.125 \
 --add-host sage3:30.0.1.153 \
  -p 27017:27017 -d percona/percona-server-mongodb:3.6 --smallfiles --replSet rs0.test
sudo docker ps --all

sudo docker run --name mongo -v /data/data/mongodb:/data/db \
 --hostname=sage-old-data1 \
 --add-host sage-old-data1:30.0.1.243 \
  -p 27017:27017 -d percona/percona-server-mongodb:3.4 --smallfiles --replSet rs0.test
sudo docker ps --all

sudo docker stop mongo
sudo docker rm -f mongo
sudo docker run --name mongo -v /data/data/mongodb:/data/db  \
 -p 27017:27017 -d percona/percona-server-mongodb:3.4 --smallfiles  --replSet rs0.test
sudo docker ps --all


mongo --host 30.0.1.243 --port 27017
mongo --host 30.0.1.136 --port 27017

 echo "========== mount efs ... ============="
sudo apt-get -y install nfs-common
 sudo mkdir -p /efs
//Using the NFS client:



ssh -i '/Users/sagegu/Documents/GitHub/test_keypair.pem' ubuntu@30.0.1.238

----node2---------------- 30.0.1.238

sudo docker stop mongo
sudo docker rm mongo
sudo docker run --name mongo  -v /data/data/mongodb:/data/db \
 --hostname=sage2 \
 --add-host sage1:30.0.1.243 \
 --add-host sage2:30.0.1.125 \
 --add-host sage3:30.0.1.153 \
 -p 27017:27017 -d percona/percona-server-mongodb:3.6 --smallfiles --replSet rs0.test
sudo docker ps --all


mongo --host 30.0.1.243 --port 27017
mongo --host 30.0.1.136 --port 27017


upgrade
sudo docker stop mongo
sudo docker rm -f mongo 
sudo docker run --name mongo  -v /data/data/mongodb:/data/db \
 --hostname=sage3 \
 --add-host sage1:30.0.1.243 \
 --add-host sage2:30.0.1.125 \
 --add-host sage3:30.0.1.153 \
 -p 27017:27017 -d percona/percona-server-mongodb:3.6 --smallfiles --replSet rs0.test
sudo docker ps --all

db.adminCommand( {setFeatureCompatibilityVersion: 3.6} )

ssh -i '/Users/sagegu/Documents/GitHub/test_keypair.pem' ubuntu@30.0.1.136

----node3---------------- 30.0.1.136

sudo docker stop mongo
sudo docker rm -f mongo 
sudo docker run --name mongo  -v /data/mongodb:/data/db \
 --hostname=sage3 \
 --add-host sage1:30.0.1.243 \
 --add-host sage2:30.0.1.125 \
 --add-host sage3:30.0.1.153 \
 -p 27017:27017 -d percona/percona-server-mongodb:3.6 --smallfiles --replSet rs0.test

mongo --host 30.0.1.243 --port 27017
mongo --host 30.0.1.238 --port 27017

----------------------------------------------------------------
Deploy a MongoDB Replica Set with Transport Encryption (Part 2)

https://www.percona.com/blog/2018/05/23/deploy-mongodb-replica-set-with-transport-encryption-part-2/

rs.initiate( { _id: "rs0.test", members: [ { _id: 0, host: "30.0.1.83:27017" }, { _id: 1, host: "30.0.1.238:27017" }, { _id: 2, host: "30.0.1.136:27017" } ] })

----------------------------------------------------------------
cfg = rs.conf()
cfg.members[0].host = "30.0.1.243"
cfg.members[1].host = "30.0.1.125"
cfg.members[2].host = "30.0.1.153"
rs.reconfig(cfg,  {force: true})



----------------------------------------------------------------
echo "============== setup mongo users ======= "

db.createUser({user:"admin",pwd:"iHealth.Next",roles:[{role:"root",db:"admin"}]});
sudo docker exec -t mongo mongo Sharecare --eval 'db.foo.insert({x:1,y:1});'
sudo docker exec -t mongo mongo Sharecare --eval 'db.createUser({user:"app_user",pwd:"ihealth99",roles:[{role:"dbOwner",db:"ShareCare"}]});'


Verify from primary
the primary is 30.0.1.83
 mongo --host 30.0.1.238 --port 27017
 mongo --host 30.0.1.136 --port 27017

Configuring the hostnames into our hosts is not mandatory for the replica set. In fact you can configure the replica set using just the IPs and it’s fine. But we need to define the hostnames because they will be very useful when we discuss how to configure internal encryption
We need to ensure that each member is accessible by way of resolvable DNS or hostnames.

Set up each node in the /etc/hosts file

sudo nano /etc/hosts

 cat /etc/hosts
127.0.0.1       localhost
30.0.1.83   psmdb1
30.0.1.238  psmdb2  
30.0.1.136  psmdb3
 

 mongo --host 30.0.1.200 --port 27017

* Upgrate to 4.0

ssh -i '/Users/sagegu/Documents/GitHub/test_keypair.pem' ubuntu@30.0.1.125
sudo docker stop mongo
sudo docker rm -f mongo 
sudo docker run --name mongo  -v /data/data/mongodb:/data/db  --hostname=sage2  --add-host sage1:30.0.1.243  --add-host sage2:30.0.1.125  --add-host sage3:30.0.1.153  -p 27017:27017 -d percona/percona-server-mongodb:4.2 --replSet rs0.test --bind_ip 0.0.0.0
sudo docker ps --all

ssh -i '/Users/sagegu/Documents/GitHub/test_keypair.pem' ubuntu@30.0.1.153
sudo docker stop mongo
sudo docker rm -f mongo 
sudo docker run --name mongo  -v /data/data/mongodb:/data/db  --hostname=sage3  --add-host sage1:30.0.1.243  --add-host sage2:30.0.1.125  --add-host sage3:30.0.1.153  -p 27017:27017 -d percona/percona-server-mongodb:4.4 --replSet rs0.test --bind_ip 0.0.0.0
sudo docker ps --all

db.hostInfo() 
 