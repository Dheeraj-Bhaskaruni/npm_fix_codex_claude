# 1) Create a global npm dir in your home
mkdir -p ~/.npm-global

# 2) Tell npm to use it for global installs
npm config set prefix "$HOME/.npm-global"

# 3) Add it to PATH (bash)
echo 'export PATH="$HOME/.npm-global/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc

# If you use zsh instead:
# echo 'export PATH="$HOME/.npm-global/bin:$PATH"' >> ~/.zshrc
# source ~/.zshrc

# 4) Now install
npm i -g @openai/codex

# 5) Verify
command -v codex
codex --version