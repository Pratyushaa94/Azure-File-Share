resource "azurerm_resource_group" "example" {
  name     = var.resource_group_name
  location = var.location

  tags = {
    environment = "dev"
  }
}

resource "azurerm_storage_account" "example" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "dev"
  }
}

resource "azurerm_storage_share" "example" {
  name                 = var.file_share_name
  storage_account_name = azurerm_storage_account.example.name
  quota                = var.file_share_quota
}