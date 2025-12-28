# priviledge container
#distrobox create --root --hostname devbox --name devbox -i archlinux --home /home/rodhfr/Dots/devbox
distrobox create --hostname devbox --name devbox -i archlinux --home /home/rodhfr/Dots/devbox
distrobox enter devbox -- sudo pacman -Syu --noconfirm git neovim fish waybar ttf-nerd-fonts-symbols ttf-nerd-fonts-symbols-mono ttf-nerd-fonts-symbols-common swaybg tree-sitter-cli fzf
distrobox enter devbox -- sh /home/rodhfr/Dots/setup_devbox.sh
distrobox enter devbox
