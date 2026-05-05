# Next Steps - Updated Provider Version

## What Changed
Updated the AWS provider in module-2 from version `~> 3.27` to `~> 5.0` to support the newer SSO session configuration format.

## What You Need to Do

### 1. Reinitialize Terraform in module-2
Since we changed the provider version, you need to run `terraform init` again:

```bash
cd /Users/dgooch/Documents/Cloud-Stuff/FortiShield\ /AWSGoat/modules/module-2

# Reinitialize to download the new provider version
terraform init -upgrade

# Now plan should work
terraform plan --out tf.plan
```

### 2. If You Still Get Credential Errors
Make sure you've run:
```bash
source /Users/dgooch/Documents/Cloud-Stuff/FortiShield\ /AWSGoat/modules/setup-env.sh
```

### 3. Verify Setup
```bash
# Check AWS_PROFILE is set
echo $AWS_PROFILE
# Should show: AdministratorAccess-051022872926

# Check SSO session is active
aws sts get-caller-identity
# Should show your account info
```

## Why This Fix Works

**The Problem:**
- Your `~/.aws/config` uses the modern `sso-session` format:
  ```ini
  [profile AdministratorAccess-051022872926]
  sso_session = Fortinet
  
  [sso-session Fortinet]
  sso_start_url = https://fortinet-prod.awsapps.com/start/#
  sso_region = us-west-2
  ```

- AWS Provider v3.27 doesn't understand this format (released before SSO sessions existed)
- AWS Provider v5.0+ fully supports SSO sessions

**The Solution:**
- Upgraded to AWS Provider v5.0 which supports SSO sessions
- Now Terraform can properly read your SSO configuration

## Summary of All Fixes Applied

1. ✅ Fixed deprecated `template` provider (replaced with `templatefile()` and `file()`)
2. ✅ Fixed macOS `sed -i` syntax (added empty string argument)
3. ✅ Created Python virtual environment with boto3, PyJWT, bcrypt
4. ✅ Fixed `populate-table.py` to use AWS credential chain instead of env vars
5. ✅ Updated AWS provider to v5.0 to support SSO sessions
6. ✅ Created helper scripts for environment setup

## Ready to Deploy!

Run these commands in your terminal:

```bash
# Set up environment (if not already done)
cd /Users/dgooch/Documents/Cloud-Stuff/FortiShield\ /AWSGoat/modules
source setup-env.sh

# Deploy module-2
cd module-2
terraform init -upgrade
terraform plan --out tf.plan
terraform apply tf.plan
```
