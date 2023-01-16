resource "azurerm_resource_group" "rg" {
  location = var.resource_group_location
  name     = var.resource_group_name
}


resource "azurerm_kubernetes_cluster" "cinema_cluster" {
  name                = "cinema-aks"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "cinemaaks"
  sku_tier            = "Free"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "standard_ds2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Development"
  }
}

module "setup_gitops" {
  source = "./argocd"
  providers = {
    helm = helm
  }
}
