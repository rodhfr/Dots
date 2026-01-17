#!/bin/bash

# Ask the user for their Git email and username
read -p "What is your Git email? " user_email
read -p "What is your Git username? " user_name

# Set the Git configuration with the provided information
git config --global user.email "$user_email"
git config --global user.name "$user_name"

echo "Git configuration completed successfully!"
