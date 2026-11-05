package main

import (
    "syscall"
)

func main() int {
    ts := syscall.timespec{
        sec: 0,
        nsec: 100000000,
    }
    syscall.nanosleep(&ts)
    println("Hello")
    return 0
}
