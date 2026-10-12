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

# 1. Resource Group
resource "azurerm_resource_group" "rg" {
  name     = "myrg"
  location = "West Europe"
}

resource "azurerm_resource_group" "rg1" {
  name     = "myrg1"
  location = "West Europe"
}

# 2. Network Security Group
resource "azurerm_network_security_group" "myrg" {
  name                = "myrg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# 3. Virtual Network with Subnets
resource "azurerm_virtual_network" "vnet" {
  name                = "myrg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.0.0.0/16"]

  subnet {
    name             = "subnet1"
    address_prefixes = ["10.0.1.0/24"]
  }

  subnet {
    name             = "subnet2"
    address_prefixes = ["10.0.2.0/24"]
    security_group   = azurerm_network_security_group.myrg.id
  }

  tags = {
    environment = "P1"
  }
}
