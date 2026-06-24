# TorArgus

<p align="center">
  <b>EN</b> | <a href="README.zh-CN.md">中文</a>
</p>

> Put your Tor Browser into a macOS sandbox — prevent drive-by downloads and keep your system safe.

## What is this?

TorArgus is a macOS toolset that **automatically cleans up all Tor Browser downloads** the moment the browser closes.  
If a malicious .onion site tries to drop a file on your machine — it's gone instantly.

## Features

- ✅ **Exit-time cleanup** — close Tor Browser, all downloads get deleted
- ✅ **Real-time watchdog** — files in the download folder are deleted the moment they appear
- ✅ **No browser crashes** — works by cleaning up after, not blocking writes
- ✅ **Privacy-focused** — designed to complement Tor Browser's built-in protections

## Quick Start

```bash
# 1. Install Tor Browser (if not already)
brew install --cask tor-browser

# 2. Safe launch (exit → auto cleanup)
bash safe-tor.sh

# 3. Real-time watchdog (optional, recommended)
cp com.user.tor-cleanup.plist ~/Library/LaunchAgents/
launchctl load ~/Library/LaunchAgents/com.user.tor-cleanup.plist
```

## Files

| File | Purpose |
|------|---------|
| `safe-tor.sh` | Launch Tor Browser, clean downloads on exit |
| `com.user.tor-cleanup.plist` | macOS launchd watchdog — deletes files in real time |

## How it works

- `safe-tor.sh` monitors the Tor Browser (Firefox) process. When it exits, it wipes `~/Downloads/Tor Downloads`.
- `com.user.tor-cleanup.plist` uses macOS `launchd` `WatchPaths` — as soon as a file lands in the download folder, it gets removed instantly.

## Dependencies

- macOS
- Tor Browser (`brew install --cask tor-browser`)
- Tor daemon (optional, `brew install tor`)

## Uninstall

```bash
sudo rm /usr/local/bin/safe-tor
launchctl unload ~/Library/LaunchAgents/com.user.tor-cleanup.plist
rm ~/Library/LaunchAgents/com.user.tor-cleanup.plist
```
