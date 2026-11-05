CC = g++
SC = s
CFLAGS = -lncurses
TARGET = snake
TARGET_SIMPLE = snake_simple
TARGET_S = snake_s
SRC = snake.cpp
SRC_SIMPLE = snake_simple.cpp
SRC_S = snake.s

.PHONY: all clean run run-simple run-s run-ncurses

all: $(TARGET_S)
	./$(TARGET_S)

run: $(TARGET_S)
	./$(TARGET_S)

run-s: $(TARGET_S)
	./$(TARGET_S)

run-simple: $(TARGET_SIMPLE)
	./$(TARGET_SIMPLE)

run-ncurses: $(TARGET)
	./$(TARGET)

help:
	@echo "Snake Game - Makefile targets:"
	@echo "  make            - Compile and run S language version (default)"
	@echo "  make run        - Run S language version"
	@echo "  make run-s      - Run S language version"
	@echo "  make run-simple - Run simple C++ text version"
	@echo "  make run-ncurses- Run ncurses C++ version (requires terminal)"
	@echo "  make clean      - Remove compiled files"

$(TARGET): $(SRC)
	$(CC) -o $(TARGET) $(SRC) $(CFLAGS)

$(TARGET_SIMPLE): $(SRC_SIMPLE)
	$(CC) -o $(TARGET_SIMPLE) $(SRC_SIMPLE)

$(TARGET_S): $(SRC_S)
	$(SC) -o $(TARGET_S) $(SRC_S)

clean:
	rm -f $(TARGET) $(TARGET_SIMPLE) $(TARGET_S)
