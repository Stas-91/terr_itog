resource "yandex_alb_backend_group" "backend_group" {
  name = "my-backend-group"

  http_backend {
    name             = "http-backend"
    target_group_ids = [yandex_alb_target_group.target_group.id]
    port             = 5000  # Application port
  }
}

resource "yandex_alb_target_group" "target_group" {
  name = "my-target-group"

  target {
    ip_address = yandex_compute_instance.vm_with_coi.network_interface[0].ip_address
    subnet_id = module.vpc_dev.subnet_ids[var.vm_config.zone]
  }
}

resource "yandex_alb_http_router" "http_router" {
  name = "my-http-router"
}

resource "yandex_alb_virtual_host" "virtual_host" {
  name           = "my-virtual-host"
  http_router_id = yandex_alb_http_router.http_router.id

  route {
    name = "default-route"
    http_route {
      http_match {
        path {
          prefix = "/"  
        }
      }
      http_route_action {
        backend_group_id = yandex_alb_backend_group.backend_group.id  
      }
    }
  }
}

resource "yandex_alb_load_balancer" "load_balancer" {
  name       = "my-alb"
  network_id = module.vpc_dev.network_id

  listener {
    name = "http-listener"
    endpoint {
      address {
        external_ipv4_address {}        
      }
      ports = [80]  
    }
    http {
      handler {
        http_router_id = yandex_alb_http_router.http_router.id
      }
    }
  }

  allocation_policy {
    location {
      zone_id   = "ru-central1-a"
      subnet_id = module.vpc_dev.subnet_ids[var.vm_config.zone]
    }
  }
}