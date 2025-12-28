echo "Installing dots"
cp -rf ./host/dot_config/* ~/.config/
echo "Installing host programs"
sudo sh ./host/programs.sh
