# Map each module provider to their corresponding `azurerm` provider using the providers input object
module "enterprise_scale" {
  source  = "Azure/caf-enterprise-scale/azurerm"
  version = "2.0.1"

  providers = {
    azurerm              = azurerm
    azurerm.connectivity = azurerm.connectivity
    azurerm.management   = azurerm.management
  }

  root_parent_id = data.azurerm_client_config.core.tenant_id
  root_id        = var.root_id
  root_name      = var.root_name
  library_path   = "${path.root}/lib"

  deploy_management_resources    = var.deploy_management_resources
  configure_management_resources = local.configure_management_resources
  subscription_id_management     = data.azurerm_client_config.management.subscription_id

  deploy_connectivity_resources    = var.deploy_connectivity_resources
  configure_connectivity_resources = local.configure_connectivity_resources
  subscription_id_connectivity     = data.azurerm_client_config.connectivity.subscription_id

  custom_landing_zones = {
    "vw-production" = {
      display_name               = "Production"
      parent_management_group_id = "${var.root_id}-landing-zones"
      subscription_ids           = ["1b4c4c87-616f-4256-aa10-b614c43a6f8f"]
      archetype_config = {
        archetype_id = "production_internal"
        parameters = {
          Deny-Resource-Locations = {
            listOfAllowedLocations = ["westeurope", ]
          }
          Deny-RSG-Locations = {
            listOfAllowedLocations = ["westeurope", ]
          }
        }
        access_control = {}
      }
    }
  }

  # remote state storage

  # demo workload
}
