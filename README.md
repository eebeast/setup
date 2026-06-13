# Mac Developer Setup Script

Automated setup script for macOS developer environment with essential tools, programming languages, and utilities.

## Quick Start

### Method 1: Direct Download and Execute (Recommended - Interactive)

```bash
# Clone or download the repository
git clone https://github.com/pradeep1402/setup.git
cd setup

# Make the script executable
chmod +x setup.sh

# Run the setup script (will prompt for git email and username)
./setup.sh
```

### Method 2: With Git Credentials as Arguments (Non-Interactive)

```bash
# Pass email and username directly to skip prompts
curl -fsSL https://raw.githubusercontent.com/pradeep1402/setup/main/setup.sh | bash -s "your-email@example.com" "Your Name"
```

**Or locally:**
```bash
./setup.sh "your-email@example.com" "Your Name"
```

### Method 3: Using bash (Works Better with Prompts)

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/pradeep1402/setup/main/setup.sh)"
```

### Method 4: Pipe to bash with Credentials

```bash
curl -fsSL https://raw.githubusercontent.com/pradeep1402/setup/main/setup.sh | bash -s "your-email@example.com" "Your Name"
```

 > **Note:** Method 1 (Direct execution) works best for interactive prompts. If you have trouble with interactive prompts, use Method 2 or 4 and pass your git credentials as arguments.

## Features

✅ **Flexible Git Configuration** - Configure git interactively OR pass credentials as arguments
✅ **Multiple Execution Methods** - Works with direct execution, curl piping, or with arguments  
✅ **Zsh Syntax Highlighting** - Better terminal experience with color syntax
✅ **Git Aliases** - Quick shortcuts (gi, gc, gp, gl, gs)
✅ **Complete Developer Toolkit** - Git, Docker, Node.js, Python, Java 21, and more
✅ **Modern IDE** - VS Code for code editing
✅ **API Testing** - Insomnia for API development and testing
✅ **Terminal Enhancements** - Kitty terminal with advanced features
✅ **Window Management** - Rectangle for efficient window organization
✅ **Graceful Error Handling** - Continues even if some packages fail, allows manual setup

## What Gets Installed

### Package Managers
- **Homebrew** - macOS package manager
- **Oh My Zsh** - Zsh configuration framework

### Version Control
- **Git** - Version control system
- **Git GUI** - Graphical interface for Git

### CLI Utilities
- **bat** - Better cat implementation with syntax highlighting
- **tree** - Display directory structure
- **zsh-syntax-highlighting** - Syntax highlighting for Zsh
- **zsh-autosuggestions** - Auto-suggestions in Zsh
- **jump** - Fast directory navigation
- **tokei** - Count lines of code
- **curl** - Data transfer tool

### Programming Languages & Runtimes
- **Node.js** - JavaScript runtime
- **Python 3.11** - Python programming language
- **Java 21** - Java development kit
- **Deno** - Modern JavaScript/TypeScript runtime

### Development Tools
- **Docker** - Container platform

### Terminal & Shell
- **Kitty** - Modern terminal emulator

### Window Management
- **Rectangle** - Window management and tiling

### Editors & IDEs
- **Visual Studio Code** - Popular code editor
- **Insomnia** - API testing and design tool

## What the Script Does

1. Installs Homebrew (if not already installed)
2. Updates shell configuration (.zprofile and .zshrc)
3. Installs Oh My Zsh for better shell experience
4. Downloads and runs `brew bundle install` from Brewfile
5. Prompts for Git configuration (email and username)
6. Installs Zsh syntax highlighting
7. Adds useful Git aliases

## Requirements

- macOS (Apple Silicon or Intel)
- Terminal/Shell access
- Internet connection

## Customization

To customize what gets installed, edit the `Brewfile` before running the script or modify it after installation and run `brew bundle install`.

## Git Aliases Added

- `gi` - git init
- `gc` - git commit -m
- `gp` - git push
- `gl` - git log
- `gs` - git status

## Troubleshooting

### Script stops or fails during Git Configuration prompts

**Solution 1 (Recommended):** Pass git credentials as command-line arguments to skip interactive prompts:

```bash
# Download and run locally first
git clone https://github.com/pradeep1402/setup.git && cd setup && ./setup.sh "your-email@example.com" "Your Name"

# Or with curl, pass arguments after --s 
curl -fsSL https://raw.githubusercontent.com/pradeep1402/setup/main/setup.sh | bash -s "your-email@example.com" "Your Name"
```

**Solution 2:** Run the script directly locally (best for interactive prompts):

```bash
git clone https://github.com/pradeep1402/setup.git
cd setup
chmod +x setup.sh
./setup.sh  # Will prompt for email and username
```

**Solution 3 - Scripted runs:** If the script can't read from terminal, configure git manually after:

```bash
git config --global user.email "your-email@example.com"
git config --global user.name "Your Name"
```

### Script stops after "Oh My Zsh installed successfully"

This usually happens when using the old command format. Use one of the recommended methods above instead of the deprecated `sh` version.

### Some brew packages fail to install

This is usually not a critical issue. The script will continue and show a warning. You can manually install failed packages:

```bash
brew install PACKAGE_NAME
```

### Manual Setup Steps

If the automated script fails completely, run these commands manually:

```bash
# 1. Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# 2. Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# 3. Install tools from Brewfile
curl https://raw.githubusercontent.com/pradeep1402/setup/main/Brewfile > Brewfile
brew bundle install

# 4. Configure Git
git config --global user.email "your-email@example.com"
git config --global user.name "Your Name"

# 5. Configure Zsh
echo 'source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh' >> ~/.zshrc
echo 'source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh' >> ~/.zshrc
```

After running the setup, consider:
- Configure SSH keys for GitHub: https://docs.github.com/en/authentication/connecting-to-github-with-ssh

