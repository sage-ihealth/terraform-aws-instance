 the example configuration sets the AMI ID to an Ubuntu image, and the instance type to t2.micro, which qualifies for AWS' free tier.

 terraform init
 terraform apply  
 terraform destroy

 ----------------------------------------------------------------
login to sage-dev=new mock
ps aux | grep -i apt
sudo dpkg --configure -a


sudo apt update

sudo apt-get update
sudo apt-get -y install percona-server-mongodb-34

#version is  Ubuntu 16.04.3 LTS
lsb_release -a

---------------below working-----------------
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