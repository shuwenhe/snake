CC = g++
SC = s
CFLAGS = -lncurses
TARGET_CPP = snake_ncurses
TARGET_SIMPLE = snake_simple
TARGET_S = snake
TARGET_S_LOGIC = snake_logic
SRC = snake.cpp
SRC_SIMPLE = snake_simple.cpp
SRC_S = snake.s
SRC_S_DISPLAY = snake_display.cpp

.PHONY: all clean run run-simple run-s run-ncurses run-logic run-display help

S_COMPILER = /root/shuwen/s/bin/s_compiler
S_WORK_DIR = /tmp/s-snake-build

all: $(TARGET_S)
	@./$(TARGET_S) || true

run: $(TARGET_S)
	./$(TARGET_S)

run-display: $(TARGET_S_DISPLAY)
	./$(TARGET_S_DISPLAY)

run-logic: $(TARGET_S_LOGIC)
	@./$(TARGET_S_LOGIC) || true

run-simple: $(TARGET_SIMPLE)
	./$(TARGET_SIMPLE)

run-ncurses: $(TARGET_CPP)
	./$(TARGET_CPP)

help:
	@echo "Snake Game - Makefile targets:"
	@echo "  make               - Compile and run S language version with display (default)"
	@echo "  make run           - Run S language version"
	@echo "  make run-display   - Run C++ ncurses display wrapper version"
	@echo "  make run-simple    - Run simple C++ text version"
	@echo "  make run-ncurses   - Run original ncurses C++ version"
	@echo "  make clean         - Remove compiled files"

$(TARGET_CPP): $(SRC)
	$(CC) -o $(TARGET_CPP) $(SRC) $(CFLAGS)

$(TARGET_SIMPLE): $(SRC_SIMPLE)
	$(CC) -o $(TARGET_SIMPLE) $(SRC_SIMPLE)

$(TARGET_S): $(SRC_S)
	@mkdir -p $(S_WORK_DIR)
	$(S_COMPILER) --compile-unit $(S_WORK_DIR)/main.sasm /root/shuwen/s/src/std/time.s $(SRC_S)
	$(S_COMPILER) --emit-bin $(S_WORK_DIR)/main.sasm $(TARGET_S)

$(TARGET_S_LOGIC): $(SRC_S)
	@mkdir -p $(S_WORK_DIR)
	$(S_COMPILER) --compile-unit $(S_WORK_DIR)/main-logic.sasm /root/shuwen/s/src/std/time.s $(SRC_S)
	$(S_COMPILER) --emit-bin $(S_WORK_DIR)/main-logic.sasm $(TARGET_S_LOGIC)

clean:
	rm -f $(TARGET_CPP) $(TARGET_SIMPLE) $(TARGET_S) $(TARGET_S_LOGIC)
