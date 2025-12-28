distrobox create --hostname devbox --name devbox -i archlinux --home /home/rodhfr/Dots/devbox
distrobox enter devbox -- sudo pacman -Syu --noconfirm git neovim fish
distrobox enter devbox -- sh /home/rodhfr/Dots/setup_devbox.sh
distrobox enter devbox
