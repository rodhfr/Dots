#!/usr/bin/env bash

set -e

echo "Starting dotfiles sync process..."

echo "Copying yt-dlp configuration..."
cp -rf ./yt-dlp/* /home/rodhfr/Dots/host/dot_config/yt-dlp/
echo "yt-dlp configuration copied."

echo "Copying fuzzel configuration..."
cp -rf ./fuzzel/* /home/rodhfr/Dots/host/dot_config/fuzzel/
echo "fuzzel configuration copied."

echo "Copying mpv configuration..."
cp -rf ./mpv/* /home/rodhfr/Dots/host/dot_config/mpv/
echo "mpv configuration copied."

echo "Copying sway configuration..."
cp -rf ./sway/* /home/rodhfr/Dots/host/dot_config/sway/
echo "sway configuration copied."

echo "Copying keyd configuration..."
cp -rf ./keyd/* /home/rodhfr/Dots/host/dot_config/keyd/
echo "keyd configuration copied."

echo "Copying Neovim configuration..."
cp -rf ./nvim/* /home/rodhfr/Dots/host/dot_config/nvim/
echo "Neovim configuration copied."

echo "Copying Fish shell configuration..."
cp -rf ./fish/* /home/rodhfr/Dots/host/dot_config/fish/
echo "Fish configuration copied."

echo "Changing directory to Dots repository..."
cd /home/rodhfr/Dots

echo "Staging dot_config..."
git add .

if git diff --cached --quiet; then
  echo "No changes detected. Nothing to commit or push."
  exit 0
fi

echo "Committing changes..."
git commit -m "Update dot_config"

echo "Pushing to remote repository..."
git push

echo "Dotfiles synced, committed, and pushed successfully."
