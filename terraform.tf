# When using multiple providers, you must add the required_providers block
# to declare the configuration_aliases under the Azure Provider, along with
# the source and version being used.

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.0.2"
      configuration_aliases = [
        azurerm.connectivity,
        azurerm.management,
      ]
    }
  }
  # backend "azurerm" {
  #   resource_group_name  = "tfstate"
  #   storage_account_name = "tfstateki3a2"
  #   container_name       = "tfstate"
  #   key                  = "terraform.tfstate"
  # }

}

# Declare a standard provider block using your preferred configuration.
# This will target the "default" Subscription and be used for the deployment of all "Core resources".
provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}

# Declare an aliased provider block using your preferred configuration.
# This will be used for the deployment of all "Connectivity resources" to the specified `subscription_id`.
provider "azurerm" {
  alias           = "connectivity"
  subscription_id = "3cbb78d4-282c-4907-a786-704d4c68560d"
  features {}
}

# Declare a standard provider block using your preferred configuration.
# This will be used for the deployment of all "Management resources" to the specified `subscription_id`.
provider "azurerm" {
  alias           = "management"
  subscription_id = "49b25bcb-6689-4c05-8ed0-72c6957811df"
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}

# Obtain client configuration from the un-aliased provider
data "azurerm_client_config" "core" {
  provider = azurerm
}

# Obtain client configuration from the "management" provider
data "azurerm_client_config" "management" {
  provider = azurerm.management
}

# Obtain client configuration from the "connectivity" provider
data "azurerm_client_config" "connectivity" {
  provider = azurerm.connectivity
}
