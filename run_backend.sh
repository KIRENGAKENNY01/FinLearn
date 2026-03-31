#!/bin/bash

# Configuration
PORT=8081
HOSTNAME="0.0.0.0" # Listen on all interfaces

echo "🚀 Starting FinLearn Backend on http://$HOSTNAME:$PORT..."

# Check if we are in the right directory
if [ ! -f "Package.swift" ]; then
    if [ -d "FinLearnBackend" ]; then
        cd FinLearnBackend
    else
        echo "❌ Error: Could not find FinLearnBackend directory or Package.swift"
        exit 1
    fi
fi

# Run the Vapor server
swift run Run serve --hostname $HOSTNAME --port $PORT
