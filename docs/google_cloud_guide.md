# Google Cloud Free Tier Setup (Frankfurt)

## 1. Create Project and Link Billing
```bash
# Set your project ID (must be globally unique)
export PROJECT_ID="your-unique-seedbox-id"  # No spaces/special chars

# Create project first
gcloud projects create $PROJECT_ID --name="Magic-Seedbox"
gcloud config set project $PROJECT_ID

# List available billing accounts and copy the ID
gcloud beta billing accounts list

# Link billing account (REPLACE WITH YOUR BILLING ACCOUNT ID)
export BILLING_ACCOUNT_ID="XXXXXX-XXXXXX-XXXXXX"

# Verify billing account status (must show 'OPEN')
gcloud beta billing accounts describe $BILLING_ACCOUNT_ID

# Link project to billing
gcloud beta billing projects link $PROJECT_ID \
  --billing-account=$BILLING_ACCOUNT_ID

# Verify billing enabled
gcloud beta billing projects describe $PROJECT_ID \
  | grep "billingEnabled"  # Should show "billingEnabled: true"
```

## 2. Enable Required APIs
```bash
gcloud services enable \
  compute.googleapis.com \
  iam.googleapis.com \
  --project=$PROJECT_ID # Is gonna take a minute

# Verify API activation (should show "STATE: ENABLED")
gcloud services list --project=$PROJECT_ID \
  --filter="config.name:compute.googleapis.com OR config.name:iam.googleapis.com"
```

## 3. Create Free-Tier Service Account
```bash
gcloud iam service-accounts create magic-seedbox \
  --description="Seedbox deployment account" \
  --display-name="magic-seedbox" \
  --project=$PROJECT_ID

# Grant compute admin role
gcloud projects add-iam-policy-binding $PROJECT_ID \
  --member="serviceAccount:magic-seedbox@$PROJECT_ID.iam.gserviceaccount.com" \
  --role="roles/compute.admin"

# Verify service account creation
gcloud iam service-accounts list --project=$PROJECT_ID \
  --filter="displayName:magic-seedbox"
```

## 4. Generate Access Key
```bash
gcloud iam service-accounts keys create magic-seedbox-key.json \
  --iam-account=magic-seedbox@$PROJECT_ID.iam.gserviceaccount.com \
  --project=$PROJECT_ID

# Verify key creation
ls -l magic-seedbox-key.json  # Should show file exists
```

## 5. Free Tier Compliance Checklist
| Resource        | Requirement                  | Verification Command                   |
|-----------------|------------------------------|----------------------------------------|
| Region          | `europe-west3`               | `gcloud compute instances list --filter="zone:europe-west3-a"` |
| Machine Type    | `e2-micro`                   | `gcloud compute instances describe <INSTANCE> --format="value(machineType)"` |
| Storage         | ≤30GB                        | `gcloud compute disks list --format="value(sizeGb)"` |
| Billing Status  | Linked & Active              | `gcloud beta billing projects describe $PROJECT_ID` |

## 6. GitHub Secrets Setup
```bash
# For Linux/Mac users: Encode magic-seedbox-key.json for GitHub
base64 -i magic-seedbox-key.json >> gcp_key_base64.txt
```
### Environment Secrets (production environment)
| Secret Name             | Where to Find                          |
|-------------------------|----------------------------------------|
| `GCP_SA_KEY`            | Contents of gcp_key_base64.txt file    |
| `CLOUDFLARE_API_TOKEN`  | Cloudflare API token (DNS:Edit perm)   |
| `CF_ZONE_ID`            | Cloudflare Zone ID for your domain     |

### Repository Variables
| Variable Name      | Example Value                |
|--------------------|------------------------------|
| `GCP_PROJECT`      | your-project-id              |
| `DOMAIN`           | example.com                  |

### How to Configure:
1. **Environment Secrets**:
   - Go to Repository Settings → Environments → production
   - Add secrets under "Environment secrets"

2. **Repository Variables**:
   - Go to Repository Settings → Secrets and variables → Actions
   - Add variables under "Variables"

### How to Find Cloudflare Zone ID:
1. Go to your Cloudflare dashboard
2. Select your domain
3. In the right sidebar under **API**, copy the **Zone ID**
---

**Troubleshooting Billing Errors**:
1. **"Billing account not open"**  
   - Verify billing account status:  
     ```bash
     gcloud beta billing accounts describe $BILLING_ACCOUNT_ID
     ```
   - Ensure account has valid payment method at [Cloud Console](https://console.cloud.google.com/billing)

2. **"Billing must be enabled"**  
   Re-run linking command:  
   ```bash
   gcloud beta billing projects link $PROJECT_ID \
     --billing-account=$BILLING_ACCOUNT_ID
   ```

3. **New Users**: Activate $300 free credit at [GCP Free Trial](https://cloud.google.com/free)

**Safety Net**: Add this to GitHub Actions workflow to auto-destroy on failure:
```yaml
- name: Destroy on Failure
  if: failure()
  run: terraform destroy -auto-approve -chdir=terraform
```