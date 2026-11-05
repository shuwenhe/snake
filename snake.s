package main
import ("std.time"; "std.terminal"; "std.input"; "std.prelude")

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
    for attempts < 50 {
        food_x = 1 + (prng() % 48)
        food_y = 1 + (prng() % 18)
        
        valid := 1
        
        if food_x == head_x && food_y == head_y {
            valid = 0
        }
        
        i := 0
        for i < length {
            if food_x == body_x[i] && food_y == body_y[i] {
                valid = 0
            }
            i = i + 1
        }
        
        if valid == 1 {
            return
        }
        attempts = attempts + 1
    }
}

func move_up() {
    head_y = head_y - 1
    if head_y <= 0 {
        head_y = 19
    }
}

func move_down() {
    head_y = head_y + 1
    if head_y >= 20 {
        head_y = 1
    }
}

func move_left() {
    head_x = head_x - 1
    if head_x <= 0 {
        head_x = 49
    }
}

func move_right() {
    head_x = head_x + 1
    if head_x >= 50 {
        head_x = 1
    }
}

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

func collision_food() int {
    if head_x == food_x && head_y == food_y {
        return 1
    }
    return 0
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

func eat() {
    if length < max_body_length {
        length = length + 1
    }
    score = score + 1
    place_food()
}

func render_board() {
    for r := 0; r < 21; r = r + 1 {
        line := ""
        for cc := 0; cc < 51; cc = cc + 1 {
            if r == 0 || r == 20 {
                line = line + "="
            } else if cc == 0 || cc == 50 {
                line = line + "|"
            } else if r == head_y && cc == head_x {
                line = line + "@"
            } else {
                found := 0
                i := 0
                for i < length {
                    if r == body_y[i] && cc == body_x[i] {
                        found = 1
                    }
                    i = i + 1
                }
                if found == 1 {
                    line = line + "o"
                } else if r == food_y && cc == food_x {
                    line = line + "*"
                } else {
                    line = line + " "
                }
            }
        }
        println(line)
    }
    println("")
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
    println("==================== SNAKE GAME ====================")
    println("Head: @  Body: o  Food: *  Max length: 20")
    println("Use WASD or Arrow Keys to move. Q to quit.")
    println("==================================================")
    println("")
    
    session, session_error := std.input.raw_mode(0)
    if session_error.code != 0 {
        println("Failed to enter raw mode")
        return 1
    }
    
    reader, reader_error := std.input.new_reader(0)
    if reader_error.code != 0 {
        std.input.restore(&session)
        println("Failed to create reader")
        return 1
    }
    
    direction = 3
    
    for i := 0; i < 10000; i = i + 1 {
        key, key_error := std.input.read_nonblocking(&reader)
        if key_error.code == 0 {
            if key.kind == "up" {
                if direction != 1 { direction = 0 }
            } else if key.kind == "down" {
                if direction != 0 { direction = 1 }
            } else if key.kind == "left" {
                if direction != 3 { direction = 2 }
            } else if key.kind == "right" {
                if direction != 2 { direction = 3 }
            } else if key.kind == "key" {
                if key.code == 113 || key.code == 81 {
                    break
                }
            } else if key.kind == "eof" {
                break
            }
        }
        
        if step() != 0 {
            break
        }
        
        error := std.time.sleep_ms(100)
        if error.code != 0 {
            break
        }
    }
    
    std.input.restore(&session)
    
    println("")
    println("================== GAME OVER ======================")
    println("==================================================")
    println("Score: ")
    println("")
    
    return score
}

func main() int {
    return run()
}
