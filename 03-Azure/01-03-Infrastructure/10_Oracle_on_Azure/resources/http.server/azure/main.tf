locals {
  nodejs_server = "${var.prefix}nodejs"
  oracle_server = "${var.prefix}oracle"
}

resource "azurerm_resource_group" "rg" {
  name     = var.prefix
  location = var.location
}

resource "azurerm_virtual_network" "vnet" {
  name                = var.prefix
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  tags = {
    environment = var.environment_tag
  }
}

resource "azurerm_subnet" "subnet" {
  name                 = var.prefix
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_network_security_group" "nsg" {
  name                = var.prefix
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = var.my_ip
    destination_address_prefix = "*"
  }
  tags = {
    environment = var.environment_tag
  }
}

resource "azurerm_subnet_network_security_group_association" "subnet_nsg_association" {
  subnet_id                 = azurerm_subnet.subnet.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

resource "azurerm_storage_account" "boot_diagnostics_storage_account" {
  name                     = "${var.prefix}diag"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags = {
    environment = var.environment_tag
  }
}

resource "azurerm_storage_container" "boot_diagnostics_container" {
  name                  = "bootdiagnostics"
  storage_account_name  = azurerm_storage_account.boot_diagnostics_storage_account.name
  container_access_type = "private"
}

resource "azurerm_ssh_public_key" "sshkey" {
  name                = var.prefix
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  public_key          = var.ssh_vm_public_key
  tags = {
    environment = var.environment_tag
  }
}

# Create a role assignment to allow AAD users to SSH into the VM
resource "azurerm_role_assignment" "vm_ssh_access" {
  principal_id         = data.azurerm_client_config.current.object_id
  role_definition_name = "Virtual Machine Administrator Login"
  scope                = azurerm_virtual_machine.vm_nodejs.id
}

# data "azurerm_client_config" "current": This data source retrieves information about the current Azure client, including the object ID.
data "azurerm_client_config" "current" {}

