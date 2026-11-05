package main

import (
    "src/syscall"
)

func main() int {
    ts := src.syscall.timespec{
        sec: 0,
        nsec: 100000000,
    }
    src.syscall.nanosleep(&ts)
    println("Hello")
    return 0
}
