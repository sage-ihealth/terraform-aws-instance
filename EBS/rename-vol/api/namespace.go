package api

import (
	"context"
	"fmt"
	"strings"

	// log "github.com/sirupsen/logrus"
	corev1 "k8s.io/api/core/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

func (l *lister) PersistentV(namespace string) {
	if namespace == "etcd" {
		return
	}
	// Get pods list
	podList, _ := l.clientset.CoreV1().Pods(namespace).List(context.TODO(), metav1.ListOptions{})

	// Create new pod list
	podsWithPVC := &corev1.PodList{}

	// Filter pods to check if PVC exists, if yes append to the list
	for _, pod := range podList.Items {
		for _, volume := range pod.Spec.Volumes {
			if volume.PersistentVolumeClaim != nil {
				podsWithPVC.Items = append(podsWithPVC.Items, pod)
				// fmt.Println("Namespace: " + namespace)
				// fmt.Println("Pod Name: " + namespace + pod.GetName())
				claimName := volume.PersistentVolumeClaim.ClaimName
				// fmt.Println("PVC Name: " + claimName)
				pvc, err :=
					l.clientset.CoreV1().PersistentVolumeClaims(namespace).Get(context.TODO(), claimName, metav1.GetOptions{})
				if err != nil || pvc == nil {
					fmt.Errorf("failed to fetch PVC from API server: %v", err)
					break
				}
				pvName := pvc.Spec.VolumeName

				pv, errPV := l.clientset.CoreV1().PersistentVolumes().Get(context.Background(), pvName, metav1.GetOptions{})
				if pv == nil {
					fmt.Errorf("failed to fetch PVC from API server: %v", errPV)
					break
				}
				if pv.Spec.CSI == nil {
					fmt.Errorf("failed to fetch PVC from API server: %v", errPV)
					break
				}

				ebsSource := pv.Spec.CSI.VolumeHandle
				res1 := strings.HasPrefix(ebsSource, "vol-")
				if !res1 {
					break
				}

				fmt.Printf("volume is %s\n", ebsSource)
				colName := "k8s-prod/" + namespace + "/" + pvName
				fmt.Printf("colName is %s \n \n", colName)

				// update volume name on EC2
				renameVol(ebsSource, colName)
			}

		}
	}
}

// GetAllNamespaces lists all the Namespaces available in the K8s cluster.
func (l *lister) RenameVolume() {

	namespaces, err := l.clientset.CoreV1().Namespaces().List(context.Background(), metav1.ListOptions{})
	if err != nil {
		fmt.Println("err", err)
	}

	for _, ns := range namespaces.Items {
		l.PersistentV(ns.Name)
	}

	// l.PersistentV("coverage")
}
