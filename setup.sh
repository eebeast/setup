#!/bin/bash
set -u

# Setup logging
LOG_FILE="$HOME/.macOS-setup.log"
exec > >(tee -a "$LOG_FILE")
exec 2>&1

# Install Homebrew
if ! command -v brew &> /dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo >> ~/.zprofile
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    echo "Homebrew already installed"
fi

# Install Oh My Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
    echo "Oh My Zsh already installed"
fi

echo ""
echo "Installing development tools..."
echo ""

# Create temp directory for Brewfile
TMPDIR=${TMPDIR:-/tmp}
BREWFILE="$TMPDIR/Brewfile.$$"

if curl -fsSL https://raw.githubusercontent.com/eebeast/setup/main/Brewfile -o "$BREWFILE"; then
    cd "$TMPDIR" || exit 1
    brew bundle install --file="$BREWFILE" --verbose 2>&1
    INSTALL_STATUS=$?
    rm -f "$BREWFILE"

    if [ $INSTALL_STATUS -eq 0 ]; then
        echo ""
        echo "All tools installed successfully"
    else
        echo ""
        echo "Some tools may have failed (check log above)"
    fi
else
    echo "Failed to download Brewfile"
    exit 1
fi

# Configure Git
echo ""
echo "Configuring Git..."
GIT_EMAIL="${1:-}"
GIT_NAME="${2:-}"

if [ -z "$GIT_EMAIL" ]; then
    echo "Git email not provided (pass as first argument)"
elif [ -z "$GIT_NAME" ]; then
    echo "Git name not provided (pass as second argument)"
else
    git config --global user.email "$GIT_EMAIL"
    git config --global user.name "$GIT_NAME"
    echo "Git configured: $GIT_NAME <$GIT_EMAIL>"
fi

# Configure Zsh
echo ""
echo "Configuring Zsh and tool paths..."

# Add shell plugins
if ! grep -q "zsh-syntax-highlighting.zsh" ~/.zshrc 2>/dev/null; then
    {
        echo 'source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh'
        echo 'source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh'
    } >> ~/.zshrc
fi

# Configure Java
if ! grep -q "JAVA_HOME" ~/.zshrc 2>/dev/null; then
    {
        echo ''
        echo '# Java Configuration'
        echo 'export JAVA_HOME=$(/opt/homebrew/bin/java_home -v 21)'
        echo 'export PATH=$JAVA_HOME/bin:$PATH'
    } >> ~/.zshrc
fi

# Configure Go
if ! grep -q "GOPATH" ~/.zshrc 2>/dev/null; then
    {
        echo ''
        echo '# Go Configuration'
        echo 'export GOPATH=$HOME/go'
        echo 'export PATH=$GOPATH/bin:$PATH'
    } >> ~/.zshrc
fi

# Configure Python alias
if ! grep -q "alias python=" ~/.zshrc 2>/dev/null; then
    {
        echo ''
        echo '# Python Configuration'
        echo 'alias python=python3'
        echo 'alias pip=pip3'
    } >> ~/.zshrc
fi

echo "Zsh configured with:"
echo "  - Java 21 (JAVA_HOME, PATH)"
echo "  - Go (GOPATH, PATH)"
echo "  - Python aliases (python -> python3, pip -> pip3)"
echo "  - Syntax highlighting and auto-suggestions"

echo ""
echo "==========================================="
echo "Setup Complete!"
echo "==========================================="
echo ""
echo "Log saved to: $LOG_FILE"
echo ""
echo "Next steps:"
echo "  1. Restart your terminal or: source ~/.zshrc"
echo "  2. Configure SSH for GitHub"
echo ""
