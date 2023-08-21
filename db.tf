# TODO uncomment to enable
# resource "digitalocean_database_cluster" "postgres" {
#   count      = local.count
#   engine     = "pg"
#   name       = "since-i-remember-you"
#   node_count = 1
#   region     = local.region
#   size       = "db-s-1vcpu-2gb"
#   tags       = [digitalocean_tag.since.id, digitalocean_tag.since_database.id]
#   version    = "15"
# }

# resource "digitalocean_database_db" "t_prod" {
#   cluster_id = digitalocean_database_cluster.postgres.id
#   name       = "t_prod"
# }

# resource "digitalocean_database_user" "kindersince" {
#   cluster_id = digitalocean_database_cluster.postgres.id
#   name       = "kindersince"
# }

# resource "digitalocean_database_firewall" "postgres" {
#   cluster_id = digitalocean_database_cluster.postgres.id

#   # TODO remove :)
#   # ruslan at punspace
#   rule {
#     type  = "ip_addr"
#     value = "183.88.135.238"
#   }

#   rule {
#     type  = "tag"
#     value = "since"
#   }
# }
