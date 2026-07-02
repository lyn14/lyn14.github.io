# Git 上传到 GitHub Pages 完整指南

**创建日期**：2026-07-02
**目标**：将本地博客代码上传到 GitHub Pages

---

## 📋 前提条件

### 1. GitHub 账号准备

- ✅ 已有 GitHub 账号
- ✅ 已创建仓库：`lyn14.github.io`（用户名.github.io）
- ✅ 已配置 Git 用户信息

### 2. Git 配置检查

在 Git Bash 中运行：

```bash
# 检查 Git 版本
git --version

# 检查用户配置
git config --global user.name
git config --global user.email

# 如果未配置，设置用户信息
git config --global user.name "lyn14"
git config --global user.email "your-email@example.com"
```

---

## 🚀 上传步骤（完整流程）

### 步骤 1：初始化 Git 仓库

```bash
# 进入项目目录
cd /d/lyn14.github.io-main

# 初始化 Git 仓库
git init

# 添加远程仓库
git remote add origin https://github.com/lyn14/lyn14.github.io.git
```

### 步骤 2：检查要上传的文件

```bash
# 查看当前状态
git status

# 查看所有文件
ls -la
```

### 步骤 3：创建 .gitignore 文件

创建 `.gitignore` 文件，排除不需要上传的文件：

```bash
# 创建 .gitignore
cat > .gitignore << 'EOF'
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
EOF
```

### 步骤 4：添加所有文件到 Git

```bash
# 添加所有文件（排除 .gitignore 中的文件）
git add .

# 或者逐个添加重要文件
git add _config.yml
git add _posts/
git add _includes/
git add _layouts/
git add js/
git add css/
git add img/
git add _doc/

# 查看已添加的文件
git status
```

### 步骤 5：创建第一次提交

```bash
# 创建提交
git commit -m "Initial commit: 博客功能配置完成

- MathJax v3 数学公式支持
- Mermaid v10 流程图支持
- 代码复制按钮功能
- CSS/JS 路径修复
- 贝叶斯定理公式修复
- 启动脚本和文档完善"
```

### 步骤 6：推送到 GitHub

```bash
# 推送到 GitHub（首次推送）
git push -u origin master

# 或者如果默认分支是 main
git push -u origin main
```

---

## 🔄 后续更新流程

### 日常更新步骤

```bash
# 1. 进入项目目录
cd /d/lyn14.github.io-main

# 2. 查看修改的文件
git status

# 3. 添加修改的文件
git add .

# 4. 创建提交
git commit -m "更新说明"

# 5. 推送到 GitHub
git push
```

### 快速更新脚本

创建 `update.sh` 脚本：

```bash
#!/bin/bash
# 快速更新博客到 GitHub

echo "========================================"
echo "更新博客到 GitHub Pages"
echo "========================================"

# 进入项目目录
cd /d/lyn14.github.io-main

# 查看状态
echo "当前修改："
git status

# 添加所有修改
echo "添加修改文件..."
git add .

# 创建提交
echo "创建提交..."
read -p "请输入提交说明: " commit_msg
git commit -m "$commit_msg"

# 推送到 GitHub
echo "推送到 GitHub..."
git push

echo "========================================"
echo "更新完成！"
echo "访问: https://lyn14.github.io"
echo "========================================"
```

---

## 🌐 GitHub Pages 配置

### 1. 仓库设置

在 GitHub 仓库页面：

1. 进入 `Settings` → `Pages`
2. Source: 选择 `Deploy from a branch`
3. Branch: 选择 `master` 或 `main`（根据你的默认分支）
4. Folder: 选择 `/(root)`
5. 点击 `Save`

### 2. 等待部署

- GitHub Pages 会自动构建和部署
- 通常需要 1-3 分钟
- 可以在 `Actions` 标签查看构建状态

### 3. 访问博客

部署完成后访问：
- **博客地址**：https://lyn14.github.io
- **测试文章**：https://lyn14.github.io/2026/07/01/feature-test.html

---

## ⚠️ 注意事项

### 1. Jekyll 版本兼容性

GitHub Pages 支持的 Jekyll 版本：
- 当前支持：Jekyll 3.9.3
- 本地使用：Jekyll 4.0+

**可能的问题**：
- 某些 Jekyll 4.0 特性在 GitHub Pages 上不支持
- 需要检查 `_config.yml` 配置

### 2. 插件限制

GitHub Pages 只支持特定插件：
- 查看：https://pages.github.com/versions/

**解决方案**：
- 使用 GitHub Actions 自定义构建
- 或使用支持的插件版本

### 3. 文件大小限制

- 单文件不超过 100MB
- 仓库总大小不超过 1GB

---

## 🔧 GitHub Actions 自动构建（可选）

如果需要使用 Jekyll 4.0+ 特性，创建 `.github/workflows/jekyll.yml`：

```yaml
name: Jekyll Build and Deploy

on:
  push:
    branches: [ master ]

jobs:
  build:
    runs-on: ubuntu-latest
    
    steps:
    - uses: actions/checkout@v2
    
    - name: Setup Ruby
      uses: ruby/setup-ruby@v1
      with:
        ruby-version: '4.0'
    
    - name: Install dependencies
      run: |
        gem install bundler
        bundle install
    
    - name: Build Jekyll
      run: |
        bundle exec jekyll build
    
    - name: Deploy to GitHub Pages
      uses: peaceiris/actions-gh-pages@v3
      with:
        github_token: ${{ secrets.GITHUB_TOKEN }}
        publish_dir: ./_site
```

---

## 📝 常见问题解决

### 问题 1：推送失败

```bash
# 错误：fatal: 'origin' already exists
# 解决：更新远程仓库
git remote set-url origin https://github.com/lyn14/lyn14.github.io.git

# 错误：Permission denied
# 解决：使用 SSH 或配置 Personal Access Token
git remote set-url origin git@github.com:lyn14/lyn14.github.io.git
```

### 问题 2：GitHub Pages 构建失败

检查 `_config.yml`：
```yaml
# 确保 baseurl 正确
baseurl: ""  # 对于用户名.github.io 仓库
url: "https://lyn14.github.io"
```

### 问题 3：CSS/JS 路径错误

确保路径使用 `{{ site.baseurl }}`：
```html
<link rel="stylesheet" href="{{ site.baseurl }}/css/bootstrap.min.css">
```

---

## 🎯 快速上传命令（一键执行）

### 方案 1：首次上传

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

### 方案 2：使用 SSH（推荐）

```bash
cd /d/lyn14.github.io-main
git init
git remote add origin git@github.com:lyn14/lyn14.github.io.git
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

---

## 📚 相关文档

- [GitHub Pages 官方文档](https://docs.github.com/en/pages)
- [Jekyll 官方文档](https://jekyllrb.com/docs/)
- [Git 基础教程](https://git-scm.com/book/en/v2)

---

## ✅ 上传检查清单

- [ ] Git 已安装并配置用户信息
- [ ] GitHub 仓库已创建（lyn14.github.io）
- [ ] .gitignore 文件已创建
- [ ] 所有修改已添加到 Git
- [ ] 提交信息已创建
- [ ] 已推送到 GitHub
- [ ] GitHub Pages 设置已配置
- [ ] 博客可以正常访问

---

**创建完成时间**：2026-07-02