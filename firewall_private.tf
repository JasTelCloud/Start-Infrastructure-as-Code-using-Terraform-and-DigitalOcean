resource "digitalocean_firewall" "myprivate" {
  name = "private-rules"

  droplet_ids = [digitalocean_droplet.newDroplet02.id]

  inbound_rule {
    protocol         = "tcp"
    port_range       = "22"
    source_addresses = ["10.10.10.0/24"]
  }
  inbound_rule {
    protocol         = "icmp"
    source_addresses = ["10.10.10.0/24"]
  }

}