variable "resource_group_name" {
  default = "TerraformDevEnv"
}
variable "RGlocation" {
  default = "West US"
}

variable "adminusername" {
  default = "/subscriptions/620830f5-7bad-46de-b40b-e54b75b8bb6b/resourceGroups/AzureTerraform/providers/Microsoft.KeyVault/vaults/Azure-Tenant-Keys"
}

variable "adminpassword" {
  default = "/subscriptions/620830f5-7bad-46de-b40b-e54b75b8bb6b/resourceGroups/AzureTerraform/providers/Microsoft.KeyVault/vaults/VMsecretkv"
}


