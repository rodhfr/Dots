#!/bin/bash
sudo keyd reload
sudo systemctl restart keyd
echo "Keyd config reloaded"
