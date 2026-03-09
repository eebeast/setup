#! /bin/bash

# Install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo >> ~/.zprofile
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

source ~/.zshrc
source ~/.zprofile

# Bundle Install
curl https://raw.githubusercontent.com/pradeep1402/setup/main/Brewfile > Brewfile
brew bundle install



# setup github username and email
 git config --global --add user.email "pb63827@gmail.com"
 git config --global --add user.name "Pradeep"


# Setup zsh syntax hightlighting
echo 'source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh' >> ~/.zshrc
echo 'export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR=/opt/homebrew/share/zsh-syntax-highlighting/highlighters' >> ~/.zshrc
echo 'alias gi="git init"' >> ~/.zshrc
echo 'alias gc="git commit -m"' >> ~/.zshrc
echo 'source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh' >> ~/.zshrc
