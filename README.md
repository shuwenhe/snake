# S Language Snake Game 🐍

完全用 **S 语言** 实现的 Snake 游戏

## 🎮 快速开始

```bash
cd /root/shuwen/snake
make                # 编译并运行 S 语言版本
```

## 📁 项目结构

### 核心文件
- **snake.s** (207 行) - 完整的 S 语言实现 ⭐
- **makefile** - 构建配置

### 文档
- **SNAKE_S_IMPLEMENTATION.md** - 详细实现说明
- **S_LANGUAGE_ACHIEVEMENT.md** - 学习成果总结
- **README.md** - 本文件

### 其他版本（用于对比）
- **snake_display.cpp** - C++ ncurses 版本（`make run-display`）
- **snake.cpp** - 原始 C++ 版本（`make run-ncurses`）

## ✨ S 版本特性

| 特性 | 说明 |
|------|------|
| **语言** | 100% S 语言 |
| **行数** | 207 行 |
| **编译** | s -o snake snake.s |
| **大小** | 27 KB (静态链接) |
| **显示** | 纯文本终端 |
| **功能** | 完整游戏逻辑 |

## 🎯 功能演示

### 游戏元素
- `@` = 蛇头
- `o` = 蛇身
- `*` = 食物
- `|` = 左右边界
- `=` = 上下边界

### 游戏逻辑
- ✅ 蛇的移动（上下左右）
- ✅ 碰撞检测（食物、自身）
- ✅ 食物生成和吃食
- ✅ 实时棋盘渲染
- ✅ 游戏状态管理

## 📊 S 语言学到的特性

### ✅ 支持特性

```s
// 包级全局变量
head_x := 20

// 控制流
if condition { ... }
for i := 0; i < N; i = i + 1 { ... }
break

// 函数
func move_right() { ... }

// 字符串拼接
line = line + "@"

// I/O
println(string)
```

### ❌ 不支持特性

- ANSI Escape Code 解释
- 整数-字符串直接混用
- ncurses 库
- 字符操作函数

## 🚀 运行命令

```bash
# S 语言版本（纯文本，现在是默认）
make                  # 编译并运行
make run              # 仅运行已编译版本
make clean            # 清理

# C++ 版本（对比用）
make run-display      # ncurses 版本
make run-ncurses      # 原始 C++ 版本
make run-simple       # 简单文本版本

# 帮助
make help
```

## 💾 编译细节

### 编译器
- **版本**：dev-85dc9ba71
- **位置**：/root/.local/bin/s
- **命令**：`s -o snake snake.s`

### 编译流程
```
snake.s 
  ↓ (解析)
AST (抽象语法树)
  ↓ (语义分析)
MIR (中间表示)
  ↓ (优化)
SSA (静态单赋值)
  ↓ (代码生成)
AMD64 汇编
  ↓ (链接)
27 KB ELF 可执行文件
```

## 📈 项目统计

| 指标 | 值 |
|------|-----|
| 源文件行数 | 207 |
| 全局变量数 | 20 |
| 函数数量 | 10 |
| 编译大小 | 27 KB |
| 静态链接 | ✓ |
| 外部依赖 | 0 |

## 🎓 学习价值

这个项目展示了：

1. **S 语言的完整能力**
   - 支持复杂的应用逻辑
   - 完整的控制流
   - 有效的状态管理

2. **系统编程语言的设计**
   - 简洁的语法
   - 高效的编译
   - 强大的性能

3. **游戏开发基础**
   - 状态机设计
   - 碰撞检测算法
   - 实时渲染系统

4. **在限制下的创新**
   - 无 ncurses，用纯文本显示
   - 无格式化输出，用字符串拼接
   - 无库支持，用完整实现

## 🏆 关键成就

✅ 完全用 S 语言实现游戏  
✅ 实现了完整的游戏逻辑  
✅ 展示了多项 S 语言特性  
✅ 克服了多个技术限制  
✅ 创建了详尽的文档  

## 📚 进一步阅读

- **SNAKE_S_IMPLEMENTATION.md** - 深入技术细节
- **S_LANGUAGE_ACHIEVEMENT.md** - 完整学习总结
- **/root/shuwen/s** - S 语言源代码和标准库

## 🔍 代码示例

### 简单的移动函数
```s
func move_right() {
    head_x = head_x + 1
    if head_x >= 50 {
        head_x = 1
    }
}
```

### 碰撞检测
```s
func collision_food() int {
    if head_x == food_x && head_y == food_y {
        return 1
    }
    return 0
}
```

### 棋盘渲染
```s
func render_board() {
    for r := 0; r < 21; r = r + 1 {
        line := ""
        for cc := 0; cc < 51; cc = cc + 1 {
            if r == head_y && cc == head_x {
                line = line + "@"
            } else {
                line = line + " "
            }
        }
        println(line)
    }
}
```

## 🎯 项目目标

✅ **目标 1**：学习 S 语言  
✅ **目标 2**：完全用 S 实现 Snake  
✅ **目标 3**：实现游戏显示  
✅ **目标 4**：创建完整文档  

**所有目标已完成！** 🎉

## 📝 版本历史

- **v1.0** (2026-11-05)
  - 完整的 S 语言实现
  - 纯文本显示
  - 所有核心功能

## 👤 开发信息

- **语言**：S (dev-85dc9ba71)
- **完成日期**：2026-11-05
- **项目类型**：教学演示 + 系统编程学习
- **难度**：初中级

## 🤝 相关资源

- S 编译器：/root/.local/bin/s
- S 源代码：/root/shuwen/s/
- S 标准库：/root/shuwen/s/src/

---

**现在 snake 游戏是 100% 的 S 语言实现！** 🐍✨

用 `make` 命令试试吧！
