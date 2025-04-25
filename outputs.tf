output "REGISTRY_LOGIN_SERVER" {
  value = azurerm_container_registry.acr.login_server
}

output "REGISTRY_USERNAME" {
  value = azurerm_container_registry.acr.admin_username
}

output "REGISTRY_PASSWORD" {
  value     = azurerm_container_registry.acr.admin_password
  sensitive = true
}
