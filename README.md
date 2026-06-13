# macOS Developer Setup

Automated setup script for a modern macOS development environment.

## Quick Start

**Option 1: One-liner (Fastest)**
```bash
curl -fsSL https://raw.githubusercontent.com/eebeast/setup/main/setup.sh | bash -s "your-email@example.com" "Your Name"
```

**Option 2: Clone and run**
```bash
git clone https://github.com/eebeast/setup.git
cd setup
chmod +x setup.sh
./setup.sh "your-email@example.com" "Your Name"
```

## What Gets Installed

### Languages & Runtimes
- **Node.js** — JavaScript/TypeScript runtime
- **Python 3.12** — Python programming language
- **Java 21** — Java development kit
- **Go** — Systems programming language

### Development Tools
- **Docker** — Container platform
- **Git** — Version control
- **VS Code** — Code editor
- **Insomnia** — API testing tool

### Terminal Enhancements
- **Zsh plugins** — Syntax highlighting & auto-suggestions
- **Bat** — Better cat with syntax highlighting
- **Tree** — Directory visualization
- **Kitty** — Modern terminal emulator
- **Rectangle** — Window management

## Customization

Edit `Brewfile` to add or remove packages, then run:
```bash
brew bundle install
```