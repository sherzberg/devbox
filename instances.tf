resource "digitalocean_ssh_key" "default" {
  name       = "devbox"
  public_key = "${file("id_rsa.pub")}"
}

resource "digitalocean_droplet" "devbox" {
  image = "16944961"

  /* image    = "ubuntu-16-04-x64" */
  name     = "dev-${count.index}"
  count    = "${var.instance_count}"
  region   = "nyc3"
  size     = "4gb"
  ssh_keys = ["${digitalocean_ssh_key.default.id}"]
}

resource "null_resource" "ssh" {
  count = "${var.instance_count}"

  triggers = {
    INSTANCES_IPS = "${join(",", digitalocean_droplet.devbox.*.ipv4_address)}"
  }

  connection {
    user     = "root"
    host     = "${element(digitalocean_droplet.devbox.*.ipv4_address, count.index)}"
    key_file = "id_rsa"
    timeout  = "10m"
  }

  provisioner "file" {
    source      = "~/.ssh/id_rsa"
    destination = "~/.ssh/id_rsa"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod 600 ~/.ssh/id_rsa",
    ]
  }
}

resource "null_resource" "workspace" {
  count = "${var.instance_count}"

  triggers = {
    INSTANCES_IPS = "${join(",", digitalocean_droplet.devbox.*.ipv4_address)}"
  }

  connection {
    user     = "root"
    host     = "${element(digitalocean_droplet.devbox.*.ipv4_address, count.index)}"
    key_file = "id_rsa"
    timeout  = "10m"
  }

  provisioner "remote-exec" {
    inline = [
      "mkdir -p workspace",
    ]
  }
}

output "ips" {
  value = "${join(",", digitalocean_droplet.devbox.*.ipv4_address)}"
}
