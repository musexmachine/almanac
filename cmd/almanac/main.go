package main

import (
	"flag"
	"fmt"
	"os"
)

var version = "dev"

func main() {
	showVersion := flag.Bool("version", false, "print version")
	flag.Parse()

	if *showVersion {
		fmt.Println(version)
		return
	}

	if len(os.Args) == 1 {
		fmt.Println("almanac: bootstrap CLI ready; see PLAN.md and TASKS.md")
		return
	}

	fmt.Println("almanac: command wiring not implemented yet")
}
