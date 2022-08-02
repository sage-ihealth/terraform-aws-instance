package api

import (
	"fmt"
	"os"

	"k8s.io/client-go/kubernetes"
	"k8s.io/client-go/rest"
	"k8s.io/client-go/tools/clientcmd"
)

type lister struct {
	clientset kubernetes.Interface
	namespace []string
}

var L = lister{}

func InitK8sClient(args []string, kubeConfig, kubeContext, outputFormat, subjectKind string) {
	var config *rest.Config
	var err error

	// in cluster
	config, err = rest.InClusterConfig()
	if err != nil {

		fmt.Println("in cluster err: ", err)

		fmt.Println("maybe this is out cluster")
		// out cluster
		clientConfig := getClientConfig(kubeConfig, kubeContext)
		config, err = clientConfig.ClientConfig()
		if err != nil {
			fmt.Printf("Error getting Kubernetes config: %v\n", err)
			os.Exit(1)
		}

	}

	// creates the clientset
	clientset, err := kubernetes.NewForConfig(config)
	if err != nil {
		fmt.Println("err 2", err)

		panic(err.Error())
	}

	L = lister{
		clientset: clientset,
	}
}

func getClientConfig(kubeConfig, kubeContext string) clientcmd.ClientConfig {
	configRules := clientcmd.NewDefaultClientConfigLoadingRules()
	configRules.ExplicitPath = kubeConfig
	return clientcmd.NewNonInteractiveDeferredLoadingClientConfig(
		configRules,
		&clientcmd.ConfigOverrides{CurrentContext: kubeContext},
	)
}
