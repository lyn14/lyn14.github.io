# Git 上传快速参考卡片

---

## 🚀 快速上传命令（Git Bash）

### 首次上传（一键执行）

```bash
cd /d/lyn14.github.io-main
git init
git remote add origin https://github.com/lyn14/lyn14.github.io.git
cat > .gitignore << 'EOF'
_site/
.sass-cache/
.jekyll-cache/
.jekyll-metadata
Gemfile.lock
vendor/
.vscode/
.DS_Store
*.log
EOF
git add .
git commit -m "Initial commit: 博客功能配置完成"
git push -u origin master
```

### 日常更新（三步）

```bash
cd /d/lyn14.github.io-main
git add .
git commit -m "更新说明"
git push
```

---

## 📋 关键命令说明

### 1. 初始化相关

```bash
# 初始化 Git 仓库
git init

# 添加远程仓库（HTTPS）
git remote add origin https://github.com/lyn14/lyn14.github.io.git

# 添加远程仓库（SSH - 推荐）
git remote add origin git@github.com:lyn14/lyn14.github.io.git

# 查看远程仓库
git remote -v

# 更新远程仓库地址
git remote set-url origin https://github.com/lyn14/lyn14.github.io.git
```

### 2. 文件管理

```bash
# 查看当前状态
git status

# 添加所有文件
git add .

# 添加特定文件
git add _posts/2026-07-01-feature-test.markdown

# 添加特定目录
git add _includes/

# 删除文件（从 Git 中移除）
git rm filename

# 查看已添加的文件
git status
```

### 3. 提交相关

```bash
# 创建提交
git commit -m "提交说明"

# 创建详细提交
git commit -m "标题" -m "详细描述"

# 修改上次提交
git commit --amend -m "新的提交说明"

# 查看提交历史
git log

# 查看简洁历史
git log --oneline
```

### 4. 推送相关

```bash
# 首次推送（设置上游分支）
git push -u origin master

# 日常推送
git push

# 推送到特定分支
git push origin master

# 强制推送（谨慎使用）
git push -f
```

### 5. 分支管理

```bash
# 查看所有分支
git branch -a

# 创建新分支
git branch new-branch

# 切换分支
git checkout new-branch

# 创建并切换分支
git checkout -b new-branch

# 删除本地分支
git branch -d branch-name

# 删除远程分支
git push origin --delete branch-name
```

---

## 🔧 常见问题解决

### 问题 1：推送失败 - 认证错误

**HTTPS 方式**：
```bash
# 使用 Personal Access Token
git remote set-url origin https://<TOKEN>@github.com/lyn14/lyn14.github.io.git
```

**SSH 方式**：
```bash
# 配置 SSH 密钥
ssh-keygen -t rsa -b 4096 -C "your-email@example.com"

# 添加公钥到 GitHub
cat ~/.ssh/id_rsa.pub
# 复制内容到 GitHub Settings → SSH Keys

# 更新远程仓库为 SSH
git remote set-url origin git@github.com:lyn14/lyn14.github.io.git
```

### 问题 2：推送失败 - 远程仓库已存在

```bash
# 错误：fatal: 'origin' already exists
# 解决：更新远程仓库地址
git remote set-url origin https://github.com/lyn14/lyn14.github.io.git
```

### 问题 3：推送失败 - 本地落后于远程

```bash
# 错误：Updates were rejected
# 解决：先拉取远程更新
git pull origin master --allow-unrelated-histories
git push origin master
```

### 问题 4：GitHub Pages 构建失败

检查 `_config.yml`：
```yaml
baseurl: ""  # 对于用户名.github.io 仓库
url: "https://lyn14.github.io"
```

---

## 📝 .gitignore 标准配置

```bash
# Jekyll 生成的文件
_site/
.sass-cache/
.jekyll-cache/
.jekyll-metadata

# Ruby 相关
Gemfile.lock
vendor/

# IDE 和编辑器
.vscode/
.idea/
*.swp
*.swo
*~

# 操作系统文件
.DS_Store
Thumbs.db

# 临时文件
*.log
*.tmp
```

---

## 🎯 推送前检查清单

```bash
# 1. 查看修改状态
git status

# 2. 查看具体修改内容
git diff

# 3. 查看已添加的文件
git status

# 4. 查看提交历史
git log --oneline -5

# 5. 确认远程仓库
git remote -v

# 6. 推送
git push
```

---

## 🌐 GitHub Pages 配置

### 仓库设置

1. 进入 GitHub 仓库：`lyn14.github.io`
2. Settings → Pages
3. Source: `Deploy from a branch`
4. Branch: `master` 或 `main`
5. Folder: `/(root)`
6. Save

### 访问地址

- **博客首页**：https://lyn14.github.io
- **测试文章**：https://lyn14.github.io/2026/07/01/feature-test.html
- **仓库地址**：https://github.com/lyn14/lyn14.github.io

---

## 💡 最佳实践

### 1. 提交信息规范

```bash
# 好的提交信息
git commit -m "添加 Mermaid 流程图支持"
git commit -m "修复贝叶斯定理公式渲染问题"
git commit -m "更新博客配置文件"

# 不好的提交信息
git commit -m "update"
git commit -m "fix"
git commit -m "修改"
```

### 2. 定期推送

```bash
# 每次重要修改后推送
git add .
git commit -m "修改说明"
git push
```

### 3. 使用分支

```bash
# 创建功能分支
git checkout -b feature/new-feature

# 开发完成后合并
git checkout master
git merge feature/new-feature

# 推送
git push
```

---

## 📚 相关资源

- [Git 官方文档](https://git-scm.com/doc)
- [GitHub Pages 文档](https://docs.github.com/en/pages)
- [Pro Git 书籍](https://git-scm.com/book/en/v2)

---

**创建时间**：2026-07-02