# ⚡ ZshAutoInstall – Professional Modular ZSH Environment

<p align="center">
  <img src="https://img.shields.io/badge/ZSH-Modular-0f9d58?style=for-the-badge">
  <img src="https://img.shields.io/badge/Starship-Enabled-f39c12?style=for-the-badge">
  <img src="https://img.shields.io/badge/Konsole-DarkPro-34495e?style=for-the-badge">
  <img src="https://img.shields.io/badge/Multi--Distro-Supported-9b59b6?style=for-the-badge">
  <img src="https://img.shields.io/badge/License-MIT-blue?style=for-the-badge">
</p>

---

# 📘 Table of Contents
- [Overview](#overview)
- [Features](#features)
- [Quick Install](#quick-install)
- [Supported Distros](#supported-distros)
- [Repository Structure](#repository-structure)
- [ZSH Modular System](#zsh-modular-system)
- [Konsole Theme (DarkPro)](#konsole-theme-darkpro)
- [Starship Prompt](#starship-prompt)
- [Uninstall](#uninstall)
- [Screenshots](#screenshots)
- [FAQ](#faq)
- [License](#license)

---

# 🔎 Overview
**ZshAutoInstall** provides a complete, ready-to-use terminal environment for any Linux-based system.

It automatically installs:

- ZSH  
- Oh My Zsh  
- All recommended plugins  
- Starship prompt  
- A clean modular configuration  
- The DarkPro Konsole theme  

Everything is lightweight, fast, universal, and completely portable.

---

# ⚙️ Features

- 🚀 **One-command installation** (`curl | bash`)
- 🧩 **Fully modular ZSH configuration**
- 🌈 **Starship prompt with a clean professional layout**
- 🎨 **DarkPro Konsole theme included**
- ⚡ **fzf / fzf-tab / autosuggestions / syntax-highlighting**
- 🐧 **Works on every major Linux distribution**
- 🔒 **No personal data, safe for public use**
- 🛠️ **Completely open and customizable**
- 💻 **Ideal for workstations, laptops, VMs, and containers**

---

# 🚀 Quick Install

Run:

```bash
curl -fsSL https://raw.githubusercontent.com/fernandoalbino/ZshAutoInstall/main/scripts/install.sh | bash
```

Or:

```bash
wget -qO- https://raw.githubusercontent.com/fernandoalbino/ZshAutoInstall/main/scripts/install.sh | bash
```

---

# 🐧 Supported Distros

| Distro | Status |
|--------|--------|
| Arch / Manjaro / CachyOS | ✅ Supported |
| Debian / Ubuntu / Mint | ✅ Supported |
| Fedora / RHEL / Rocky | ✅ Supported |
| OpenSUSE | ⚠️ Partial support |
| Alpine | ⚠️ Experimental |

---

# 📁 Repository Structure

```
ZshAutoInstall/
├── assets/                → Optional screenshots
├── konsole/               → DarkPro Konsole theme
│   ├── DarkPro.colorscheme
│   └── DarkPro.profile
├── starship/
│   └── starship.toml      → Starship prompt configuration
├── zsh/                   → Modular ZSH environment
│   ├── aliases.zsh
│   ├── env.zsh
│   ├── history.zsh
│   ├── path.zsh
│   ├── perf.zsh
│   ├── plugins.zsh
│   ├── ui.zsh
│   └── zshrc
├── scripts/               → Installation scripts
│   ├── install.sh         → Bootstrap installer (curl | bash)
│   ├── install_full.sh    → Full system installer
│   └── uninstall.sh       → Removes ZshAutoInstall components
├── .gitignore
├── LICENSE
└── README.md
```

---

# 🧬 ZSH Modular System

Each configuration file has its own responsibility:

| File | Purpose |
|------|---------|
| `zshrc` | Loads all modules |
| `env.zsh` | Environment variables, editor detection |
| `path.zsh` | Builds a clean PATH |
| `aliases.zsh` | Universal aliases |
| `plugins.zsh` | Oh My Zsh + plugin loading |
| `perf.zsh` | Performance optimizations |
| `ui.zsh` | Fastfetch + Starship prompt |
| `history.zsh` | History configuration |

This design follows **modern shell engineering practices**, making it maintainable and scalable.

---

# 🎨 Konsole Theme (DarkPro)

A custom near-black theme optimized for:

- long coding sessions  
- reduced glare  
- consistent colors in Starship and ZSH  

Files included:

```
konsole/DarkPro.colorscheme
konsole/DarkPro.profile
```

---

# ✨ Starship Prompt

Starship configuration is located in:

```
starship/starship.toml
```

Features:

- minimalistic two-line layout  
- directory truncation  
- Git status indicators  
- visually balanced coloring  

---

# 🗑️ Uninstall

To remove ZshAutoInstall components:

```bash
bash scripts/uninstall.sh
```

The script can remove:

- ZSH modules  
- plugin folders  
- generated configs  
- optional Oh My Zsh removal  

---

# 🖼 Screenshots

Place your screenshots in `assets/` and reference them here:

```md
<img src="assets/screenshot_zsh.png" width="600">
```

---

# ❓ FAQ

### **Does this overwrite my existing ZSH configuration?**
Backups are automatically created before installation.

### **Can I use this on multiple machines?**
Yes — the setup is universal and reproducible.

### **Are any private files included?**
No. This repository contains only universal, non-sensitive configuration.

### **Can I customize modules?**
Absolutely. Each file is independent and editable.

---

# 📄 License

This project is licensed under the **MIT License**.
