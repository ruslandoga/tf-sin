resource "digitalocean_database_cluster" "postgres" {
  engine     = "pg"
  name       = "db-postgresql-sgp1-31387"
  node_count = 2
  region     = "sgp1"
  size       = "db-s-1vcpu-2gb"
  tags       = [digitalocean_tag.sin.id]
  version    = "15"
}

resource "digitalocean_database_db" "since_prod" {
  cluster_id = digitalocean_database_cluster.postgres.id
  name       = "since_prod"
}

resource "digitalocean_database_user" "since_client" {
  cluster_id = digitalocean_database_cluster.postgres.id
  name       = "since_client"
}
