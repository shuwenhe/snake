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

func move_head() {
    if direction == 0 {
        move_up()
    } else if direction == 1 {
        move_down()
    } else if direction == 2 {
        move_left()
    } else if direction == 3 {
        move_right()
    }
}

func collision_food() int {
    if head_x == food_x && head_y == food_y {
        return 1
    }
    return 0
}

func eat() {
    length = length + 1
    score = score + 1
}

func move_body() {
    body_x_4 = body_x_3
    body_y_4 = body_y_3
    body_x_3 = body_x_2
    body_y_3 = body_y_2
    body_x_2 = body_x_1
    body_y_2 = body_y_1
    body_x_1 = body_x_0
    body_y_1 = body_y_0
    body_x_0 = head_x
    body_y_0 = head_y
}

func collision_body() int {
    if (head_x == body_x_1 && head_y == body_y_1) ||
       (head_x == body_x_2 && head_y == body_y_2) ||
       (head_x == body_x_3 && head_y == body_y_3) ||
       (head_x == body_x_4 && head_y == body_y_4) {
        return 1
    }
    return 0
}

func step() int {
    move_head()
    move_body()
    
    if collision_food() == 1 {
        eat()
        food_x = 12
        food_y = 10
    }
    
    if collision_body() == 1 {
        return -1
    }
    
    return 0
}

func run() int {
    init_game()
    
    for i := 0; i < 10000; i = i + 1 {
        if step() != 0 {
            break
        }
    }
    
    return score
}

func main() int {
    return run()
}
