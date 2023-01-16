terraform {
  required_version = ">=1.3"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.31.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~>2.16.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~>2.7.1"
    }
  }

 backend "azurerm" {
        resource_group_name  = "tfstate"
        storage_account_name = "cinematfstate"
        container_name       = "tfstate"
        key                  = "terraform.tfstate"
    }

}

provider "azurerm" {
  skip_provider_registration = true
  features {}
}
