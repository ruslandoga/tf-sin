resource "digitalocean_database_cluster" "t_prod" {
  engine     = "pg"
  name       = "since-i-remember-you"
  node_count = 1
  region     = local.region
  size       = "db-s-1vcpu-2gb"
  tags       = [digitalocean_tag.since.id, digitalocean_tag.since_database.id]
  version    = "15"
}

resource "digitalocean_database_db" "t_prod" {
  cluster_id = digitalocean_database_cluster.t_prod.id
  name       = "t_prod"
}

resource "digitalocean_database_user" "kindersince" {
  cluster_id = digitalocean_database_cluster.t_prod.id
  name       = "kindersince"
}

resource "digitalocean_database_firewall" "t_prod" {
  cluster_id = digitalocean_database_cluster.t_prod.id

  rule {
    type  = "tag"
    value = digitalocean_tag.since_backend.id
  }
}
