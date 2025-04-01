resource "yandex_compute_instance" "vm" {
  name        = var.vm_config.vm_name
  platform_id = var.vm_config.platform_id
  folder_id   = var.folder_id  # Теперь отдельная переменная
  zone        = var.vm_config.zone
  labels      = var.vm_config.labels

  resources {
    cores  = var.vm_config.cores
    memory = var.vm_config.memory
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.image.id
      size     = var.vm_config.disk_size
      type     = var.vm_config.disk_type
    }
  }

  network_interface {
    subnet_id          = var.subnet_id
    security_group_ids = var.security_group_ids
    nat                = var.vm_config.nat_enable
  }

  metadata = {
    serial-port-enable = var.vm_config.serial_port_enable
    user-data          = var.cloudinit  # Теперь отдельная переменная
  }

  scheduling_policy {
    preemptible = var.vm_config.preemptible
  }
}

data "yandex_compute_image" "image" {
  family = var.vm_config.image_family
}