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

### 🧠 RAM Optimization (Aggressive)
- **Windows Defender** fully disabled (real-time, scripts, IOAV, behavior monitoring, services stopped)
- **42 services** disabled — Xbox, Fax, SmartCard, BITS, Windows Update, Diagnostics, Print Spooler, etc.
- **19 background processes** killed — SearchIndexer, OneDrive, RuntimeBroker, GameBar, etc.
- **Memory compression** disabled — use raw RAM directly
- **Prefetch/Superfetch** disabled via registry
- **Pagefile** auto-configured to 1.5x–3x RAM using CIM cmdlets
- **Cortana**, Notifications, Tips disabled
- **DisablePagingExecutive=1** — keep kernel in RAM for faster response
- **LargeSystemCache=0** — prioritize apps over system cache

### 💾 Disk Optimization (7-Phase Aggressive Cleanup)

| Phase | Action | Space Saved |
|-------|--------|-------------|
| 1 | Temp files (Windows, user, prefetch, logs, debug) | ~500MB–1GB |
| 2 | GitHub runner bloat (35 folders: CodeQL, Go, Ruby, Java, Rust, MongoDB, MySQL, Chocolatey, etc.) | ~5–15GB |
| 3 | Appx bloatware (26 apps: Xbox, Skype, Maps, Teams, Clipchamp, etc.) | ~500MB |
| 4 | Windows component cleanup (DISM ResetBase + SPSuperseded) | ~1–2GB |
| 5 | Windows caches (WER, FontCache, INetCache, CrashDumps, thumbnails) | ~200–500MB |
| 6 | Disable hibernation (`powercfg /h off`) | ~3–4GB |
| 7 | Compact OS (`compact /CompactOS:always`) | ~2–3GB |

**Total estimated: 12–25 GB recovered**

### 🎨 OpenGL & Video Optimization
- **Mesa3D** OpenGL software renderer — auto-fetches latest version from GitHub (64-bit + 32-bit DLLs)
- OpenGL ICD registered in Windows registry (64-bit System32 + 32-bit Wow6432Node)
- **WARP** DirectX software renderer enabled
- **Minecraft / GLFW OpenGL fix** — Mesa environment variables: `GL 4.5`, `GLSL 450`, `llvmpipe` driver
- `LIBGL_ALWAYS_SOFTWARE=1` — forces software rendering on virtual GPU
- OpenGL registered for **Hyper-V Video adapter** GPU class registry
- **K-Lite Codec Pack Full** — H.264, H.265/HEVC, VP9, AV1, AAC, etc.
- **RDP video optimization** — VideoPlaybackPolicy, Media Foundation frame server
- **Multimedia scheduling** — video playback set to High priority (GPU Priority=8)
- **Network throttling disabled** — no bandwidth limits for video streaming
- AVC444 mode at 60fps for smooth RDP video playback

### 🔧 Performance
- **High Performance** power plan enabled
- Game Bar/DVR and Error Reporting disabled
- Visual effects set to best performance

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
- Falls back to **WARP software renderer** for virtual GPUs
- Forces GPU visibility in **Task Manager** Performance tab
- DWM desktop composition enabled

### 🔄 Smart Driver Updates
Auto-detects hardware and installs matching drivers only:

| Component | Detection | Driver |
|-----------|-----------|--------|
| **GPU** | NVIDIA / AMD / Intel | GeForce Experience / Adrenalin / Intel Graphics |
| **GPU (virtual)** | Hyper-V Video | WARP renderer enabled |
| **Network** | Intel NIC | Intel Ethernet + WiFi driver |
| **Network** | Realtek NIC | Realtek Ethernet driver |
| **Network** | Mellanox / Hyper-V | Virtual adapter — inbox driver |
| **Chipset** | Intel CPU | Intel Chipset INF |
| **Chipset** | AMD CPU (EPYC, Ryzen) | AMD Chipset Software |
| **Audio** | Realtek | Realtek Audio driver |
| **Audio** | None (VM) | Skipped |
| **All others** | Windows Update scan | Auto-download & install |

All winget commands use `--source winget` to avoid Microsoft Store agreement prompts.

### 📦 Software (Toggle On/Off)

All software is installed via `winget`. Default is **off** unless noted.

| Software | Winget ID | Default |
|----------|-----------|---------|
| VS Code | `Microsoft.VisualStudioCode` | Off |
| Git | `Git.Git` | Off |
| 7-Zip | `7zip.7zip` | Off |
| Notepad++ | `Notepad++.Notepad++` | Off |
| WinRAR | `RARLab.WinRAR` | Off |
| VLC | `VideoLAN.VLC` | Off |
| Firefox | `Mozilla.Firefox` | Off |
| Telegram | `Telegram.TelegramDesktop` | Off |
| OBS Studio | `OBSProject.OBSStudio` | Off |
| PuTTY | `PuTTY.PuTTY` | Off |
| Postman | `Postman.Postman` | Off |
| Discord | `Discord.Discord` | Off |
| Steam | `Valve.Steam` | Off |
| Sublime Text | `SublimeHQ.SublimeText.4` | Off |
| FileZilla + WinSCP | `TimKosse.FileZilla.Client` + `WinSCP.WinSCP` | Off |

### 💻 Programming Languages (Single Input)

Gộp vào 1 input `install_languages` — nhập tên ngôn ngữ cách nhau bằng dấu phẩy:

| Keyword | Package | Winget ID |
|---------|---------|-----------|
| `nodejs` | Node.js LTS | `OpenJS.NodeJS.LTS` |
| `python` | Python 3.13 | `Python.Python.3.13` |
| `java` | Java JDK 21 | `Oracle.JDK.21` |
| `dotnet` | .NET 8 Runtime + Desktop Runtime | `Microsoft.DotNet.Runtime.8` |

**Ví dụ**: `nodejs,python` → cài Node.js + Python. Để trống = không cài.

### 🏪 Microsoft Store (Choose Method)

Input `install_store` — chọn 1 trong 3 cách cài trên Windows Server 2025:

| Option | Method | Mô tả |
|--------|--------|-------|
| `off` | Không cài | Mặc định |
| `reregister` | Re-register AppX | Đăng ký lại Store packages có sẵn + wsreset |
| `ltsc-script` | LTSC Script (GitHub) | Tải script từ `kkkgo/LTSC-Add-MicrosoftStore`, chạy `Add-Store.cmd` |
| `manual-cdn` | CDN + DISM | Cài VCLibs từ Microsoft CDN, re-register dependencies, DISM Add-Capability |

> **Note**: Some inputs are bundled to stay within GitHub's input limit:
> - `install_languages` = Node.js, Python, Java, .NET (comma-separated)
> - `install_store` = 3 phương pháp cài Store (choice)
> - `install_file_transfer` = FileZilla + WinSCP
> - `install_chrome` = Chrome install + Edge uninstall
> - `install_directx` = DirectX + VC++ Redistributable

### 🌐 Always Installed (No Toggle)
- **Tailscale** VPN (required for RDP connection)

All other software (Chrome, Docker, WSL2, DirectX, Microsoft Store, Edge uninstall) is **toggle-based** — enable only what you need.

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
│       ├── main.yml          # RDP Full workflow (25 inputs, 1300+ lines)
│       └── rdp-lite.yml      # RDP Lite workflow (minimal, fast setup)
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
| `install_vscode` | Install VS Code | `false` |
| `install_languages` | Languages: `nodejs,python,java,dotnet` | `''` (empty) |
| `install_git` | Install Git | `false` |
| `install_7zip` | Install 7-Zip | `false` |
| `install_notepadpp` | Install Notepad++ | `false` |
| `install_winrar` | Install WinRAR | `false` |
| `install_vlc` | Install VLC | `false` |
| `install_firefox` | Install Firefox | `false` |
| `install_telegram` | Install Telegram Desktop | `false` |
| `install_obs` | Install OBS Studio | `false` |
| `install_putty` | Install PuTTY (SSH Client) | `false` |
| `install_postman` | Install Postman (API Testing) | `false` |
| `install_discord` | Install Discord | `false` |
| `install_steam` | Install Steam | `false` |
| `install_sublimetext` | Install Sublime Text | `false` |
| `install_file_transfer` | Install FileZilla + WinSCP | `false` |
| `install_chrome` | Install Chrome + Uninstall Edge | `false` |
| `install_wsl` | Install WSL2 + Ubuntu | `false` |
| `install_docker` | Install Docker Desktop | `false` |
| `install_directx` | Install DirectX + VC++ Redist | `false` |
| `install_store` | Install Microsoft Store (method) | `off` |


## 🖥️ Runner Specs (GitHub Actions `windows-latest`)

| Spec | Value |
|------|-------|
| OS | Windows Server 2025 Datacenter |
| CPU | AMD EPYC 7763 — 2 cores / 4 threads |
| RAM | 16 GB |
| Disk | ~150 GB (80–100 GB free after cleanup) |
| GPU | Hyper-V Video (virtual) |
| Network | Mellanox ConnectX-4 Lx + Hyper-V adapter |

## 💡 Tips

- **RDP Client**: Use [Microsoft Remote Desktop](https://apps.microsoft.com/detail/9WZDNCRFJ3PS) (Windows/Mac/iOS/Android)
- **Tailscale**: Install Tailscale on your device too, so you can reach the runner's IP
- **File Transfer**: Enable drive redirection in your RDP client to share local drives
- **Audio**: Audio playback is supported over RDP
- **Multiple monitors**: Supports up to 4 monitors at 4K resolution

## ⚠️ Disclaimer

This project is for **educational and personal use only**. Please follow [GitHub's Terms of Service](https://docs.github.com/en/site-policy/github-terms/github-terms-of-service) and use responsibly.
