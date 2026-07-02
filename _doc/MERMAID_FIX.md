# Mermaid 渲染问题修复说明

**修复日期**：2026-07-02
**问题描述**：Mermaid流程图显示为原始代码，没有渲染成图表

---

## 🐛 问题原因

### 错误现象

在浏览器中看到的是：
```
graph TD
    A[开始] --> B[处理]
    B --> C[结束]
```

而不是渲染后的流程图。

### 根本原因

**Jekyll + Kramdown + Rouge 的处理流程**：

1. **Markdown源文件**：
   ````markdown
   ```mermaid
   graph TD
       A[开始] --> B[处理]
   ```
   ````

2. **Jekyll处理**：
   - Kramdown解析Markdown
   - Rouge语法高亮器处理代码块
   - 生成HTML：`<pre><code class="language-mermaid">...</code></pre>`

3. **Mermaid库期望**：
   - Mermaid默认只识别：`<div class="mermaid">...</div>`
   - 不识别：`<pre><code class="language-mermaid">...</code></pre>`

**冲突**：Jekyll生成的格式 ≠ Mermaid期望的格式

---

## ✅ 解决方案

### 修复方法

修改 `_includes/mermaid_support.html`，添加JavaScript代码：

1. **查找所有mermaid代码块**：
   ```javascript
   const mermaidCodeBlocks = document.querySelectorAll('code.language-mermaid');
   ```

2. **转换格式**：
   ```javascript
   // 从 <pre><code class="language-mermaid"> 
   // 转换为 <div class="mermaid">
   const mermaidDiv = document.createElement('div');
   mermaidDiv.className = 'mermaid';
   mermaidDiv.textContent = mermaidCode;
   ```

3. **渲染图表**：
   ```javascript
   mermaid.run();  // Mermaid v10的新API
   ```

---

## 🔧 修复后的代码

### mermaid_support.html

```html
<!-- Mermaid 流程图支持 -->
<script src="https://cdn.jsdelivr.net/npm/mermaid@10/dist/mermaid.min.js"></script>
<script>
  // 初始化 Mermaid
  mermaid.initialize({
    startOnLoad: false,  // 手动控制渲染
    theme: 'default',
    themeVariables: {
      primaryColor: '#4A90E2',
      primaryTextColor: '#fff',
      primaryBorderColor: '#357ABD',
      lineColor: '#67B',
      secondaryColor: '#F0F8FF',
      tertiaryColor: '#fff'
    },
    flowchart: {
      curve: 'basis',
      padding: 15
    },
    sequence: {
      diagramMarginX: 50,
      diagramMarginY: 10,
      actorMargin: 50,
      width: 150,
      height: 65
    }
  });

  // 处理 Jekyll/Rouge 生成的代码块
  document.addEventListener('DOMContentLoaded', function() {
    // 查找所有 mermaid 代码块
    const mermaidCodeBlocks = document.querySelectorAll('code.language-mermaid');
    
    mermaidCodeBlocks.forEach(function(codeBlock) {
      // 获取代码内容
      const mermaidCode = codeBlock.textContent;
      
      // 创建新的 div 元素
      const mermaidDiv = document.createElement('div');
      mermaidDiv.className = 'mermaid';
      mermaidDiv.textContent = mermaidCode;
      
      // 替换原来的 pre 元素
      const preElement = codeBlock.parentElement;
      preElement.parentElement.replaceChild(mermaidDiv, preElement);
    });
    
    // 渲染所有 mermaid 图表
    mermaid.run();
  });
</script>
```

---

## 📝 关键修改点

### 1. startOnLoad: false

**修改前**：
```javascript
startOnLoad: true  // 自动渲染，但只识别 <div class="mermaid">
```

**修改后**：
```javascript
startOnLoad: false  // 手动控制，先转换格式再渲染
```

### 2. 添加DOM处理

**新增代码**：
```javascript
// 等待DOM加载完成
document.addEventListener('DOMContentLoaded', function() {
  // 转换代码块格式
  // ...
  
  // 手动触发渲染
  mermaid.run();
});
```

### 3. 使用 mermaid.run()

**Mermaid v10新API**：
```javascript
mermaid.run();  // 替代旧版的自动渲染
```

---

## 🧪 验证步骤

### 1. 重新构建

```powershell
cd D:\lyn14.github.io-main
Remove-Item -Recurse -Force _site
D:\Ruby40-x64\bin\jekyll build
```

### 2. 启动服务器

```powershell
D:\Ruby40-x64\bin\jekyll serve --host 127.0.0.1 --port 4000
```

### 3. 访问测试文章

浏览器打开：http://127.0.0.1:4000/2026/07/01/feature-test.html

### 4. 检查渲染效果

应该看到：
- ✅ 流程图正常显示（不是代码）
- ✅ 时序图正常显示
- ✅ 类图正常显示
- ✅ 甘特图正常显示

---

## 🔍 技术细节

### Jekyll处理流程

```
Markdown文件 (.md)
    ↓
Kramdown解析器
    ↓
识别代码块 (```mermaid)
    ↓
Rouge语法高亮
    ↓
生成HTML: <pre><code class="language-mermaid">
    ↓
浏览器加载
    ↓
JavaScript转换
    ↓
<div class="mermaid">
    ↓
Mermaid渲染
    ↓
SVG图表
```

### 为什么不直接禁用Rouge？

**不能禁用的原因**：
1. Rouge为其他代码块（Python、R等）提供语法高亮
2. `_config.yml`中配置了`highlighter: rouge`
3. 禁用会影响所有代码块的显示效果

**解决方案**：
- ✅ 保持Rouge启用
- ✅ 用JavaScript转换Mermaid代码块格式
- ✅ 两全其美：语法高亮 + 流程图渲染

---

## 💡 其他解决方案对比

### 方案1：使用div标签（不推荐）

````markdown
<div class="mermaid">
graph TD
    A --> B
</div>
````

**缺点**：
- ❌ 不是标准Markdown语法
- ❌ 编辑器不支持预览
- ❌ 代码块没有语法高亮

### 方案2：禁用Rouge（不推荐）

```yaml
_config.yml:
kramdown:
  syntax_highlighter: none
```

**缺点**：
- ❌ 所有代码块都没有语法高亮
- ❌ 影响阅读体验

### 方案3：JavaScript转换（推荐）✅

**优点**：
- ✅ 保持标准Markdown语法
- ✅ 保持其他代码块的语法高亮
- ✅ Mermaid图表正常渲染
- ✅ 编辑器支持预览

---

## 📚 相关文档

- [Mermaid官方文档](https://mermaid-js.github.io/)
- [Mermaid v10 API](https://mermaid-js.github.io/mermaid/#/api)
- [Jekyll Kramdown配置](https://jekyllrb.com/docs/configuration/markdown/)
- [Rouge语法高亮器](https://github.com/rouge-ruby/rouge)

---

## 🎯 总结

**问题**：Jekyll生成的代码块格式与Mermaid期望格式不匹配
**解决**：用JavaScript转换格式，手动触发渲染
**结果**：Mermaid流程图正常显示

**修复文件**：`_includes/mermaid_support.html`
**关键代码**：DOM转换 + `mermaid.run()`

---

**修复完成时间**：2026-07-02