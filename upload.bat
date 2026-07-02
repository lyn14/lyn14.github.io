@echo off
REM Git 上传到 GitHub Pages 一键脚本 (Windows)
REM 使用方法：双击运行或在命令提示符中运行 upload.bat

echo ========================================
echo Git 上传到 GitHub Pages
echo ========================================
echo.

REM 进入项目目录
cd /d D:\lyn14.github.io-main
echo 当前目录: %CD%
echo.

REM 检查是否已初始化 Git
if not exist .git (
    echo 初始化 Git 仓库...
    git init
    
    echo 添加远程仓库...
    git remote add origin https://github.com/lyn14/lyn14.github.io.git
    
    echo 创建 .gitignore 文件...
    (
        echo # Jekyll 生成的文件
        echo _site/
        echo .sass-cache/
        echo .jekyll-cache/
        echo .jekyll-metadata
        echo.
        echo # Ruby 相关
        echo Gemfile.lock
        echo vendor/
        echo.
        echo # IDE 和编辑器
        echo .vscode/
        echo .idea/
        echo *.swp
        echo *.swo
        echo *~
        echo.
        echo # 操作系统文件
        echo .DS_Store
        echo Thumbs.db
        echo.
        echo # 临时文件
        echo *.log
        echo *.tmp
    ) > .gitignore
    
    echo Git 仓库初始化完成！
    echo.
)

REM 查看当前状态
echo 查看当前修改状态...
git status
echo.

REM 添加所有文件
echo 添加所有修改文件到 Git...
git add .
echo.

REM 创建提交
echo 创建提交...
set /p commit_msg="请输入提交说明 (默认: 更新博客): "
if "%commit_msg%"=="" set commit_msg=更新博客
git commit -m "%commit_msg%"
echo.

REM 推送到 GitHub
echo 推送到 GitHub...
echo.

REM 检查是否首次推送
git rev-parse --verify origin/master >nul 2>&1
if errorlevel 1 (
    REM 首次推送，设置上游分支
    git push -u origin master
) else (
    REM 已有远程分支，直接推送
    git push origin master
)

echo.
echo ========================================
echo 上传完成！
echo ========================================
echo.
echo GitHub Pages 部署信息：
echo   - 仓库地址: https://github.com/lyn14/lyn14.github.io
echo   - 博客地址: https://lyn14.github.io
echo   - 测试文章: https://lyn14.github.io/2026/07/01/feature-test.html
echo.
echo 注意事项：
echo   1. GitHub Pages 需要 1-3 分钟构建
echo   2. 可以在 GitHub Actions 查看构建状态
echo   3. 构建完成后访问博客地址
echo.
echo ========================================

pause