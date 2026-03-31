#!/bin/bash
echo "🚀 Starting FinLearn Backend Setup..."

# 1. Check/Install Vapor Toolbox
if ! command -v vapor &> /dev/null; then
    echo "📦 Vapor Toolbox not found. Installing via Homebrew..."
    brew install vapor
else
    echo "✅ Vapor Toolbox is already installed."
fi

# 2. Create Vapor Project
if [ -d "FinLearnBackend" ]; then
    echo "⚠️  Directory 'FinLearnBackend' already exists. Skipping creation."
else
    echo "🛠  Creating new Vapor project 'FinLearnBackend'..."
    # -n: no questions, --branch=main: use main template
    vapor new FinLearnBackend -n
    echo "✅ Project created!"
fi

echo "🎉 Setup Complete! You can now ask me to implement the backend logic."
