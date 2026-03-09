# 🖥️ GitHub Actions RDP — Windows Remote Desktop

Create a free Windows remote desktop via GitHub Actions, connected through Tailscale VPN.

## 🚀 Quick Start

1. **Fork** this repository
2. Add `TAILSCALE_AUTH_KEY` secret in **Settings → Secrets → Actions**
   - Get your key at: [Tailscale Admin Console](https://login.tailscale.com/admin/settings/keys) → Generate auth key (reusable recommended)
3. Go to **Actions → RDP → Run workflow**
4. Select software to install → click **Run workflow**
5. Check the **"Connection Info & Keep Alive"** step log for IP, Username, and Password
6. Open **Remote Desktop** (mstsc) on your device → enter the connection info

## ⚙️ Workflow Features

### 🔧 Performance Optimization
- **High Performance** power plan enabled
- **Windows Defender** real-time scanning disabled (saves CPU/RAM)
- 8 unnecessary services disabled (DiagTrack, SysMain, WSearch, etc.)
- Game Bar/DVR and Error Reporting disabled
- Disk cleanup (temp files, DISM component cleanup)

### 🖥️ RDP Configuration
- Clipboard, drive, printer, and audio redirection enabled
- H.264/AVC video encoding for smoother experience
- AVC444 mode for accurate color reproduction
- RemoteFX memory leak fix (Server 2025)
- No idle/disconnect timeout — session stays alive
- 4K resolution support (3840×2160) at 60fps, 32-bit color

### 🎮 GPU Detection & Optimization
- Auto-detects **NVIDIA / AMD / Intel** dedicated GPU
- Applies hardware-accelerated encoding for real GPUs
- Falls back to virtual GPU with software rendering
- Forces GPU visibility in **Task Manager** Performance tab
- DWM desktop composition enabled

### 🔄 Driver Updates
- **GPU**: Auto-installs NVIDIA GeForce / AMD Adrenalin / Intel Graphics driver
- **Network**: Detects Intel/Realtek NICs → installs latest Ethernet & WiFi drivers
- **Audio**: Realtek audio driver auto-detection
- **Chipset**: Intel Chipset INF update
- **All others**: Scans Windows Update for remaining driver updates
- Displays driver version summary after completion

### 📦 Software (Toggle On/Off)

All software is installed via `winget`. Default is **off** unless noted.

| Software | Winget ID | Default |
|----------|-----------|---------|
| VS Code | `Microsoft.VisualStudioCode` | ✅ On |
| Node.js LTS | `OpenJS.NodeJS.LTS` | Off |
| Python 3.13 | `Python.Python.3.13` | Off |
| Git | `Git.Git` | Off |
| 7-Zip | `7zip.7zip` | Off |
| Notepad++ | `Notepad++.Notepad++` | Off |
| Java JDK 21 | `Oracle.JDK.21` | Off |
| Docker Desktop | `Docker.DockerDesktop` | ✅ Always |
| DirectX Runtime | `Microsoft.DirectX` + VC++ Redist | ✅ Always |
| Microsoft Store | Windows AppX | ✅ Always |
| .NET 8 Runtime | `Microsoft.DotNet.Runtime.8` | Off |
| WinRAR | `RARLab.WinRAR` | Off |
| VLC | `VideoLAN.VLC` | Off |
| Firefox | `Mozilla.Firefox` | Off |
| Telegram | `Telegram.TelegramDesktop` | Off |

### 🌐 Pre-installed (Always)
- **Google Chrome** (replaces Edge)
- **WSL2** with Ubuntu
- **Tailscale** VPN
- **Microsoft Edge** is force-uninstalled

### 🔐 Security
- RDP user created with **16-character random password** (uppercase + lowercase + digits + special)
- User added to `Administrators` and `Remote Desktop Users` groups
- Connection only accessible via **Tailscale VPN** (not exposed to public internet)
- Credentials shown only in GitHub Actions log (accessible to repo owner only)

### ⏱️ Session
- **Timeout**: 3600 minutes (60 hours) — maximum GitHub Actions limit
- **Keep-alive**: Displays uptime and remaining time every 5 minutes
- **Concurrency**: Only one RDP session at a time (prevents conflicts)
- **Cancel**: Stop the workflow in GitHub Actions to terminate the session

## 📁 Repository Structure

```
├── .github/
│   └── workflows/
│       └── main.yml          # RDP workflow (main file)
├── H.sh                      # Termux: AutoGen Studio installer
├── Huy.sh                    # Termux: Basic tools setup (git, curl, python)
└── README.md                 # This file
```

## 🔑 Required Secrets

| Secret | Description | How to get |
|--------|-------------|------------|
| `TAILSCALE_AUTH_KEY` | Tailscale authentication key | [Tailscale Admin](https://login.tailscale.com/admin/settings/keys) → Generate auth key |

## 📋 Workflow Inputs

| Input | Description | Default |
|-------|-------------|---------|
| `username` | RDP login username | `RDP` |
| `install_vscode` | Install VS Code | `true` |
| `install_nodejs` | Install Node.js LTS | `false` |
| `install_python` | Install Python 3.13 | `false` |
| `install_git` | Install Git | `false` |
| `install_7zip` | Install 7-Zip | `false` |
| `install_notepadpp` | Install Notepad++ | `false` |
| `install_java` | Install Java JDK 21 | `false` |
| _(Docker Desktop)_ | _Always installed_ | _N/A_ |
| _(DirectX Runtime)_ | _Always installed_ | _N/A_ |
| _(Microsoft Store)_ | _Always installed_ | _N/A_ |
| `install_dotnet` | Install .NET 8 Runtime | `false` |
| `install_winrar` | Install WinRAR | `false` |
| `install_vlc` | Install VLC | `false` |
| `install_firefox` | Install Firefox | `false` |
| `install_telegram` | Install Telegram Desktop | `false` |

## 💡 Tips

- **RDP Client**: Use [Microsoft Remote Desktop](https://apps.microsoft.com/detail/9WZDNCRFJ3PS) (Windows/Mac/iOS/Android)
- **Tailscale**: Install Tailscale on your device too, so you can reach the runner's IP
- **File Transfer**: Enable drive redirection in your RDP client to share local drives
- **Audio**: Audio playback is supported over RDP
- **Multiple monitors**: Supports up to 4 monitors at 4K resolution

## ⚠️ Disclaimer

This project is for **educational and personal use only**. Please follow [GitHub's Terms of Service](https://docs.github.com/en/site-policy/github-terms/github-terms-of-service) and use responsibly.
