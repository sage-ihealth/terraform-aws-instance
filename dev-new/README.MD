
# Deploy Dev-new instance 

## terraform init

## terraform apply
To set lots of variables, it is more convenient to specify their values in a variable definitions file (with a filename ending in either .tfvars or .tfvars.json) and then specify that file on the command line with -var-file:
terraform apply -var-file="terraform.tfvars"

variables.tf connects terraform.tfvars to main.tf

 
# Install percona 
login to sage-dev=new mock
ps aux | grep -i apt
sudo dpkg --configure -a


sudo apt update

sudo apt-get update
sudo apt-get -y install percona-server-mongodb-34

#version is  Ubuntu 16.04.3 LTS
lsb_release -a

## ---------------mongodb-clients
sudo apt install mongodb-clients

## ---------------below working-----------------
sudo mkdir -p /data/mongodb
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 9334A25F8507EFA5
echo "deb http://repo.percona.com/apt "$(lsb_release -sc)" main" | sudo tee /etc/apt/sources.list.d/percona.list
sudo apt-get update
sudo apt-get -y install percona-server-mongodb-34


sudo cp /etc/mongod.conf /data/mongod.conf.orig
sudo sed -i -e "s;/var/lib/mongodb;/data/mongodb;g" /etc/mongod.conf
sudo sed -i -e "s;bindIp: 127.0.0.1;bindIp: 0.0.0.0;g" /etc/mongod.conf
sudo chown -R mongod:mongod /data/mongodb
sudo service mongod restart

mongo admin --eval 'db.createUser({user: "sharecare_app_user", pwd: "ihealth99", roles: ["root"] });'
mongo Readmission --eval 'db.foo.insert( { x: 1, y: 1 } )'
mongo Readmission --eval 'db.createUser({user: "sharecare_app_user", pwd: "ihealth99", roles: [{role: "dbOwner", db: "Readmission"}]});'
echo "security:" | sudo tee -a /etc/mongod.conf
echo "  authorization: enabled" | sudo tee -a /etc/mongod.conf
sudo service mongod restart

！！正式
ssh -i '/Users/sagegu/Documents/GitHub/pem/dev_keypair.pem' ubuntu@20.0.1.109

ssh -i '/Users/sagegu/Documents/GitHub/pem/dev_keypair.pem' ubuntu@20.0.1.52

scp -i '/Users/sagegu/Documents/GitHub/pem/dev_keypair.pem' ubuntu@20.0.1.109:/data/mongod.conf.orig ubuntu@20.0.1.52:/data

scp -i '/Users/sagegu/Documents/GitHub/pem/dev_keypair.pem'  /Users/sagegu/Documents/GitHub/pem/dev_keypair.pem ubuntu@20.0.1.52:/data

sudo docker stop mongo
sudo docker rm -f mongo 
sudo docker run --name mongo  -v /data/mongodb:/data/db -p 27017:27017 -d percona/percona-server-mongodb:3.4 --bind_ip 0.0.0.0 
docker ps -a
docker logs mongo 

### + snapshot
dev-new-mongodb44-sage-snapshot-2022-5-28
df -hT
```
sudo umount /data
sudo lsblk
sudo rm -rf /data
# create mount dir
sudo mkdir -p /data
# new file system
sudo mkfs -t ext4 /dev/xvdg
sudo mount /dev/xvdf /data
# change ownership to specified user
sudo chown -R 1001:1001 /data/mongodb

### install mongo client
sudo apt install mongodb-clients
```

### dump
DB=mongodb://sharecare_app_user:ihealth99@20.0.1.109:27017/ShareCare
mongo admin  -u admin -p ihealth99 --authenticationDatabase=admin
 
scp -i ./dev_keypair.pem -r ubuntu@20.0.1.109:/var/lib/mongodb/ .
sudo chown -R 1001:1001 /data/mongodb

 sudo docker stop mongo
sudo docker rm -f mongo 
sudo docker run --name mongo  -v /data/mongodb:/data/db -p 27017:27017 -d percona/percona-server-mongodb:4.4 --bind_ip 0.0.0.0  
docker ps -a
docker logs mongo 

use local
show collections
db.getCollection('system.replset').find({}).limit(20)
db.system.replset.remove({})

 db.replset.minvalid.update(
 { "_id" : ObjectId("5f23cff89a30f193763fa54e")},
   { $unset: { oplogDeleteFromPoint: ""} }
);

mongo ShareCare -u sharecare_app_user -p ihealth99
mongo admin  -u admin -p ihealth99 --authenticationDatabase=admin

cfg = rs.conf()
cfg.members[0].host = "dev-new-mongo.ihealth-eng.com"
rs.reconfig(cfg,  {force: true})
