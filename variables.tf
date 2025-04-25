// ───────────────────────────────
// General Azure Configuration
// ───────────────────────────────
variable "az_subscription_id" {
  description = "Azure Subscription ID"
  default     = "869e8622-b827-4081-985d-857a231d0f7f"
}

variable "location" {
  description = "Azure region for all resources"
  default     = "uksouth"
}

variable "resource_group_name" {
  description = "Name of the Azure Resource Group"
  default     = "groguResourceGroup"
}

// ───────────────────────────────
// Azure Container Registry (ACR)
// ───────────────────────────────
variable "acr_name" {
  description = "Name of the Azure Container Registry"
  default     = "grogucr"
}

// ───────────────────────────────
// Container App Environment
// ───────────────────────────────
variable "container_env_name" {
  description = "Name of the Container App Environment shared by front end and API"
  default     = "grogu-container-env"
}

// ───────────────────────────────
// Front-End Container App
// ───────────────────────────────
variable "frontend_container_app_name" {
  description = "Name of the Front-End Container App"
  default     = "grogu-front-end"
}

variable "frontend_image_name" {
  description = "ACR image name for the Front-End app"
  default     = "grogu-front-end"
}

variable "frontend_image_tag" {
  description = "ACR image tag for the Front-End app"
  default     = "v1"
}

// ───────────────────────────────
// API Container App
// ───────────────────────────────
variable "api_container_app_name" {
  description = "Name of the API Container App"
  default     = "grogu-api"
}

variable "api_image_name" {
  description = "ACR image name for the API"
  default     = "grogu-api"
}

variable "api_image_tag" {
  description = "ACR image tag for the API"
  default     = "v1"
}
