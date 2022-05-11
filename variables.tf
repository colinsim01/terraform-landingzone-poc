# Use variables to customize the deployment

variable "root_id" {
  type    = string
  default = "vw"
}

variable "root_name" {
  type    = string
  default = "VolkerWessels"
}

variable "tfstate_storage_account_name" {
  type    = string
  default = "tfstate"
}

variable "tfstate_container_name" {
  type    = string
  default = "tfstate"
}

variable "tfstate_key" {
  type    = string
  default = "tfstate"
}

variable "tfstate_resource_group_name" {
  type    = string
  default = "tfstate"
}

variable "deploy_connectivity_resources" {
  type    = bool
  default = true
}

variable "deploy_management_resources" {
  type    = bool
  default = true
}

variable "log_retention_in_days" {
  type    = number
  default = 50
}

variable "security_alerts_email_address" {
  type    = string
  default = "csim@thefactory.nl" # Replace this value with your own email address.
}

variable "default_location" {
  type    = string
  default = "westeurope"
}

variable "connectivity_resources_tags" {
  type = map(string)
  default = {
    demo_type = "deploy_connectivity_resources_custom"
  }
}
