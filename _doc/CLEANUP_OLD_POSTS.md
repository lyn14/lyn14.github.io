# 模板作者旧博客文章清理指南

**创建日期**：2026-07-02
**目的**：识别并删除模板作者 Hux 的旧博客文章

---

## 📋 需要删除的文件清单

### ✅ 你的博客文章（保留）

**根目录 `_posts/`**：
- ✅ `2026-07-01-feature-test.markdown` - 功能测试文章（保留）
- ✅ `2026-07-01-my-first-post.markdown` - 你的第一篇博客（保留）

---

### ❌ 模板作者的旧博客文章（删除）

#### 1. 根目录文章

**无** - 根目录的文章都是你的

---

#### 2. cs_idols 文件夹（计算机科学偶像系列）

**路径**：`_posts/cs_idols/`

**文件**：
- ❌ `2019-09-13-peter-john-landin.md` - Peter John Landin 传记

**说明**：
- 作者：Hux
- 主题：计算机科学偶像传记
- 发布状态：published: false（未发布）

---

#### 3. data_rep 文件夹（数据表示系列）

**路径**：`_posts/data_rep/`

**文件**：
- ❌ `2020-06-19-data-rep-int.md` - 数据表示：整数
- ❌ `2020-06-21-data-rep-float.md` - 数据表示：浮点数
- ❌ `2020-06-21-data-rep-todo.md` - 数据表示：待办事项

**说明**：
- 作者：Hux
- 主题：数据在计算机中的表示方式
- 发布状态：hidden: true（隐藏文章）

---

#### 4. hidden 文件夹（隐藏文章）

**路径**：`_posts/hidden/`

**文件**：
- ❌ `2020-05-05-pl-chart.md` - 编程语言图表

**说明**：
- 作者：Hux
- 主题：编程语言相关
- 发布状态：隐藏文章

---

#### 5. read_sf_lf 文件夹（软件基础-逻辑基础系列）

**路径**：`_posts/read_sf_lf/`

**文件**（共16篇）：
- ❌ `2019-01-01-sf-lf-01-basics.md` - 第1章：基础
- ❌ `2019-01-02-sf-lf-02-induction.md` - 第2章：归纳
- ❌ `2019-01-03-sf-lf-03-list.md` - 第3章：列表
- ❌ `2019-01-04-sf-lf-04-poly.md` - 第4章：多态
- ❌ `2019-01-05-sf-lf-05-tactics.md` - 第5章：策略
- ❌ `2019-01-06-sf-lf-06-logic.md` - 第6章：逻辑
- ❌ `2019-01-07-sf-lf-07-indprop.md` - 第7章：归纳属性
- ❌ `2019-01-08-sf-lf-08-map.md` - 第8章：映射
- ❌ `2019-01-09-sf-lf-09-proof-object.md` - 第9章：证明对象
- ❌ `2019-01-10-sf-lf-10-ind-principle.md` - 第10章：归纳原理
- ❌ `2019-01-11-sf-lf-11-rel.md` - 第11章：关系
- ❌ `2019-01-12-sf-lf-12-imp.md` - 第12章：Imp语言
- ❌ `2019-01-13-sf-lf-13-imp-parser.md` - 第13章：Imp解析器
- ❌ `2019-01-14-sf-lf-14-imp-ceval.md` - 第14章：Imp求值
- ❌ `2019-01-15-sf-lf-15-extraction.md` - 第15章：提取
- ❌ `2019-01-16-sf-lf-16-auto.md` - 第16章：自动化

**说明**：
- 作者：Hux
- 主题：Software Foundations - Logical Foundations 学习笔记
- 内容：Coq 函数式编程和逻辑基础
- 发布状态：hidden: true（隐藏文章）

---

#### 6. read_sf_plf 文件夹（软件基础-编程语言基础系列）

**路径**：`_posts/read_sf_plf/`

**文件**（共19篇）：
- ❌ `2019-03-01-sf-plf-01-equiv.md` - 第1章：等价
- ❌ `2019-03-02-sf-plf-02-hoare-1.md` - 第2章：Hoare逻辑1
- ❌ `2019-03-03-sf-plf-03-hoare-2.md` - 第3章：Hoare逻辑2
- ❌ `2019-03-04-sf-plf-04-hoare-logic.md` - 第4章：Hoare逻辑
- ❌ `2019-03-05-sf-plf-05-smallstep.md` - 第5章：小步语义
- ❌ `2019-03-06-sf-plf-06-types.md` - 第6章：类型
- ❌ `2019-03-07-sf-plf-07-STLC.md` - 第7章：STLC
- ❌ `2019-03-08-sf-plf-08-STLC-prop.md` - 第8章：STLC属性
- ❌ `2019-03-09-sf-plf-09-more-STLC.md` - 第9章：更多STLC
- ❌ `2019-03-10-sf-plf-10-subtyping.md` - 第10章：子类型
- ❌ `2019-03-11-sf-plf-11-typechecking.md` - 第11章：类型检查
- ❌ `2019-03-12-sf-plf-12-records.md` - 第12章：记录
- ❌ `2019-03-13-sf-plf-13-references.md` - 第13章：引用
- ❌ `2019-03-14-sf-plf-14-record-sub.md` - 第14章：记录子类型
- ❌ `2019-03-15-sf-plf-15-norm-STLC.md` - 第15章：STLC规范化
- ❌ `2019-03-16-sf-plf-16-lib-tactics.md` - 第16章：库策略
- ❌ `2019-03-17-sf-plf-17-use-tactics.md` - 第17章：使用策略
- ❌ `2019-03-18-sf-plf-18-use-auto.md` - 第18章：使用自动化
- ❌ `2019-03-19-sf-plf-19-partial-eval.md` - 第19章：部分求值

**说明**：
- 作者：Hux
- 主题：Software Foundations - Programming Language Foundations 学习笔记
- 内容：Coq 编程语言基础和类型系统
- 发布状态：hidden: true（隐藏文章）

---

#### 7. read_sf_qc 文件夹（软件基础-快速检查系列）

**路径**：`_posts/read_sf_qc/`

**文件**（共1篇）：
- ❌ `2019-09-02-sf-qc-02-typeclasses.md` - 第2章：类型类

**说明**：
- 作者：Hux
- 主题：Software Foundations - QuickChick 学习笔记
- 内容：Coq 测试和验证
- 发布状态：可能隐藏

---

## 📊 统计信息

### 文件数量统计

| 类别 | 文件数 | 操作 |
|------|--------|------|
| **你的文章** | 2 | ✅ 保留 |
| **cs_idols** | 1 | ❌ 删除 |
| **data_rep** | 3 | ❌ 删除 |
| **hidden** | 1 | ❌ 删除 |
| **read_sf_lf** | 16 | ❌ 删除 |
| **read_sf_plf** | 19 | ❌ 删除 |
| **read_sf_qc** | 1 | ❌ 删除 |
| **总计** | 43 | 删除41篇 |

### 文件夹统计

| 文件夹 | 文件数 | 操作 |
|--------|--------|------|
| `cs_idols/` | 1 | ❌ 删除整个文件夹 |
| `data_rep/` | 3 | ❌ 删除整个文件夹 |
| `hidden/` | 1 | ❌ 删除整个文件夹 |
| `read_sf_lf/` | 16 | ❌ 删除整个文件夹 |
| `read_sf_plf/` | 19 | ❌ 删除整个文件夹 |
| `read_sf_qc/` | 1 | ❌ 删除整个文件夹 |

---

## 🗑️ 删除方法

### 方法 1：手动删除（推荐）

**在 Windows 文件资源管理器中**：

1. 打开文件夹：`D:\lyn14.github.io-main\_posts`
2. 删除以下文件夹：
   - `cs_idols`
   - `data_rep`
   - `hidden`
   - `read_sf_lf`
   - `read_sf_plf`
   - `read_sf_qc`
3. 保留以下文件：
   - `2026-07-01-feature-test.markdown`
   - `2026-07-01-my-first-post.markdown`

---

### 方法 2：使用 Git Bash 删除

**在 Git Bash 中运行**：

```bash
cd /d/lyn14.github.io-main/_posts

# 删除所有模板作者的文件夹
rm -rf cs_idols
rm -rf data_rep
rm -rf hidden
rm -rf read_sf_lf
rm -rf read_sf_plf
rm -rf read_sf_qc

# 查看剩余文件
ls -la

# 应该只剩下你的两篇文章
```

---

### 方法 3：使用 PowerShell 删除

**在 PowerShell 中运行**：

```powershell
cd D:\lyn14.github.io-main\_posts

# 删除所有模板作者的文件夹
Remove-Item -Recurse -Force cs_idols
Remove-Item -Recurse -Force data_rep
Remove-Item -Recurse -Force hidden
Remove-Item -Recurse -Force read_sf_lf
Remove-Item -Recurse -Force read_sf_plf
Remove-Item -Recurse -Force read_sf_qc

# 查看剩余文件
Get-ChildItem
```

---

### 方法 4：使用命令一键删除

**在 Git Bash 中运行**：

```bash
cd /d/lyn14.github.io-main/_posts

# 一键删除所有模板作者的文件夹
rm -rf cs_idols data_rep hidden read_sf_lf read_sf_plf read_sf_qc

# 验证删除结果
echo "剩余文件："
ls -la
```

---

## ⚠️ 注意事项

### 1. 删除前确认

**请确认以下内容**：

- ✅ 你不需要这些文章的内容
- ✅ 这些文章都是模板作者 Hux 的
- ✅ 删除后不会影响你的博客功能

### 2. Git 提交

**删除后需要提交到 Git**：

```bash
cd /d/lyn14.github.io-main

# 查看删除状态
git status

# 添加删除操作到 Git
git add _posts/

# 创建提交
git commit -m "删除模板作者的旧博客文章"

# 推送到 GitHub
git push origin main
```

### 3. GitHub Pages 更新

**推送后**：
- GitHub Pages 会自动重新构建
- 博客首页不再显示这些旧文章
- 文章列表只显示你的两篇文章

---

## 📝 删除后的博客结构

### _posts 文件夹结构

```
_posts/
├── 2026-07-01-feature-test.markdown  ✅ 功能测试文章
├── 2026-07-01-my-first-post.markdown ✅ 第一篇博客
└── (其他文件夹已删除)
```

### 博客首页显示

删除后，博客首页只会显示：
- ✅ "博客功能测试" - 2026-07-01
- ✅ "我的第一篇博客" - 2026-07-01

---

## 🔍 验证删除结果

### 步骤 1：本地验证

```bash
cd /d/lyn14.github.io-main/_posts

# 查看剩余文件
ls -la

# 应该只看到：
# 2026-07-01-feature-test.markdown
# 2026-07-01-my-first-post.markdown
```

### 步骤 2：重新构建

```bash
cd /d/lyn14.github.io-main

# 清理旧构建
Remove-Item -Recurse -Force _site

# 重新构建
D:\Ruby40-x64\bin\jekyll build

# 启动服务器
D:\Ruby40-x64\bin\jekyll serve --host 127.0.0.1 --port 4000
```

### 步骤 3：浏览器验证

访问：http://127.0.0.1:4000

**检查内容**：
- ✅ 首页只显示你的两篇文章
- ✅ 没有 "计算机科学偶像" 相关文章
- ✅ 没有 "数据表示" 相关文章
- ✅ 没有 "软件基础" 相关文章

---

## 📚 文章内容说明

### 模板作者 Hux 的文章主题

**cs_idols 系列**：
- 计算机科学偶像传记
- 介绍计算机科学领域的杰出人物

**data_rep 系列**：
- 数据在计算机中的表示方式
- 整数、浮点数等数据类型的底层实现

**read_sf_lf 系列**：
- Software Foundations - Logical Foundations
- Coq 函数式编程和逻辑基础学习笔记

**read_sf_plf 系列**：
- Software Foundations - Programming Language Foundations
- Coq 编程语言基础和类型系统学习笔记

**read_sf_qc 系列**：
- Software Foundations - QuickChick
- Coq 测试和验证学习笔记

---

## ✅ 删除检查清单

- [ ] 确认不需要这些文章
- [ ] 删除 cs_idols 文件夹
- [ ] 删除 data_rep 文件夹
- [ ] 删除 hidden 文件夹
- [ ] 删除 read_sf_lf 文件夹
- [ ] 删除 read_sf_plf 文件夹
- [ ] 删除 read_sf_qc 文件夹
- [ ] 验证剩余文件正确
- [ ] 提交删除到 Git
- [ ] 推送到 GitHub
- [ ] 验证博客首页更新

---

## 🚀 快速删除命令

### 一键删除（Git Bash）

```bash
cd /d/lyn14.github.io-main/_posts
rm -rf cs_idols data_rep hidden read_sf_lf read_sf_plf read_sf_qc
ls -la
```

### 一键删除（PowerShell）

```powershell
cd D:\lyn14.github.io-main\_posts
Remove-Item -Recurse -Force cs_idols, data_rep, hidden, read_sf_lf, read_sf_plf, read_sf_qc
Get-ChildItem
```

---

**创建完成时间**：2026-07-02