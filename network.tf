resource "digitalocean_vpc" "since_fra1" {
  name        = "since"
  region      = "fra1"
  ip_range    = "10.0.1.0/24"
  description = "getsince.app fra1 vpc"
}

resource "digitalocean_firewall" "docker" {
  name = "since"
  tags = [digitalocean_tag.since_backend.id]

  # allow pings
  inbound_rule {
    protocol         = "icmp"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  # allow ssh
  inbound_rule {
    port_range       = "22"
    protocol         = "tcp"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  # allow https
  inbound_rule {
    port_range       = "443"
    protocol         = "tcp"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  # allow http
  inbound_rule {
    port_range       = "80"
    protocol         = "tcp"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "icmp"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    port_range            = "all"
    protocol              = "tcp"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    port_range            = "all"
    protocol              = "udp"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
}
