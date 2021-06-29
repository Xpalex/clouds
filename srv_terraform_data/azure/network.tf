resource "azurerm_network_interface" "main" {
  name                = "${element(var.name_vm, count.index)}"
  count               = "${length(var.private_ip_addresses)}"
  location            = "West Europe"
  resource_group_name = azurerm_resource_group.main.name

  ip_configuration {
    name                          =  "${element(var.name_vm, count.index)}"
    public_ip_address_id          = "${element(azurerm_public_ip.main.*.id, count.index)}"
    subnet_id                     = azurerm_subnet.internal.id
    private_ip_address_allocation = "Static"    
    private_ip_address            = "${element(var.private_ip_addresses, count.index)}"
  }
}



resource "azurerm_virtual_network" "main" {
  name                = "${var.prefix}-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
}



resource "azurerm_subnet" "internal" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_public_ip" "main" {
    name                = "${element(var.name_vm, count.index)}"
    count               = "${length(var.private_ip_addresses)}"
    location            = "West Europe"
    resource_group_name = azurerm_resource_group.main.name
    allocation_method   = "Dynamic"

    tags = {
        environment = "Terraform Demo"
    }
}

data  "azurerm_public_ip"  "ansible" {
  name                 =  "${azurerm_public_ip.main.0.name}" 
  resource_group_name  =  azurerm_resource_group.main.name
}


data  "azurerm_public_ip"  "docker" {
  name                 =  "${azurerm_public_ip.main.2.name}" 
  resource_group_name  =  azurerm_resource_group.main.name
}

