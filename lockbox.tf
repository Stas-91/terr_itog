# Create lockbox
resource "yandex_lockbox_secret" "my_password_secret" {
  name        = "my-password-secret"
  description = "pass for MySQL"
  folder_id   = var.folder_id
}

# Add password
resource "yandex_lockbox_secret_version" "my_password_version" {
  secret_id = yandex_lockbox_secret.my_password_secret.id

  entries {
    key        = "password"           
    text_value = var.lockbox_password 
  }
}

# Get password
data "yandex_lockbox_secret_version" "my_password" {
  secret_id  = yandex_lockbox_secret.my_password_secret.id
  version_id = yandex_lockbox_secret_version.my_password_version.id
}