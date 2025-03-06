terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.100.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "~>3.2.2"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.6.1"
    }
  }
  # backend "azurerm" {}
  backend "local" {}
}

provider "azurerm" {
  tenant_id          = var.tenant_id
  subscription_id    = var.subscription_id
  client_id          = var.client_id
  client_secret      = var.client_secret
  use_oidc           = var.use_oidc
  oidc_request_token = var.oidc_request_token
  oidc_request_url   = var.oidc_request_url
  features {
    log_analytics_workspace {
      permanently_delete_on_destroy = true
    }
    key_vault {
      recover_soft_deleted_key_vaults = true
      purge_soft_delete_on_destroy    = false
    }
    template_deployment {
      # Bug: https://github.com/hashicorp/terraform-provider-azurerm/issues/14810
      # When you edit these area of your teraform code:
      #   - name of `azurerm_resource_group_template_deployment`
      #   - name of `Deployment`
      #   - name of `softwareUpdateConfigurations`
      # Please:
      #    1) Go to `resource group` then select `Deployment`.
      #    2) Delete the deployment with the name of `azurerm_resource_group_template_deployment` resource.
      #    3) Then manually delete resource created from the `Deployment`
      #    4) `terraform apply` to recreate `Deployment` and its resources.
      delete_nested_items_during_deletion = false
    }
  }
}

provider "null" {
  # Configuration options
}

provider "random" {
  # Configuration options
}
