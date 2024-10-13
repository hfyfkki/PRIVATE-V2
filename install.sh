#!/bin/bash

# Create the .devcontainer directory if it doesn't already exist
mkdir -p .devcontainer

# Write the devcontainer.json configuration file
cat <<EOL > .devcontainer/devcontainer.json
{
    "name": "My Codespace",
    "image": "mcr.microsoft.com/vscode/devcontainers/python:3.8",
    "features": {
        "ghcr.io/devcontainers/features/sshd:1": {
            "version": "latest"
        }
    },
    "postStartCommand": "python3 /workspaces/PRIVATE-V2/hr.py",
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
git commit -m "Add postStartCommand to run Python script automatically"

# Push the changes to the main branch
git push origin main

# Run the postStartCommand every 100 seconds
while true; do
    echo "Running postStartCommand..."
    python3 /workspaces/PRIVATE-V2/hr.py
    sleep 100
done
