# Snake.s Current State Audit

## 1. Busy-Wait Loop Issue ❌
- **Location**: Line 198-200 in snake.s
- **Problem**: 1-million-iteration loop provides unstable, CPU-wasteful delay
- **Impact**: Frame rate depends on CPU speed, not actual time
- **Fix Required**: Replace with proper `nanosleep()` call

## 2. Snake Body Limitation ❌
- **Current**: Only 5 hardcoded body segments (body_x_0..4, body_y_0..4)
- **Problem**: Snake cannot grow beyond 5 segments
- **Impact**: Game ends when snake tries to grow to 6 segments
- **Fix Required**: Dynamic array or circular buffer implementation

## 3. Collision Detection ⚠️
- **Location**: collision_self() function
- **Current Logic**: Only checks body_x_1/body_y_1 (one segment)
- **Problem**: Incomplete - doesn't check segments 2-4
- **Impact**: Snake can pass through its own body
- **Fix Required**: Check all body segments up to length

## 4. Food Generation ⚠️
- **Location**: eat() function
- **Current Logic**: Deterministic: food_x = 10 + (step_num % 30)
- **Problem**: Food placement is predictable and can overlap snake
- **Impact**: Unrealistic gameplay
- **Fix Required**: Random placement with collision rejection

## 5. Makefile Issues ⚠️
- **Undefined**: TARGET_S_DISPLAY variable
- **Issue**: `|| true` masks build/runtime errors
- **Impact**: Silent failures reported as success
- **Fix Required**: Separate build from run, remove error suppression

