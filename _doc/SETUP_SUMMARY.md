# 博客功能配置总结

**配置日期**：2026-07-01
**配置内容**：MathJax v3、Mermaid 流程图、代码复制按钮

---

## 📁 新增/修改的文件

### 1. 修改的文件

| 文件路径 | 修改内容 |
|---------|---------|
| `_includes/mathjax_support.html` | 升级到 MathJax v3，优化配置 |
| `_layouts/post.html` | 添加 Mermaid 支持和代码复制按钮引用 |

### 2. 新增的文件

| 文件路径 | 功能说明 |
|---------|---------|
| `_includes/mermaid_support.html` | Mermaid 流程图支持 |
| `js/code-copy.js` | 代码复制按钮功能 |
| `_posts/2026-07-01-feature-test.markdown` | 功能测试文章 |
| `_doc/feature-guide.md` | 详细使用指南 |
| `_doc/quick-reference.md` | 快速参考卡片 |

---

## 🎯 功能对比

### MathJax 版本对比

| 特性 | v2（旧版） | v3（新版） |
|------|-----------|-----------|
| 加载速度 | 较慢 | **快50%** |
| 配置方式 | `MathJax.Hub.Config` | `MathJax = {...}` |
| 输出格式 | SVG | **CHTML（更清晰）** |
| 公式编号 | 手动 | **自动（AMS风格）** |

### 新增功能

| 功能 | 状态 | 使用场景 |
|------|------|---------|
| **Mermaid 流程图** | ✅ 已启用 | 系统架构、算法流程、实验流程 |
| **代码复制按钮** | ✅ 自动启用 | 所有代码块 |

---

## 📊 使用统计

### 启用方式

```yaml
# 在文章 Front Matter 中添加
mathjax: true    # 启用数学公式
mermaid: true    # 启用流程图
# 代码复制按钮自动启用，无需配置
```

### 推荐配置组合

| 文章类型 | 推荐配置 |
|---------|---------|
| **医学/生物信息学** | `mathjax: true` + `mermaid: true` |
| **机器学习/AI** | `mathjax: true` + `mermaid: true` |
| **编程教程** | `mermaid: true`（代码复制自动） |
| **随笔/日记** | 无需配置 |

---

## 🚀 性能优化

### MathJax v3 优化点

1. **异步加载**：使用 `async` 属性，不阻塞页面渲染
2. **CDN 加速**：使用 jsdelivr CDN，国内访问更快
3. **按需渲染**：只渲染页面中的公式，不预加载

### Mermaid 优化点

1. **主题定制**：配色与博客主题一致
2. **延迟加载**：页面加载完成后初始化
3. **缓存机制**：SVG 缓存，减少重复渲染

### 代码复制优化点

1. **现代 API**：优先使用 Clipboard API
2. **降级方案**：兼容旧浏览器
3. **视觉反馈**：复制成功有动画提示

---

## 🔧 技术细节

### MathJax 配置参数

```javascript
MathJax = {
  tex: {
    inlineMath: [['$', '$'], ['\\(', '\\)']],  // 行内公式标识
    displayMath: [['$$', '$$'], ['\\[', '\\]']], // 块级公式标识
    processEscapes: true,  // 支持转义字符
    tags: 'ams'  // AMS风格公式编号
  },
  chtml: {
    scale: 1.1  // 公式缩放比例
  }
};
```

### Mermaid 配置参数

```javascript
mermaid.initialize({
  startOnLoad: true,  // 页面加载时自动渲染
  theme: 'default',   // 主题风格
  flowchart: {
    curve: 'basis',   // 连线曲线类型
    padding: 15       // 图表内边距
  }
});
```

---

## 📝 测试验证

### 测试文章

已创建测试文章：`_posts/2026-07-01-feature-test.markdown`

包含测试内容：
- ✅ 行内公式、块级公式、多行公式、矩阵
- ✅ 流程图、时序图、类图、甘特图
- ✅ Python、R、Bash 代码复制测试

### 本地预览

```bash
# 构建博客
jekyll build

# 启动本地服务器
jekyll serve --host 0.0.0.0 --port 4000

# 访问地址
http://localhost:4000
```

---

## 📚 学习资源

### 官方文档

- [MathJax v3 文档](https://docs.mathjax.org/en/latest/)
- [Mermaid 官方文档](https://mermaid-js.github.io/)
- [Jekyll 官方文档](https://jekyllrb.com/docs/)

### LaTeX 学习

- [LaTeX 数学符号大全](https://oeis.org/wiki/List_of_LaTeX_mathematical_symbols)
- [LaTeX 公式编辑器](https://www.latexlive.com/)
- [在线 LaTeX 编辑器](https://www.overleaf.com/)

### Mermaid 学习

- [Mermaid Live Editor](https://mermaid-js.github.io/mermaid-live-editor/)
- [Mermaid 语法参考](https://mermaid-js.github.io/mermaid/#/flowchart)

---

## 🎉 下一步建议

### 可选扩展功能

1. **Plotly 交互图表**：数据可视化
2. **Jupyter Notebook 集成**：自动转换 .ipynb
3. **代码行号显示**：增强代码可读性
4. **公式编号引用**：支持公式交叉引用

### 内容创作建议

1. **医学文章**：使用 MathJax 展示统计公式
2. **生物信息学**：使用 Mermaid 展示分析流程
3. **编程教程**：使用代码块 + 流程图
4. **学习笔记**：综合使用所有功能

---

**配置完成！开始创作精彩内容吧！** 🚀