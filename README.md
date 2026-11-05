# Native S Snake

The default game is `snake_native.s`, retained here as the independently maintained application integration for the S standard library. `snake.s` preserves the earlier global-state implementation. Both remain in this external project; the compiler repository contains the test harness and no game source.

```
make build
./snake
make test
make integration
```

Set `S_ROOT=/path/to/s` to select another compiler checkout. The build resolves actual imported sources and produces a native Linux/amd64 ELF using the S compiler. All game logic and rendering are S; there is no C++ or ncurses dependency. A terminal at least 38 columns by 16 rows is required for interactive play.

Arrows or WASD steer. Reverse turns are ignored; one direction change is applied per simulation tick. Q, Escape, Ctrl-C or EOF exits. Wall/body collision and filling the board end the game. Food is deterministic for reproducible tests and always chooses an unoccupied cell.

`std.time` supplies monotonic 100 ms simulation ticks and 10 ms kernel sleeps between input polls. `std.input` supplies raw, nonblocking keyboard events. `std.terminal` buffers changes to the head, tail, food and score; it clears the screen only at initialization. Explicit cleanup attempts both input and output restoration, and normal runtime return retries active sessions. Fatal signals and forced termination retain the runtime's documented limitations.

`make test` checks growth, reversal, wall/body collision, moving into a vacated tail, full-board completion and food placement without a terminal. `make integration` builds through the public import resolver and uses a real PTY to verify timed head movement, arrow direction changes, cursor/screen cleanup, exact termios restoration and low CPU consumption. The test harness is Python; application behavior is implemented by the compiled S source.

This is development integration coverage. It does not certify the compiler's final self-hosted stages or all standard-library packages as production-ready.
