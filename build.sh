#!/bin/bash
set -e

S_COMPILER="${S_COMPILER:-s}"
WORK_DIR=$(mktemp -d)
trap "rm -rf $WORK_DIR" EXIT

# Compile units
echo "Compiling S units..."
$S_COMPILER --compile-unit "$WORK_DIR/main.sasm" \
    /root/shuwen/s/src/std/time.s \
    snake.s

# Emit binary
echo "Emitting binary..."
$S_COMPILER --emit-bin "$WORK_DIR/main.sasm" snake

echo "✓ Build successful: ./snake"
