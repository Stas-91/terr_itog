resource "yandex_mdb_mysql_database" "db" {
  cluster_id = var.cluster_id
  name       = var.database_name
}

resource "yandex_mdb_mysql_user" "user" {
  cluster_id = var.cluster_id
  name       = var.username
  password   = var.password

  permission {
    database_name = yandex_mdb_mysql_database.db.name
    roles         = var.user_roles
  }
}