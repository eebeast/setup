#!/bin/bash
set -u

echo "==========================================="
echo "   macOS Developer Environment Setup"
echo "==========================================="
echo ""

# Install Homebrew
echo "📦 Installing Homebrew..."
if ! command -v brew &> /dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo >> ~/.zprofile
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
    echo "✅ Homebrew installed"
else
    echo "✅ Homebrew already installed"
fi

# Install Oh My Zsh
echo ""
echo "🐚 Installing Oh My Zsh..."
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    echo "✅ Oh My Zsh installed"
else
    echo "✅ Oh My Zsh already installed"
fi

# Reload shell configuration
echo ""
echo "🔄 Reloading shell configuration..."
[ -f "$HOME/.zshrc" ] && source "$HOME/.zshrc" 2>/dev/null || true
[ -f "$HOME/.zprofile" ] && source "$HOME/.zprofile" 2>/dev/null || true

# Install tools from Brewfile
echo ""
echo "📥 Installing development tools..."

# Create temp directory for Brewfile
TMPDIR=${TMPDIR:-/tmp}
BREWFILE="$TMPDIR/Brewfile.$$"

if curl -fsSL https://raw.githubusercontent.com/eebeast/setup/main/Brewfile -o "$BREWFILE"; then
    cd "$TMPDIR" || exit 1
    brew bundle install --file="$BREWFILE" --no-lock || echo "⚠️  Some packages failed to install"
    rm -f "$BREWFILE"
    echo "✅ Tools installed"
else
    echo "❌ Failed to download Brewfile"
    exit 1
fi

# Configure Git
echo ""
echo "⚙️  Configuring Git..."
GIT_EMAIL="${1:-}"
GIT_NAME="${2:-}"

if [ -z "$GIT_EMAIL" ]; then
    echo "⚠️  Git email not provided (pass as first argument)"
elif [ -z "$GIT_NAME" ]; then
    echo "⚠️  Git name not provided (pass as second argument)"
else
    git config --global user.email "$GIT_EMAIL"
    git config --global user.name "$GIT_NAME"
    echo "✅ Git configured: $GIT_NAME <$GIT_EMAIL>"
fi

# Configure Zsh
echo ""
echo "🎨 Configuring Zsh..."
if ! grep -q "zsh-syntax-highlighting.zsh" ~/.zshrc 2>/dev/null; then
    {
        echo 'source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh'
        echo 'source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh'
    } >> ~/.zshrc
fi

echo "✅ Zsh configured"

echo ""
echo "==========================================="
echo "   ✨ Setup Complete!"
echo "==========================================="
echo ""
echo "Next steps:"
echo "  1. Restart your terminal or: source ~/.zshrc"
echo "  2. Configure SSH for GitHub if needed"
echo ""
echo "Happy coding! 🚀"
