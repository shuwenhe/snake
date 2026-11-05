#include <iostream>
#include <ncurses.h>
#include <unistd.h>
using namespace std;

extern "C" {
    void snake__init_game();
    void snake__move_head();
    void snake__move_body();
    int snake__collision_food();
    void snake__eat();
    int snake__collision_body();
    int snake__step();
    
    int snake__get_head_x();
    int snake__get_head_y();
    int snake__get_food_x();
    int snake__get_food_y();
    int snake__get_score();
    int snake__get_length();
    int snake__get_body_x(int i);
    int snake__get_body_y(int i);
}

void render_board() {
    clear();
    
    for (int y = 0; y < 21; y++) {
        for (int x = 0; x < 51; x++) {
            if (y == 0 || y == 20) {
                addch('=');
            } else if (x == 0 || x == 50) {
                addch('|');
            } else {
                int hx = snake__get_head_x();
                int hy = snake__get_head_y();
                int fx = snake__get_food_x();
                int fy = snake__get_food_y();
                int len = snake__get_length();
                
                if (y == hy && x == hx) {
                    addch('@');
                } else if (y == fy && x == fx) {
                    addch('*');
                } else {
                    bool is_body = false;
                    for (int i = 0; i < 5 && i < len; i++) {
                        if (y == snake__get_body_y(i) && x == snake__get_body_x(i)) {
                            is_body = true;
                            break;
                        }
                    }
                    addch(is_body ? 'o' : ' ');
                }
            }
        }
        addch('\n');
    }
    
    printw("Score: %d | Length: %d\n", snake__get_score(), snake__get_length());
    refresh();
}

int main() {
    initscr();
    cbreak();
    noecho();
    nodelay(stdscr, TRUE);
    keypad(stdscr, TRUE);
    
    snake__init_game();
    
    for (int i = 0; i < 1000; i++) {
        render_board();
        usleep(100000);
        
        if (snake__step() != 0) {
            break;
        }
    }
    
    endwin();
    cout << "Game Over! Final Score: " << snake__get_score() << endl;
    return snake__get_score();
}
