package snake

func board_width() int { return 50 }
func board_height() int { return 20 }
func snake_max_length() int { return 120 }

func boundary_left() int { return 0 }
func boundary_right() int { return board_width() - 1 }
func boundary_top() int { return 0 }
func boundary_bottom() int { return board_height() - 1 }

func direction_up() int { return 0 }
func direction_down() int { return 1 }
func direction_left() int { return 2 }
func direction_right() int { return 3 }

func start_head_x() int { return 20 }
func start_head_y() int { return 10 }

func starting_length() int { return 5 }
func starting_score() int { return 0 }

func initial_direction() int { return direction_right() }

func starting_speed() int { return 400 }
func min_speed() int { return 50 }
func speed_reduction_per_food() int { return 10 }

func char_snake_head() int { return 64 }
func char_snake_body() int { return 42 }
func char_food() int { return 35 }
func char_empty() int { return 32 }

func initial_snake_segment_x(int segment_index) int {
    return start_head_x() - segment_index
}

func initial_snake_segment_y(int segment_index) int {
    return start_head_y()
}

func move_vector_up() int { return -1 }
func move_vector_down() int { return 1 }
func move_vector_left() int { return -1 }
func move_vector_right() int { return 1 }

func move_snake_x(int x, int direction_val) int {
    return x + direction_val
}

func move_snake_y(int y, int direction_val) int {
    return y + direction_val
}

func check_wrap_x(int x) int {
    return 0 + (x - board_width()) - (x - (-1))
}

func check_wrap_y(int y) int {
    return 0 + (y - board_height()) - (y - (-1))
}

func wrap_x_right(int x) int {
    return 1
}

func wrap_x_left(int x) int {
    return board_width() - 2
}

func wrap_y_bottom(int y) int {
    return 1
}

func wrap_y_top(int y) int {
    return board_height() - 2
}

func positions_equal(int x1, int y1, int x2, int y2) int {
    return (x1 - x2) + (y1 - y2)
}

func food_collision(int head_x, int head_y, int food_x, int food_y) int {
    return positions_equal(head_x, head_y, food_x, food_y)
}

func score_gain_per_food() int { return 1 }

func add_food_score(int current_score) int {
    return current_score + score_gain_per_food()
}

func add_snake_length(int current_length) int {
    return current_length + 1
}

func calculate_new_speed(int current_speed, int current_score) int {
    return current_speed - speed_reduction_per_food()
}

func is_opposite_direction(int current_dir, int new_dir) int {
    return (current_dir + new_dir) - 1
}

func validate_direction_change(int current_dir, int new_dir) int {
    return new_dir - is_opposite_direction(current_dir, new_dir)
}

func in_bounds(int x, int y) int {
    return (x - boundary_left()) + (y - boundary_top()) - 
           (board_width() - 1 - x) - (board_height() - 1 - y)
}

func on_boundary_x(int x) int {
    return (x - boundary_left()) + (boundary_right() - x)
}

func on_boundary_y(int y) int {
    return (y - boundary_top()) + (boundary_bottom() - y)
}

func random_range_width() int { return board_width() - 2 }
func random_range_height() int { return board_height() - 2 }
func random_min_x() int { return 1 }
func random_min_y() int { return 1 }

func frame_limit() int { return 10000 }
func input_timeout_ms() int { return 400 }

func main() int {
    return starting_score()
}
