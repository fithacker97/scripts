#!/bin/bash

# Default virtual environment name
VENV_NAME=${1:-venv}

# Optional: Python version (e.g., python3.10), default to python3
PYTHON_BIN=${2:-python3}

# Check if Python is installed
if ! command -v $PYTHON_BIN &> /dev/null; then
    echo "❌ Error: $PYTHON_BIN not found. Please install it first."
    exit 1
fi

# Check if venv module is available
if ! $PYTHON_BIN -m venv --help &> /dev/null; then
    echo "❌ Error: venv module is not available for $PYTHON_BIN"
    echo "Try: sudo apt install python3-venv"
    exit 1
fi

# Create virtual environment
echo "🔧 Creating virtual environment: $VENV_NAME using $PYTHON_BIN..."
$PYTHON_BIN -m venv "$VENV_NAME"

# Check if creation succeeded
if [ $? -eq 0 ]; then
    echo "✅ Virtual environment '$VENV_NAME' created successfully."
    echo "👉 To activate, run: source $VENV_NAME/bin/activate"
else
    echo "❌ Failed to create virtual environment."
fi
# Optional: Install pip packages if requirements.txt exists
if [ -f requirements.txt ]; then
    echo "📦 Installing packages from requirements.txt..."
    source "$VENV_NAME/bin/activate"
    pip install -r requirements.txt
    if [ $? -eq 0 ]; then
        echo "✅ Packages installed successfully."
    else
        echo "❌ Failed to install packages."
    fi
    deactivate
else
    echo "📄 No requirements.txt found, skipping package installation."
fi      
