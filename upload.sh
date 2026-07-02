#!/bin/bash
# Git 上传到 GitHub Pages 一键脚本
# 使用方法：在 Git Bash 中运行 ./upload.sh

echo "========================================"
echo "Git 上传到 GitHub Pages"
echo "========================================"
echo ""

# 进入项目目录
cd /d/lyn14.github.io-main
echo "当前目录: $(pwd)"
echo ""

# 检查是否已初始化 Git
if [ ! -d ".git" ]; then
    echo "初始化 Git 仓库..."
    git init
    
    # 添加远程仓库（使用 HTTPS）
    echo "添加远程仓库..."
    git remote add origin https://github.com/lyn14/lyn14.github.io.git
    
    # 创建 .gitignore
    echo "创建 .gitignore 文件..."
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
    
    echo "Git 仓库初始化完成！"
    echo ""
fi

# 查看当前状态
echo "查看当前修改状态..."
git status
echo ""

# 添加所有文件
echo "添加所有修改文件到 Git..."
git add .
echo ""

# 创建提交
echo "创建提交..."
read -p "请输入提交说明 (默认: '更新博客'): " commit_msg
commit_msg=${commit_msg:-"更新博客"}
git commit -m "$commit_msg"
echo ""

# 推送到 GitHub
echo "推送到 GitHub..."
echo ""

# 检查是否首次推送
if git rev-parse --verify origin/master >/dev/null 2>&1; then
    # 已有远程分支，直接推送
    git push origin master
else
    # 首次推送，设置上游分支
    git push -u origin master
fi

echo ""
echo "========================================"
echo "上传完成！"
echo "========================================"
echo ""
echo "GitHub Pages 部署信息："
echo "  - 仓库地址: https://github.com/lyn14/lyn14.github.io"
echo "  - 博客地址: https://lyn14.github.io"
echo "  - 测试文章: https://lyn14.github.io/2026/07/01/feature-test.html"
echo ""
echo "注意事项："
echo "  1. GitHub Pages 需要 1-3 分钟构建"
echo "  2. 可以在 GitHub Actions 查看构建状态"
echo "  3. 构建完成后访问博客地址"
echo ""
echo "========================================"