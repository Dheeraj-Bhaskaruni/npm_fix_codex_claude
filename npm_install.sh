# Add NodeSource repo for LTS (20.x)
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -

# Install node + npm
sudo apt-get install -y nodejs

# Verify
node -v
npm -v


# If curl isn’t installed:
sudo apt-get update
sudo apt-get install -y curl

# no-sudo global install setup + install Codex

mkdir -p ~/.npm-global
npm config set prefix "$HOME/.npm-global"
echo 'export PATH="$HOME/.npm-global/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc

npm i -g @openai/codex

command -v codex
codex --version
