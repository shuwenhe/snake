# Snake Game - S Language Implementation

## 学习 S 语言的关键发现

### 1. 包级全局变量（Package-level Globals）

S 支持在函数外使用 `:=` 声明包级全局变量：

```s
package main

head_x := 20  // 全局变量
head_y := 10
score := 0

func init_game() {
    head_x = 20  // 可在函数中修改
}

func move_right() {
    head_x = head_x + 1  // 全局变量支持读写
}
```

**关键点**：
- 这是 `main` 包特有的特性
- 其他包中无法这样声明
- 全局变量作用域是包级，不是所有包共享

### 2. 控制流完整支持

S 完全支持标准的控制流：

```s
func move_head() {
    if direction == 0 {
        move_up()
    } else if direction == 1 {
        move_down()
    } else if direction == 2 {
        move_left()
    } else if direction == 3 {
        move_right()
    }
}

for i := 0; i < 100; i = i + 1 {
    result := step()
    if result != 0 {
        break
    }
}
```

**语法**：
- `if/else if/else` - 无需括号
- `for i := 初始; 条件; 增量` - 类似 C 风格
- `break` 跳出循环
- 操作符: `+`, `-`, `*`, `/`, `%`, `==`, `!=`, `<`, `>`, `<=`, `>=`, `&&`, `||`

### 3. 函数特性

```s
// 无参数函数
func move_up() {
    head_y = head_y - 1
    if head_y <= 0 {
        head_y = 19
    }
}

// 带参数和返回值
func collision_at(x int, y int) int {
    if x == head_x && y == head_y {
        return 1
    }
    return 0
}

// 多返回值
func parse_input() (int, string) {
    return direction, "ok"
}
```

**注意**：
- 参数语法：`name type` (e.g., `x int`)
- 返回类型放在参数列表后
- 支持多返回值用 `()` 包裹

### 4. 标准库能力

#### 4.1 I/O

```s
func println(string text) ()  // 字符串输出
func eprintln(string text) () // 错误流输出
```

#### 4.2 系统调用（底层）

```s
import "std.syscall"

extern "intrinsic" func __syscall0(int nr) int
extern "intrinsic" func __syscall1(int nr, int a1) int
extern "intrinsic" func __syscall2(int nr, int a1, int a2) int
extern "intrinsic" func __syscall3(int nr, int a1, int a2, int a3) int
extern "intrinsic" func __syscall4(int nr, int a1, int a2, int a3, int a4) int
extern "intrinsic" func __syscall6(int nr, int a1, int a2, int a3, int a4, int a5, int a6) int

// 文件操作
func exit(int code)
func write_to_fd(int fd, int buffer_ptr, int count) int
func read_from_fd(int fd, int buffer_ptr, int count) int
func open_file(string path, int flags, int mode) int
func close_fd(int fd) int

const stdin_fd = 0
const stdout_fd = 1
const stderr_fd = 2
```

#### 4.3 文件操作

```s
import "std.io_syscall"

struct file_handle {
    fd: int
    path: string
    mode: string
}

func file_open_read(string path) (file_handle, int)
func file_open_write(string path) (file_handle, int)
func file_write_string(string path, string content) int
func file_read_string(string path) (string, int)
func file_close(file_handle f) int
```

### 5. 类型系统

```s
// 基本类型
int, string, bool, byte

// 数组
int[] // 动态数组
[10]int // 固定大小数组

// 结构体
struct point {
    int x
    int y
}

// 接口（trait）
trait writer {
    func (w writer) write(string data) ((), error)
}
```

### 6. 编译和运行

```bash
# 编译 S 源代码
s -o output_name source.s

# 运行生成的二进制
./output_name

# 查看编译过程
s -o snake snake.s 2>&1  # 看编译日志
```

### 7. 当前 Snake 游戏的 S 实现

- **文件**: `snake.s` (170+ 行纯 S 代码)
- **特性**：
  - 完整的游戏逻辑
  - 包级全局变量管理状态
  - 所有方向控制
  - 碰撞检测
  - 食物进食和得分
  
- **限制**：
  - 仅文本输出（println 只支持 string）
  - 无法读取用户输入（交互式需要 ncurses）
  - 无实时棋盘渲染

### 8. S 语言的独特设计

1. **编译目标**：Linux/amd64 ELF（P0 目标）
2. **编译方式**：
   - 前端：词法分析、语法分析
   - 中端：MIR → SSA 优化
   - 后端：AMD64 代码生成
3. **不支持**（在当前设计中）：
   - 共享库编译（无 .so/.a 产物）
   - C FFI（难以从 C 调用 S 函数）
   - 动态链接库

### 9. 学习资源

```
/root/shuwen/s/doc/          # 官方文档
/root/shuwen/s/src/std/      # 标准库源代码
/root/shuwen/s/test/         # 测试程序和示例
/root/shuwen/s/src/io/       # I/O 包实现
/root/shuwen/s/src/std/syscall.s # 系统调用绑定
```

## 总结

S 是一个**系统编程语言**，设计用于：
- 编译到原生代码
- 提供底层系统访问
- 实现自举编译器

对于 Snake 游戏：
- ✅ snake.s：展示 S 的核心能力（逻辑、变量、控制流）
- ✅ snake_display.cpp：展示如何集成交互式界面
- 这个组合充分演示了 S 的设计目的和限制

