# GitHub Git 认证配置指南

**创建日期**：2026-07-02
**问题**：Git push 时提示输入密码，但账户密码无效

---

## 🚨 重要说明

**从 2021 年 8 月 13 日开始，GitHub 不再支持使用账户密码进行 Git 操作认证！**

现在必须使用以下方式之一：
1. ✅ **Personal Access Token (PAT)** - HTTPS 方式（推荐新手）
2. ✅ **SSH 密钥** - SSH 方式（推荐长期使用）
3. ✅ **GitHub CLI** - 命令行工具

---

## 🔑 方案 1：Personal Access Token (推荐新手)

### 步骤 1：创建 Personal Access Token

#### 1.1 登录 GitHub

访问：https://github.com

#### 1.2 进入 Settings

1. 点击右上角头像
2. 选择 **Settings**
3. 在左侧菜单最下方找到 **Developer settings**
4. 点击 **Personal access tokens**
5. 选择 **Tokens (classic)**（推荐）或 **Fine-grained tokens**

#### 1.3 创建新 Token

点击 **Generate new token (classic)**

#### 1.4 配置 Token

**Note（名称）**：
```
Jekyll Blog Upload Token
```

**Expiration（过期时间）**：
- 选择 **No expiration**（永不过期）- 推荐
- 或选择 **90 days**（90天）

**Select scopes（权限选择）**：
必须勾选以下权限：
- ✅ **repo** - 完整的仓库访问权限（包含所有子选项）
  - ✅ repo:status
  - ✅ repo_deployment
  - ✅ public_repo
  - ✅ repo:invite
  - ✅ security_events

可选权限：
- ✅ **workflow** - 更新 GitHub Actions 工作流
- ✅ **write:packages** - 上传包到 GitHub Packages
- ✅ **read:packages** - 从 GitHub Packages 下载包
- ✅ **delete:packages** - 删除包
- ✅ **admin:org** - 如果需要组织权限
- ✅ **gist** - 创建 Gist

#### 1.5 生成 Token

点击 **Generate token**

#### 1.6 复制 Token

**⚠️ 重要**：立即复制生成的 Token！

```
ghp_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
```

**注意**：
- Token 只显示一次，关闭页面后无法再次查看
- 如果忘记了，需要重新生成
- 妥善保存 Token，它相当于密码

---

### 步骤 2：使用 Token 进行 Git 认证

#### 2.1 方法 A：在推送时输入 Token（临时）

当 Git 提示输入密码时：
```bash
Username for 'https://github.com': lyn14
Password for 'https://lyn14@github.com': ghp_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
```

**输入内容**：
- Username：输入你的 GitHub 用户名 `lyn14`
- Password：输入刚才复制的 Personal Access Token（不是账户密码）

#### 2.2 方法 B：将 Token 嵌入 URL（永久保存）

**更新远程仓库 URL**：
```bash
# 格式：https://<TOKEN>@github.com/<username>/<repo>.git
git remote set-url origin https://ghp_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx@github.com/lyn14/lyn14.github.io.git

# 推送（不再需要输入密码）
git push -u origin master
```

**优点**：
- ✅ 不需要每次输入 Token
- ✅ 自动保存在 Git 配置中

**缺点**：
- ⚠️ Token 明文保存在 .git/config 文件中
- ⚠️ 需要妥善保管项目目录

#### 2.3 方法 C：使用 Git Credential Manager（推荐）

**安装 Git Credential Manager**：
- Windows：Git for Windows 已包含
- Mac：`brew install git-credential-manager`
- Linux：下载并安装

**配置 Git 使用 Credential Manager**：
```bash
# 配置 credential helper
git config --global credential.helper manager

# 推送时输入 Token（会自动保存）
git push -u origin master
# 输入 Username: lyn14
# 输入 Password: ghp_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

# 下次推送不再需要输入
git push
```

**优点**：
- ✅ Token 安全保存在系统凭证管理器中
- ✅ 不需要每次输入
- ✅ 跨平台支持

---

### 步骤 3：验证推送

```bash
# 推送到 GitHub
git push -u origin master

# 查看远程仓库
git remote -v
```

---

## 🔐 方案 2：SSH 密钥认证（推荐长期使用）

### 步骤 1：生成 SSH 密钥

#### 1.1 打开 Git Bash

在 Git Bash 中运行：

```bash
# 生成 SSH 密钥（推荐使用 Ed25519）
ssh-keygen -t ed25519 -C "your-email@example.com"

# 或使用 RSA（兼容性更好）
ssh-keygen -t rsa -b 4096 -C "your-email@example.com"
```

#### 1.2 配置密钥文件

**提示信息**：
```
Enter file in which to save the key (/c/Users/lyn20/.ssh/id_ed25519):
```

**操作**：
- 按 Enter 使用默认路径
- 或输入自定义路径：`/c/Users/lyn20/.ssh/github_key`

**提示信息**：
```
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
```

**操作**：
- 按 Enter 不设置密码（推荐）
- 或输入密码短语（更安全）

#### 1.3 查看生成的密钥

```bash
# 查看公钥
cat ~/.ssh/id_ed25519.pub

# 或
cat ~/.ssh/id_rsa.pub
```

**输出示例**：
```
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAI... your-email@example.com
```

---

### 步骤 2：添加 SSH 密钥到 GitHub

#### 2.1 复制公钥内容

```bash
# 复制公钥到剪贴板（Windows）
clip < ~/.ssh/id_ed25519.pub

# 或手动复制
cat ~/.ssh/id_ed25519.pub
# 复制输出的完整内容
```

#### 2.2 在 GitHub 添加 SSH 密钥

1. 登录 GitHub：https://github.com
2. 点击右上角头像 → **Settings**
3. 左侧菜单 → **SSH and GPG keys**
4. 点击 **New SSH key**
5. 填写信息：
   - **Title**：`lyn14-windows-laptop`
   - **Key type**：Authentication Key
   - **Key**：粘贴刚才复制的公钥内容
6. 点击 **Add SSH key**

#### 2.3 测试 SSH 连接

```bash
# 测试 SSH 连接
ssh -T git@github.com

# 首次连接会提示确认
The authenticity of host 'github.com' can't be established.
ED25519 key fingerprint is SHA256:...
Are you sure you want to continue connecting (yes/no/[fingerprint])?

# 输入 yes
yes

# 成功提示
Hi lyn14! You've successfully authenticated, but GitHub does not provide shell access.
```

---

### 步骤 3：更新 Git 远程仓库为 SSH

```bash
# 查看当前远程仓库
git remote -v

# 更新为 SSH URL
git remote set-url origin git@github.com:lyn14/lyn14.github.io.git

# 验证更新
git remote -v
# 输出：
# origin  git@github.com:lyn14/lyn14.github.io.git (fetch)
# origin  git@github.com:lyn14/lyn14.github.io.git (push)

# 推送（不再需要密码）
git push -u origin master
```

---

### 步骤 4：配置 SSH Agent（可选）

如果设置了密钥密码短语，需要使用 SSH Agent：

```bash
# 启动 SSH Agent
eval "$(ssh-agent -s)"

# 添加密钥到 Agent
ssh-add ~/.ssh/id_ed25519

# 如果使用自定义路径
ssh-add ~/.ssh/github_key

# 查看已添加的密钥
ssh-add -l
```

**Windows 自动启动 SSH Agent**：

创建 `~/.bashrc` 文件：
```bash
# 自动启动 SSH Agent
env=~/.ssh/agent.env

agent_load_env () { test -f "$env" && . "$env" >| /dev/null ; }

agent_start () {
    (umask 077; ssh-agent >| "$env")
    . "$env" >| /dev/null ; }

agent_load_env

# agent_run_state: 0=agent running w/ key; 1=agent w/o key; 2= agent not running
agent_run_state=$(ssh-add -l >| /dev/null 2>&1; echo $?)

if [ ! "$SSH_AUTH_SOCK" ] || [ $agent_run_state = 2 ]; then
    agent_start
    ssh-add
elif [ "$SSH_AUTH_SOCK" ] && [ $agent_run_state = 1 ]; then
    ssh-add
fi

unset env
```

---

## 🛠️ 方案 3：GitHub CLI（最简单）

### 步骤 1：安装 GitHub CLI

**Windows**：
```bash
# 使用 winget
winget install --id GitHub.cli

# 或下载安装包
# https://cli.github.com/
```

**Mac**：
```bash
brew install gh
```

**Linux**：
```bash
# Debian/Ubuntu
sudo apt install gh

# Fedora
sudo dnf install gh
```

### 步骤 2：登录 GitHub

```bash
# 登录 GitHub
gh auth login

# 选择选项
? What account do you want to log into? GitHub.com
? What is your preferred protocol for Git operations? HTTPS
? Authenticate Git with your GitHub credentials? Yes
? How would you like to authenticate GitHub CLI? Login with a web browser

# 复制 one-time code
! First copy your one-time code: xxxx-xxxx

# 按 Enter 打开浏览器
# 在浏览器中输入 code 并授权

# 成功提示
✓ Logged in as lyn14
```

### 步骤 3：推送

```bash
# 直接推送（自动认证）
git push -u origin master
```

---

## 📊 方案对比

| 方案 | 优点 | 缺点 | 推荐度 |
|------|------|------|--------|
| **Personal Access Token** | 简单易用，适合新手 | Token 需要妥善保管，可能过期 | ⭐⭐⭐⭐ |
| **SSH 密钥** | 安全可靠，无需密码，永不过期 | 需要配置密钥，稍复杂 | ⭐⭐⭐⭐⭐ |
| **GitHub CLI** | 最简单，自动配置 | 需要安装额外工具 | ⭐⭐⭐⭐⭐ |

---

## 🎯 推荐方案

### 新手推荐：Personal Access Token + Credential Manager

**步骤**：
1. 创建 Personal Access Token
2. 配置 Git Credential Manager
3. 推送时输入 Token（自动保存）
4. 后续推送无需输入

### 长期使用推荐：SSH 密钥

**步骤**：
1. 生成 SSH 密钥
2. 添加到 GitHub
3. 更新远程仓库为 SSH
4. 推送无需密码

---

## 🔧 常见问题解决

### 问题 1：Token 输入错误

```bash
# 错误：remote: Invalid username or password
# 解决：重新生成 Token 或检查 Token 是否正确

# 更新 Token
git remote set-url origin https://ghp_NEW_TOKEN@github.com/lyn14/lyn14.github.io.git
```

### 问题 2：Token 过期

```bash
# 错误：remote: Personal access token expired
# 解决：重新生成 Token

# 1. 在 GitHub 创建新 Token
# 2. 更新 Git URL
git remote set-url origin https://ghp_NEW_TOKEN@github.com/lyn14/lyn14.github.io.git
```

### 问题 3：SSH 连接失败

```bash
# 错误：Permission denied (publickey)
# 解决：检查 SSH 密钥是否正确添加

# 测试 SSH 连接
ssh -T git@github.com

# 查看已添加的密钥
ssh-add -l

# 重新添加密钥
ssh-add ~/.ssh/id_ed25519
```

### 问题 4：多个 GitHub 账号

**配置 SSH Config**：

创建 `~/.ssh/config` 文件：
```
# 个人账号
Host github.com
    HostName github.com
    User git
    IdentityFile ~/.ssh/id_ed25519

# 工作账号
Host github-work
    HostName github.com
    User git
    IdentityFile ~/.ssh/work_key
```

**使用不同账号**：
```bash
# 个人账号
git remote set-url origin git@github.com:lyn14/lyn14.github.io.git

# 工作账号
git remote set-url origin git@github-work:work-org/work-repo.git
```

---

## 📝 安全建议

### 1. Token 安全

- ✅ 不要分享 Token 给他人
- ✅ 不要提交 Token 到 Git 仓库
- ✅ 定期更新 Token
- ✅ 使用最小必要权限
- ✅ 设置合理的过期时间

### 2. SSH 密钥安全

- ✅ 妥善保管私钥（~/.ssh/id_ed25519）
- ✅ 不要分享私钥给他人
- ✅ 可以设置密钥密码短语
- ✅ 定期检查 GitHub SSH 密钥列表

### 3. Credential Manager 安全

- ✅ 使用系统凭证管理器
- ✅ 不要明文保存 Token
- ✅ 定期清理旧凭证

---

## 🚀 快速配置命令

### 方案 1：Token 方式（最快）

```bash
# 1. 在 GitHub 创建 Token
# 2. 更新 Git URL
git remote set-url origin https://ghp_YOUR_TOKEN@github.com/lyn14/lyn14.github.io.git

# 3. 推送
git push -u origin master
```

### 方案 2：SSH 方式（最安全）

```bash
# 1. 生成 SSH 密钥
ssh-keygen -t ed25519 -C "your-email@example.com"

# 2. 查看公钥
cat ~/.ssh/id_ed25519.pub

# 3. 在 GitHub 添加公钥
# 4. 测试连接
ssh -T git@github.com

# 5. 更新 Git URL
git remote set-url origin git@github.com:lyn14/lyn14.github.io.git

# 6. 推送
git push -u origin master
```

### 方案 3：GitHub CLI（最简单）

```bash
# 1. 安装 GitHub CLI
winget install GitHub.cli

# 2. 登录
gh auth login

# 3. 推送
git push -u origin master
```

---

## 📚 相关文档

- [GitHub Token 文档](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token)
- [GitHub SSH 文档](https://docs.github.com/en/authentication/connecting-to-github-with-ssh)
- [GitHub CLI 文档](https://cli.github.com/manual/)

---

**创建完成时间**：2026-07-02