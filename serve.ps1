# Jekyll 博客本地服务器启动脚本 (PowerShell)
# 使用方法：在PowerShell中运行 .\serve.ps1

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "启动 Jekyll 博客本地服务器" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# 切换到项目目录
Set-Location D:\lyn14.github.io-main
Write-Host "当前目录: $PWD" -ForegroundColor Green
Write-Host ""

# 清理缓存
Write-Host "清理旧的构建文件..." -ForegroundColor Yellow
if (Test-Path _site) { Remove-Item -Recurse -Force _site }
if (Test-Path .jekyll-cache) { Remove-Item -Recurse -Force .jekyll-cache }
Write-Host "清理完成！" -ForegroundColor Green
Write-Host ""

# 构建博客
Write-Host "构建博客..." -ForegroundColor Yellow
D:\Ruby40-x64\bin\jekyll build
if ($LASTEXITCODE -eq 0) {
    Write-Host "构建成功！" -ForegroundColor Green
} else {
    Write-Host "构建失败！请检查错误信息。" -ForegroundColor Red
    exit 1
}
Write-Host ""

# 启动服务器
Write-Host "启动本地服务器..." -ForegroundColor Yellow
Write-Host ""
Write-Host "访问地址:" -ForegroundColor Green
Write-Host "  - 首页: http://127.0.0.1:4000" -ForegroundColor White
Write-Host "  - 测试文章: http://127.0.0.1:4000/2026/07/01/feature-test.html" -ForegroundColor White
Write-Host ""
Write-Host "功能测试:" -ForegroundColor Green
Write-Host "  - MathJax数学公式: 应正常渲染" -ForegroundColor White
Write-Host "  - Mermaid流程图: 应显示为图表（不是代码）" -ForegroundColor White
Write-Host "  - 代码复制按钮: 点击应能复制代码" -ForegroundColor White
Write-Host ""
Write-Host "按 Ctrl+C 停止服务器" -ForegroundColor Red
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

D:\Ruby40-x64\bin\jekyll serve --host 127.0.0.1 --port 4000