package main

body_x := [19, 18, 17, 16, 15, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
body_y := [10, 10, 10, 10, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
max_body_length := 20
length := 5
head_x := 20
head_y := 10

func update_body() {
    if length < max_body_length {
        i := length
        for i > 0 {
            body_x[i] = body_x[i - 1]
            body_y[i] = body_y[i - 1]
            i = i - 1
        }
    } else {
        i := max_body_length - 1
        for i > 0 {
            body_x[i] = body_x[i - 1]
            body_y[i] = body_y[i - 1]
            i = i - 1
        }
    }
    body_x[0] = head_x
    body_y[0] = head_y
}

func main() int {
    println("Initial length: 5")
    
    idx := 0
    for idx < length {
        println("Body segment: ")
        idx = idx + 1
    }
    
    length = 6
    update_body()
    head_x = 21
    update_body()
    
    println("After eating twice:")
    println("Length should be 6+")
    
    return 0
}
