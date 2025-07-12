# Azure File Share Automation with Terraform & GitHub Actions

##  What This Does
Provisions an Azure File Share using Terraform and automates deployments with GitHub Actions.

Azure File Share allows you to mount scalable cloud-based SMB/NFS shares from Windows, Linux, or macOS.

##  Features
- Fully managed and highly available
- Supports SMB and NFS protocols
- Secure access with Azure AD
- Accessible from cloud and on-premises
- CI/CD-enabled with GitHub Actions
- Integrated Infracost cost analysis

##  Project Structure
Azure-File-Share/
├── main.tf                  # Terraform resources
├── provider.tf              # Azure provider config
├── variables.tf             # Input variable declarations
├── terraform.tfvars         # Default values
├── environments/
│   ├── dev.tfvars           # Dev-specific variables
│   ├── prod.tfvars          # Prod-specific variables
│   └── backend.tf           # Remote backend config
└── .github/
    └── workflows/
        └── deploy.yml       # GitHub Actions CI/CD

##  Generate Azure Credentials

# Run this command to generate credentials and get JSON output:
az ad sp create-for-rbac --name "ServicePrinciple-name" --role Contributor --scopes /subscriptions/$(az account show --query id -o tsv) --sdk-auth

# Copy the full JSON output and store it as a GitHub secret named:
AZURE_CREDENTIALS

##  GitHub Secrets Required
AZURE_CREDENTIALS     → Azure SP credentials in JSON format  
INFRACOST_API_KEY     → Infracost API key for cost estimation

## ☁ Remote State Backend
Configured in environments/backend.tf

Storage Account   = prathyushastateacct  
Container         = tfstate  
State File Name   = azurefileshare.tfstate  

## GitHub Actions Flow
On push to main branch:
1. Authenticate to Azure
2. Create backend storage (if needed)
3. terraform init
4. terraform plan using dev.tfvars
5. Upload plan file
6. Generate and upload Infracost report
7. Await manual approval via GitHub Environments
8. terraform apply

## Set Up Collaborators and Approvals
- GitHub > Settings > Collaborators → add your team
- GitHub > Settings > Environments → create "dev-approval"
- Add reviewers for manual terraform apply

## 🛠 How to Use

# 1. Prerequisites
- Terraform installed
- Azure CLI configured with `az login`
- Azure subscription
- GitHub Secrets set (AZURE_CREDENTIALS, INFRACOST_API_KEY)

# 2. Clone the Repo
git clone https://github.com/Pratyushaa94/Azure-File-Share.git
cd Azure-File-Share

# 3. Configure terraform.tfvars
resource_group_name   = "my-resource-group"
location              = "East US"
storage_account_name  = "prathyusha9sj2"
file_share_name       = "prathyushafileshare"
file_share_quota      = 10

# Note: storage_account_name must be globally unique & lowercase alphanumeric

##  Infracost Integration
- Cost report generated at each terraform plan
- Stored as infracost-report.txt
- Requires INFRACOST_API_KEY GitHub secret

##  Use Cases
- Shared volume for VMs or containers
- Lift-and-shift of file servers
- Cloud-accessible file storage for teams
