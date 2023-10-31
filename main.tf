# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "cis620-rg" {
  name     = "cis620-resources"
  location = "East Us"
  tags = {
    enviroment = "dev"
  }
}