resource "digitalocean_ssh_key" "docker" {
  name       = "ssh key to connect to docker hosts and manage containers"
  public_key = file("./docker.pub")
}

resource "digitalocean_ssh_key" "ruslan" {
  name       = "ruslan's"
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB+NkXLa0cvXkuV9DeM2i4+Jk7Sh/OSyxrzrD5vavyK2 ruslandoga@do"
}

resource "digitalocean_droplet" "docker" {
  region = "sgp1"
  size   = "s-1vcpu-2gb"
  image  = "docker-20-04"

  name = "docker-ubuntu-s-1vcpu-2gb-sgp1-01"
  tags = [digitalocean_tag.sin.id]

  ipv6     = true
  vpc_uuid = digitalocean_vpc.sin.id

  ssh_keys = [
    digitalocean_ssh_key.ruslan.fingerprint,
    digitalocean_ssh_key.docker.fingerprint
  ]

  graceful_shutdown = true
  backups           = false
  droplet_agent     = false
  monitoring        = false

  user_data = null

  #   user_data = <<EOF
  #   #!/bin/sh
  #   ufw deny 2375
  #   ufw deny 2376
  #   ufw limit ssh
  #   ufw allow http
  #   ufw allow https
  #   EOF
}

resource "digitalocean_reserved_ip_assignment" "docker" {
  ip_address = digitalocean_reserved_ip.docker.ip_address
  droplet_id = digitalocean_droplet.docker.id
}
