terraform {
  backend "s3" {
    bucket         = "simple-bucket-iqz461d3"
    key            = "16itog/terraform.tfstate"
    region         = "ru-central1"
endpoints = {
      s3       = "https://storage.yandexcloud.net"
      dynamodb = "https://docapi.serverless.yandexcloud.net/ru-central1/b1g8ta6qu7na0ir2khnv/etnld6anrv93cf3cfqfe"
    }
    dynamodb_table = "tfstate-lock-develop"
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_requesting_account_id  = true
  }
}