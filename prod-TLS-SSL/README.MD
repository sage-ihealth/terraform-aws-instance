
# How to configure a ReplicaSet to support TLS/SSL?


 
##  Create the Root Certificate
 openssl req -nodes -out ca.pem -new -x509 -keyout ca.key

Generating a 2048 bit RSA private key
.........+++
...........+++
writing new private key to 'ca.key'
-----
You are about to be asked to enter information that will be incorporated
into your certificate request.
What you are about to enter is what is called a Distinguished Name or a DN.
There are quite a few fields but you can leave some blank
For some fields there will be a default value,
If you enter '.', the field will be left blank.
-----
Country Name (2 letter code) []:
State or Province Name (full name) []:
Locality Name (eg, city) []:
Organization Name (eg, company) []:
Organizational Unit Name (eg, section) []:
Common Name (eg, fully qualified host name) []:prod
Email Address []:

## Generate the Certificate Requests and the Private Keys
When generating the Certificate Signing Request (aka CSR), input the exact hostname (or IP) of your node in the Common Name (aka CN) field. The others fields must have exactly the same value. You might need to modify your /etc/hosts file.

The commands below will generate the CSR files and the RSA Private Keys (4096 bits).
```
openssl req -nodes -newkey rsa:4096 -sha256 -keyout mongodb_node_1.key -out mongodb_node_1.csr
openssl req -nodes -newkey rsa:4096 -sha256 -keyout mongodb_node_2.key -out mongodb_node_2.csr
openssl req -nodes -newkey rsa:4096 -sha256 -keyout mongodb_node_3.key -out mongodb_node_3.csr
```

## Sign your Certificate Requests

Use the CA File (ca.pem) and its Private Key (ca.key) generated previously to sign each Certificate Request by running the commands below.
```
openssl x509 -req -in mongodb_node_1.csr -CA ca.pem -CAkey ca.key -set_serial 00 -out mongodb_node_1.crt
openssl x509 -req -in mongodb_node_2.csr -CA ca.pem -CAkey ca.key -set_serial 00 -out mongodb_node_2.crt
openssl x509 -req -in mongodb_node_3.csr -CA ca.pem -CAkey ca.key -set_serial 00 -out mongodb_node_3.crt
```

You must sign each CSR.

Signature ok
subject=/CN=node1.prod-mongo.ihealth-eng.com
Getting CA Private Key
Signature ok
subject=/CN=node2.prod-mongo.ihealth-eng.com
Getting CA Private Key
Signature ok
subject=/CN=node3.prod-mongo.ihealth-eng.com
Getting CA Private Key



Your must now have 3 CSRs, 3 Private Keys and 3 self-signed Certificates. Only the Private Keys and the Certificates will be used by MongoDB.

## Concat each Node Certificate with its key

Run the commands below to concat each Node Certificate with its key in one file (MongoDB requirement).
```
cat mongodb_node_1.key mongodb_node_1.crt > mongodb_node_1.pem
cat mongodb_node_2.key mongodb_node_2.crt > mongodb_node_2.pem
cat mongodb_node_3.key mongodb_node_3.crt > mongodb_node_3.pem
```

Your must now have 3 PEM files.


## Deploy your ReplicaSet for Mutual SSL / Mutual Trust

To force your client to provide a Client Certificate (Mutual SSL), you must add the CA File when running your instances.
```
mongod --dbpath data/data_1 --replSet rs0 --port 27017 --sslMode requireSSL --sslPEMKeyFile mongodb_node_1.pem --sslCAFile ca.pem
mongod --dbpath data/data_2 --replSet rs0 --port 27018 --sslMode requireSSL --sslPEMKeyFile mongodb_node_2.pem --sslCAFile ca.pem
mongod --dbpath data/data_3 --replSet rs0 --port 27019 --sslMode requireSSL --sslPEMKeyFile mongodb_node_3.pem --sslCAFile ca.pem
```

You now have a 3 Nodes ReplicaSet deployed on your local environment and all their transactions are encrypted. You cannot connect to this ReplicaSet without using TLS or without providing a Client Certificate trusted by your CA.

## With Mutual SSL
openssl req -nodes -newkey rsa:4096 -sha256 -keyout mongodb_client.key -out mongodb_client.csr

```
openssl req -nodes -newkey rsa:4096 -sha256 -keyout mongodb_client.key -out mongodb_client.csr -config <(
cat <<-EOF
[req]
default_bits = 4096
prompt = no
default_md = sha256
req_extensions = req_ext
distinguished_name = dn
 
[ dn ]
CN = .
 
[ req_ext ]
subjectAltName = @alt_names
 
[ alt_names ]
DNS.1 = node1.prod-mongo.ihealth-eng.com
DNS.2 = node2.prod-mongo.ihealth-eng.com
DNS.3 = node3.prod-mongo.ihealth-eng.com
EOF
)
openssl x509 -req -in mongodb_client.csr  -CA ca.pem -CAkey ca.key -set_serial 00 -out mongodb_client.crt
cat mongodb_client.key mongodb_client.crt > mongodb_client.pem
```

mongo --ssl --sslCAFile ca.pem --host rs0.prod/node1.prod-mongo.ihealth-eng.com:27017,node2.prod-mongo.ihealth-eng.com:27017,node3.prod-mongo.ihealth-eng.com:27017 --sslPEMKeyFile mongodb_client.pem
