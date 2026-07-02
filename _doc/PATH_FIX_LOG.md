# 路径修复日志

**修复日期**：2026-07-01
**问题描述**：CSS、JS、图片文件路径引用错误导致资源加载失败

---

## 🐛 发现的问题

### 错误信息
```
[2026-07-01 17:56:30] ERROR '/css/bootstrap.min.css' not found.
[2026-07-01 17:56:30] ERROR '/js/jquery.min.js' not found.
[2026-07-01 17:56:30] ERROR '/img/icon_wechat.png' not found.
```

### 问题原因

Jekyll 模板中使用了错误的路径引用语法：
```liquid
{{ "/css/bootstrap.min.css" | prepend: site.baseurl }}
```

这种语法在 Jekyll 4.0+ 中可能导致路径解析错误。

---

## ✅ 修复内容

### 1. head.html - CSS 文件路径

**修复前**：
```liquid
<link rel="stylesheet" href="{{ " /css/bootstrap.min.css" | prepend: site.baseurl }}">
<link rel="stylesheet" href="{{ " /css/hux-blog.min.css" | prepend: site.baseurl }}">
```

**修复后**：
```liquid
<link rel="stylesheet" href="{{ site.baseurl }}/css/bootstrap.min.css">
<link rel="stylesheet" href="{{ site.baseurl }}/css/hux-blog.min.css">
```

### 2. footer.html - JS 文件路径

**修复前**：
```liquid
<script src="{{ "/js/jquery.min.js " | prepend: site.baseurl }}"></script>
<script src="{{ "/js/bootstrap.min.js " | prepend: site.baseurl }}"></script>
<script src="{{ "/js/hux-blog.min.js " | prepend: site.baseurl }}"></script>
<script src="{{ "/js/simple-jekyll-search.min.js" | prepend: site.baseurl }}"></script>
<script src="{{ "/js/snackbar.js " | prepend: site.baseurl }}"></script>
<script src="{{ "/js/sw-registration.js " | prepend: site.baseurl }}"></script>
```

**修复后**：
```liquid
<script src="{{ site.baseurl }}/js/jquery.min.js"></script>
<script src="{{ site.baseurl }}/js/bootstrap.min.js"></script>
<script src="{{ site.baseurl }}/js/hux-blog.min.js"></script>
<script src="{{ site.baseurl }}/js/simple-jekyll-search.min.js"></script>
<script src="{{ site.baseurl }}/js/snackbar.js"></script>
<script src="{{ site.baseurl }}/js/sw-registration.js"></script>
```

### 3. default.html - 图片路径

**修复前**：
```liquid
<img src="/img/icon_wechat.png" width="0" height="0" />
```

**修复后**：
```liquid
<img src="{{ site.baseurl }}/img/icon_wechat.png" width="0" height="0" />
```

---

## 📝 修复的文件列表

| 文件路径 | 修复内容 | 状态 |
|---------|---------|------|
| `_includes/head.html` | CSS 文件路径引用 | ✅ 已修复 |
| `_includes/footer.html` | JS 文件路径引用 | ✅ 已修复 |
| `_layouts/default.html` | 图片文件路径引用 | ✅ 已修复 |

---

## 🔍 正确的路径引用语法

### Jekyll 4.0+ 推荐语法

```liquid
<!-- 推荐：直接拼接 -->
{{ site.baseurl }}/path/to/file

<!-- 不推荐：使用 prepend 过滤器 -->
{{ "/path/to/file" | prepend: site.baseurl }}
```

### 为什么推荐直接拼接？

1. **更简洁**：代码更易读
2. **更可靠**：避免空格和引号导致的解析错误
3. **更高效**：减少 Liquid 处理步骤

---

## 🧪 验证结果

### 构建测试
```bash
jekyll build
```
✅ 构建成功，无错误

### 服务器测试
```bash
jekyll serve --host 0.0.0.0 --port 4000
```
✅ 服务器启动成功

### 资源加载测试
- ✅ CSS 文件正常加载
- ✅ JS 文件正常加载
- ✅ 图片文件正常加载

---

## 💡 最佳实践

### 1. 资源路径引用

**静态资源（CSS、JS、图片）**：
```liquid
{{ site.baseurl }}/css/style.css
{{ site.baseurl }}/js/script.js
{{ site.baseurl }}/img/image.png
```

**页面链接**：
```liquid
{{ page.url | prepend: site.baseurl }}
{{ post.url | prepend: site.baseurl }}
```

### 2. 外部资源引用

**CDN 链接**：
```liquid
<!-- 使用协议相对 URL -->
<link href="//cdn.example.com/style.css" rel="stylesheet">

<!-- 或使用完整 URL -->
<link href="https://cdn.example.com/style.css" rel="stylesheet">
```

### 3. 配置检查

确保 `_config.yml` 中正确配置 `baseurl`：
```yaml
url: "https://lyn14.github.io"
baseurl: ""  # 如果博客在根路径，留空
# baseurl: "/blog"  # 如果博客在子路径，填写子路径
```

---

## 📚 相关文档

- [Jekyll 文档 - Links](https://jekyllrb.com/docs/links/)
- [Jekyll 文档 - Liquid Filters](https://jekyllrb.com/docs/liquid/filters/)
- [GitHub Pages - Troubleshooting](https://docs.github.com/en/pages/troubleshooting-jekyll-build-errors)

---

## 🎯 总结

**修复了 3 个文件中的路径引用问题**：
- ✅ CSS 文件路径（2处）
- ✅ JS 文件路径（6处）
- ✅ 图片文件路径（1处）

**所有资源现在都能正确加载！**

---

**修复完成时间**：2026-07-01 18:00