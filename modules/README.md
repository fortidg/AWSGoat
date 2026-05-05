# AWSGoat Modules - Setup Guide

## Overview
This directory contains a Python virtual environment with all dependencies required for the AWSGoat Terraform modules, plus helpers for running Terraform with AWS SSO.

## Installed Packages
- **boto3** (>=1.26.0) - AWS SDK for Python
- **PyJWT** (>=2.8.0) - JSON Web Token implementation
- **bcrypt** (>=4.0.0) - Password hashing library

## Usage

### Option 1: Use the activation script
```bash
source activate.sh
```

### Option 2: Activate manually
```bash
source venv/bin/activate
```

### Deactivate
```bash
deactivate
```

## Terraform Integration
The Terraform configuration in `module-1/main.tf` automatically activates the virtual environment when running Python scripts during provisioning.

## Updating Dependencies
To update or add new dependencies:

1. Activate the virtual environment:
   ```bash
   source venv/bin/activate
   ```

2. Install or update packages:
   ```bash
   pip install <package-name>
   ```

3. Update requirements.txt:
   ```bash
   pip freeze > requirements.txt
   ```

## Running Terraform with AWS SSO

### Prerequisites
1. Ensure you're logged into AWS SSO:
   ```bash
   aws sso login --profile AdministratorAccess-051022872926
   ```

2. Verify your credentials:
   ```bash
   aws sts get-caller-identity
   ```

### Option 1: Use the Terraform Wrapper (Recommended)
```bash
# Initialize terraform
./terraform-wrapper.sh module-1 init

# Plan changes
./terraform-wrapper.sh module-1 plan

# Apply changes
./terraform-wrapper.sh module-1 apply
```

### Option 2: Run Terraform Directly
Since `AWS_PROFILE` is already set in your environment, you can run terraform directly:
```bash
cd module-1
terraform init
terraform plan
terraform apply
```

### Important Notes
- The AWS provider configuration uses the `AWS_PROFILE` environment variable (already set to `AdministratorAccess-051022872926`)
- Do NOT add `profile =` to the provider block in main.tf - it will cause SSO configuration errors
- Python scripts automatically use the AWS_PROFILE for credentials

## Troubleshooting

### Python Import Errors
If you encounter import errors when running Terraform:
- Ensure the virtual environment is created: `python3 -m venv venv`
- Reinstall dependencies: `pip install -r requirements.txt`
- Verify installation: `python3 -c "import boto3, jwt, bcrypt; print('OK')"`

### AWS SSO Errors
If you get credential errors:
1. Check if your SSO session is active: `aws sts get-caller-identity`
2. If expired, re-login: `aws sso login --profile AdministratorAccess-051022872926`
3. Verify AWS_PROFILE is set: `echo $AWS_PROFILE`

### Certificate Errors
If you see SSL certificate errors (common with corporate proxies):
```bash
export AWS_CA_BUNDLE=/path/to/ca-bundle.crt
# or temporarily (less secure):
export AWS_CA_BUNDLE=""
```
