terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      version = ">= 0.61.0"
    }

    aws = {
      source  = "hashicorp/aws"
      version = "> 5.1"
    }

    docker = {
      source  = "kreuzwerker/docker"
      version = ">= 3.0.0"  # Укажите нужную версию
    }
  }
  required_version = "~>1.8.4"
}

provider "yandex" {
  token                    = var.token
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  # service_account_key_file = file("~/.authorized_key.json")
  zone                     = var.default_zone
}

provider "aws" {
  region                      = "us-east-1"
  skip_credentials_validation = true
  skip_requesting_account_id  = true
  skip_metadata_api_check     = true
  access_key                  = "mock_access_key"
  secret_key                  = "mock_secret_key"
}

provider "docker" {
  registry_auth {
    address  = "cr.yandex"
    username = "oauth"
    password = var.token
  }
}