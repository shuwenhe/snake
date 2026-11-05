# S Snake Game - Implementation Roadmap

## Current Status Assessment

### Working ✅
- Compilation with S compiler
- Basic game loop structure
- Movement in 4 directions
- Food detection  
- Score tracking
- Text rendering (no scrolling)

### Broken/Incomplete ❌
1. **Timing** - Busy-wait loop (unstable, CPU-wasteful)
2. **Snake Growth** - Limited to 5 segments max
3. **Random Food** - Deterministic placement (step-based, not random)
4. **Makefile** - Undefined variables, error suppression
5. **Input** - No keyboard input (manual direction only)
6. **Terminal** - No ANSI control (scrolling only)

## Priority Implementation Order

### P0.1: Dynamic Snake Body [CRITICAL - blocks gameplay]
**Problem**: Only 5 hardcoded segments, cannot grow beyond
**Limitation**: S doesn't support dynamic arrays at package scope
**Workaround**: Use fixed-capacity circular buffer (10-20 segments max)
**Files to modify**: snake.s
**Tests**: Eat 10 food items, verify snake has 15 segments

### P0.2: Deterministic→Random Food [CRITICAL - correctness]
**Problem**: Food placement is predictable, can overlap snake
**Solution**: Pseudo-random generator based on step_num
**Files to modify**: eat() function in snake.s
**Tests**: Play 100 steps, verify no food overlaps snake body

### P0.3: Real Sleep Implementation [P0 - frame timing]
**Problem**: 1M-iteration busy-wait is CPU-wasteful, speed-dependent
**Current Blocker**: S import system complex, syscall.nanosleep is stub
**Options**:
   A. Improve syscall wrapping (requires S stdlib modification)
   B. Accept busy-wait with documentation (current)
   C. Use assembly syscall directly (advanced, not pure S)
**Decision**: Document current limitation, flag for future S stdlib enhancement

### P1: Keyboard Input [P1 - interactivity]
**Requirement**: Non-blocking arrow key reading
**Blocker**: S has no stdin/keyboard API yet
**Workaround**: Manual game state steering for now

### P1: ANSI Terminal Control [P1 - UX]
**Requirement**: Cursor positioning, screen clear, no scrolling
**Blocker**: S println() doesn't interpret ANSI codes
**Workaround**: Accept text-based rendering for now

### P2: Makefile Cleanup [P2 - build quality]
**Issues**: 
   - `TARGET_S_DISPLAY` undefined
   - `|| true` suppresses errors
   - Unclear build targets
**Fix**: 
   - Define all variables
   - Separate build from run
   - Remove error suppression

### P2: Automated Tests [P2 - reliability]
**Required**:
   - Initial state test
   - Movement test
   - Growth test
   - Collision test

## S Language Limitations Discovered

| Feature | Status | Impact |
|---------|--------|--------|
| Packages/Imports | ⚠️ Complex | Cannot import src.time cleanly |
| Dynamic Arrays | ❌ Not at package scope | Must use fixed-capacity or globals |
| Syscall Wrappers | ⚠️ Stubs | nanosleep/poll not implemented |
| I/O | Limited | Only println(string), no stdin |
| Type System | ⚠️ Quirky | Single-letter params fail (`c`, `ms`) |
| String Concat | ✅ Works | `+` operator functional |

## Recommended Next Action

**Implement P0.2 (Random Food)** as quick win:
- Improves gameplay correctness immediately
- No import/type issues
- Testable and verifiable
- Unblocks food-eating gameplay

Then **document P0.3 (Sleep)** as known limitation pending S stdlib enhancement.

