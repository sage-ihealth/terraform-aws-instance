

curl  --request DELETE 'connector.da.svc.cluster.local:8083/connectors/da'
curl  --request POST 'connector.da.svc.cluster.local:8083/connectors/'  \
--header 'Content-Type: application/json' \
--data-raw  '{"name":"da","config":{"connector.class":"io.debezium.connector.mongodb.MongoDbConnector","mongodb.password":"ihealth99","tasks.max":"1","mongodb.user":"admin","name":"da","mongodb.name":"da","database.whitelist":"ShareCare","mongodb.hosts":"dev-new-mongo.ihealth-eng.com:27017","snapshot.fetch.size":"1000","collection.whitelist":"ShareCare.enrolled_programs,ShareCare.visits,ShareCare.lab_results,ShareCare.admin_programs,ShareCare.device_hubs,ShareCare.claimed_time_log,ShareCare.billable_time_reports,ShareCare.roles,ShareCare.chatMessages,ShareCare.user_status,ShareCare.patient_assignees,ShareCare.feedbacks,ShareCare.organizations,ShareCare.challenge_reward_details,ShareCare.measurements,ShareCare.phone_call,ShareCare.patient_reward,ShareCare.results,ShareCare.remote_enrollment,ShareCare.patient_referral,ShareCare.patient_consent,ShareCare.orders,ShareCare.smart_alert_tasks,ShareCare.provider_notes,ShareCare.postits,ShareCare.missing_info,ShareCare.icd10_billables,ShareCare.billing_monthly_times,ShareCare.time_tracker,ShareCare.task_assignments,ShareCare.food_logs,ShareCare.member_billable_codes,ShareCare.teams,ShareCare.insurance_providers,ShareCare.phone_report_info,ShareCare.iot_devices,ShareCare.heartbeat_logs,ShareCare.usage_heartbeats,ShareCare.accounts"}}' 


curl  --request DELETE 'connector.da.svc.cluster.local:8083/connectors/workstation'
curl  --request POST 'connector.da.svc.cluster.local:8083/connectors/'  \
--header 'Content-Type: application/json' \
--data-raw  '{"name":"workstation","config":{"connector.class":"io.debezium.connector.mongodb.MongoDbConnector","mongodb.password":"ihealth99","tasks.max":"1","mongodb.user":"admin","name":"workstation","mongodb.name":"workstation","database.whitelist":"ShareCare","mongodb.hosts":"dev-new-mongo.ihealth-eng.com:27017","snapshot.fetch.size":"1000","collection.whitelist":"ShareCare.food_logs,ShareCare.smart_alert_tasks,ShareCare.chatMessages,ShareCare.chatMessageTags,ShareCare.monthly_review,ShareCare.enrolled_programs,ShareCare.task_assignments,ShareCare.patient_assignees,ShareCare.missing_info"}}'

curl  --request DELETE 'connector.da.svc.cluster.local:8083/connectors/hl7'
curl  --request POST 'connector.da.svc.cluster.local:8083/connectors/'  \
--header 'Content-Type: application/json' \
--data-raw  '{"name":"hl7","config":{"connector.class":"io.debezium.connector.mongodb.MongoDbConnector","mongodb.password":"ihealth99","tasks.max":"1","mongodb.user":"admin","name":"hl7","mongodb.name":"hl7","database.whitelist":"ShareCare","mongodb.hosts":"dev-new-mongo.ihealth-eng.com:27017","snapshot.fetch.size":"1000","collection.whitelist":"ShareCare.accounts,ShareCare.smart_alert_tasks,ShareCare.measurements"}}'


curl  --request DELETE 'connector.da.svc.cluster.local:8083/connectors/soter'
curl  --request POST 'connector.da.svc.cluster.local:8083/connectors/'  \
--header 'Content-Type: application/json' \
--data-raw  '{"name":"soter","config":{"connector.class":"io.debezium.connector.mongodb.MongoDbConnector","mongodb.password":"ihealth99","tasks.max":"1","mongodb.user":"ruixue","name":"soter","mongodb.name":"soter","database.whitelist":"ShareCare","mongodb.hosts":"dev-new-mongo.ihealth-eng.com","snapshot.fetch.size":"1000","collection.whitelist":"ShareCare.enrolled_programs,ShareCare.roles,ShareCare.organizations,ShareCare.accounts,ShareCare.teams"}}' 

curl connector.da.svc.cluster.local:8083/connectors/da
curl connector.da.svc.cluster.local:8083/connectors/workstation
curl connector.da.svc.cluster.local:8083/connectors/hl7
curl connector.da.svc.cluster.local:8083/connectors/soter
