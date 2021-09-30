terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "2.11.1"
    }
  }
}

variable "do_token" {}

provider "digitalocean" {
  token = var.do_token
}

resource "digitalocean_ssh_key" "mykey01" {
  name       = "mykeyname"
  public_key = file("~/.ssh/id_rsa.pub")
}

// vpc
resource "digitalocean_vpc" "vpc01" {
  name     = "myvpc01"
  region   = "sgp1"
  ip_range = "10.10.10.0/24"
}

// vm01
resource "digitalocean_droplet" "myDroplet01" {
  image    = "ubuntu-18-04-x64"
  name     = "myDroplet01"
  region   = "sgp1"
  size     = "s-1vcpu-1gb"
  ssh_keys = [digitalocean_ssh_key.mykey01.fingerprint]
  vpc_uuid = digitalocean_vpc.vpc01.id
}

// vm02
resource "digitalocean_droplet" "newDroplet02" {
  image    = "ubuntu-20-04-x64"
  name     = "newDroplet02"
  region   = "sgp1"
  size     = "s-2vcpu-2gb"
  ssh_keys = [digitalocean_ssh_key.mykey01.fingerprint]
  vpc_uuid = digitalocean_vpc.vpc01.id
}
