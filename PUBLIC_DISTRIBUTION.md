# 阿在 Token Pet 公开分发说明

## 当前能怎么公开给别人下载

截至 `2026-04-09`，Codex 官方文档已经明确：

- 官方公共 Plugin Directory 的插件发布还未开放
- 自助提交和管理流程也还未开放

因此，当前可执行的公开分发方式不是“直接上官方目录”，而是：

1. 把插件仓库公开
2. 发布公开下载包
3. 让用户按本地 marketplace 或本地安装方式接入 Codex

当前公开仓库：

- `https://github.com/woohuaca/Tokenpet`

## 当前推荐的公开分发路径

### 方案一：公开仓库 + 发布包

最稳的路径是：

1. 把 `plugins/azai-token-pet/` 放进公开仓库
2. 附上 `builds/azai-token-pet-v1.0.0-public-share.zip`
3. 在仓库首页写清楚安装步骤、系统要求和边界

这样别人至少可以：

- 下载源码或 zip
- 在本地 Codex 中按 marketplace 方式安装
- 在 macOS 上启动桌宠 companion

### 方案二：团队自建 marketplace

如果你们有团队自己的仓库或共享目录，可以维护一个：

- `repo marketplace`
- 或团队共享的 marketplace JSON

这样团队成员能在自己的 Codex 里看到同一组插件来源。

## 公开前必须补齐的三项外部信息

当前仓内已经把正式版包、说明文档和安装脚本收齐了，但如果要进一步对外公开，仍建议补齐：

1. 仓库地址
   用于填写 `.codex-plugin/plugin.json` 里的 `repository`
2. 官网或产品主页
   用于填写 `homepage` 和 `interface.websiteURL`
3. 对外可访问的隐私与条款链接
   用于填写 `interface.privacyPolicyURL` 和 `interface.termsOfServiceURL`

## 仓内已经准备好的公开分发产物

- `builds/azai-token-pet-v1.0.0-codex-macos.zip`
  面向 Codex 首发正式版的标准包
- `builds/azai-token-pet-v1.0.0-public-share.zip`
  面向公开下载分享的精简分发包

如果要让 GitHub 仓库访问者直接下载，下一步建议在 GitHub Releases 中上传：

- `azai-token-pet-v1.0.0-public-share.zip`
- `azai-token-pet-v1.0.0-codex-macos.zip`

建议同时附上：

- `docs/v1-github-release.md`
- `docs/v1-release-checksums.md`

## 公开说明里建议直接写清楚的句子

建议对外统一写成：

- 阿在 Token Pet 当前以 `Codex + macOS companion` 为正式首发范围。
- 官方公共 Codex 插件目录尚未开放自助提交，因此当前通过公开仓库和下载包分发。
- 下载后可按 README 中的本地安装方式接入 Codex。
