# Resource Group
resource "azurerm_resource_group" "rg" {
    location = "polandcentral"
    name = "${random_pet.prefix.id}-rg"
}