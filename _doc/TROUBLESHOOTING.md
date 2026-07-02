# 故障排查指南

**问题日期**：2026-07-01
**问题描述**：Jekyll serve 命令在错误目录运行导致资源加载失败

---

## 🐛 问题根本原因

### 错误现象
```
[2026-07-01 18:02:07] ERROR '/css/bootstrap.min.css' not found.
[2026-07-01 18:02:07] ERROR '/js/jquery.min.js' not found.
[2026-07-01 18:02:07] ERROR '/img/icon_wechat.png' not found.
...
FrozenError: can't modify frozen String: ""
```

### 根本原因

**Jekyll serve 命令在错误的目录运行！**

从终端历史可以看到：
```powershell
Last Command: D:\Ruby40-x64\bin\jekyll serve --host 127.0.0.1 --port 4000
Cwd: C:\Users\lyn20  # ❌ 错误的目录！
Exit Code: 0
```

**正确的目录应该是**：
```powershell
Cwd: D:\lyn14.github.io-main  # ✅ 项目目录
```

---

## 🔍 为什么会出现这个问题？

### Jekyll serve 的工作原理

1. **查找配置文件**：Jekyll 需要在当前目录查找 `_config.yml`
2. **查找源文件**：Jekyll 需要在当前目录查找 `_posts/`, `_includes/`, `_layouts/` 等
3. **生成输出**：Jekyll 将生成的文件放在当前目录的 `_site/` 子目录
4. **启动服务器**：Jekyll 从 `_site/` 目录提供静态文件服务

### 在错误目录运行的后果

当在 `C:\Users\lyn20` 运行 Jekyll serve：
- ❌ 找不到 `_config.yml` → 使用默认配置
- ❌ 找不到 `_posts/`, `_includes/` → 没有内容
- ❌ `_site/` 目录不存在或为空 → 所有资源都找不到
- ❌ WEBrick 尝试列出空目录 → FrozenError

---

## ✅ 解决方案

### 方案1：使用启动脚本（推荐）

我已经为你创建了两个启动脚本：

#### Windows批处理脚本
```batch
双击运行：D:\lyn14.github.io-main\serve.bat
```

#### PowerShell脚本
```powershell
在PowerShell中运行：
cd D:\lyn14.github.io-main
.\serve.ps1
```

**脚本功能**：
1. ✅ 自动切换到项目目录
2. ✅ 清理旧的构建文件
3. ✅ 构建博客
4. ✅ 启动本地服务器

### 方案2：手动切换目录

#### PowerShell
```powershell
# 1. 切换到项目目录
cd D:\lyn14.github.io-main

# 2. 清理缓存（可选）
Remove-Item -Recurse -Force _site, .jekyll-cache

# 3. 构建博客
D:\Ruby40-x64\bin\jekyll build

# 4. 启动服务器
D:\Ruby40-x64\bin\jekyll serve --host 127.0.0.1 --port 4000
```

#### CMD
```batch
# 1. 切换到项目目录
cd /d D:\lyn14.github.io-main

# 2. 清理缓存（可选）
rmdir /s /q _site
rmdir /s /q .jekyll-cache

# 3. 构建博客
D:\Ruby40-x64\bin\jekyll build

# 4. 启动服务器
D:\Ruby40-x64\bin\jekyll serve --host 127.0.0.1 --port 4000
```

---

## 🧪 验证步骤

### 1. 检查当前目录
```powershell
pwd  # 或 Get-Location
```
应该显示：`D:\lyn14.github.io-main`

### 2. 检查文件是否存在
```powershell
ls _config.yml
ls _site/css/bootstrap.min.css
ls _site/js/jquery.min.js
```

### 3. 启动服务器
```powershell
D:\Ruby40-x64\bin\jekyll serve --host 127.0.0.1 --port 4000
```

应该看到：
```
Server address: http://127.0.0.1:4000
Server running... press ctrl-c to stop.
```

### 4. 访问博客
在浏览器中打开：http://127.0.0.1:4000

应该看到：
- ✅ 博客样式正常显示
- ✅ 导航栏正常工作
- ✅ 所有资源正常加载

---

## 📝 常见错误对比

### ❌ 错误示例
```powershell
# 在错误的目录运行
C:\Users\lyn20> D:\Ruby40-x64\bin\jekyll serve
# 结果：找不到任何文件
```

### ✅ 正确示例
```powershell
# 在项目目录运行
D:\lyn14.github.io-main> D:\Ruby40-x64\bin\jekyll serve
# 结果：成功启动服务器
```

---

## 🚨 其他可能的问题

### 1. WEBrick FrozenError

**错误信息**：
```
FrozenError: can't modify frozen String: ""
```

**原因**：Ruby 4.0 和 WEBrick 1.9.2 的兼容性问题

**解决方案**：
- ✅ 确保在正确的目录运行（主要解决方案）
- ✅ 清理 `_site` 和 `.jekyll-cache` 目录
- ✅ 使用 `--host 127.0.0.1` 而不是 `0.0.0.0`

### 2. 端口被占用

**错误信息**：
```
Address already in use - bind(2) for 127.0.0.1:4000
```

**解决方案**：
```powershell
# 使用不同的端口
D:\Ruby40-x64\bin\jekyll serve --host 127.0.0.1 --port 4001
```

### 3. 权限问题

**错误信息**：
```
Permission denied - bind(2) for 0.0.0.0:4000
```

**解决方案**：
```powershell
# 使用 127.0.0.1 而不是 0.0.0.0
D:\Ruby40-x64\bin\jekyll serve --host 127.0.0.1 --port 4000
```

---

## 💡 最佳实践

### 1. 始终在项目目录运行

```powershell
# 创建别名（可选）
Set-Alias -Name jekyll-serve -Value "cd D:\lyn14.github.io-main; D:\Ruby40-x64\bin\jekyll serve"
```

### 2. 使用启动脚本

- ✅ 双击 `serve.bat`（最简单）
- ✅ 运行 `.\serve.ps1`（PowerShell）
- ✅ 脚本自动处理所有步骤

### 3. 定期清理缓存

```powershell
# 构建前清理缓存
Remove-Item -Recurse -Force _site, .jekyll-cache
D:\Ruby40-x64\bin\jekyll build
```

---

## 📚 相关文档

- [Jekyll 文档 - Usage](https://jekyllrb.com/docs/usage/)
- [Jekyll 文档 - Configuration](https://jekyllrb.com/docs/configuration/)
- [WEBrick 文档](https://ruby-doc.org/stdlib-2.7.0/libdoc/webrick/rdoc/WEBrick.html)

---

## 🎯 总结

**问题**：Jekyll serve 在错误目录运行
**解决**：使用启动脚本或手动切换到项目目录
**验证**：检查 `pwd` 显示 `D:\lyn14.github.io-main`

**启动脚本已创建**：
- ✅ `serve.bat` - Windows批处理脚本
- ✅ `serve.ps1` - PowerShell脚本

**使用方法**：
```batch
双击运行：D:\lyn14.github.io-main\serve.bat
```

---

**文档创建时间**：2026-07-01 18:10