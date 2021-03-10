resource "azurerm_resource_group" "rg" {
  name     = var.rgname
  location = var.rgloc
}

resource "azurerm_kubernetes_cluster" "kubweb" {

  name                = var.cluster_name
  location            = var.rgloc
  resource_group_name = var.rgname
  dns_prefix          = "${var.cluster_name}-dns"

  # used to group all the internal objects of this cluster
  node_resource_group = "${var.cluster_name}-rg-node"

  # azure will assign the id automatically
  identity {
    type = "SystemAssigned"
  }

  default_node_pool {
    name                 = "nodepool1"
    node_count           = 1
    vm_size              = var.vm_size
  }

  role_based_access_control {
    enabled = true
  }

  depends_on = [
    azurerm_resource_group.rg 
  ]

  tags = {
    environment = var.env
  }
}


resource "azurerm_container_registry" "acr" {
  name                = "homeworkacr"
  resource_group_name = var.rgname
  location            = var.rgloc
  sku                 = "Standard"
  admin_enabled       = true

  tags = {
    environment = var.env
  }
}

# add the role to the identity the kubernetes cluster was assigned
resource "azurerm_role_assignment" "kubweb_to_acr" {
  scope                = azurerm_container_registry.acr.id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_kubernetes_cluster.kubweb.kubelet_identity[0].object_id
}
