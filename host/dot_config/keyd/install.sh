#!/bin/bash

# Remover arquivos antigos
echo "Excluding old config..."
sudo rm -rf /etc/keyd/* 
echo "OK."

# Criar diretórios, se não existirem
echo "Recreating directory structure..."
sudo mkdir -p /etc/keyd/
echo "/etc/keyd/ directory created."
echo "OK."

echo "Installing new .conf, and ./include/* files..."

# copy include files
for f in "/home/rodhfr/.config/keyd/include/"*; do
    [ -e "$f" ] || continue
    echo "Copying $f to /etc/keyd/"
    sudo ln -s "$f" /etc/keyd/
done
echo "OK."

# copy confs
for f in "/home/rodhfr/.config/keyd/"*.conf; do
    [ -e "$f" ] || continue
    echo "Copying $f to /etc/keyd/"
    sudo ln -s "$f" /etc/keyd/
done
echo "OK."

echo "Restarting Keyd..."
# Ativar e recarregar o serviço
sudo systemctl enable --now keyd
sudo keyd reload
echo "OK."
echo "Done."

