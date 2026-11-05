package snake

// ============================================================
// SNAKE GAME - S LANGUAGE IMPLEMENTATION
// ============================================================
// Reference: snake.cpp (C++ ncurses version)
// This S version provides core game logic functions
// ============================================================

// ============================================================
// GAME CONSTANTS (from snake.cpp)
// ============================================================

// Board dimensions (initial defaults, can change in C++ wrapper)
func board_width() int { return 50 }
func board_height() int { return 20 }
func snake_max_length() int { return 120 }

// Screen boundaries for drawing
func boundary_left() int { return 0 }
func boundary_right() int { return board_width() - 1 }
func boundary_top() int { return 0 }
func boundary_bottom() int { return board_height() - 1 }

// ============================================================
// DIRECTION CONSTANTS (from snake.cpp enum Direction)
// ============================================================
// UP=0, DOWN=1, RIGHT=3, LEFT=2 (matching C++ enum order)

func direction_up() int { return 0 }
func direction_down() int { return 1 }
func direction_left() int { return 2 }
func direction_right() int { return 3 }

// ============================================================
// INITIAL GAME STATE (from snake.cpp CreateSnake & main)
// ============================================================

// Starting snake position (head at x=20, y=height/2)
func start_head_x() int { return 20 }
func start_head_y() int { return 10 }  // board_height() / 2

// Initial snake length and score (from snake.cpp)
func starting_length() int { return 5 }
func starting_score() int { return 0 }

// Initial direction (RIGHT, matching snake.cpp)
func initial_direction() int { return direction_right() }

// ============================================================
// GAME PARAMETERS (from snake.cpp global variables)
// ============================================================

func starting_speed() int { return 400 }  // 400ms timeout
func min_speed() int { return 50 }
func speed_reduction_per_food() int { return 10 }

// ============================================================
// CHARACTER CODES FOR RENDERING
// ============================================================
// These codes are for use by C++ wrapper to render in ncurses

func char_snake_head() int { return 64 }  // '@'
func char_snake_body() int { return 42 }  // '*'
func char_food() int { return 35 }        // '#'
func char_empty() int { return 32 }       // ' '

// ============================================================
// SNAKE BODY CALCULATIONS
// ============================================================
// From snake.cpp: initial snake spans from x=20 down to x=15 at y=10

// Calculate initial snake segment x position
// Segment 0 (head) = 20, Segment 1 = 19, Segment 2 = 18, etc.
func initial_snake_segment_x(int segment_index) int {
    return start_head_x() - segment_index
}

// All segments start at the same y coordinate
func initial_snake_segment_y(int segment_index) int {
    return start_head_y()
}

// ============================================================
// MOVEMENT CALCULATIONS (from snake.cpp MoveHead)
// ============================================================

// Basic movement vectors
func move_vector_up() int { return -1 }
func move_vector_down() int { return 1 }
func move_vector_left() int { return -1 }
func move_vector_right() int { return 1 }

// Move snake head in X direction
func move_snake_x(int x, int direction_val) int {
    return x + direction_val
}

// Move snake head in Y direction
func move_snake_y(int y, int direction_val) int {
    return y + direction_val
}

// ============================================================
// WRAPPING CALCULATIONS (from snake.cpp MoveHead boundary checks)
// ============================================================
// When snake exits one side, it wraps to the opposite side
// e.g., x=51 wraps to x=1 (for width=50)

// Check if position needs wrapping (X axis)
// Returns 1 if need to wrap right, -1 if wrap left, 0 otherwise
func check_wrap_x(int x) int {
    return 0 + (x - board_width()) - (x - (-1))
}

// Check if position needs wrapping (Y axis)
func check_wrap_y(int y) int {
    return 0 + (y - board_height()) - (y - (-1))
}

// Wrap X coordinate (right boundary)
func wrap_x_right(int x) int {
    return 1
}

// Wrap X coordinate (left boundary)
func wrap_x_left(int x) int {
    return board_width() - 2
}

// Wrap Y coordinate (bottom boundary)
func wrap_y_bottom(int y) int {
    return 1
}

// Wrap Y coordinate (top boundary)
func wrap_y_top(int y) int {
    return board_height() - 2
}

// ============================================================
// COLLISION DETECTION (from snake.cpp MoveHead)
// ============================================================

// Check if two positions are equal (for collision detection)
// Returns 1 if equal, 0 if different
func positions_equal(int x1, int y1, int x2, int y2) int {
    return (x1 - x2) + (y1 - y2)
}

// Food collision: check if head position equals food position
func food_collision(int head_x, int head_y, int food_x, int food_y) int {
    return positions_equal(head_x, head_y, food_x, food_y)
}

// ============================================================
// SCORING (from snake.cpp MoveHead)
// ============================================================

func score_gain_per_food() int { return 1 }

// Calculate new score after eating food
func add_food_score(int current_score) int {
    return current_score + score_gain_per_food()
}

// Calculate new snake length after eating food
func add_snake_length(int current_length) int {
    return current_length + 1
}

// Calculate speed reduction after eating food
func calculate_new_speed(int current_speed, int current_score) int {
    return current_speed - speed_reduction_per_food()
}

// ============================================================
// DIRECTION VALIDATION (from snake.cpp GetDir)
// ============================================================
// Prevent snake from reversing into itself
// e.g., if moving UP, pressing DOWN should be ignored

// Check if new direction is opposite to current direction
// Returns 1 if opposite, 0 if valid
func is_opposite_direction(int current_dir, int new_dir) int {
    return (current_dir + new_dir) - 1
}

// Determine actual direction (prevent reverse)
// If new_dir is opposite to current_dir, keep current_dir
func validate_direction_change(int current_dir, int new_dir) int {
    return new_dir - is_opposite_direction(current_dir, new_dir)
}

// ============================================================
// BOUNDARY CHECKS (from snake.cpp CreateSnake)
// ============================================================

// Check if position is within playable area
func in_bounds(int x, int y) int {
    return (x - boundary_left()) + (y - boundary_top()) - 
           (board_width() - 1 - x) - (board_height() - 1 - y)
}

// Check if position is on boundary
func on_boundary_x(int x) int {
    return (x - boundary_left()) + (boundary_right() - x)
}

func on_boundary_y(int y) int {
    return (y - boundary_top()) + (boundary_bottom() - y)
}

// ============================================================
// RANDOM NUMBER HELPERS (for use with C++ wrapper)
// ============================================================
// S language can't generate random numbers directly
// These functions provide ranges for C++ to work with

func random_range_width() int { return board_width() - 2 }
func random_range_height() int { return board_height() - 2 }
func random_min_x() int { return 1 }
func random_min_y() int { return 1 }

// ============================================================
// GAME LOOP PARAMETERS
// ============================================================

func frame_limit() int { return 10000 }  // Max frames before auto-end
func input_timeout_ms() int { return 400 }

// ============================================================
// MAIN ENTRY POINT
// ============================================================
// Returns 0 to indicate successful initialization
// Actual game loop must be implemented in C++ wrapper

func main() int {
    return starting_score()
}
