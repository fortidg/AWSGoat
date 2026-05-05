#!/bin/bash
# AWS Configuration Check Script

echo "=== AWS Configuration Check ==="
echo ""

echo "1. AWS_PROFILE environment variable:"
if [ -z "$AWS_PROFILE" ]; then
    echo "   ❌ AWS_PROFILE is NOT set"
    echo "   Run: export AWS_PROFILE=AdministratorAccess-051022872926"
else
    echo "   ✅ AWS_PROFILE=$AWS_PROFILE"
fi
echo ""

echo "2. AWS CLI Test:"
if aws sts get-caller-identity 2>/dev/null; then
    echo "   ✅ AWS CLI working"
else
    echo "   ❌ AWS CLI failed"
    echo "   Run: aws sso login --profile AdministratorAccess-051022872926"
fi
echo ""

echo "3. Terraform AWS credentials check:"
if aws configure list 2>/dev/null | grep -q "profile"; then
    echo "   ✅ AWS credentials available"
    aws configure list
else
    echo "   ⚠️  Checking credential chain..."
    aws configure list
fi
echo ""

echo "4. AWS Config file check:"
if grep -q "sso_session" ~/.aws/config 2>/dev/null; then
    echo "   ✅ SSO session configuration found"
else
    echo "   ⚠️  No SSO session configuration"
fi
echo ""

echo "=== Recommended Commands ==="
echo "If AWS_PROFILE is not set in your terminal, run:"
echo "  export AWS_PROFILE=AdministratorAccess-051022872926"
echo ""
echo "If AWS CLI test failed, run:"
echo "  aws sso login --profile AdministratorAccess-051022872926"
echo ""
echo "Then run Terraform with:"
echo "  terraform plan"
