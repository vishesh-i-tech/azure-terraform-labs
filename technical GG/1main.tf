terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

# Provider configuration: Tells Terraform how to authenticate with Azure
provider "azurerm" {
  features {}
}

# 1. Resource Group: The parent container for your infrastructure
resource "azurerm_resource_group" "myrg" {
  name     = "myrg"
  location = "West Europe"
}

# 2. Storage Account: Linked to the Resource Group via implicit dependency
resource "azurerm_storage_account" "storage" {
  name                     = "jemini24"
  resource_group_name      = azurerm_resource_group.myrg.name
  location                 = azurerm_resource_group.myrg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
