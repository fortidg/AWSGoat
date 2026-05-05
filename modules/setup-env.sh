#!/bin/bash
# Source this script to set up your environment for Terraform
# Usage: source setup-env.sh

export AWS_PROFILE=AdministratorAccess-051022872926

echo "✅ AWS_PROFILE set to: $AWS_PROFILE"

# Check if SSO session is active
if aws sts get-caller-identity &>/dev/null; then
    echo "✅ AWS SSO session is active"
    aws sts get-caller-identity
else
    echo "❌ AWS SSO session not active"
    echo "Run: aws sso login --profile $AWS_PROFILE"
    return 1
fi

echo ""
echo "Environment ready for Terraform!"
echo "You can now run:"
echo "  cd module-1 && terraform plan"
echo "  cd module-2 && terraform plan"
