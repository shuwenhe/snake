package main

struct timespec {
    i64 sec
    i64 nsec
}

func nanosleep(timespec s) {
    return
}

func main() int {
    ts := timespec{sec: 0, nsec: 100000000}
    nanosleep(ts)
    println("Sleep done")
    return 0
}
