sudo dnf install -y git \
  neovim \
  fish \
  fd \
  distrobox

curl -fsSL https://raw.githubusercontent.com/getnf/getnf/main/install.sh | bash
getnf -i CascadiaCode

curl -sS https://starship.rs/install.sh | sh
chsh -s /usr/bin/fish
