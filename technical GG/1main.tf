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

# Resource block: Creates the Resource Group in Azure
resource "azurerm_resource_group" "myrg" {
  name     = "myrg"
  location = "West Europe"
}


resource "azurerm_storage_account" "storage" {
  name                     = "jemini24"
  resource_group_name      = "myrg"
  location                 = "West Europe"
  account_tier             = "Standard"
  account_replication_type = "LRS"

}

