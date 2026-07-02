# 快速启动指南

## 🚀 启动博客的正确方法

### ⚠️ 重要提示

**必须在项目目录 `D:\lyn14.github.io-main` 中运行 Jekyll 命令！**

---

## 方法1：使用启动脚本（最简单）

### Windows 批处理脚本
```batch
双击运行：D:\lyn14.github.io-main\serve.bat
```

### PowerShell 脚本
```powershell
在 PowerShell 中运行：
cd D:\lyn14.github.io-main
.\serve.ps1
```

**脚本会自动完成**：
1. ✅ 切换到正确目录
2. ✅ 清理旧构建文件
3. ✅ 构建博客
4. ✅ 启动服务器

---

## 方法2：手动启动（推荐学习）

### PowerShell 步骤

```powershell
# 步骤1：切换到项目目录
cd D:\lyn14.github.io-main

# 步骤2：验证当前目录（应该显示 D:\lyn14.github.io-main）
pwd

# 步骤3：清理缓存（可选，遇到问题时使用）
Remove-Item -Recurse -Force _site, .jekyll-cache

# 步骤4：构建博客
D:\Ruby40-x64\bin\jekyll build

# 步骤5：启动服务器
D:\Ruby40-x64\bin\jekyll serve --host 127.0.0.1 --port 4000
```

### CMD 步骤

```cmd
# 步骤1：切换到项目目录
cd /d D:\lyn14.github.io-main

# 步骤2：验证当前目录
cd

# 步骤3：清理缓存（可选）
rmdir /s /q _site
rmdir /s /q .jekyll-cache

# 步骤4：构建博客
D:\Ruby40-x64\bin\jekyll build

# 步骤5：启动服务器
D:\Ruby40-x64\bin\jekyll serve --host 127.0.0.1 --port 4000
```

---

## ✅ 验证服务器启动成功

### 应该看到的信息

```
Configuration file: D:/lyn14.github.io-main/_config.yml
            Source: D:/lyn14.github.io-main
       Destination: D:/lyn14.github.io-main/_site
 Incremental write: disabled. Enable with --incremental
      Generating...
                    done in X seconds.
 Auto-regeneration: enabled for 'D:/lyn14.github.io-main'
    Server address: http://127.0.0.1:4000/
  Server running... press ctrl-c to stop.
```

### 访问博客

在浏览器中打开：
- **首页**：http://127.0.0.1:4000
- **测试文章**：http://127.0.0.1:4000/2026/07/01/feature-test.html

---

## ❌ 常见错误

### 错误1：在错误的目录运行

```powershell
# ❌ 错误示例
C:\Users\lyn20> D:\Ruby40-x64\bin\jekyll serve
# 结果：找不到任何文件，出现大量 ERROR
```

**解决方法**：
```powershell
# ✅ 正确做法
C:\Users\lyn20> cd D:\lyn14.github.io-main
D:\lyn14.github.io-main> D:\Ruby40-x64\bin\jekyll serve
```

### 错误2：端口被占用

```
Address already in use - bind(2) for "127.0.0.1" port 4000
```

**解决方法**：
```powershell
# 使用其他端口
D:\Ruby40-x64\bin\jekyll serve --host 127.0.0.1 --port 4001
```

### 错误3：WEBrick FrozenError

```
FrozenError: can't modify frozen String
```

**解决方法**：
```powershell
# 清理缓存并重新构建
Remove-Item -Recurse -Force _site, .jekyll-cache
D:\Ruby40-x64\bin\jekyll build
D:\Ruby40-x64\bin\jekyll serve --host 127.0.0.1 --port 4000
```

---

## 🔍 检查清单

启动前检查：

- ✅ 当前目录是 `D:\lyn14.github.io-main`
- ✅ `_config.yml` 文件存在
- ✅ `_posts/` 目录存在
- ✅ `_site/` 目录已生成
- ✅ 端口 4000 未被占用

---

## 💡 快速命令参考

### 常用命令

| 命令 | 说明 |
|------|------|
| `jekyll build` | 构建博客到 `_site` 目录 |
| `jekyll serve` | 构建并启动本地服务器 |
| `jekyll clean` | 清理构建文件和缓存 |
| `jekyll serve --port 4001` | 使用指定端口 |

### 常用参数

| 参数 | 说明 |
|------|------|
| `--host 127.0.0.1` | 使用本地地址（避免网络问题） |
| `--port 4000` | 指定端口 |
| `--verbose` | 显示详细日志 |
| `--incremental` | 增量构建（更快） |

---

## 📚 相关文档

- **故障排查**：`_doc/TROUBLESHOOTING.md`
- **功能指南**：`_doc/feature-guide.md`
- **快速参考**：`_doc/quick-reference.md`

---

## 🎯 一句话总结

**在 `D:\lyn14.github.io-main` 目录中运行 `jekyll serve`！**

---

**创建日期**：2026-07-01