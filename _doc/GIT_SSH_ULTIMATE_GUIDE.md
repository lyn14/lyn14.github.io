# Git SSH 配置终极指南

**创建时间**：2026-07-02
**目的**：彻底解决 Git SSH 配置问题，确保永久有效

---

## 🎯 问题总结

### 遇到的问题

1. **网络连接失败**：HTTPS 443 端口被阻止
2. **SSH 主机密钥验证**：首次连接提示
3. **SSH 权限拒绝**：Permission denied (publickey)
4. **环境变量不生效**：配置后仍然失败

### 根本原因

- Git 默认使用 Git Bash SSH
- Git Bash SSH 配置有问题
- 需要强制 Git 使用 Windows OpenSSH

---

## ✅ 最终解决方案

### 方案 1：Git 配置（推荐，永久有效）

```powershell
# 配置 Git 使用 Windows OpenSSH（注意：使用正斜杠）
git config --global core.sshCommand "C:/Windows/System32/OpenSSH/ssh.exe"

# 验证配置
git config --global --get core.sshCommand

# 应该显示：
# C:/Windows/System32/OpenSSH/ssh.exe
```

**优点**：
- ✅ 永久有效
- ✅ 不依赖环境变量
- ✅ 所有 Git 操作都生效

---

### 方案 2：环境变量（备用）

```powershell
# 永久环境变量
[Environment]::SetEnvironmentVariable("GIT_SSH", "C:\Windows\System32\OpenSSH\ssh.exe", "User")

# 验证
[Environment]::GetEnvironmentVariable("GIT_SSH", "User")

# 应该显示：
# C:\Windows\System32\OpenSSH\ssh.exe
```

**注意**：
- ⚠️ 需要重启 PowerShell 才能生效
- ⚠️ 可能被 Git 配置覆盖

---

### 方案 3：临时环境变量（测试用）

```powershell
# 临时环境变量（仅当前会话有效）
$env:GIT_SSH = "C:\Windows\System32\OpenSSH\ssh.exe"

# 推送
git push origin main
```

**注意**：
- ⚠️ 仅当前 PowerShell 会话有效
- ⚠️ 关闭 PowerShell 后失效

---

## 🔧 推荐配置顺序

### 按优先级排序

```
┌─────────────────────────────────────────┐
│  Git 查找 SSH 客户端的优先级             │
└─────────────────────────────────────────┘

1. Git 配置 core.sshCommand（最高优先级）
   └─ git config --global core.sshCommand

2. 环境变量 GIT_SSH
   └─ $env:GIT_SSH 或用户环境变量

3. 默认 SSH（最低优先级）
   └─ Git Bash SSH（C:\Program Files\Git\usr\bin\ssh.exe）
```

### 推荐配置

**使用 Git 配置（方案 1）**，因为：
- 优先级最高
- 永久有效
- 不依赖环境变量

---

## 📝 完整配置流程

### 从零开始的完整配置

```powershell
# 步骤 1：检查 SSH 密钥
ls ~/.ssh

# 应该看到：
# id_rsa（私钥）
# id_rsa.pub（公钥）

# 步骤 2：测试 SSH 连接
ssh -T git@github.com

# 应该看到：
# Hi lyn14! You've successfully authenticated

# 步骤 3：配置 Git 使用 Windows OpenSSH
git config --global core.sshCommand "C:/Windows/System32/OpenSSH/ssh.exe"

# 步骤 4：验证配置
git config --global --get core.sshCommand

# 应该显示：
# C:/Windows/System32/OpenSSH/ssh.exe

# 步骤 5：切换到 SSH URL（如果还在使用 HTTPS）
git remote set-url origin git@github.com:lyn14/lyn14.github.io.git

# 步骤 6：推送测试
git push origin main

# 应该成功推送
```

---

## 🔍 验证配置

### 检查所有配置

```powershell
# 1. 检查 Git SSH 配置
git config --global --get core.sshCommand

# 2. 检查环境变量
[Environment]::GetEnvironmentVariable("GIT_SSH", "User")
$env:GIT_SSH

# 3. 检查远程 URL
git remote -v

# 4. 测试 SSH 连接
ssh -T git@github.com

# 5. 查看系统 SSH 位置
where.exe ssh
```

---

## 🚨 常见问题排查

### 问题 1：配置后仍然失败

**原因**：路径格式错误

**解决**：
```powershell
# ❌ 错误：反斜杠会被 Git Bash 解释
git config --global core.sshCommand "C:\Windows\System32\OpenSSH\ssh.exe"

# ✅ 正确：使用正斜杠
git config --global core.sshCommand "C:/Windows/System32/OpenSSH/ssh.exe"

# ✅ 正确：使用双反斜杠
git config --global core.sshCommand "C:\\Windows\\System32\\OpenSSH\\ssh.exe"
```

---

### 问题 2：环境变量不生效

**原因**：需要重启 PowerShell 或优先级问题

**解决**：
```powershell
# 方法 1：使用 Git 配置（推荐）
git config --global core.sshCommand "C:/Windows/System32/OpenSSH/ssh.exe"

# 方法 2：重启 PowerShell 后再试

# 方法 3：在当前会话设置临时变量
$env:GIT_SSH = "C:\Windows\System32\OpenSSH\ssh.exe"
```

---

### 问题 3：SSH 测试成功但 Git push 失败

**原因**：Git 使用的 SSH 客户端与系统 SSH 不同

**解决**：
```powershell
# 强制 Git 使用 Windows OpenSSH
git config --global core.sshCommand "C:/Windows/System32/OpenSSH/ssh.exe"

# 推送
git push origin main
```

---

### 问题 4：每次都需要设置环境变量

**原因**：临时环境变量只在当前会话有效

**解决**：
```powershell
# 使用 Git 配置（永久有效）
git config --global core.sshCommand "C:/Windows/System32/OpenSSH/ssh.exe"

# 或设置永久环境变量
[Environment]::SetEnvironmentVariable("GIT_SSH", "C:\Windows\System32\OpenSSH\ssh.exe", "User")
```

---

## 📊 配置对比

### 三种配置方式对比

| 配置方式 | 命令 | 持久性 | 优先级 | 推荐度 |
|---------|------|--------|--------|--------|
| **Git 配置** | `git config --global core.sshCommand` | ✅ 永久 | 🥇 最高 | ⭐⭐⭐⭐⭐ |
| **永久环境变量** | `[Environment]::SetEnvironmentVariable` | ✅ 永久 | 🥈 中等 | ⭐⭐⭐⭐ |
| **临时环境变量** | `$env:GIT_SSH` | ❌ 临时 | 🥈 中等 | ⭐⭐ |

---

## 🎯 最佳实践

### 推荐的完整配置

```powershell
# 1. 配置 Git 使用 Windows OpenSSH
git config --global core.sshCommand "C:/Windows/System32/OpenSSH/ssh.exe"

# 2. 配置 Git 用户信息
git config --global user.name "lyn14"
git config --global user.email "your_email@example.com"

# 3. 配置默认分支
git config --global init.defaultBranch main

# 4. 配置凭证缓存
git config --global credential.helper cache

# 5. 切换到 SSH URL
git remote set-url origin git@github.com:lyn14/lyn14.github.io.git

# 6. 验证所有配置
git config --global --list
```

---

## 🔄 完整推送流程

### 从修改到推送成功

```powershell
# 1. 进入项目目录
cd D:\lyn14.github.io-main

# 2. 检查状态
git status

# 3. 添加更改
git add .

# 4. 提交
git commit -m "更新博客内容"

# 5. 推送（使用配置好的 SSH）
git push origin main

# 应该成功推送
```

---

## 🔐 SSH 密钥管理

### 检查 SSH 密钥状态

```powershell
# 查看密钥文件
ls ~/.ssh

# 查看公钥内容
cat ~/.ssh/id_rsa.pub

# 测试 SSH 连接
ssh -T git@github.com

# 查看密钥指纹
ssh-keygen -lf ~/.ssh/id_rsa.pub
```

### 添加密钥到 GitHub

**如果密钥未添加到 GitHub**：

1. 查看公钥：
```powershell
cat ~/.ssh/id_rsa.pub
```

2. 访问 GitHub SSH 设置：
   https://github.com/settings/keys

3. 点击 "New SSH key"

4. 粘贴公钥内容

5. 点击 "Add SSH key"

---

## 📚 相关文档

- **SSH 认证过程详解**：`_doc/SSH_AUTHENTICATION_EXPLAINED.md`
- **SSH 密钥 vs 客户端**：`_doc/SSH_CLIENT_VS_KEY.md`
- **SSH 权限问题**：`_doc/GIT_SSH_PERMISSION_FIX.md`
- **SSH 主机密钥**：`_doc/SSH_HOST_KEY_GUIDE.md`
- **网络连接问题**：`_doc/GIT_NETWORK_FIX.md`

---

## ✅ 配置检查清单

### 完整检查清单

- [ ] SSH 密钥存在 (`ls ~/.ssh`)
- [ ] SSH 测试成功 (`ssh -T git@github.com`)
- [ ] Git SSH 配置正确 (`git config --global --get core.sshCommand`)
- [ ] 远程 URL 使用 SSH (`git remote -v`)
- [ ] 推送成功 (`git push origin main`)

---

## 🚀 快速修复命令

### 一键修复

```powershell
# 一键配置 Git SSH
git config --global core.sshCommand "C:/Windows/System32/OpenSSH/ssh.exe"

# 一键切换到 SSH URL
git remote set-url origin git@github.com:lyn14/lyn14.github.io.git

# 一键推送
git push origin main
```

---

## 📝 总结

### 核心要点

1. **使用 Git 配置**（最推荐）
   ```powershell
   git config --global core.sshCommand "C:/Windows/System32/OpenSSH/ssh.exe"
   ```

2. **路径格式很重要**
   - ✅ 使用正斜杠：`C:/Windows/System32/OpenSSH/ssh.exe`
   - ❌ 避免反斜杠：`C:\Windows\System32\OpenSSH\ssh.exe`

3. **优先级顺序**
   - Git 配置 > 环境变量 > 默认 SSH

4. **验证配置**
   ```powershell
   git config --global --get core.sshCommand
   ssh -T git@github.com
   git push origin main
   ```

---

**创建时间**：2026-07-02