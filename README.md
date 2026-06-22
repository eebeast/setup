# macOS Developer Setup

Automated setup script for a modern macOS development environment.

## Quick Start

### Step 1: Generate Your Email

You have two options:

**Option A: Use an existing email**
- Use your personal or work email address
- Example: `john@gmail.com`

**Option B: Generate a GitHub-specific email**
- GitHub allows you to create a private/noreply email for commits
- Example: `107491133+eebeast@users.noreply.github.com`
- Set this in [GitHub Settings → Email](https://github.com/settings/emails) to keep your email private

### Step 2: Run the Setup

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

**Replace the placeholders:**
- `your-email@example.com` — Your email address (for Git commits and GitHub)
- `Your Name` — Your full name (will appear in Git commits)

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