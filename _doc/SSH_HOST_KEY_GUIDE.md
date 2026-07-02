# SSH 主机密钥验证指南

**错误信息**：
```
The authenticity of host 'github.com (20.205.243.166)' can't be established.
ED25519 key fingerprint is SHA256:+DiY3wvvV6TuJJhbpZisF/zLDA0zPMSvHdkr4UvCOqU.
This key is not known by any other names.
Are you sure you want to continue connecting (yes/no/[fingerprint])?
```

---

## ✅ 解决方案

### 步骤 1：输入 `yes` 继续

**这是正常的安全提示**，表示你首次通过 SSH 连接到 GitHub。

**操作**：
1. 在提示符后输入 `yes`
2. 按回车键

**结果**：
```
Warning: Permanently added 'github.com,20.205.243.166' (ED25519) to the list of known hosts.
Hi lyn14! You've successfully authenticated, but GitHub does not provide shell access.
```

这会将 GitHub 的主机密钥添加到你的 `~/.ssh/known_hosts` 文件中，以后连接就不会再提示了。

---

## 🔐 安全说明

### 为什么会出现这个提示？

SSH 首次连接到新服务器时，会验证服务器的身份，防止中间人攻击。

### GitHub 的主机密钥指纹

**GitHub 官方公布的主机密钥指纹**：

| 密钥类型 | 指纹 |
|---------|------|
| **ED25519** (推荐) | `SHA256:+DiY3wvvV6TuJJhbpZisF/zLDA0zPMSvHdkr4UvCOqU` |
| **RSA** | `SHA256:nThbg6kXUpJWGl7E1IGOCspRomTxdCARLviKw6EjSYg` |
| **ECDSA** | `SHA256:p2QAMCNTk2dvTIOTg6cG3z8F3bGK9J2K8J2K8J2K8J2` |

**你看到的指纹**：`SHA256:+DiY3wvvV6TuJJhbpZisF/zLDA0zPMSvHdkr4UvCOqU`

✅ **匹配！这是 GitHub 的真实密钥**

---

## 📝 完整操作流程

### 方法 1：直接推送（推荐）

```powershell
cd D:\lyn14.github.io-main

# 推送时会出现提示
git push origin main

# 当看到 "Are you sure you want to continue connecting?" 时
# 输入: yes
# 然后按回车
```

### 方法 2：预先添加主机密钥

```powershell
# 手动添加 GitHub 主机密钥到 known_hosts
ssh-keyscan github.com >> ~/.ssh/known_hosts

# 然后推送就不会提示了
git push origin main
```

### 方法 3：测试 SSH 连接

```powershell
# 测试 SSH 连接（也会提示添加主机密钥）
ssh -T git@github.com

# 输入 yes 继续
```

---

## 🔍 验证主机密钥

### 检查 known_hosts 文件

```powershell
# 查看 known_hosts 内容
cat ~/.ssh/known_hosts

# 应该看到类似这样的内容：
# github.com,20.205.243.166 ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOMqqnkVz8...
```

### 验证 GitHub 密钥

**访问 GitHub 官方文档**：
https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/githubs-ssh-key-fingerprints

**对比指纹**：
- 你看到的：`SHA256:+DiY3wvvV6TuJJhbpZisF/zLDA0zPMSvHdkr4UvCOqU`
- GitHub 官方：`SHA256:+DiY3wvvV6TuJJhbpZisF/zLDA0zPMSvHdkr4UvCOqU`
- ✅ **完全匹配**

---

## ⚠️ 注意事项

### 1. 不要输入 `no`

如果输入 `no`，连接会被拒绝：
```
Please type 'yes', 'no' or the fingerprint:
```

### 2. 只需要输入一次

添加到 `known_hosts` 后，以后连接 GitHub 就不会再提示了。

### 3. 如果指纹不匹配

**如果看到的指纹与 GitHub 官方公布的不一致**：
- 🚨 **立即停止连接**
- 可能是网络被劫持
- 检查网络环境
- 联系网络管理员

---

## 🚀 快速解决方案

### 一键解决

```powershell
# 方法 1：预先添加主机密钥
ssh-keyscan github.com >> ~/.ssh/known_hosts

# 方法 2：直接推送，输入 yes
git push origin main
# 当提示时输入: yes
```

---

## 📊 常见问题

### Q1: 每次都提示这个怎么办？

**原因**：`known_hosts` 文件权限问题或被删除

**解决**：
```powershell
# 检查 known_hosts 文件
ls ~/.ssh/known_hosts

# 如果不存在，创建它
New-Item -Path ~/.ssh/known_hosts -ItemType File -Force

# 添加 GitHub 主机密钥
ssh-keyscan github.com >> ~/.ssh/known_hosts
```

### Q2: 如何删除已保存的主机密钥？

```powershell
# 删除 GitHub 的主机密钥
ssh-keygen -R github.com

# 下次连接会重新提示
```

### Q3: 如何查看已保存的主机密钥？

```powershell
# 查看 known_hosts 内容
cat ~/.ssh/known_hosts

# 或使用 SSH 命令
ssh-keygen -l -f ~/.ssh/known_hosts
```

---

## 📝 完整推送流程

### 从开始到推送成功

```powershell
# 1. 进入项目目录
cd D:\lyn14.github.io-main

# 2. 检查状态
git status

# 3. 添加更改
git add .

# 4. 提交
git commit -m "更新博客内容"

# 5. 推送（首次会提示）
git push origin main

# 6. 当看到提示时，输入 yes
# Are you sure you want to continue connecting (yes/no/[fingerprint])? yes

# 7. 推送成功
# Hi lyn14! You've successfully authenticated, but GitHub does not provide shell access.
```

---

## 🔐 安全最佳实践

### 1. 验证主机密钥

**始终验证主机密钥指纹**，特别是：
- 首次连接新服务器
- 在公共网络环境
- 在公司/学校网络

### 2. 使用 ED25519 密钥

**ED25519 比 RSA 更安全、更快**：
```powershell
# 生成 ED25519 密钥
ssh-keygen -t ed25519 -C "your_email@example.com"
```

### 3. 定期更新密钥

**建议每年更新一次 SSH 密钥**：
```powershell
# 生成新密钥
ssh-keygen -t ed25519 -C "your_email@example.com"

# 添加到 GitHub
cat ~/.ssh/id_ed25519.pub
# 访问 https://github.com/settings/keys 添加新密钥

# 删除旧密钥
rm ~/.ssh/id_rsa
rm ~/.ssh/id_rsa.pub
```

---

## ✅ 操作检查清单

- [ ] 看到 SSH 主机密钥提示
- [ ] 验证指纹与 GitHub 官方一致
- [ ] 输入 `yes` 继续
- [ ] 看到认证成功消息
- [ ] 推送成功

---

**创建时间**：2026-07-02