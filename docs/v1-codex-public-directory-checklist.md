# 阿在 Token Pet 官方 Codex 公共目录准备清单

## 这份清单解决什么问题

这份清单不回答“现在能不能上官方公共目录”，而回答：

- 一旦 Codex 官方开放公共 Plugin Directory 提交
- 我们还差哪些材料
- 哪些字段已经有，哪些还只是临时占位

## 当前结论

截至 `2026-04-09`：

- 官方公共 Plugin Directory 自助提交还未开放
- 我们已经完成了公开仓库和下载包分发准备
- 但要进入官方目录，仍建议再补几项对外资产

## 已经具备的项

- 插件仓库：`https://github.com/woohuaca/Tokenpet`
- 正式版本号：`v1.0.0`
- 正式发布说明：`docs/v1-codex-release-notes.md`
- 公开分发说明：`PUBLIC_DISTRIBUTION.md`
- 隐私说明：`PRIVACY.md`
- 条款说明：`TERMS.md`
- 下载包：
  - `builds/azai-token-pet-v1.0.0-public-share.zip`
  - `builds/azai-token-pet-v1.0.0-codex-macos.zip`

## 建议补齐的项

### 1. 独立官网或落地页

当前 `homepage` 和 `websiteURL` 先指向 GitHub 仓库，可先用，但更适合补成独立页面。

### 2. 稳定外链的隐私与条款页面

当前先指向 GitHub 仓库里的 Markdown 文件，可先用，但更适合补成官网可访问页面。

### 3. 官方目录风格的展示素材

建议提前准备：

- 1 张主视觉横幅
- 1 张插件卡片图
- 2 到 4 张使用截图
- 1 段 1 句核心价值描述

### 4. 英文版对外介绍

如果官方目录支持英文面向更广用户，建议提前准备：

- 英文 short description
- 英文 long description
- 英文安装说明

### 5. 公开支持渠道

建议补：

- issue 模板
- bug 反馈入口
- 用户联系邮箱或讨论区

## `.codex-plugin/plugin.json` 当前还可进一步加强的字段

当前已经补了：

- `repository`
- `homepage`
- `interface.websiteURL`
- `interface.privacyPolicyURL`
- `interface.termsOfServiceURL`

后续如果官方目录开放更多展示字段，建议再补：

- 更明确的 release notes 链接
- 支持链接
- 截图或媒体链接

## 到时建议的提交顺序

1. 先确认官方目录提交流程已开放
2. 先把官网、隐私、条款外链切成稳定 URL
3. 再补官方目录所需截图和营销文案
4. 最后用 `v1.x` 当前稳定包作为首个提交版本
