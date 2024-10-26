resource "azurerm_public_ip" "public_ip_nodejs" {
  name                = local.nodejs_server
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  domain_name_label   = local.nodejs_server
  tags = {
    environment = var.environment_tag
  }
}

resource "azurerm_network_interface" "nic_nodejs" {
  name                = local.nodejs_server
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = local.nodejs_server
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip_nodejs.id
  }
  lifecycle {
    prevent_destroy = false
  }
  tags = {
    environment = var.environment_tag
  }
}

resource "azurerm_virtual_machine" "vm_nodejs" {
  name                  = local.nodejs_server
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  network_interface_ids = [azurerm_network_interface.nic_nodejs.id]
  vm_size               = "Standard_D16as_v4"
  identity {
    type = "SystemAssigned"
  }
  delete_os_disk_on_termination    = true
  delete_data_disks_on_termination = true
  storage_os_disk {
    name              = local.nodejs_server
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  # https://documentation.ubuntu.com/azure/en/latest/azure-how-to/instances/find-ubuntu-images/
  storage_image_reference {
    publisher = "Canonical"
    offer     = "ubuntu-24_04-lts"
    sku       = "server"
    version   = "latest"
  }

  os_profile {
    computer_name  = local.nodejs_server
    admin_username = var.vm_admin_username
  }

  os_profile_linux_config {
    disable_password_authentication = true

    ssh_keys {
      path     = "/home/${var.vm_admin_username}/.ssh/authorized_keys"
      key_data = azurerm_ssh_public_key.sshkey.public_key
    }
  }

  boot_diagnostics {
    enabled     = true
    storage_uri = azurerm_storage_account.boot_diagnostics_storage_account.primary_blob_endpoint
  }

  tags = {
    environment = var.environment_tag
  }
}

resource "azurerm_virtual_machine_extension" "custom_script_nodejs" {
  name                 = "InstallNodeJS"
  virtual_machine_id   = azurerm_virtual_machine.vm_nodejs.id
  publisher            = "Microsoft.Azure.Extensions"
  type                 = "CustomScript"
  type_handler_version = "2.0"
  settings             = <<SETTINGS
        {
                "commandToExecute": "sudo apt-get update && sudo apt-get install -y nodejs npm"
        }
SETTINGS
}

# Add the Azure VM extension for AAD login
resource "azurerm_virtual_machine_extension" "aad_login_nodejs" {
  name                 = "AADLogin"
  virtual_machine_id   = azurerm_virtual_machine.vm_nodejs.id
  publisher            = "Microsoft.Azure.ActiveDirectory"
  type                 = "AADSSHLoginForLinux"
  type_handler_version = "1.0"
}