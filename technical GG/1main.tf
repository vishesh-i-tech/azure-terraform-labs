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
resource "azurerm_resource_group" "RG" {
  name     = "myrg"
  location = "West Europe"
}
