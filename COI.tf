# Declare COI
data "yandex_compute_image" "coi" {
  family = "container-optimized-image"
}

# Create VM with COI
resource "yandex_compute_instance" "vm_with_coi" {
  name        = "coi-vm"
  platform_id = var.vm_config.platform_id
  zone        = var.vm_config.zone

  resources {
    cores  = var.vm_config.cores
    memory = var.vm_config.memory
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.coi.id
    }
  }

  network_interface {
    subnet_id = module.vpc_dev.subnet_ids[var.vm_config.zone]
    security_group_ids = [module.security_group.security_group_id]
    nat       = var.vm_config.nat_enable
  }

  # Metadata for COI app
  metadata = {
    docker-container-declaration = templatefile("${path.module}/declaration.tpl", {
      container_image = "cr.yandex/${yandex_container_registry.my_registry.id}/my-app:latest"
      privileged      = "false"
      db_host         = module.mysql_cluster.host_names[0]     
      db_user         = var.mysql_config.username               
      db_password     = data.yandex_lockbox_secret_version.my_password.entries[0].text_value      # lockbox DB_PASSWORD
      db_name         = var.mysql_config.database_name             
    })
    user-data = templatefile("${path.module}/cloud_config.tpl", {
      username  = var.vm_common.username        
      ssh_key1  = var.vms_ssh_root_key          
    })
  }

  depends_on = [
    yandex_container_registry.my_registry,
    docker_image.app_image,
    docker_registry_image.app_push,
    module.mysql_cluster
  ]

}