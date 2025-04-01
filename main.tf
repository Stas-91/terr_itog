# Create VPC
module "vpc_dev" {
  source       = "./modules/vpc"
  network_name = var.vpc_configs.dev.network_name
  subnets      = var.vpc_configs.dev.subnets
}

# Create security group
module "security_group" {
  source              = "./modules/security_group"
  security_group_name = "example_dynamic"
  network_id          = module.vpc_dev.network_id
  folder_id           = var.folder_id
}

# # Data source for cloud-init
# data "template_file" "cloudinit" {
#   template = file("./cloud-init.tpl")
#   vars = {
#     username  = var.vm_common.username
#     ssh_key1  = var.vms_ssh_root_key
#     packages  = jsonencode(var.vm_common.packages)
#     # runcmd    = var.vm_common.runcmd
#   }
# }

# # Create VM
# module "vm" {
#   source             = "./modules/vm"
#   vm_config          = var.vm_config
#   folder_id          = var.folder_id
#   cloudinit          = data.template_file.cloudinit.rendered
#   subnet_id          = module.vpc_dev.subnet_ids["${var.vm_config.zone}"]
#   security_group_ids = [module.security_group.security_group_id]
# }

# Create MySQL cluster
module "mysql_cluster" {
  source       = "./modules/mysql_cluster"
  cluster_name = var.mysql_config.cluster_name
  network_id   = module.vpc_dev.network_id
  ha           = var.mysql_config.ha
}

# Create DB for MySQL cluster
module "mysql_db_user" {
  source        = "./modules/mysql_db_user"
  cluster_id    = module.mysql_cluster.cluster_id
  database_name = var.mysql_config.database_name
  username      = var.mysql_config.username
  password      = data.yandex_lockbox_secret_version.my_password.entries[0].text_value     # lockbox DB_PASSWORD
  user_roles    = var.mysql_config.user_roles
}

# Create container registry
resource "yandex_container_registry" "my_registry" {
  name      = var.registry_name
  folder_id = var.folder_id
}

# Create container image
resource "docker_image" "app_image" {
  name = "cr.yandex/${yandex_container_registry.my_registry.id}/my-app:latest"
  build {
    context = "./app"
    tag     = ["cr.yandex/${yandex_container_registry.my_registry.id}/my-app:latest"]
  }
}

# Push container image
resource "docker_registry_image" "app_push" {
  name = docker_image.app_image.name
}
