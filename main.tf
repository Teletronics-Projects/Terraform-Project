terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>2.76"
    }
  }
}


provider "azurerm" {
  features {}
}

data "azurerm_key_vault_secret" "adminuser" {
  name         = "SqlAdmin"
  key_vault_id = var.adminusername
}


data "azurerm_key_vault_secret" "adminpassword" {
  name         = "Dev-VM-Password"
  key_vault_id = var.adminpassword
}
#value = data.azurerm_key_vault_secret.clientID.value


resource "azurerm_resource_group" "devRG" {
  name     = var.resource_group_name
  location = var.RGlocation
}

resource "azurerm_app_service_plan" "devserviceplan" {
  name                = "terraserviceplan"
  resource_group_name = azurerm_resource_group.devRG.name
  location            = azurerm_resource_group.devRG.location

  sku {
    tier = "Standard"
    size = "P1V2"
  }
}

resource "azurerm_app_service" "devwebapp" {
  name                = "terrawebapp"
  resource_group_name = azurerm_resource_group.devRG.name
  location            = azurerm_resource_group.devRG.location
  app_service_plan_id = azurerm_app_service_plan.devserviceplan.id

  connection_string {
    name  = "Database"
    type  = "SQLServer"
    value = azurerm_sql_server.devSqlServer.id
  }
}


resource "azurerm_storage_account" "devStrg" {
  name                     = "terrastrgacc"
  resource_group_name      = azurerm_resource_group.devRG.name
  location                 = azurerm_resource_group.devRG.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
}

resource "azurerm_sql_server" "devSqlServer" {
  name                         = "terra-sqlserver"
  resource_group_name          = azurerm_resource_group.devRG.name
  location                     = azurerm_resource_group.devRG.location
  version                      = "12.0"
  administrator_login          = data.azurerm_key_vault_secret.adminuser.value
  administrator_login_password = data.azurerm_key_vault_secret.adminpassword.value

}




