package main

import (
	"fmt"
	"os"
	"os/exec"
	"time"
)

func change_freq(freq string)  {
	for true {
		cmd := exec.Command("bash", "-c", "sudo cpupower frequency-set -u " + freq)
		cmd.Run()
		time.Sleep(2 * time.Second)
	}
}

func main() {
	fmt.Println("Setting the cpu frequency to " + os.Args[1] + " via cpupower frequency-set")
	fmt.Println("The command is executed every 2 seconds since cpupower with amd doesn't persist the set freuquency.")

	channel := make(chan string)
	
	go change_freq(os.Args[1])

	close(channel)

}
