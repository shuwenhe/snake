#include <iostream>
#include <ncurses.h>
#include <unistd.h>
#include <cstdlib>
#include <ctime>

using namespace std;

int main() {
    srand(time(0));
    initscr();
    cbreak();
    noecho();
    nodelay(stdscr, TRUE);
    keypad(stdscr, TRUE);
    
    int head_x = 20, head_y = 10;
    int food_x = 15, food_y = 10;
    int body_x[] = {19, 18, 17, 16, 15};
    int body_y[] = {10, 10, 10, 10, 10};
    int length = 5;
    int score = 0;
    int direction = 3;
    
    auto move_head = [&]() {
        if (direction == 0) head_y--;
        else if (direction == 1) head_y++;
        else if (direction == 2) head_x--;
        else if (direction == 3) head_x++;
        
        if (head_x <= 0) head_x = 49;
        if (head_x >= 50) head_x = 1;
        if (head_y <= 0) head_y = 19;
        if (head_y >= 20) head_y = 1;
    };
    
    auto move_body = [&]() {
        for (int i = 4; i > 0; i--) {
            body_x[i] = body_x[i-1];
            body_y[i] = body_y[i-1];
        }
        body_x[0] = head_x;
        body_y[0] = head_y;
    };
    
    auto render = [&]() {
        clear();
        for (int y = 0; y < 21; y++) {
            for (int x = 0; x < 51; x++) {
                if (y == 0 || y == 20) addch('=');
                else if (x == 0 || x == 50) addch('|');
                else if (y == head_y && x == head_x) addch('@');
                else if (y == food_y && x == food_x) addch('*');
                else {
                    bool is_body = false;
                    for (int i = 0; i < length && i < 5; i++) {
                        if (y == body_y[i] && x == body_x[i]) {
                            is_body = true;
                            break;
                        }
                    }
                    addch(is_body ? 'o' : ' ');
                }
            }
            addch('\n');
        }
        printw("Score: %d  Length: %d\n", score, length);
        refresh();
    };
    
    for (int step = 0; step < 1000; step++) {
        move_head();
        move_body();
        
        if (head_x == food_x && head_y == food_y) {
            length++;
            score++;
            food_x = 10 + rand() % 30;
            food_y = 3 + rand() % 14;
        }
        
        bool collision = false;
        for (int i = 1; i < length && i < 5; i++) {
            if (head_x == body_x[i] && head_y == body_y[i]) {
                collision = true;
                break;
            }
        }
        
        if (collision) break;
        
        render();
        usleep(100000);
    }
    
    endwin();
    cout << "Game Over! Final Score: " << score << endl;
    return score;
}
