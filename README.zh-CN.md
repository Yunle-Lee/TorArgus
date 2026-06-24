# TorArgus

<p align="center">
  <a href="README.md">EN</a> | <b>中文</b>
</p>

> 把 Tor Browser 关进 macOS 沙箱 — 防止路过式下载，保护系统安全。

## 这是什么？

TorArgus 是一个 macOS 工具集，**在 Tor Browser 关闭时自动清理所有下载内容**。  
如果某个恶意 .onion 站点试图往你电脑里塞文件 — 它会被瞬间删除。

## 功能特性

- ✅ **退出即清理** — 关闭 Tor Browser，所有下载自动删除
- ✅ **实时监控** — 下载目录里的文件一出现就被秒删
- ✅ **浏览器不报错** — 采用"事后清理"而非"拒绝写入"，浏览器不会卡死崩溃
- ✅ **专注隐私** — 设计上补充 Tor Browser 的内置保护

## 快速开始

```bash
# 1. 安装 Tor Browser（如果没有的话）
brew install --cask tor-browser

# 2. 安全启动（退出 → 自动清理）
bash safe-tor.sh

# 3. 实时监控（可选，推荐）
cp com.user.tor-cleanup.plist ~/Library/LaunchAgents/
launchctl load ~/Library/LaunchAgents/com.user.tor-cleanup.plist
```

## 文件说明

| 文件 | 用途 |
|------|------|
| `safe-tor.sh` | 启动 Tor Browser，退出后自动清空下载目录 |
| `com.user.tor-cleanup.plist` | macOS launchd 实时监控，文件出现即删除 |

## 原理

- `safe-tor.sh`：监控 Tor Browser（Firefox）进程，进程退出后清除 `~/Downloads/Tor Downloads`
- `com.user.tor-cleanup.plist`：利用 macOS `launchd` 的 `WatchPaths` 功能，下载目录一有新文件就立即删除

## 依赖

- macOS
- Tor Browser（`brew install --cask tor-browser`）
- Tor 守护进程（可选，`brew install tor`）

## 卸载

```bash
sudo rm /usr/local/bin/safe-tor
launchctl unload ~/Library/LaunchAgents/com.user.tor-cleanup.plist
rm ~/Library/LaunchAgents/com.user.tor-cleanup.plist
```
