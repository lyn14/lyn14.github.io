# Git SSH 权限拒绝问题解决方案

**错误信息**：
```
git@github.com: Permission denied (publickey).
fatal: Could not read from remote repository.
Please make sure you have the correct access rights and the repository exists.
```

**但是 SSH 测试成功**：
```
ssh -T git@github.com
Hi lyn14! You've successfully authenticated, but GitHub does not provide shell access.
```

---

## 🔍 问题诊断

### 现象分析

1. ✅ SSH 连接测试成功 (`ssh -T git@github.com`)
2. ❌ Git push 失败 (`Permission denied (publickey)`)
3. ✅ 远程 URL 配置正确 (`git@github.com:lyn14/lyn14.github.io.git`)

### 根本原因

**Git 使用的 SSH 客户端与系统 SSH 不同**

- 系统 SSH：`C:\Windows\System32\OpenSSH\ssh.exe` ✅ 正常工作
- Git SSH：可能使用 Git Bash 自带的 SSH ❌ 权限问题

---

## ✅ 解决方案

### 方案 1：使用环境变量（推荐）

**临时设置环境变量**：
```powershell
# 设置 Git 使用的 SSH 客户端
$env:GIT_SSH = "C:\Windows\System32\OpenSSH\ssh.exe"

# 推送
git push origin main
```

**永久设置环境变量**：
```powershell
# 添加到用户环境变量
[Environment]::SetEnvironmentVariable("GIT_SSH", "C:\Windows\System32\OpenSSH\ssh.exe", "User")

# 验证设置
[Environment]::GetEnvironmentVariable("GIT_SSH", "User")

# 推送
git push origin main
```

---

### 方案 2：配置 Git SSH 命令

**注意：Windows 路径格式问题**

```powershell
# ❌ 错误：反斜杠会被 Git Bash 解释为转义字符
git config --global core.sshCommand "C:\Windows\System32\OpenSSH\ssh.exe"

# ✅ 正确：使用正斜杠或双反斜杠
git config --global core.sshCommand "C:/Windows/System32/OpenSSH/ssh.exe"

# 或者使用双反斜杠
git config --global core.sshCommand "C:\\Windows\\System32\\OpenSSH\\ssh.exe"

# 推送
git push origin main
```

---

### 方案 3：使用 Git Bash 的 SSH（如果可用）

**检查 Git Bash SSH**：
```powershell
# 查找 Git Bash 的 SSH
where.exe ssh

# 如果找到多个 SSH，选择 Git Bash 的
# 通常在：C:\Program Files\Git\usr\bin\ssh.exe
```

**配置使用 Git Bash SSH**：
```powershell
# 使用 Git Bash 的 SSH
git config --global core.sshCommand "C:/Program Files/Git/usr/bin/ssh.exe"

# 推送
git push origin main
```

---

### 方案 4：启动 SSH Agent

**SSH Agent 可以管理多个密钥**：

```powershell
# 启动 SSH Agent 服务
Start-Service ssh-agent

# 设置为自动启动
Set-Service ssh-agent -StartupType Automatic

# 添加密钥到 SSH Agent
ssh-add ~/.ssh/id_rsa

# 推送
git push origin main
```

---

## 🔍 诊断命令

### 检查 SSH 配置

```powershell
# 1. 测试 SSH 连接
ssh -T git@github.com

# 2. 查看系统 SSH 位置
where.exe ssh

# 3. 查看 Git SSH 配置
git config --global --get core.sshCommand

# 4. 查看 SSH Agent 状态
Get-Service ssh-agent

# 5. 查看 SSH 密钥
ls ~/.ssh
```

---

## 📊 问题对比

### SSH 测试成功 vs Git Push 失败

| 命令 | 结果 | 原因 |
|------|------|------|
| `ssh -T git@github.com` | ✅ 成功 | 使用系统 SSH (`C:\Windows\System32\OpenSSH\ssh.exe`) |
| `git push origin main` | ❌ 失败 | Git 可能使用不同的 SSH 客户端 |

### 解决方法对比

| 方法 | 优点 | 缺点 |
|------|------|------|
| **环境变量** | 简单直接，立即生效 | 需要在每个 PowerShell 会话设置 |
| **Git 配置** | 永久生效 | 路径格式容易出错 |
| **SSH Agent** | 自动管理密钥 | 需要启动服务 |

---

## 🚀 快速解决方案

### 一键修复（推荐）

```powershell
# 方法 1：环境变量（最简单）
$env:GIT_SSH = "C:\Windows\System32\OpenSSH\ssh.exe"
git push origin main

# 方法 2：永久环境变量
[Environment]::SetEnvironmentVariable("GIT_SSH", "C:\Windows\System32\OpenSSH\ssh.exe", "User")
git push origin main

# 方法 3：Git 配置（注意路径格式）
git config --global core.sshCommand "C:/Windows/System32/OpenSSH/ssh.exe"
git push origin main
```

---

## 🔐 SSH 密钥管理

### 检查密钥状态

```powershell
# 查看密钥文件
ls ~/.ssh

# 查看公钥内容
cat ~/.ssh/id_rsa.pub

# 测试密钥
ssh -T git@github.com
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

## ⚠️ 常见错误

### 错误 1：路径格式错误

**错误**：
```powershell
git config --global core.sshCommand "C:\Windows\System32\OpenSSH\ssh.exe"
# 结果：C:WindowsSystem32OpenSSHssh.exe: command not found
```

**正确**：
```powershell
# 使用正斜杠
git config --global core.sshCommand "C:/Windows/System32/OpenSSH/ssh.exe"

# 或使用双反斜杠
git config --global core.sshCommand "C:\\Windows\\System32\\OpenSSH\\ssh.exe"
```

### 错误 2：SSH Agent 未运行

**错误**：
```
Could not open a connection to your authentication agent.
```

**解决**：
```powershell
# 启动 SSH Agent
Start-Service ssh-agent

# 添加密钥
ssh-add ~/.ssh/id_rsa
```

### 错误 3：密钥权限问题

**错误**：
```
Permissions 0644 for '~/.ssh/id_rsa' are too open.
```

**解决**：
```powershell
# 设置正确的权限
icacls ~/.ssh/id_rsa /inheritance:r
icacls ~/.ssh/id_rsa /grant:r "$env:USERNAME:F"
```

---

## 📝 完整推送流程

### 从诊断到推送成功

```powershell
# 1. 测试 SSH 连接
ssh -T git@github.com

# 2. 如果测试成功但推送失败，设置环境变量
$env:GIT_SSH = "C:\Windows\System32\OpenSSH\ssh.exe"

# 3. 进入项目目录
cd D:\lyn14.github.io-main

# 4. 检查状态
git status

# 5. 添加更改
git add .

# 6. 提交
git commit -m "更新博客内容"

# 7. 推送
git push origin main
```

---

## 🔄 永久解决方案

### 设置永久环境变量

**方法 1：PowerShell 命令**
```powershell
# 设置用户环境变量
[Environment]::SetEnvironmentVariable("GIT_SSH", "C:\Windows\System32\OpenSSH\ssh.exe", "User")

# 验证
[Environment]::GetEnvironmentVariable("GIT_SSH", "User")
```

**方法 2：Windows 设置**
1. 打开 "系统属性" → "高级" → "环境变量"
2. 在 "用户变量" 中点击 "新建"
3. 变量名：`GIT_SSH`
4. 变量值：`C:\Windows\System32\OpenSSH\ssh.exe`
5. 点击 "确定"

**方法 3：Git 配置**
```powershell
# 使用正斜杠路径
git config --global core.sshCommand "C:/Windows/System32/OpenSSH/ssh.exe"

# 验证
git config --global --get core.sshCommand
```

---

## 📊 验证成功

### 推送成功的标志

```
Enumerating objects: 5, done.
Counting objects: 100% (5/5), done.
Delta compression using up to 32 threads
Compressing objects: 100% (3/3), done.
Writing objects: 100% (3/3), 322 bytes | 322.00 KiB/s, done.
Total 3 (delta 2), reused 0 (delta 0), pack-reused 0 (from 0)
remote: Resolving deltas: 100% (2/2), completed with 2 local objects.
To github.com:lyn14/lyn14.github.io.git
   6b0e624..83a164b  main -> main
```

### 或者显示已更新

```
Everything up-to-date
```

---

## 🎯 最佳实践

### 推荐配置

```powershell
# 1. 设置永久环境变量
[Environment]::SetEnvironmentVariable("GIT_SSH", "C:\Windows\System32\OpenSSH\ssh.exe", "User")

# 2. 启动 SSH Agent（可选）
Start-Service ssh-agent
Set-Service ssh-agent -StartupType Automatic

# 3. 添加密钥到 SSH Agent（可选）
ssh-add ~/.ssh/id_rsa

# 4. 测试连接
ssh -T git@github.com

# 5. 推送
git push origin main
```

---

## 🔍 深入诊断

### 检查 Git 使用的 SSH

```powershell
# 查看 Git 配置
git config --list --global

# 查看 SSH 相关配置
git config --global --get-regexp ssh

# 查看 Git Bash 的 SSH
where.exe ssh

# 查看所有 SSH 可执行文件
Get-Command ssh -All | Select-Object Source, Name
```

---

## 📚 相关文档

- **SSH 主机密钥验证**：`_doc/SSH_HOST_KEY_GUIDE.md`
- **网络连接问题**：`_doc/GIT_NETWORK_FIX.md`
- **认证快速参考**：`_doc/AUTH_QUICK_REFERENCE.md`

---

## ✅ 问题解决检查清单

- [ ] SSH 测试成功 (`ssh -T git@github.com`)
- [ ] 设置环境变量 (`$env:GIT_SSH`)
- [ ] 或配置 Git SSH 命令 (`git config --global core.sshCommand`)
- [ ] 推送成功 (`git push origin main`)
- [ ] 验证 GitHub 仓库更新

---

**创建时间**：2026-07-02