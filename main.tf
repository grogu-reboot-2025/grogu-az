provider "azurerm" {
  features {}
  subscription_id = var.az_subscription_id
}

# ───────────────────────────────
# existing RG
# ───────────────────────────────
data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

# ───────────────────────────────
# ACR
# ───────────────────────────────
resource "azurerm_container_registry" "acr" {
  name                = var.acr_name
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  sku                 = "Basic"
  admin_enabled       = true
}

# ───────────────────────────────
# UAMI
# ───────────────────────────────
resource "azurerm_user_assigned_identity" "uami" {
  name                = "grogu-uami"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
}

# ───────────────────────────────
# role assignment: AcrPull for UAMI
# ───────────────────────────────
resource "azurerm_role_assignment" "acr_pull" {
  scope                = azurerm_container_registry.acr.id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_user_assigned_identity.uami.principal_id

  depends_on = [azurerm_user_assigned_identity.uami]
}

# ───────────────────────────────
# container aps + env
# ───────────────────────────────
# resource "azurerm_container_app_environment" "env" {
#   name                = var.container_env_name
#   location            = var.location
#   resource_group_name = data.azurerm_resource_group.rg.name
# }

# resource "azurerm_container_app" "frontend" {
#   name                         = var.frontend_container_app_name
#   container_app_environment_id = azurerm_container_app_environment.env.id
#   resource_group_name          = data.azurerm_resource_group.rg.name
#   revision_mode                = "Single"

#   identity {
#     type         = "UserAssigned"
#     identity_ids = [azurerm_user_assigned_identity.uami.id]
#   }

#   registry {
#     server   = azurerm_container_registry.acr.login_server
#     identity = azurerm_user_assigned_identity.uami.id
#   }

#   template {
#     container {
#       name   = var.frontend_container_app_name
#       image  = "${azurerm_container_registry.acr.login_server}/${var.frontend_image_name}:${var.frontend_image_tag}"
#       cpu    = 0.25
#       memory = "0.5Gi"
#     }
#   }

#   ingress {
#     external_enabled = true
#     target_port      = 80

#     traffic_weight {
#       percentage      = 100
#       latest_revision = true
#     }
#   }

#   depends_on = [azurerm_role_assignment.acr_pull]
# }

# resource "azurerm_container_app" "api" {
#   name                         = var.api_container_app_name
#   container_app_environment_id = azurerm_container_app_environment.env.id
#   resource_group_name          = data.azurerm_resource_group.rg.name
#   revision_mode                = "Single"

#   identity {
#     type         = "UserAssigned"
#     identity_ids = [azurerm_user_assigned_identity.uami.id]
#   }

#   registry {
#     server   = azurerm_container_registry.acr.login_server
#     identity = azurerm_user_assigned_identity.uami.id
#   }

#   template {
#     container {
#       name   = var.api_container_app_name
#       image  = "${azurerm_container_registry.acr.login_server}/${var.api_image_name}:${var.api_image_tag}"
#       cpu    = 0.25
#       memory = "0.5Gi"
#     }
#   }

#   ingress {
#     external_enabled = true
#     target_port      = 3000

#     traffic_weight {
#       percentage      = 100
#       latest_revision = true
#     }
#   }

#   depends_on = [azurerm_role_assignment.acr_pull]
# }
