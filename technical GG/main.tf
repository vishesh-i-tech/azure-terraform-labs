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
  location            = "centralindia"
  virtual_network = {
    name = "vnet1"
    address_space = ["10.0.0.0/16"]
  }
  subnets = [
    {
        name = "subnet1"
        address_prefix = "10.0.1.0/24"
    },
    {
        name = "subnet2"
        address_prefix = "10.0.2.0/24"
    }
  ]
}
resource "azurerm_resource_group" "rg" {
  name     = local.resource_group_name
  location = local.location
}


resource "azurerm_virtual_network" "vnet" {
  name                = local.virtual_network.name
  location            = local.location
  resource_group_name = local.resource_group_name
  address_space       = local.virtual_network.address_space
depends_on = [
    azurerm_resource_group.rg
  ]
}
resource  "azurerm_subnet" "subnet1" {
  name                 = local.subnets[0].name
  resource_group_name  = local.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes      = [local.subnets[0].address_prefix]
    depends_on = [
    azurerm_virtual_network.vnet
  ]
}
resource  "azurerm_subnet" "subnet2" {
  name                 = local.subnets[1].name
  resource_group_name  = local.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes      = [local.subnets[1].address_prefix]
  depends_on = [
    azurerm_virtual_network.vnet
  ]
}

resource "azurerm_network_interface" "nic" {
  name                = "nic1"
  location            = local.location
  resource_group_name = local.resource_group_name

  ip_configuration {
    name                          = "internal1"
    subnet_id                     = azurerm_subnet.subnet1.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.publicip1.id
  }
  depends_on = [
    azurerm_subnet.subnet1
  ]
}

resource "azurerm_public_ip" "publicip1" {
  name                = "myfirstpublic1"
  resource_group_name = local.resource_group_name
  location            = local.location
  allocation_method   = "Static"

  tags = {
    environment = "Production"
  }
  depends_on = [
    azurerm_resource_group.rg
  ] 
}

resource "azurerm_network_security_group" "nsg" {
  name                = "nsg1"
  location            = local.location
  resource_group_name = local.resource_group_name

  security_rule {
    name                       = "rdprule"
    priority                   = 1000
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    channel = "magnum"
  }
  depends_on = [
    azurerm_resource_group.rg
  ]     

}

resource "azurerm_subnet_network_security_group_association" "nsgassociation" {
  subnet_id                 = azurerm_subnet.subnet1.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

resource "azurerm_windows_virtual_machine" "virtualmachine1" {
  name                = "tg-vm1"
  resource_group_name = local.resource_group_name
  location            = local.location
  size                = "Standard_DS1_v2"
  admin_username      = "adminuser"
  admin_password      = "P@$$w0rd1234!"
  network_interface_ids = [
    azurerm_network_interface.nic.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
  depends_on = [
 azurerm_network_interface.nic, azurerm_resource_group.rg
] 
}

resource "azurerm_managed_disk" "datadisk1" {
  name                 = "disk1"
  location             = local.location
  resource_group_name  = local.resource_group_name
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = "10"

 
}


resource "azurerm_virtual_machine_data_disk_attachment" "attachment" {
  managed_disk_id    = azurerm_managed_disk.datadisk1.id
  virtual_machine_id = azurerm_windows_virtual_machine.virtualmachine1.id
  lun                = "1"
  caching            = "ReadWrite"
}
