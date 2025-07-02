variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
  default     = "example-resources"
}

variable "location" {
  description = "The Azure location"
  type        = string
  default     = "East US"
}

variable "storage_account_name" {
  description = "The name of the storage account"
  type        = string
  default     = "examplestorageacct"
}

variable "file_share_name" {
  description = "The name of the file share"
  type        = string
  default     = "examplefileshare"
}

variable "file_share_quota" {
  description = "The quota for the file share in GB"
  type        = number
  default     = 5
}