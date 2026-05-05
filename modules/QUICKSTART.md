# AWSGoat Quick Start Guide

## Step 0: Set Up Your Terminal Environment
**IMPORTANT:** In your terminal where you'll run Terraform, set the AWS profile:

```bash
# Navigate to the modules directory
cd /Users/dgooch/Documents/Cloud-Stuff/FortiShield\ /AWSGoat/modules

# Source the setup script (this sets AWS_PROFILE)
source setup-env.sh
```

This is required because each terminal session needs the `AWS_PROFILE` environment variable set.

## Step 1: Login to AWS SSO (if not already logged in)
```bash
aws sso login --profile AdministratorAccess-051022872926
```

## Step 2: Verify Credentials
```bash
aws sts get-caller-identity
```
Expected output should show:
- Account: 051022872926
- Arn: arn:aws:sts::051022872926:assumed-role/AWSReservedSSO_AdministratorAccess_...

## Step 3: Deploy Module-1
```bash
cd /Users/dgooch/Documents/Cloud-Stuff/FortiShield\ /AWSGoat/modules/module-1

# Initialize Terraform
terraform init

# Review the plan
terraform plan

# Apply changes (will prompt for confirmation)
terraform apply
```

## Step 4: Deploy Module-2 (if needed)
```bash
cd /Users/dgooch/Documents/Cloud-Stuff/FortiShield\ /AWSGoat/modules/module-2

# Initialize Terraform
terraform init

# Review the plan
terraform plan

# Apply changes (will prompt for confirmation)
terraform apply
```

## Environment Check
Run this command to verify your environment is properly configured:
```bash
./check-aws-config.sh
```

Or manually check:
```bash
echo "AWS Profile: $AWS_PROFILE"
aws sts get-caller-identity
```

**If AWS_PROFILE is empty**, you need to run in your terminal:
```bash
source setup-env.sh
```

## Common Issues

### Issue: "profile is configured to use SSO but is missing required configuration"
**Solution**: Remove any `profile = "..."` line from the provider block in main.tf. The profile should be set via the `AWS_PROFILE` environment variable only.

### Issue: "No module named 'boto3'"
**Solution**: The virtual environment should be automatically activated by Terraform. If issues persist:
```bash
source /Users/dgooch/Documents/Cloud-Stuff/FortiShield\ /AWSGoat/modules/venv/bin/activate
pip install -r /Users/dgooch/Documents/Cloud-Stuff/FortiShield\ /AWSGoat/modules/requirements.txt
```

### Issue: "KeyError: 'AWS_ACCESS_KEY_ID'"
**Solution**: This has been fixed. The populate-table.py script now uses the AWS credential chain instead of environment variables.

### Issue: SSO session expired
**Solution**: Re-authenticate:
```bash
aws sso login --profile AdministratorAccess-051022872926
```

## Cleanup/Destroy Resources
When you're done and want to tear down the infrastructure:
```bash
cd /Users/dgooch/Documents/Cloud-Stuff/FortiShield\ /AWSGoat/modules/module-1
terraform destroy

cd /Users/dgooch/Documents/Cloud-Stuff/FortiShield\ /AWSGoat/modules/module-2
terraform destroy
```
