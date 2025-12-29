#!/bin/bash

sudo pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git /tmp/yay && cd /tmp/yay && makepkg -si --noconfirm
rm -rf /tmp/yay
yay -Sy --noconfirm google-chrome
