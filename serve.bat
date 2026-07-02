@echo off
REM Jekyll 博客本地服务器启动脚本
REM 使用方法：双击运行此文件

echo ========================================
echo 启动 Jekyll 博客本地服务器
echo ========================================
echo.

REM 切换到项目目录
cd /d D:\lyn14.github.io-main
echo 当前目录: %CD%
echo.

REM 清理缓存
echo 清理旧的构建文件...
if exist _site rmdir /s /q _site
if exist .jekyll-cache rmdir /s /q .jekyll-cache
echo 清理完成！
echo.

REM 构建博客
echo 构建博客...
D:\Ruby40-x64\bin\jekyll build
if errorlevel 1 (
    echo 构建失败！请检查错误信息。
    pause
    exit /b 1
)
echo 构建成功！
echo.

REM 启动服务器
echo 启动本地服务器...
echo.
echo 访问地址:
echo   - 首页: http://127.0.0.1:4000
echo   - 测试文章: http://127.0.0.1:4000/2026/07/01/feature-test.html
echo.
echo 功能测试:
echo   - MathJax数学公式: 应正常渲染
echo   - Mermaid流程图: 应显示为图表（不是代码）
echo   - 代码复制按钮: 点击应能复制代码
echo.
echo 按 Ctrl+C 停止服务器
echo ========================================
echo.

D:\Ruby40-x64\bin\jekyll serve --host 127.0.0.1 --port 4000

pause