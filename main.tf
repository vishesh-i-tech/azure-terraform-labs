terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

# 1. Create a Resource Group (Mandatory logical container in Azure)
resource "azurerm_resource_group" "my_rg" {
  name     = "my-first-rg"
  location = "East US" # Equivalent to AWS 'region' (e.g., us-east-1)
}

# 2. Create a Virtual Network (Equivalent to AWS VPC)
resource "azurerm_virtual_network" "my_vnet" {
  name                = "my-vnet"
  address_space       = ["10.0.0.0/16"] # Equivalent to AWS VPC CIDR block
  location            = azurerm_resource_group.my_rg.location
  resource_group_name = azurerm_resource_group.my_rg.name
}

# 3. Create a Subnet (Equivalent to AWS Subnet)
resource "azurerm_subnet" "my_subnet" {
  name                 = "my-subnet"
  resource_group_name  = azurerm_resource_group.my_rg.name
  virtual_network_name = azurerm_virtual_network.my_vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

# 4. Create a Public IP Address (Equivalent to AWS Elastic IP / Auto-assigned Public IP)
resource "azurerm_public_ip" "my_ip" {
  count          = 2 # create 2 public ips 
  name                = "my-vm-ip-${count.index}"
  resource_group_name = azurerm_resource_group.my_rg.name
  location            = azurerm_resource_group.my_rg.location
  allocation_method   = "Static" # Options: "Static"
}

# 5. Create a Network Interface Card / NIC (Equivalent to AWS Elastic Network Interface - ENI)
resource "azurerm_network_interface" "my_nic" {
  count = 2 # create 2 NICs 
  name                = "my-nic-${count.index}"
  location            = azurerm_resource_group.my_rg.location
  resource_group_name = azurerm_resource_group.my_rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.my_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.my_ip[count.index].id
  }
}

# 6. Create a Virtual Machine (Equivalent to AWS EC2 Instance)
resource "azurerm_linux_virtual_machine" "my_vm" {
  count = 2
  name                = "my-linux-vm-${count.index}"
  resource_group_name = azurerm_resource_group.my_rg.name
  location            = azurerm_resource_group.my_rg.location
  size                = "Standard_B1s" # Equivalent to AWS 'instance_type' (e.g., t2.micro)
  admin_username      = "adminuser"

  # Attach the Network Interface (NIC)
  network_interface_ids = [
    azurerm_network_interface.my_nic[count.index].id,
  ]

  # SSH Key configuration (Equivalent to AWS 'key_name')
  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/id_rsa.pub") # Path to your local public SSH key
  }

  # Root OS Disk (Equivalent to AWS 'root_block_device')
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS" # Storage tier: Standard HDD/SSD (Equivalent to AWS gp2/gp3)
  }

  # OS Image Reference (Equivalent to AWS AMI)
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}
