# declare providers
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.78.0"
    }
  }
}

# call the provider
provider "azurerm" {
  features {}
}

# add resources to provision
resource "azurerm_resource_group" "cis620-rg" {
  name     = "cis620-resources"
  location = "West US"

  tags = {
    enviroment = "dev"
  }
}

resource "azurerm_virtual_network" "cis620-vn" {
  name                = "cis620-network"
  resource_group_name = azurerm_resource_group.cis620-rg.name
  location            = azurerm_resource_group.cis620-rg.location
  address_space       = ["10.123.0.0/16"]

  tags = {
    enviroment = "dev"
  }
}

resource "azurerm_subnet" "cis620-subnet" {
  name                 = "cis620-subnet"
  resource_group_name  = azurerm_resource_group.cis620-rg.name
  virtual_network_name = azurerm_virtual_network.cis620-vn.name
  address_prefixes     = ["10.123.1.0/24"]
}

resource "azurerm_network_security_group" "cis620-sg" {
  name                = "cis620-sg"
  resource_group_name = azurerm_resource_group.cis620-rg.name
  location            = azurerm_resource_group.cis620-rg.location

  tags = {
    enviroment = "dev"
  }
}

resource "azurerm_network_security_rule" "cis620-dev-rule" {
  name                        = "cis620-dev-rule"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.cis620-rg.name
  network_security_group_name = azurerm_network_security_group.cis620-sg.name
}

resource "azurerm_subnet_network_security_group_association" "cis620-sga" {
  subnet_id                 = azurerm_subnet.cis620-subnet.id
  network_security_group_id = azurerm_network_security_group.cis620-sg.id
}