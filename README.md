#  Azure File Share Automation using Terraform & GitHub Actions

This project provisions an **Azure File Share** using Terraform.  
Azure File Share provides cloud-based file storage that can be mounted via SMB or NFS from **Windows**, **Linux**, or **macOS** systems.

---

##  Key Features of Azure File Share

- Fully managed and highly available
- Supports **SMB** and **NFS** protocols
- Accessible from **on-prem or cloud**
- Integrates with **Azure AD** for access control
- Scalable and secure

---

##  Project Structure

Azure-File-Share/
├── main.tf # Terraform resources
├── provider.tf # Azure provider config
├── variables.tf # Input variable declarations
├── terraform.tfvars # Default variable values
├── environments/
│ ├── dev.tfvars # Dev-specific variables
│ ├── prod.tfvars # Prod-specific variables
│ └── backend.tf # Remote state backend config
└── .github/
└── workflows/
└── deploy.yml # GitHub Actions CI/CD pipeline

yaml
Copy
Edit

---

##  Generate Azure Credentials

Use the following command to create an Azure Service Principal and get credentials in JSON format:

```bash
az ad sp create-for-rbac \
  --name "ServicePrinciple-Prathyusha" \
  --role Contributor \
  --scopes /subscriptions/$(az account show --query id -o tsv) \
  --sdk-auth
Then copy the JSON output and save it as a secret in GitHub called:

nginx
Copy
Edit
AZURE_CREDENTIALS
🔐 GitHub Secrets Required
Secret Name	Description
AZURE_CREDENTIALS	Azure SP credentials (JSON from SDK auth cmd)
INFRACOST_API_KEY	Your Infracost API key

 Remote State Configuration
The environments/backend.tf configures remote state storage in an Azure Blob container:

Property	Example Value
Storage Account	prathyushastateacct
Container	tfstate
State File Name	azurefileshare.tfstate

The pipeline ensures this is created before any terraform init.

 GitHub Actions Flow
On every push to main, GitHub Actions will:

Authenticate to Azure

Create backend storage if missing

Run terraform init

Execute terraform plan with dev.tfvars

Upload plan file

Generate Infracost breakdown report

Upload report

Await manual approval (via GitHub Environments)

Run terraform apply only after manual approval

✅ Add Collaborators & Approvals
Add Collaborators

Go to GitHub → Settings → Collaborators and teams

Add your team members as collaborators

Setup Environment Approvals

Go to GitHub → Settings → Environments → New environment

Name it (e.g., dev-approval)

Add reviewers for approval before terraform apply

🛠 How to Use
1. Prerequisites
Terraform installed

Azure CLI installed and authenticated (az login)

Azure subscription

Service Principal added to GitHub Secrets

2. Clone the Repository
bash
Copy
Edit
git clone https://github.com/Pratyushaa94/Azure-File-Share.git
cd Azure-File-Share
3. Configure Variables
Edit terraform.tfvars with:

hcl
Copy
Edit
resource_group_name   = "my-resource-group"
location              = "East US"
storage_account_name  = "prathyusha9sj2"
file_share_name       = "prathyushafileshare"
file_share_quota      = 10
 Storage account names must be globally unique and use only lowercase letters and numbers.

4. Initialize Terraform
bash
Copy
Edit
terraform init
5. Review the Execution Plan
bash
Copy
Edit
terraform plan
6. Apply the Configuration
bash
Copy
Edit
terraform apply
Type yes when prompted to confirm.

7. (Optional) Destroy Resources
bash
Copy
Edit
terraform destroy
 Infracost Integration
Infracost shows you how much your Azure infrastructure will cost before applying it.

GitHub Actions generates a cost estimate report (infracost-report.txt) on every terraform plan.

 Use Cases
Shared storage for apps running across VMs

Lift-and-shift file shares from on-prem to cloud

Centralized file storage for remote teams
