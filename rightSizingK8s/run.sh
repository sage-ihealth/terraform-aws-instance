
kubectl config current-context
k version

# https://github.com/kubernetes-sigs/metrics-server
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml

# https://github.com/kubernetes/autoscaler/tree/master/vertical-pod-autoscaler
# Compatibility √ 
cd /Users/sagegu/Desktop/autoscaler #cd rightSizingK8s/autoscaler/
git checkout vpa-release-0.8
# ./autoscaler/vertical-pod-autoscaler/hack/vpa-down.sh 
./vertical-pod-autoscaler/hack/vpa-up.sh 

# https://goldilocks.docs.fairwinds.com/installation/#installation-2
k create ns goldilocks

helm repo add fairwinds-stable https://charts.fairwinds.com/stable
helm install goldilocks --namespace goldilocks fairwinds-stable/goldilocks

# export POD_NAME=$(kubectl get pods --namespace goldilocks -l "app.kubernetes.io/name=goldilocks,app.kubernetes.io/instance=goldilocks,app.kubernetes.io/component=dashboard" -o jsonpath="{.items[0].metadata.name}”)
# kubectl port-forward $POD_NAME 8080:80 --namespace goldilocks
# kubectl -n goldilocks port-forward svc/goldilocks-dashboard 8080:80

kubectl label ns goldilocks goldilocks.fairwinds.com/enabled=true
kubectl label ns backend goldilocks.fairwinds.com/enabled=true
kubectl label ns backend goldilocks.fairwinds.com/vpa-update-mode="off"

kubectl label ns amazon-cloudwatch goldilocks.fairwinds.com/enabled=true 
kubectl label ns analytics goldilocks.fairwinds.com/enabled=true
kubectl label ns backend goldilocks.fairwinds.com/enabled=true
kubectl label ns backend-admin-portal goldilocks.fairwinds.com/enabled=true
kubectl label ns coverage goldilocks.fairwinds.com/enabled=true
kubectl label ns covid-test-kit goldilocks.fairwinds.com/enabled=true
kubectl label ns cronjobs goldilocks.fairwinds.com/enabled=true
kubectl label ns da goldilocks.fairwinds.com/enabled=true
kubectl label ns data-pipeline goldilocks.fairwinds.com/enabled=true
kubectl label ns default goldilocks.fairwinds.com/enabled=true
kubectl label ns demo goldilocks.fairwinds.com/enabled=true
kubectl label ns dingchao goldilocks.fairwinds.com/enabled=true
kubectl label ns drone goldilocks.fairwinds.com/enabled=true
kubectl label ns edward-zhang goldilocks.fairwinds.com/enabled=true
kubectl label ns ehr goldilocks.fairwinds.com/enabled=true
kubectl label ns emrdirect goldilocks.fairwinds.com/enabled=true
kubectl label ns epic-oauth goldilocks.fairwinds.com/enabled=true
kubectl label ns etcd goldilocks.fairwinds.com/enabled=true
kubectl label ns fhir goldilocks.fairwinds.com/enabled=true
kubectl label ns flink-cluster goldilocks.fairwinds.com/enabled=true
kubectl label ns goldilocks goldilocks.fairwinds.com/enabled=true
kubectl label ns haidong goldilocks.fairwinds.com/enabled=true
kubectl label ns hapi goldilocks.fairwinds.com/enabled=true
kubectl label ns heartbeat goldilocks.fairwinds.com/enabled=true
kubectl label ns hl7 goldilocks.fairwinds.com/enabled=true
kubectl label ns ihealth-lambda goldilocks.fairwinds.com/enabled=true
kubectl label ns ihealth-test goldilocks.fairwinds.com/enabled=true
kubectl label ns jiaxi goldilocks.fairwinds.com/enabled=true
kubectl label ns kafka-sink goldilocks.fairwinds.com/enabled=true
kubectl label ns kube-node-lease goldilocks.fairwinds.com/enabled=true
kubectl label ns kube-public goldilocks.fairwinds.com/enabled=true
kubectl label ns kube-system goldilocks.fairwinds.com/enabled=true
kubectl label ns kubernetes-dashboard goldilocks.fairwinds.com/enabled=true

kubectl label ns message goldilocks.fairwinds.com/enabled=true
 
kubectl label ns monitoring goldilocks.fairwinds.com/enabled=true
kubectl label ns newchs goldilocks.fairwinds.com/enabled=true
kubectl label ns orders goldilocks.fairwinds.com/enabled=true
kubectl label ns permission goldilocks.fairwinds.com/enabled=true
kubectl label ns permission-a goldilocks.fairwinds.com/enabled=true
kubectl label ns permission-manager goldilocks.fairwinds.com/enabled=true
kubectl label ns pritunl goldilocks.fairwinds.com/enabled=true
kubectl label ns proctor goldilocks.fairwinds.com/enabled=true
kubectl label ns quan goldilocks.fairwinds.com/enabled=true
kubectl label ns repository goldilocks.fairwinds.com/enabled=true
kubectl label ns ruixue goldilocks.fairwinds.com/enabled=true
kubectl label ns sage goldilocks.fairwinds.com/enabled=true
kubectl label ns saml-service goldilocks.fairwinds.com/enabled=true
kubectl label ns shuoliu goldilocks.fairwinds.com/enabled=true
kubectl label ns smilecdr goldilocks.fairwinds.com/enabled=true
kubectl label ns soter goldilocks.fairwinds.com/enabled=true



kubectl label ns amazon-cloudwatch goldilocks.fairwinds.com/vpa-update-mode="off" --overwrite=true
kubectl label ns analytics goldilocks.fairwinds.com/vpa-update-mode="off"
kubectl label ns backend goldilocks.fairwinds.com/vpa-update-mode="off"
kubectl label ns backend-admin-portal goldilocks.fairwinds.com/vpa-update-mode="off"
kubectl label ns coverage goldilocks.fairwinds.com/vpa-update-mode="off"
kubectl label ns covid-test-kit goldilocks.fairwinds.com/vpa-update-mode="off"
kubectl label ns da goldilocks.fairwinds.com/vpa-update-mode="off"
kubectl label ns data-pipeline goldilocks.fairwinds.com/vpa-update-mode="off"
kubectl label ns default goldilocks.fairwinds.com/vpa-update-mode="off"
kubectl label ns demo goldilocks.fairwinds.com/vpa-update-mode="off"
kubectl label ns dingchao goldilocks.fairwinds.com/vpa-update-mode="off"
kubectl label ns drone goldilocks.fairwinds.com/vpa-update-mode="off"
kubectl label ns ehr goldilocks.fairwinds.com/vpa-update-mode="off"
kubectl label ns emrdirect goldilocks.fairwinds.com/vpa-update-mode="off"
kubectl label ns epic-oauth goldilocks.fairwinds.com/vpa-update-mode="off"
kubectl label ns etcd goldilocks.fairwinds.com/vpa-update-mode="off"
kubectl label ns fhir goldilocks.fairwinds.com/vpa-update-mode="off"
kubectl label ns flink-cluster goldilocks.fairwinds.com/vpa-update-mode="off"
kubectl label ns goldilocks goldilocks.fairwinds.com/vpa-update-mode="off"
kubectl label ns haidong goldilocks.fairwinds.com/vpa-update-mode="off"
kubectl label ns hapi goldilocks.fairwinds.com/vpa-update-mode="off"
kubectl label ns heartbeat goldilocks.fairwinds.com/vpa-update-mode="off"
kubectl label ns hl7 goldilocks.fairwinds.com/vpa-update-mode="off"
kubectl label ns ihealth-lambda goldilocks.fairwinds.com/vpa-update-mode="off"
kubectl label ns ihealth-test goldilocks.fairwinds.com/vpa-update-mode="off"
kubectl label ns jiaxi goldilocks.fairwinds.com/vpa-update-mode="off"
kubectl label ns kafka-sink goldilocks.fairwinds.com/vpa-update-mode="off"
kubectl label ns kube-node-lease goldilocks.fairwinds.com/vpa-update-mode="off"
kubectl label ns kube-public goldilocks.fairwinds.com/vpa-update-mode="off"
kubectl label ns kube-system goldilocks.fairwinds.com/vpa-update-mode="off"
kubectl label ns kubernetes-dashboard goldilocks.fairwinds.com/vpa-update-mode="off"
kubectl label ns kun goldilocks.fairwinds.com/vpa-update-mode="off"
kubectl label ns message goldilocks.fairwinds.com/vpa-update-mode="off"
kubectl label ns mongo goldilocks.fairwinds.com/vpa-update-mode="off"
kubectl label ns mongodb goldilocks.fairwinds.com/vpa-update-mode="off"
kubectl label ns monitoring goldilocks.fairwinds.com/vpa-update-mode="off"
kubectl label ns newchs goldilocks.fairwinds.com/vpa-update-mode="off"
kubectl label ns orders goldilocks.fairwinds.com/vpa-update-mode="off"
kubectl label ns permission goldilocks.fairwinds.com/vpa-update-mode="off"
kubectl label ns permission-a goldilocks.fairwinds.com/vpa-update-mode="off"
kubectl label ns permission-manager goldilocks.fairwinds.com/vpa-update-mode="off"
kubectl label ns pritunl goldilocks.fairwinds.com/vpa-update-mode="off"
kubectl label ns proctor goldilocks.fairwinds.com/vpa-update-mode="off"
kubectl label ns quan goldilocks.fairwinds.com/vpa-update-mode="off"
kubectl label ns repository goldilocks.fairwinds.com/vpa-update-mode="off"
kubectl label ns sage goldilocks.fairwinds.com/vpa-update-mode="off"
kubectl label ns saml-service goldilocks.fairwinds.com/vpa-update-mode="off"
kubectl label ns shuoliu goldilocks.fairwinds.com/vpa-update-mode="off"
kubectl label ns smilecdr goldilocks.fairwinds.com/vpa-update-mode="off"
kubectl label ns soter goldilocks.fairwinds.com/vpa-update-mode="off"


kubectl label ns hl7 goldilocks.fairwinds.com/enabled=false --overwrite=true

