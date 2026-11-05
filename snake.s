package main

head_x := 20
head_y := 10
food_x := 15
food_y := 10

body_x_0 := 19
body_x_1 := 18
body_x_2 := 17
body_x_3 := 16
body_x_4 := 15

body_y_0 := 10
body_y_1 := 10
body_y_2 := 10
body_y_3 := 10
body_y_4 := 10

length := 5
score := 0
direction := 3
step_num := 0

func init_game() {
    head_x = 20
    head_y = 10
    food_x = 15
    food_y = 10
    body_x_0 = 19
    body_x_1 = 18
    body_x_2 = 17
    body_x_3 = 16
    body_x_4 = 15
    body_y_0 = 10
    body_y_1 = 10
    body_y_2 = 10
    body_y_3 = 10
    body_y_4 = 10
    length = 5
    score = 0
    direction = 3
    step_num = 0
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
    if length >= 5 {
        body_x_4 = body_x_3
        body_y_4 = body_y_3
        body_x_3 = body_x_2
        body_y_3 = body_y_2
        body_x_2 = body_x_1
        body_y_2 = body_y_1
        body_x_1 = body_x_0
        body_y_1 = body_y_0
    }
    body_x_0 = head_x
    body_y_0 = head_y
}

func collision_food() int {
    if head_x == food_x && head_y == food_y {
        return 1
    }
    return 0
}

func collision_self() int {
    if length >= 2 && head_x == body_x_1 && head_y == body_y_1 {
        return 1
    }
    if length >= 3 && head_x == body_x_2 && head_y == body_y_2 {
        return 1
    }
    if length >= 4 && head_x == body_x_3 && head_y == body_y_3 {
        return 1
    }
    if length >= 5 && head_x == body_x_4 && head_y == body_y_4 {
        return 1
    }
    return 0
}

func eat() {
    length = length + 1
    score = score + 1
    food_x = 10 + (step_num % 30)
    food_y = 3 + ((step_num / 30) % 14)
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
            } else if r == food_y && cc == food_x {
                line = line + "*"
            } else if length >= 1 && r == body_y_0 && cc == body_x_0 {
                line = line + "o"
            } else if length >= 2 && r == body_y_1 && cc == body_x_1 {
                line = line + "o"
            } else if length >= 3 && r == body_y_2 && cc == body_x_2 {
                line = line + "o"
            } else if length >= 4 && r == body_y_3 && cc == body_x_3 {
                line = line + "o"
            } else if length >= 5 && r == body_y_4 && cc == body_x_4 {
                line = line + "o"
            } else {
                line = line + " "
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
    
    if collision_self() != 0 {
        return 1
    }
    
    update_body()
    
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
    println("Head: @  Body: o  Food: *")
    println("==================================================")
    println("")
    
    direction = 3
    
    for i := 0; i < 10000; i = i + 1 {
        if step() != 0 {
            break
        }
    }
    
    println("")
    println("================== GAME OVER ======================")
    println("==================================================")
    
    return score
}

func main() int {
    return run()
}
