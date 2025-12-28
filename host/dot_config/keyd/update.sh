#!/bin/bash
rm -r /home/rodhfr/.config/keyd/*
cp -rf ./* /home/rodhfr/.config/keyd/
/home/rodhfr/.config/keyd/install.sh
sudo keyd reload
sudo systemctl restart keyd
echo "Keyd config reloaded"
