S_ROOT ?= /root/shuwen/s
SOURCE ?= snake_from_example.s
TARGET ?= snake

.PHONY: all build run test integration help
all: build

# This project retains independent legacy main programs. Resolve imports for
# the selected executable only, using the actual native S compiler.
build:
	python3 $(S_ROOT)/misc/scripts/s-build.py $(S_ROOT) $(SOURCE) $(TARGET) --single-entry

run: build
	./$(TARGET)

test: build
	./$(TARGET) --self-test

integration: test
	S_SNAKE_SOURCE=$(abspath $(SOURCE)) python3 $(S_ROOT)/test/stdlib-native/test_snake.py -v

help:
	@echo 'make build       Build the native S game'
	@echo 'make run         Run in an ANSI terminal (at least 38x16)'
	@echo 'make test        Run deterministic headless game rules'
	@echo 'make integration Run native PTY input/rendering/restoration tests'
