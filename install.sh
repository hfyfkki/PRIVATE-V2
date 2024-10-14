#!/bin/bash

# Create the .devcontainer directory if it doesn't already exist
mkdir -p .devcontainer

# Write the devcontainer.json configuration file
cat <<EOL > .devcontainer/devcontainer.json
{
    "name": "Telegram Bot Dev Container",
    "image": "mcr.microsoft.com/vscode/devcontainers/python:3.8",
    "features": {
        "ghcr.io/devcontainers/features/sshd:1": {
            "version": "latest"
        }
    },
    "postCreateCommand": "pip install python-telegram-bot",
    "postStartCommand": "python3 /workspaces/PRIVATE-V2/bot.py",
    "customizations": {
        "vscode": {
            "settings": {
                "python.pythonPath": "/usr/local/bin/python"
            },
            "extensions": [
                "ms-python.python"
            ]
        }
    }
}
EOL

# Add the new configuration file to git
git add .devcontainer/devcontainer.json

# Commit the changes with a message
git commit -m "Optimize devcontainer for running Telegram bot"

# Push the changes to the main branch
git push origin main

# Run the start command every 120 seconds
while true; do
    echo "Running postStartCommand..."
    python3 /workspaces/PRIVATE-V2/bot.py
    sleep 120
done