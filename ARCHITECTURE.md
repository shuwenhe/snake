# Snake Game Architecture

## Current Implementation

### snake.s (S Language - 200+ lines)
- **Purpose**: Pure game logic implementation in S language
- **Features**:
  - Package-level global variables for game state
  - Movement, collision detection, scoring logic
  - Getter functions to access game state
  - No I/O, no rendering
  - Compiles to `snake_logic` executable

### snake_display.cpp (C++ - 60+ lines)
- **Purpose**: Interactive game display with ncurses
- **Features**:
  - Full game logic implementation in C++
  - Real-time board rendering
  - User input handling (optional)
  - Compiles to `snake` executable

## Design Rationale

**Why two implementations?**

1. **snake.s**: Demonstrates S language capabilities
   - Shows how to use package-level global variables
   - Shows game logic in functional style
   - Educational purpose
   - Runs headless (no display)

2. **snake_display.cpp**: Provides interactive experience
   - Requires ncurses for terminal rendering
   - Needs fast iteration and user input handling
   - C++ provides better control for graphics
   - Separate concern: logic vs. presentation

## Build Targets

```bash
make                  # Builds snake_display.cpp → snake (interactive)
make run-logic        # Builds snake.s → snake_logic (headless)
```

## Future: Unified Architecture

To truly use snake.s in the display, would require:
1. Compile snake.s to a shared library (requires S compiler changes)
2. Create C bindings for game functions
3. Have snake_display.cpp call S functions via FFI

Currently, both are independent implementations of the same game.
