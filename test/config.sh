 
export DRONE_SERVER=https://test-drone.ihealth-eng.com
export DRONE_TOKEN=ur6bR9vvOD3M8B0BOawQs0xblmXnTR0c
drone info

drone secret update iHealthLab/ShareCareBackend --name DB --data mongodb://app_user:ihealth99@node1.test-mongo.ihealth-eng.com:27017,node2.test-mongo.ihealth-eng.com:27017,node3.test-mongo.ihealth-eng.com:27017/Sharecare?replicaSet=rs0.test --allow-pull-request


#------------soter------------
drone secret update iHealthLab/soter \
--name MONGODB_URL \
--data mongodb://app_user:ihealth99@node1.test-mongo.ihealth-eng.com:27017,node2.test-mongo.ihealth-eng.com:27017,node3.test-mongo.ihealth-eng.com:27017/Sharecare?replicaSet=rs0.test \
--allow-pull-request

#------------Workstation------------
curl connector.da.svc.cluster.local:8083/connectors/test
curl  --request DELETE 'connector.da.svc.cluster.local:8083/connectors/test'
# mongodb.node1.test.ihealthnext.com,mongodb.node2.test.ihealthnext.com,mongodb.node3.test.ihealthnext.com
# node1.test-mongo.ihealth-eng.com,node2.test-mongo.ihealth-eng.com,node3.test-mongo.ihealth-eng.com
curl  --request POST 'connector.da.svc.cluster.local:8083/connectors/'  \
--header 'Content-Type: application/json' \
--data-raw  '{"name":"test","config":{"connector.class":"io.debezium.connector.mongodb.MongoDbConnector","mongodb.password":"iHealth.Next","tasks.max":"1","mongodb.user":"admin","name":"test","mongodb.name":"test","database.whitelist":"Sharecare","mongodb.hosts":"node1.test-mongo.ihealth-eng.com,node2.test-mongo.ihealth-eng.com,node3.test-mongo.ihealth-eng.com","snapshot.fetch.size":"1000","collection.whitelist":"Sharecare.roles,Sharecare.roles,Sharecare.accounts,Sharecare.teams,Sharecare.organizations,Sharecare.enrolled_programs,Sharecare.chatMessages,Sharecare.food_logs,Sharecare.missing_info,Sharecare.monthly_review,Sharecare.smart_alert_tasks,Sharecare.task_assignments,Sharecare.user_status,Sharecare.patient_assignees"}}'


#------------hapi------------
drone secret info iHealthLab/hapi-fhir-mongo-server --name FHIR_MONGODB_URI

drone secret update iHealthLab/hapi-fhir-mongo-server --name FHIR_MONGODB_URI --data 'mongodb://workstation_user:ihealth99@node1.test-mongo.ihealth-eng.com:27017,node2.test-mongo.ihealth-eng.com:27017,node3.test-mongo.ihealth-eng.com:27017/Fhir?replicaSet=rs0.test&authSource=admin' --allow-pull-request

drone secret update iHealthLab/hapi-fhir-mongo-server \
--name HAPI_MONGODB_URI \
--data 'mongodb://workstation_user:ihealth99@node1.test-mongo.ihealth-eng.com:27017,node2.test-mongo.ihealth-eng.com:27017,node3.test-mongo.ihealth-eng.com:27017/Fhir?replicaSet=rs0.test&authSource=admin' \
--allow-pull-request

drone secret update iHealthLab/hapi-fhir-mongo-server \
--name UC_MONGODB_URI \
--data 'mongodb://workstation_user:ihealth99@node1.test-mongo.ihealth-eng.com:27017,node2.test-mongo.ihealth-eng.com:27017,node3.test-mongo.ihealth-eng.com:27017/Sharecare?replicaSet=rs0.test&authSource=admin' \
--allow-pull-request

#------------hapi restart to update configmap------------
drone build restart iHealthLab/hapi-fhir-mongo-server --branch test
drone build restart iHealthLab/hapi-fhir-mongo-server 420

#------------hapi pod------------
export AWS_DEFAULT_REGION=us-west-2
export AWS_PROFILE=us.dev.aws.cmd.user
export ENVIRONMENT=test
export AWS_ACCOUNT_ID=arn:aws:iam::358153424697
aws eks update-kubeconfig --name $ENVIRONMENT-k8s-cluster --role-arn $AWS_ACCOUNT_ID:role/$ENVIRONMENT-k8s-admin
k  -n hapi get configmap workstation-config -o yaml
k  -n hapi get pod
k  -n hapi delete pod workstation-59d956488c-v5859