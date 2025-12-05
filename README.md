# ⚡ ZshAutoInstall – Professional Modular ZSH Environment

<p align="center">
  <img src="https://img.shields.io/badge/ZSH-Modular-0f9d58?style=for-the-badge">
  <img src="https://img.shields.io/badge/Starship-Enabled-f39c12?style=for-the-badge">
  <img src="https://img.shields.io/badge/Konsole-DarkPro-34495e?style=for-the-badge">
  <img src="https://img.shields.io/badge/Multi--Distro-Supported-9b59b6?style=for-the-badge">
  <img src="https://img.shields.io/badge/License-MIT-blue?style=for-the-badge">
</p>

---

<details>
<summary><strong>📘 Table of Contents</strong></summary>

- [Overview](#overview)
- [Features](#features)
- [Quick Install](#quick-install)
- [Supported Distros](#supported-distros)
- [Repository Structure](#repository-structure)
- [ZSH Modular System](#zsh-modular-system)
- [Konsole Theme - DarkPro](#konsole-theme---darkpro)
- [Starship Prompt - DarkPro Edition](#starship-prompt---darkpro-edition)
- [Uninstall](#uninstall)
- [Screenshots](#screenshots)
- [FAQ](#faq)
- [License](#license)

</details>

---

# Overview
ZshAutoInstall provides a complete, ready-to-use terminal environment for any Linux system.

It automatically installs:

- ZSH  
- Oh My Zsh  
- Recommended plugins  
- Starship prompt (DarkPro Edition)  
- Modular configuration  
- DarkPro Konsole theme  

Fast, lightweight, universal, and fully portable.

---

# Features
- 🚀 One-command installation (`curl | bash`)
- 🧩 Fully modular ZSH configuration
- 🎨 Includes DarkPro theme for Konsole & universal Starship preset
- ⚡ Enhanced workflow: fzf, fzf-tab, autosuggestions, syntax-highlighting
- 🐧 Multi-distro support (Arch, Debian, Fedora, etc.)
- 🔒 No personal data included — safe for public use
- 💻 Ideal for desktops, laptops, VMs, and containers

---

# Quick Install

```bash
curl -fsSL https://raw.githubusercontent.com/fernandoalbino/ZshAutoInstall/main/scripts/install.sh | bash
```

or

```bash
wget -qO- https://raw.githubusercontent.com/fernandoalbino/ZshAutoInstall/main/scripts/install.sh | bash
```

---

# Supported Distros

| Distro | Status |
|--------|--------|
| Arch / Manjaro / CachyOS | ✅ Supported |
| Debian / Ubuntu / Mint | ✅ Supported |
| Fedora / RHEL / Rocky | ✅ Supported |
| OpenSUSE | ⚠️ Partial |
| Alpine | ⚠️ Experimental |

---

# Repository Structure

```
ZshAutoInstall/
├── assets/                → Optional screenshots
├── konsole/               → DarkPro Konsole theme
│   ├── DarkPro.colorscheme
│   └── DarkPro.profile
├── starship/
│   └── starship.toml      → Starship (DarkPro Edition)
├── zsh/                   → Modular ZSH configuration
│   ├── aliases.zsh
│   ├── env.zsh
│   ├── history.zsh
│   ├── path.zsh
│   ├── perf.zsh
│   ├── plugins.zsh
│   ├── ui.zsh
│   └── zshrc
├── scripts/
│   ├── install.sh
│   ├── install_full.sh
│   └── uninstall.sh
├── .gitignore
├── LICENSE
└── README.md
```

---

# ZSH Modular System

| File | Purpose |
|------|---------|
| `zshrc` | Loads all modules |
| `env.zsh` | Environment variables and XDG-compliant paths |
| `history.zsh` | History configuration |
| `path.zsh` | Clean & ordered PATH |
| `aliases.zsh` | Universal aliases |
| `plugins.zsh` | Oh My Zsh + plugin loading |
| `perf.zsh` | Performance optimizations |
| `ui.zsh` | Fastfetch + Starship initialization |

This structure follows professional dotfile engineering practices.

---

# Konsole Theme - DarkPro

A polished, near-black theme optimized for:

- Long coding sessions  
- Low glare  
- Clean contrast  
- Perfect integration with the Starship DarkPro preset  

Files include:

```
konsole/DarkPro.colorscheme
konsole/DarkPro.profile
```

---

# Starship Prompt - DarkPro Edition

This repository includes a professional, minimalistic, and clean Starship preset.

### Key Features
- Two-line compact layout  
- Git branch + status indicators  
- Python venv and NodeJS detection  
- Command duration  
- Color palette aligned with DarkPro  
- Zero visual clutter  

Installed automatically to:

```
~/.config/starship.toml
```

---

# Uninstall

```bash
bash scripts/uninstall.sh
```

The script optionally removes:

- ZSH modules  
- Plugin directories  
- Starship configuration  
- Oh My Zsh (if selected)  

---

# Screenshots

Add your screenshots to `assets/` and reference them here:

```md
<img src="assets/screenshot_zsh.png" width="600">
```

---

# FAQ

### Will this overwrite my ZSH configuration?
A backup is created automatically.

### Can I use this across multiple machines?
Yes — the environment is fully portable.

### Are private configs included?
No. This repo is safe for public use.

### Can I customize modules?
Yes, every file is independent and easy to edit.

---

# License
This project is licensed under the **MIT License**.
