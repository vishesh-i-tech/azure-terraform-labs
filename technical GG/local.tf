terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "c10d7f17-d9e3-4bad-ae5a-bd748d701142"
}

locals {
  resource_group_name = "myrg"
  location            = "cetralindia"
}
resource "azurerm_resource_group" "rg" {
  name     = local.resource_group_name
  location = local.location
}


resource "azurerm_virtual_network" "vnet" {
  name                = "vnet1"
  location            = local.location
  resource_group_name = local.resource_group_name
  address_space       = ["10.0.0.0/16"]

  subnet {
    name           = "subnet1"
    address_prefix = "10.0.1.0/24"
  }

  subnet {
    name           = "subnet2"
    address_prefix = "10.0.2.0/24"

  }

  tags = {
    environment = "P1"
  }

  depends_on = [
    azurerm_resource_group.rg

  ]
}
