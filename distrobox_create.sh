#!/bin/bash
SCRIPT_DIR=$(dirname "$0")

# priviledge container
#distrobox create --root --hostname devbox --name devbox -i archlinux --home /home/rodhfr/Dots/devbox

# regular container
distrobox create --hostname devbox --name devbox -i archlinux --home $HOME/Dots/devbox

# install packages
distrobox enter devbox -- sudo pacman -Syu --noconfirm git htop which ttf-firacode-nerd make gcc fuzzel wl-clipboard firefox alacritty neovim sway fish waybar ttf-nerd-fonts-symbols ttf-nerd-fonts-symbols-mono ttf-nerd-fonts-symbols-common swaybg tree-sitter-cli fzf fd ttf-font-nerd starship

# git setup
distrobox enter devbox -- sh "$SCRIPT_DIR/git_setup.sh"

# ssh-keygen
distrobox enter devbox -- ssh-keygen

# enter container
distrobox enter devbox
