package api

import (
	"encoding/json"
	"testing"

	"golang.org/x/net/context"

	log "github.com/sirupsen/logrus"
	"github.com/stretchr/testify/assert"
	v1 "k8s.io/api/core/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"

	"k8s.io/client-go/kubernetes"
	testclient "k8s.io/client-go/kubernetes/fake"
)

func genLister() lister {
	return lister{
		clientset: testclient.NewSimpleClientset(),
	}
}

type namespacePolicy struct {
	Ingress struct {
		Isolation string `json:"isolation"`
	} `json:"ingress"`
}

func createNamespaceInt(
	clientset kubernetes.Interface,
	name string,
	labels map[string]string,
	isolation string,
) {
	ns_in := &v1.Namespace{
		ObjectMeta: metav1.ObjectMeta{
			Name:   name,
			Labels: labels,
		},
	}
	if isolation != "" {
		np := namespacePolicy{}
		np.Ingress.Isolation = isolation
		annotation, _ := json.Marshal(np)
		ns_in.ObjectMeta.Annotations = map[string]string{
			"net.beta.kubernetes.io/network-policy": string(annotation),
		}
	}
	log.WithField("ns_in", ns_in).Debug("Namespace defined")
	ns_out, err := clientset.CoreV1().Namespaces().Create(context.Background(), ns_in, metav1.CreateOptions{})
	if err != nil {
		panic(err)
	}
	log.WithField("ns_out", ns_out).Debug("Created namespace")
}

func TestNamespace(t *testing.T) {
	l := genLister()
	names, err := l.GetAllNamespaces()

	assert.Nil(t, err, "Expected no error loading role bindings")
	assert.Len(t, names, 0, "Expected no rbac subjects initially")

	name := "test"
	var labels = make(map[string]string)
	labels["name"] = "subjectName"
	createNamespaceInt(l.clientset, name, labels, "DefaultDeny")

	names1, err1 := l.GetAllNamespaces()

	log.WithField("ns_in", names1).Debug("Namespace defined")

	assert.Nil(t, err1, "Expected no error loading role bindings")
	assert.Len(t, names1, 1, "Expected no rbac subjects initially")

}
