# GitHub 认证快速参考

---

## 🚨 问题：Git push 提示输入密码

```
Password for 'https://lyn14@github.com': 
```

**重要**：GitHub 从 2021 年 8 月开始不再支持账户密码！

---

## ✅ 解决方案（3 种方式）

### 方案 1：Personal Access Token（最快）

#### 步骤 1：创建 Token

访问：https://github.com/settings/tokens

1. 点击 **Generate new token (classic)**
2. Note: `Jekyll Blog Upload Token`
3. Expiration: `No expiration`
4. 勾选权限: `repo`（完整仓库访问）
5. 点击 **Generate token**
6. **立即复制 Token**：`ghp_xxxxxxxxxxxx`

#### 步骤 2：使用 Token

**方法 A：推送时输入**
```bash
Username: lyn14
Password: ghp_xxxxxxxxxxxx  # 输入 Token，不是账户密码
```

**方法 B：保存到 URL（推荐）**
```bash
git remote set-url origin https://ghp_xxxxxxxxxxxx@github.com/lyn14/lyn14.github.io.git
git push -u origin master  # 不再需要输入密码
```

---

### 方案 2：SSH 密钥（最安全）

#### 步骤 1：生成密钥

```bash
ssh-keygen -t ed25519 -C "your-email@example.com"
# 按 Enter 使用默认路径
# 按 Enter 不设置密码
```

#### 步骤 2：查看公钥

```bash
cat ~/.ssh/id_ed25519.pub
# 复制输出的完整内容
```

#### 步骤 3：添加到 GitHub

访问：https://github.com/settings/ssh/new

1. Title: `lyn14-windows-laptop`
2. Key: 粘贴公钥内容
3. 点击 **Add SSH key**

#### 步骤 4：测试连接

```bash
ssh -T git@github.com
# 输入 yes 确认
# 看到 "Hi lyn14! You've successfully authenticated"
```

#### 步骤 5：更新 Git URL

```bash
git remote set-url origin git@github.com:lyn14/lyn14.github.io.git
git push -u origin master  # 不需要密码
```

---

### 方案 3：GitHub CLI（最简单）

#### 步骤 1：安装

```bash
winget install GitHub.cli
```

#### 步骤 2：登录

```bash
gh auth login
# 选择 GitHub.com
# 选择 HTTPS
# 选择 Login with a web browser
# 复制 one-time code
# 在浏览器中授权
```

#### 步骤 3：推送

```bash
git push -u origin master  # 自动认证
```

---

## 🎯 推荐选择

| 场景 | 推荐方案 | 原因 |
|------|---------|------|
| **新手** | Personal Access Token | 简单快速，5分钟搞定 |
| **长期使用** | SSH 密钥 | 安全可靠，永不过期 |
| **最简单** | GitHub CLI | 自动配置，无需手动操作 |

---

## 🔑 Token 权限说明

创建 Token 时必须勾选：

- ✅ **repo** - 完整仓库访问（包含所有子选项）
  - ✅ repo:status
  - ✅ repo_deployment
  - ✅ public_repo
  - ✅ repo:invite
  - ✅ security_events

可选权限：
- ✅ **workflow** - GitHub Actions
- ✅ **write:packages** - GitHub Packages

---

## ⚠️ 安全提示

### Token 安全
- ✅ 不要分享给他人
- ✅ 不要提交到 Git 仓库
- ✅ 妥善保存（只显示一次）
- ✅ 定期更新

### SSH 密钥安全
- ✅ 妥善保管私钥（~/.ssh/id_ed25519）
- ✅ 不要分享私钥
- ✅ 可以设置密码短语

---

## 📝 快速命令

### Token 方式（一键配置）

```bash
# 1. 在 GitHub 创建 Token
# 2. 运行以下命令
git remote set-url origin https://ghp_YOUR_TOKEN@github.com/lyn14/lyn14.github.io.git
git push -u origin master
```

### SSH 方式（一键配置）

```bash
# 1. 生成密钥
ssh-keygen -t ed25519 -C "your-email@example.com"

# 2. 查看公钥
cat ~/.ssh/id_ed25519.pub

# 3. 在 GitHub 添加公钥
# 4. 更新 URL
git remote set-url origin git@github.com:lyn14/lyn14.github.io.git

# 5. 推送
git push -u origin master
```

---

## 🔗 快速链接

- **创建 Token**：https://github.com/settings/tokens
- **添加 SSH**：https://github.com/settings/ssh/new
- **GitHub CLI**：https://cli.github.com/

---

## 💡 常见问题

### Q1：Token 输入后还是失败？

**检查**：
- Token 是否正确复制（完整）
- Token 权限是否勾选 `repo`
- Token 是否过期

**解决**：
```bash
# 重新生成 Token
# 更新 Git URL
git remote set-url origin https://ghp_NEW_TOKEN@github.com/lyn14/lyn14.github.io.git
```

### Q2：SSH 连接失败？

**检查**：
```bash
# 测试 SSH
ssh -T git@github.com

# 查看密钥
ssh-add -l

# 添加密钥
ssh-add ~/.ssh/id_ed25519
```

### Q3：推送时还是提示输入密码？

**检查远程 URL**：
```bash
git remote -v

# 如果是 HTTPS，需要 Token
origin  https://github.com/lyn14/lyn14.github.io.git

# 如果是 SSH，不需要密码
origin  git@github.com:lyn14/lyn14.github.io.git
```

---

**创建时间**：2026-07-02