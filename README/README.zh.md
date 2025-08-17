# Proton Sieve Filters - 智能邮件过滤器

[![MIT License](https://img.shields.io/badge/License-MIT-green.svg)](https://choosealicense.com/licenses/mit/)
[![GitHub contributors](https://img.shields.io/badge/Contributors-Welcome-brightgreen.svg)](https://github.com/poli0981/proton-sieve-filters/graphs/contributors)
[![GitHub issues](https://img.shields.io/github/issues/poli0981/proton-sieve-filters.svg)](https://github.com/poli0981/proton-sieve-filters/issues)
[![Version](https://img.shields.io/badge/Version-0.2.0-blue.svg)](https://github.com/poli0981/proton-sieve-filters/releases)

## 📧 描述

这个项目为Proton Mail用户提供全面的Sieve邮件过滤脚本。Sieve是一种用于服务器端邮件过滤的特定领域语言(DSL)，能够自动执行邮件分类、标记为已读、设置过期日期和高效组织收件箱等操作。

**🤖 AI辅助开发**: 本项目在研究、脚本编写、错误修复和翻译方面获得了AI的协助。最终实现由[@poli0981](https://github.com/poli0981)审查和完善。

**开发贡献比例:**
- **👨‍💻 人工 (@poli0981): 35%** - 项目概念、脚本架构、AI提示工程、错误修复、越南语内容、质量保证
- **🤖 AI (GitHub Copilot/Claude Sonnet 4 & Grok 4): 65%** - 脚本实现、翻译、研究、文档、域名/关键词编译

## ⚠️ 关键设置要求

**🚨 重要**: 在使用这些过滤器之前，您必须先在Proton Mail账户中创建目标文件夹。**如果文件夹不存在，脚本将无法工作。**

### 需要创建的文件夹:
```
📁 Shopping      (购物)
📁 Travel        (旅行)  
📁 Work          (工作)
📁 Security      (安全)
📁 Entertainment (娱乐)
📁 Gaming        (游戏)
📁 Social        (社交)
📁 Invoices      (发票)
📁 Newsletters   (新闻通讯)
📁 Health        (健康)
📁 Study         (学习)
📁 Proton        (Proton服务)
📁 Spam_Filter   (垃圾邮件过滤)
📁 EULA          (用户协议)
```

**如何在Proton Mail中创建文件夹:**
1. 进入 **设置** → **文件夹和标签**
2. 点击 **添加文件夹**
3. 创建上面列出的每个文件夹
4. **只有这样** 才能安装Sieve过滤器

## 🚀 主要功能

- **🎯 15+专业过滤器**: 数字生活各个方面的全面邮件分类
- **📱 简易安装**: 直接复制粘贴脚本到Proton Mail
- **⚙️ 完全可定制**: 编辑域名、关键词和保留期限
- **🌍 多语言支持**: 英语、越南语、中文和日语关键词
- **⏰ 智能保留**: 基于重要性的自动邮件过期
- **🔒 安全专注**: 增强垃圾邮件检测和安全警报优先级

## 📂 可用过滤器 (版本 0.2.0)

| 过滤器 | 目的 | 关键词 | 域名 | 保留期 |
|--------|------|--------|------|--------|
| **🛒 Shopping** | 电子商务、优惠、购买 | 200+ | 200+ | 1-365天 |
| **✈️ Travel** | 预订、航班、酒店 | 150+ | 200+ | 1-90天 |
| **💼 Work** | 专业、商务 | 200+ | 150+ | 1-365天 |
| **🔐 Security** | 账户警报、2FA、违规 | 200+ | - | 1-365天 |
| **🎮 Gaming** | 游戏、平台、新闻 | 150+ | 100+ | 1-30天 |
| **📺 Entertainment** | 流媒体、媒体、活动 | 120+ | 80+ | 1-14天 |
| **📱 Social Media** | 社交网络、通知 | 100+ | 60+ | 1-7天 |
| **💰 Invoices** | 账单、付款、收据 | 80+ | 70+ | 30-365天 |
| **📰 Newsletters** | 新闻、更新、订阅 | 60+ | 50+ | 1-30天 |
| **🏥 Health** | 医疗、健身、健康 | 100+ | 60+ | 7-90天 |
| **📚 Study** | 教育、课程、学习 | 80+ | 40+ | 7-180天 |
| **⚗️ Proton** | Proton服务通知 | 40+ | - | 30-90天 |
| **🚫 Spam** | 高级垃圾邮件检测 | 150+ | - | 立即删除 |
| **📜 EULA** | 条款、政策、法律更新 | 30+ | - | 90天 |

## 📥 安装指南

### 第1步: 创建必需的文件夹
1. 登录您的 **Proton Mail** 账户
2. 导航到 **设置** → **文件夹和标签**
3. 创建上面"需要创建的文件夹"部分列出的所有文件夹

### 第2步: 安装过滤器
1. 前往 **设置** → **过滤器** → **添加Sieve过滤器**
2. 从`filter/`目录选择一个过滤器 (如 `shopping.sieve`)
3. 复制整个脚本内容
4. 粘贴到Proton Mail的Sieve过滤器编辑器中
5. 给它一个描述性名称 (如 "购物过滤器 v0.2.0")
6. 在完全激活前 **先测试** 几封邮件
7. 保存并激活过滤器

### 第3步: 自定义 (可选)
- 在脚本文件中编辑域名列表
- 为您的语言/地区修改关键词
- 根据需要调整保留期限
- 将个人邮件地址添加到白名单

## 🧪 测试您的过滤器

### 生产部署前:
1. **小规模开始**: 一次激活一个过滤器
2. **监控活动**: 检查过滤器日志24-48小时
3. **验证文件夹**: 确保邮件正确分类
4. **检查误报**: 最初每天审查过滤的邮件
5. **调整规则**: 根据需要微调域名和关键词

## 🚨 故障排除

### 常见问题:

**过滤器不工作**
- ✅ 验证所有目标文件夹都存在
- ✅ 检查Sieve语法错误
- ✅ 确保过滤器已激活
- ✅ 用样本邮件测试

**重要邮件被过滤**
- ✅ 将发件人添加到个人通讯录(白名单)
- ✅ 审查和优化域名/关键词列表
- ✅ 检查过滤器优先级顺序

## 📄 许可证

本项目采用 **MIT许可证** 授权 - 详情请见 [LICENSE](LICENSE) 文件。

## 👨‍💻 联系与支持

- **GitHub**: [@poli0981](https://github.com/poli0981)
- **X (Twitter)**: [@SkullMute0011](https://x.com/SkullMute0011)
- **Facebook**: [skull.loro](https://www.facebook.com/skull.loro)
- **邮箱**: coding201913@hotmail.com

## 🙏 致谢

- **🤖 AI支持**: GitHub Copilot (Claude Sonnet 4) & Grok 4 提供开发支持
- **📧 灵感来源**: Proton Mail社区对高级邮件过滤的需求
- **🌐 社区**: 改进这些过滤器的贡献者、测试者和用户

---

**🔗 仓库**: https://github.com/poli0981/proton-sieve-filters  
**📊 版本**: 0.2.0  
**📅 最后更新**: 2025年8月17日

---

*祝您邮件过滤愉快! 📧✨*