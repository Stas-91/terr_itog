## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~>1.8.4 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | > 5.1 |
| <a name="requirement_docker"></a> [docker](#requirement\_docker) | >= 3.0.0 |
| <a name="requirement_yandex"></a> [yandex](#requirement\_yandex) | >= 0.61.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_docker"></a> [docker](#provider\_docker) | 3.0.2 |
| <a name="provider_yandex"></a> [yandex](#provider\_yandex) | 0.139.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_mysql_cluster"></a> [mysql\_cluster](#module\_mysql\_cluster) | ./modules/mysql_cluster | n/a |
| <a name="module_mysql_db_user"></a> [mysql\_db\_user](#module\_mysql\_db\_user) | ./modules/mysql_db_user | n/a |
| <a name="module_security_group"></a> [security\_group](#module\_security\_group) | ./modules/security_group | n/a |
| <a name="module_vpc_dev"></a> [vpc\_dev](#module\_vpc\_dev) | ./modules/vpc | n/a |

## Resources

| Name | Type |
|------|------|
| [docker_image.app_image](https://registry.terraform.io/providers/kreuzwerker/docker/latest/docs/resources/image) | resource |
| [docker_registry_image.app_push](https://registry.terraform.io/providers/kreuzwerker/docker/latest/docs/resources/registry_image) | resource |
| [yandex_alb_backend_group.backend_group](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/alb_backend_group) | resource |
| [yandex_alb_http_router.http_router](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/alb_http_router) | resource |
| [yandex_alb_load_balancer.load_balancer](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/alb_load_balancer) | resource |
| [yandex_alb_target_group.target_group](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/alb_target_group) | resource |
| [yandex_alb_virtual_host.virtual_host](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/alb_virtual_host) | resource |
| [yandex_compute_instance.vm_with_coi](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/compute_instance) | resource |
| [yandex_container_registry.my_registry](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/container_registry) | resource |
| [yandex_lockbox_secret.my_password_secret](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/lockbox_secret) | resource |
| [yandex_lockbox_secret_version.my_password_version](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/lockbox_secret_version) | resource |
| [yandex_compute_image.coi](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/data-sources/compute_image) | data source |
| [yandex_lockbox_secret_version.my_password](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/data-sources/lockbox_secret_version) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cloud_id"></a> [cloud\_id](#input\_cloud\_id) | https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id | `string` | n/a | yes |
| <a name="input_default_zone"></a> [default\_zone](#input\_default\_zone) | https://cloud.yandex.ru/docs/overview/concepts/geo-scope | `string` | `"ru-central1-a"` | no |
| <a name="input_folder_id"></a> [folder\_id](#input\_folder\_id) | https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id | `string` | n/a | yes |
| <a name="input_lockbox_password"></a> [lockbox\_password](#input\_lockbox\_password) | Password for the lockbox | `string` | n/a | yes |
| <a name="input_mysql_config"></a> [mysql\_config](#input\_mysql\_config) | MySQL Configuration | `map` | <pre>{<br/>  "cluster_name": "example",<br/>  "database_name": "test",<br/>  "ha": false,<br/>  "password": "Qwerty123",<br/>  "user_roles": [<br/>    "ALL"<br/>  ],<br/>  "username": "app"<br/>}</pre> | no |
| <a name="input_registry_name"></a> [registry\_name](#input\_registry\_name) | Registry name (unique, 3-63 characters, lowercase letters, numbers, and hyphens only) | `string` | `"my-registry1"` | no |
| <a name="input_token"></a> [token](#input\_token) | OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token | `string` | n/a | yes |
| <a name="input_vm_common"></a> [vm\_common](#input\_vm\_common) | VM Common Configurations | `map` | <pre>{<br/>  "packages": [<br/>    "vim"<br/>  ],<br/>  "username": "ubuntu"<br/>}</pre> | no |
| <a name="input_vm_config"></a> [vm\_config](#input\_vm\_config) | Configuration object for the virtual machine | <pre>object({<br/>    vm_name            = string<br/>    platform_id        = string<br/>    zone               = string<br/>    labels             = map(string)<br/>    cores              = number<br/>    memory             = number<br/>    disk_size          = number<br/>    disk_type          = string<br/>    nat_enable         = bool<br/>    serial_port_enable = number<br/>    image_family       = string<br/>    preemptible        = bool<br/>  })</pre> | <pre>{<br/>  "cores": 2,<br/>  "disk_size": 10,<br/>  "disk_type": "network-ssd",<br/>  "image_family": "ubuntu-2004-lts",<br/>  "labels": {},<br/>  "memory": 2,<br/>  "nat_enable": true,<br/>  "platform_id": "standard-v3",<br/>  "preemptible": true,<br/>  "serial_port_enable": 0,<br/>  "vm_name": "my-vm",<br/>  "zone": "ru-central1-a"<br/>}</pre> | no |
| <a name="input_vms_ssh_root_key"></a> [vms\_ssh\_root\_key](#input\_vms\_ssh\_root\_key) | SSH Configurations | `string` | n/a | yes |
| <a name="input_vpc_configs"></a> [vpc\_configs](#input\_vpc\_configs) | VPC Configurations | `map` | <pre>{<br/>  "dev": {<br/>    "network_name": "develop",<br/>    "subnets": [<br/>      {<br/>        "cidr": "10.0.1.0/24",<br/>        "zone": "ru-central1-a"<br/>      }<br/>    ]<br/>  },<br/>  "prod": {<br/>    "network_name": "production",<br/>    "subnets": [<br/>      {<br/>        "cidr": "10.1.1.0/24",<br/>        "zone": "ru-central1-a"<br/>      },<br/>      {<br/>        "cidr": "10.1.2.0/24",<br/>        "zone": "ru-central1-b"<br/>      },<br/>      {<br/>        "cidr": "10.1.3.0/24",<br/>        "zone": "ru-central1-d"<br/>      }<br/>    ]<br/>  }<br/>}</pre> | no |

## Outputs

No outputs.
