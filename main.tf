# Resource Group
resource "azurerm_resource_group" "rg" {
    location = var.resource_group_location
    name = "${random_pet.prefix.id}-rg"
}

resource "random_pet" "prefix" {
    prefix = var.resource_group_name_prefix
    length = 1
}

resource "azurerm_virtual_network" "my_terraform_network" {
    name = "${random_pet.prefix.id}-vnet"
    address_space = ["10.0.0.0/16"]
    location = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "my_terraform_subnet_1"{
    name = "AzureBastionSubnet"
    resource_group_name = azurerm_resource_group.rg.name
    virtual_network_name = azurerm_virtual_network.my_terraform_network.name
    address_prefixes = ["10.0.0.0/24"]
}

resource "azurerm_subnet" "my_terraform_subnet_2" {
    name = "${random_pet.prefix.id}-subnet"
    resource_group_name = azurerm_resource_group.rg.name
    virtual_network_name = azurerm_virtual_network.my_terraform_network.name
    address_prefixes = ["10.0.1.0/24"]
}