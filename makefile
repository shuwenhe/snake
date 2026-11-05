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

.PHONY: all clean run run-simple run-s run-ncurses run-logic help

all: $(TARGET_S)
	@./$(TARGET_S) || true

run: $(TARGET_S)
	./$(TARGET_S)

run-logic: $(TARGET_S_LOGIC)
	@./$(TARGET_S_LOGIC) || true

run-simple: $(TARGET_SIMPLE)
	./$(TARGET_SIMPLE)

run-ncurses: $(TARGET_CPP)
	./$(TARGET_CPP)

help:
	@echo "Snake Game - Makefile targets:"
	@echo "  make               - Compile and run interactive ncurses version (default)"
	@echo "  make run           - Run interactive ncurses version"
	@echo "  make run-logic     - Run pure S language logic (headless, no display)"
	@echo "  make run-simple    - Run simple C++ text version"
	@echo "  make run-ncurses   - Run ncurses C++ version"
	@echo "  make clean         - Remove compiled files"

$(TARGET_CPP): $(SRC)
	$(CC) -o $(TARGET_CPP) $(SRC) $(CFLAGS)

$(TARGET_SIMPLE): $(SRC_SIMPLE)
	$(CC) -o $(TARGET_SIMPLE) $(SRC_SIMPLE)

$(TARGET_S): $(SRC_S_DISPLAY)
	$(CC) -o $(TARGET_S) $(SRC_S_DISPLAY) $(CFLAGS)

$(TARGET_S_LOGIC): $(SRC_S)
	$(SC) -o $(TARGET_S_LOGIC) $(SRC_S)

clean:
	rm -f $(TARGET_CPP) $(TARGET_SIMPLE) $(TARGET_S) $(TARGET_S_LOGIC)
