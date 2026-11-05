# Circular Buffer Design for Snake Body

## Problem
S doesn't support dynamic arrays at package scope. Current impl uses 5 hardcoded segments.
Need to support growth to ~20 segments.

## Solution: Fixed-Capacity Circular Buffer

Instead of:
```
body_x_0, body_x_1, ..., body_x_4
body_y_0, body_y_1, ..., body_y_4
```

Use:
```
max_length := 20
body_x [20] // array of 20 positions
body_y [20]
head_idx := 0  // points to where head was added
tail_idx := 19 // points to tail segment
```

## Circular Movement Example

```
Initial: head=@, segments=ooooo
Max capacity: 20

Step 1: Head moves right
  body_x[head_idx] = head_x
  body_y[head_idx] = head_y
  head_idx = (head_idx + 1) % 20
  // Tail stays same position, will be overwritten when snake grows

When eating:
  length++  // Now 6
  // Don't move tail_idx, leave one segment "behind"

When length == max_length and eating:
  // Circle fully: tail_idx = (tail_idx + 1) % 20
```

## Implementation Steps

1. Declare arrays (if S supports them):
   ```s
   body_x := [0, 0, 0, ...]  // size 20
   body_y := [0, 0, 0, ...]  // size 20
   ```

2. Refactor collision_self() to use array:
   ```s
   func collision_self() int {
       idx := 1
       for idx < length {
           check_idx := (head_idx - idx + 20) % 20
           if head_x == body_x[check_idx] && ... return 1
           idx++
       }
       return 0
   }
   ```

3. Refactor update_body():
   ```s
   func update_body() {
       body_x[head_idx] = head_x
       body_y[head_idx] = head_y
       head_idx = (head_idx + 1) % max_length
   }
   ```

4. Refactor render_board():
   ```s
   func render_board() {
       // ... for each r, cc check:
       idx := 0
       for idx < length {
           check_idx := (head_idx - length + idx + 20) % 20
           if r == body_y[check_idx] && cc == body_x[check_idx]
               line += "o"
       }
   }
   ```

## Issue: S Array Support at Package Scope

Test if S allows:
```s
body_x := [20]int  // or similar syntax
```

If not, create wrapper struct:
```s
struct body_buffer {
    int x[20]
    int y[20]
}
body := body_buffer{}
```

