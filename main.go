package main

import (
	"fmt"
	"os"
	"os/exec"
	"time"
)

func main() {
	fmt.Println("Setting the cpu frequency to " + os.Args[1] + " via cpupower frequency-set")
	fmt.Println("The command is executed every 2 seconds since cpupower with amd doesn't persist the set freuquency.")
	for true {
		cmd := exec.Command("bash", "-c", "sudo cpupower frequency-set -u " + os.Args[1])
		cmd.Run()
		time.Sleep(2 * time.Second)
	}
}
