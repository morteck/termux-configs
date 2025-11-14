# Termux Configs

**Uncomplicating Termux one headache at a time.**

This repository is a work in progress. I've created a custom `.bashrc` for Termux to enhance productivity, simplify common tasks, and improve the shell appearance. 

This project is designed for the [Termux App](https://github.com/termux/termux-app), the terminal emulator and Linux environment for Android.

---

## Features

- **Colorized prompt** with username, device, and current directory
- **Aliases** for quick navigation, Git commands, system shortcuts, and more
- **Helper functions**:
  - `extract <archive>` – Extract multiple archive types
  - `myip` – Display local and external IP addresses
  - `sysinfo` – Show system information
  - `serve [port]` – Start a simple Python HTTP server
- **History management** and safer shell behavior for interactive use
- Automatic **custom greeting** on shell start

---

## Installation

You can install this `.bashrc` directly in Termux:

``` bash 
# Backup your current bashrc

$ cp ~/.bashrc ~/.bashrc.backup 2>/dev/null || true

# Download the custom bashrc

$ curl -o ~/.bashrc https://raw.githubusercontent.com/morteck/termux-configs/main/bashrc

# Apply changes immediately

$ source ~/.bashrc
