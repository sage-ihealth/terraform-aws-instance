package main

import (
	"rename-vol/api"
)

func main() {
	var args []string
	api.InitK8sClient(args, "", "", "", "")
	api.L.RenameVolume()
}
