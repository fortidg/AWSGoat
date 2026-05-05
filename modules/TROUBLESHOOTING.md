# Troubleshooting Guide

## Error: "no valid credential sources for Terraform AWS Provider found"

This error means Terraform cannot find your AWS credentials. Here's how to fix it:

### Root Cause
The `AWS_PROFILE` environment variable is not set in your **terminal session** where you're running Terraform.

### Solution

**In your terminal** (not in Claude Code), run these commands:

```bash
# 1. Navigate to the modules directory
cd /Users/dgooch/Documents/Cloud-Stuff/FortiShield\ /AWSGoat/modules

# 2. Set the AWS profile (IMPORTANT!)
export AWS_PROFILE=AdministratorAccess-051022872926

# 3. Verify it's set
echo $AWS_PROFILE
# Should output: AdministratorAccess-051022872926

# 4. Test AWS credentials
aws sts get-caller-identity
# Should show your account info

# 5. If SSO session expired, login again
aws sso login --profile AdministratorAccess-051022872926
```

### Quick Setup (Recommended)
Instead of manually exporting, use the setup script:

```bash
cd /Users/dgooch/Documents/Cloud-Stuff/FortiShield\ /AWSGoat/modules
source setup-env.sh
```

This will:
- Set `AWS_PROFILE` automatically
- Verify your SSO session is active
- Show your AWS identity

### Then Run Terraform
```bash
cd module-2   # or module-1
terraform plan --out tf.plan
```

---

## Error: "profile is configured to use SSO but is missing required configuration"

### Solution
Do NOT add `profile = "..."` to the provider block in main.tf. The provider should look like this:

```hcl
provider "aws" {
  region = "us-east-1"
  # AWS_PROFILE environment variable must be set in your terminal
}
```

---

## Error: SSO Token Expired

### Symptoms
```
Error: error configuring Terraform AWS Provider: failed to refresh cached credentials
```

### Solution
```bash
aws sso login --profile AdministratorAccess-051022872926
```

---

## How to Verify Everything is Working

### Check 1: AWS_PROFILE is set
```bash
echo $AWS_PROFILE
```
Should output: `AdministratorAccess-051022872926`

If empty, run: `export AWS_PROFILE=AdministratorAccess-051022872926`

### Check 2: SSO Session is active
```bash
aws sts get-caller-identity
```
Should show your account: 051022872926

If it fails, run: `aws sso login --profile AdministratorAccess-051022872926`

### Check 3: Run the diagnostic script
```bash
cd /Users/dgooch/Documents/Cloud-Stuff/FortiShield\ /AWSGoat/modules
./check-aws-config.sh
```

---

## Common Mistakes

### ❌ Mistake 1: Running terraform without setting AWS_PROFILE
```bash
# This will FAIL:
cd module-2
terraform plan
```

### ✅ Correct Way:
```bash
# Set the profile first:
export AWS_PROFILE=AdministratorAccess-051022872926
cd module-2
terraform plan
```

### ❌ Mistake 2: Setting AWS_PROFILE in a different terminal
If you set AWS_PROFILE in one terminal but run terraform in another terminal, it won't work. Each terminal session needs the variable set.

### ✅ Correct Way:
Run `source setup-env.sh` in **every new terminal** where you want to run Terraform.

---

## Adding AWS_PROFILE to Your Shell Profile (Optional)

To automatically set AWS_PROFILE in all new terminal sessions, add this to your `~/.zshrc` or `~/.bash_profile`:

```bash
export AWS_PROFILE=AdministratorAccess-051022872926
```

Then reload your shell:
```bash
source ~/.zshrc   # for zsh
# or
source ~/.bash_profile   # for bash
```

---

## Still Having Issues?

Run the comprehensive check:
```bash
cd /Users/dgooch/Documents/Cloud-Stuff/FortiShield\ /AWSGoat/modules
./check-aws-config.sh
```

This will show you exactly what's configured and what's missing.
