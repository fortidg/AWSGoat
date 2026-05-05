#!/bin/bash
# Activate the Python virtual environment for AWSGoat modules

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "${SCRIPT_DIR}/venv/bin/activate"

echo "Virtual environment activated!"
echo "Python: $(which python3)"
echo "Installed packages:"
pip list | grep -E "boto3|PyJWT|bcrypt"
