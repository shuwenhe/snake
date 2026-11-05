package main
import ("std.prelude")

// Global game state
prng_state := 1234567
head_x := 20
head_y := 10
food_x := 15
food_y := 10
body_x := [19, 18, 17, 16, 15, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
body_y := [10, 10, 10, 10, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
max_body_length := 20
length := 5
score := 0
direction := 3
step_num := 0

func init_game() {
    head_x = 20
    head_y = 10
    food_x = 15
    food_y = 10
    
    body_x[0] = 19
    body_x[1] = 18
    body_x[2] = 17
    body_x[3] = 16
    body_x[4] = 15
    
    body_y[0] = 10
    body_y[1] = 10
    body_y[2] = 10
    body_y[3] = 10
    body_y[4] = 10
    
    length = 5
    score = 0
    direction = 3
    step_num = 0
}

func prng() int {
    prng_state = (prng_state * 1103515245 + 12345) & 2147483647
    return prng_state
}

func place_food() {
    attempts := 0
    attempts_limit := 100
    
    for attempts < attempts_limit {
        food_x = 2 + (prng() % 76)
        food_y = 2 + (prng() % 20)
        
        collision := 0
        i := 0
        for i < length {
            if body_x[i] == food_x && body_y[i] == food_y {
                collision = 1
            }
            i = i + 1
        }
        
        if head_x == food_x && head_y == food_y {
            collision = 1
        }
        
        if collision == 0 {
            return
        }
        
        attempts = attempts + 1
    }
}

func render_board() {
    i := 0
    y := 0
    
    for y < 24 {
        x := 0
        for x < 80 {
            if head_x == x && head_y == y {
                println("@")
            } else if food_x == x && food_y == y {
                println("*")
            } else {
                in_body := 0
                i = 0
                for i < length {
                    if body_x[i] == x && body_y[i] == y {
                        in_body = 1
                    }
                    i = i + 1
                }
                
                if in_body != 0 {
                    println("o")
                } else {
                    println(" ")
                }
            }
            x = x + 1
        }
        println("")
        y = y + 1
    }
}

func move_up() {
    head_y = head_y - 1
}

func move_down() {
    head_y = head_y + 1
}

func move_left() {
    head_x = head_x - 1
}

func move_right() {
    head_x = head_x + 1
}

func update_body() {
    i := length - 1
    for i > 0 {
        body_x[i] = body_x[i - 1]
        body_y[i] = body_y[i - 1]
        i = i - 1
    }
    body_x[0] = head_x
    body_y[0] = head_y
}

func collision_self() int {
    i := 1
    for i < length {
        if head_x == body_x[i] && head_y == body_y[i] {
            return 1
        }
        i = i + 1
    }
    return 0
}

func collision_food() int {
    if head_x == food_x && head_y == food_y {
        return 1
    }
    return 0
}

func eat() {
    score = score + 1
    if length < max_body_length {
        length = length + 1
    }
    place_food()
}

func step() int {
    step_num = step_num + 1
    
    if direction == 0 {
        move_up()
    } else if direction == 1 {
        move_down()
    } else if direction == 2 {
        move_left()
    } else if direction == 3 {
        move_right()
    }
    
    update_body()
    
    if collision_self() != 0 {
        return 1
    }
    
    if collision_food() != 0 {
        eat()
    }
    
    render_board()
    
    return 0
}

func run() int {
    init_game()
    
    println("====================================================")
    println("        S Language SNAKE GAME - Pure S")
    println("====================================================")
    println("")
    println("================== SNAKE GAME ==================")
    println("Head: @  Body: o  Food: *  Max length: 20")
    println("Default direction: RIGHT")
    println("This version is auto-play demonstration")
    println("============================================")
    println("")
    
    i := 0
    max_ticks := 1000
    
    for i < max_ticks {
        if step() != 0 {
            println("")
            println("GAME OVER!")
            println("Score: " + std.prelude.to_string(score))
            println("Steps: " + std.prelude.to_string(step_num))
            println("Length: " + std.prelude.to_string(length))
            return 0
        }
        
        i = i + 1
    }
    
    println("")
    println("Time limit reached!")
    println("Final Score: " + std.prelude.to_string(score))
    println("Final Length: " + std.prelude.to_string(length))
    return 0
}

func main() {
    return run()
}
