# Azure-File-Share

This project provisions an Azure File Share using Terraform.

## Files

- `provider.tf` – Configures the Azure provider.
- `main.tf` – Declares the resource group, storage account, and file share.
- `variables.tf` – Defines input variables.
- `terraform.tfvars` – Sets variable values.

## Usage

1. **Initialize Terraform**
   ```powershell
   terraform init
   ```

2. **Plan the deployment**
   ```powershell
   terraform plan
   ```

3. **Apply the configuration**
   ```powershell
   terraform apply
   ```

4. **Destroy resources (optional)**
   ```powershell
   terraform destroy
   ```

## Variables

You can customize the deployment by editing `terraform.tfvars`:

```hcl
resource_group_name   = "my-resource-group"
location              = "East US"
storage_account_name  = "mystorageacct123"
file_share_name       = "myfileshare"
file_share_quota      = 10
```

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html)
- An Azure subscription
- Azure CLI authenticated (`az login`)