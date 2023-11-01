# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.78.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "cis620-rg" {
  name     = "cis620-resources"
  location = "West US"
  
  tags = {
    enviroment = "dev"
  }
}

resource "azurerm_virtual_network" "cis620-vn" {
  name = "cis620-network"
  resource_group_name = azurerm_resource_group.cis620-rg.name 
  location = azurerm_resource_group.cis620-rg.location
  address_space = ["10.123.0.0/16"]

  tags = {
    enviroment = "dev"
  }
}