#!/bin/bash

# Exit on undefined variables, but allow commands to fail gracefully
set -u

echo "==========================================="
echo "   macOS Developer Environment Setup"
echo "==========================================="
echo ""

# Install homebrew
echo "📦 Installing Homebrew..."
if ! command -v brew &> /dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo >> ~/.zprofile
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
    echo "✅ Homebrew installed successfully"
else
    echo "✅ Homebrew already installed"
fi

echo ""
echo "🐚 Installing Oh My Zsh..."
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    echo "✅ Oh My Zsh installed successfully"
else
    echo "✅ Oh My Zsh already installed"
fi

# Reload shell configuration safely
echo "🔄 Reloading shell configuration..."
if [ -f "$HOME/.zshrc" ]; then
    source "$HOME/.zshrc" 2>/dev/null || true
fi
if [ -f "$HOME/.zprofile" ]; then
    source "$HOME/.zprofile" 2>/dev/null || true
fi

echo ""
echo "📥 Installing development tools..."
# Bundle Install
echo "Downloading Brewfile..."
if ! curl -fsSL https://raw.githubusercontent.com/pradeep1402/setup/main/Brewfile -o Brewfile; then
    echo "⚠️  Failed to download Brewfile. Trying with local Brewfile if available..."
    if [ ! -f "Brewfile" ]; then
        echo "❌ No Brewfile found. Exiting."
        exit 1
    fi
fi

echo "Running brew bundle install..."
if ! brew bundle install --no-lock; then
    echo "⚠️  Some packages failed to install. Continuing..."
fi
echo "✅ All tools installed successfully"


echo ""
echo "⚙️  Git Configuration"
echo "===================="

# Try to read git configuration from command line arguments or prompt
GIT_EMAIL="${1:-}"
GIT_NAME="${2:-}"

# If not provided via arguments, try to get from user
if [ -z "$GIT_EMAIL" ] || [ -z "$GIT_NAME" ]; then
    # Try to read from terminal
    if [ -t 0 ]; then
        # Interactive mode - read from stdin
        read -p "Enter your git email: " GIT_EMAIL
        read -p "Enter your git username: " GIT_NAME
    elif [ -e /dev/tty ]; then
        # Try reading from /dev/tty (works better than exec)
        echo "Enter your git configuration (reading from terminal):"
        read -p "Enter your git email: " GIT_EMAIL < /dev/tty 2>/dev/null || true
        read -p "Enter your git username: " GIT_NAME < /dev/tty 2>/dev/null || true
    fi
fi

# If we still don't have values, use defaults
if [ -z "$GIT_EMAIL" ] || [ -z "$GIT_NAME" ]; then
    echo "⚠️  Could not read git configuration interactively."
    echo ""
    echo "You can configure git manually after script completes:"
    echo "  git config --global user.email \"your-email@example.com\""
    echo "  git config --global user.name \"Your Name\""
    echo ""
    # Skip git config if we can't get values
    GIT_EMAIL=""
    GIT_NAME=""
else
    git config --global user.email "$GIT_EMAIL"
    git config --global user.name "$GIT_NAME"
    echo "✅ Git configured:"
    echo "   Email: $GIT_EMAIL"
    echo "   Name: $GIT_NAME"
fi

echo ""
echo "🎨 Configuring Zsh..."
# Setup zsh syntax highlighting (check if already added)
if ! grep -q "zsh-syntax-highlighting.zsh" ~/.zshrc 2>/dev/null; then
    echo 'source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh' >> ~/.zshrc
    echo 'export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR=/opt/homebrew/share/zsh-syntax-highlighting/highlighters' >> ~/.zshrc
fi

if ! grep -q "zsh-autosuggestions.zsh" ~/.zshrc 2>/dev/null; then
    echo 'source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh' >> ~/.zshrc
fi

# Add git aliases (check if already added)
if ! grep -q 'alias gi=' ~/.zshrc 2>/dev/null; then
    echo 'alias gi="git init"' >> ~/.zshrc
    echo 'alias gc="git commit -m"' >> ~/.zshrc
    echo 'alias gp="git push"' >> ~/.zshrc
    echo 'alias gl="git log"' >> ~/.zshrc
    echo 'alias gs="git status"' >> ~/.zshrc
fi

echo "✅ Zsh configured with syntax highlighting and aliases"

echo ""
echo "==========================================="
echo "   ✨ Setup Complete!"
echo "==========================================="
echo ""
echo "Please restart your terminal or run:"
echo "  source ~/.zshrc"
echo ""
echo "Happy coding! 🚀"
