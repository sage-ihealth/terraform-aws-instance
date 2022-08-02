kubectl label ns amazon-cloudwatch goldilocks.fairwinds.com/vpa-update-mode="off" --overwrite=true 
kubectl label ns analytics goldilocks.fairwinds.com/vpa-update-mode="off" --overwrite=true
kubectl label ns backend goldilocks.fairwinds.com/vpa-update-mode="off" --overwrite=true
kubectl label ns backend-admin-portal goldilocks.fairwinds.com/vpa-update-mode="off" --overwrite=true
kubectl label ns coverage goldilocks.fairwinds.com/vpa-update-mode="auto" --overwrite=true
kubectl label ns covid-test-kit goldilocks.fairwinds.com/vpa-update-mode="off" --overwrite=true
kubectl label ns da goldilocks.fairwinds.com/vpa-update-mode="off" --overwrite=true
kubectl label ns data-pipeline goldilocks.fairwinds.com/vpa-update-mode="off" --overwrite=true
kubectl label ns default goldilocks.fairwinds.com/vpa-update-mode="off" --overwrite=true
kubectl label ns demo goldilocks.fairwinds.com/vpa-update-mode="off" --overwrite=true
kubectl label ns dingchao goldilocks.fairwinds.com/vpa-update-mode="off" --overwrite=true
kubectl label ns drone goldilocks.fairwinds.com/vpa-update-mode="off" --overwrite=true
kubectl label ns ehr goldilocks.fairwinds.com/vpa-update-mode="off" --overwrite=true
kubectl label ns emrdirect goldilocks.fairwinds.com/vpa-update-mode="off" --overwrite=true
kubectl label ns epic-oauth goldilocks.fairwinds.com/vpa-update-mode="off" --overwrite=true
kubectl label ns etcd goldilocks.fairwinds.com/vpa-update-mode="off" --overwrite=true
kubectl label ns fhir goldilocks.fairwinds.com/vpa-update-mode="off" --overwrite=true
kubectl label ns flink-cluster goldilocks.fairwinds.com/vpa-update-mode="off" --overwrite=true
kubectl label ns goldilocks goldilocks.fairwinds.com/vpa-update-mode="off" --overwrite=true
kubectl label ns haidong goldilocks.fairwinds.com/vpa-update-mode="off" --overwrite=true
kubectl label ns hapi goldilocks.fairwinds.com/vpa-update-mode="off" --overwrite=true
kubectl label ns heartbeat goldilocks.fairwinds.com/vpa-update-mode="off" --overwrite=true
kubectl label ns hl7 goldilocks.fairwinds.com/vpa-update-mode="off" --overwrite=true
kubectl label ns ihealth-lambda goldilocks.fairwinds.com/vpa-update-mode="off" --overwrite=true
kubectl label ns ihealth-test goldilocks.fairwinds.com/vpa-update-mode="off" --overwrite=true
kubectl label ns jiaxi goldilocks.fairwinds.com/vpa-update-mode="off" --overwrite=true
kubectl label ns kafka-sink goldilocks.fairwinds.com/vpa-update-mode="off" --overwrite=true
kubectl label ns kube-node-lease goldilocks.fairwinds.com/vpa-update-mode="off" --overwrite=true
kubectl label ns kube-public goldilocks.fairwinds.com/vpa-update-mode="off" --overwrite=true
kubectl label ns kube-system goldilocks.fairwinds.com/vpa-update-mode="off" --overwrite=true
kubectl label ns kubernetes-dashboard goldilocks.fairwinds.com/vpa-update-mode="off" --overwrite=true
kubectl label ns kun goldilocks.fairwinds.com/vpa-update-mode="off" --overwrite=true
kubectl label ns message goldilocks.fairwinds.com/vpa-update-mode="off" --overwrite=true
kubectl label ns mongo goldilocks.fairwinds.com/vpa-update-mode="off" --overwrite=true
kubectl label ns mongodb goldilocks.fairwinds.com/vpa-update-mode="off" --overwrite=true
kubectl label ns monitoring goldilocks.fairwinds.com/vpa-update-mode="off" --overwrite=true

kubectl label ns orders goldilocks.fairwinds.com/vpa-update-mode="off" --overwrite=true
kubectl label ns permission goldilocks.fairwinds.com/vpa-update-mode="off" --overwrite=true
kubectl label ns permission-a goldilocks.fairwinds.com/vpa-update-mode="off" --overwrite=true
kubectl label ns permission-manager goldilocks.fairwinds.com/vpa-update-mode="off" --overwrite=true
kubectl label ns pritunl goldilocks.fairwinds.com/vpa-update-mode="off" --overwrite=true

kubectl label ns quan goldilocks.fairwinds.com/vpa-update-mode="off" --overwrite=true
kubectl label ns repository goldilocks.fairwinds.com/vpa-update-mode="off" --overwrite=true
kubectl label ns sage goldilocks.fairwinds.com/vpa-update-mode="off" --overwrite=true
kubectl label ns saml-service goldilocks.fairwinds.com/vpa-update-mode="off" --overwrite=true
kubectl label ns shuoliu goldilocks.fairwinds.com/vpa-update-mode="off" --overwrite=true
kubectl label ns smilecdr goldilocks.fairwinds.com/vpa-update-mode="off" --overwrite=true
kubectl label ns soter goldilocks.fairwinds.com/vpa-update-mode="off" --overwrite=true


kubectl label ns backend goldilocks.fairwinds.com/vpa-update-mode="off" --overwrite=true
kubectl label ns backend goldilocks.fairwinds.com/enabled=false  --overwrite=true


kubectl delete pod pritunl-mongo-5789ff574d-8fhnt --grace-period=0 --force --namespace pritunl

kubectl describe pod pritunl-mongo-5789ff574d-8fhnt --namespace pritunl
k -n pritunl scale deployment pritunl-mongo --replicas=0
k -n covid-test-kit  scale deployment covid-test-kit-app  --replicas=1

kubectl -n backend delete pod analytics-67b948f987-vcjkn  --grace-period=0 --force 

kubectl delete pod --grace-period=0 --force --namespace   covid-test-kit  


 # export POD_NAME=$(kubectl get pods --namespace goldilocks -l "app.kubernetes.io/name=goldilocks,app.kubernetes.io/instance=goldilocks,app.kubernetes.io/component=dashboard" -o jsonpath="{.items[0].metadata.name}”)
kubectl label ns covid-test-kit goldilocks.fairwinds.com/enabled=false  --overwrite=true 

k -n dingchao scale deployment form-service-backend --replicas=0

kubectl delete pod --grace-period=0 --force --namespace monitoring  node-exporter-6hzt7 


k -n kube-system scale deployment coredns --replicas=1

kubectl label ns coverage goldilocks.fairwinds.com/enabled=true  --overwrite=true 
