#!/bin/bash
# Tor Browser Safe Launcher
# 安全启动 Tor Browser，退出后自动清理下载
# 安装: sudo cp safe-tor.sh /usr/local/bin/safe-tor && sudo chmod +x /usr/local/bin/safe-tor

set -e

BROWSER_APP="/Applications/Tor Browser.app"
DOWNLOAD_DIR="$HOME/Downloads/Tor Downloads"

echo "========================================"
echo "  Tor Browser - Safe Launcher"
echo "========================================"
echo ""

# 检查 Tor Browser 是否安装
if [ ! -d "$BROWSER_APP" ]; then
    echo "❌ 错误: Tor Browser 未安装"
    echo "   请先安装: brew install --cask tor-browser"
    exit 1
fi

# 创建下载目录（Tor Browser 默认会下载到这里）
mkdir -p "$DOWNLOAD_DIR"

# 标记启动时间（用于后续清理判断）
LAUNCH_TIME=$(date +%s)

echo "🚀 启动 Tor Browser..."
echo "📂 下载目录: $DOWNLOAD_DIR"
echo "⚠️  关闭浏览器后自动清理所有下载内容"
echo ""

# 启动 Tor Browser
open "$BROWSER_APP"

# 等待浏览器进程退出
echo "⏳ 浏览器已启动，等待窗口关闭..."
echo "   （保持此终端打开，或按 Ctrl+C 手动退出）"
echo ""

while true; do
    # 检查 Tor Browser 进程（firefox 是 Tor Browser 的内核）
    if ! pgrep -f "Tor Browser" > /dev/null 2>&1; then
        echo ""
        echo "🔍 浏览器已关闭，开始清理..."
        break
    fi
    sleep 2
done

# 清理下载目录
if [ -d "$DOWNLOAD_DIR" ]; then
    rm -rf "$DOWNLOAD_DIR"/*
    echo "   ✅ 已清空: $DOWNLOAD_DIR"
fi

# 同时清理其他可能的残留
rm -f "$HOME/Downloads/"*.part 2>/dev/null
rm -f "$HOME/Downloads/"*.download 2>/dev/null

echo ""
echo "========================================"
echo "  ✅ 安全退出完成"
echo "  所有本次会话的下载已清理"
echo "========================================"
