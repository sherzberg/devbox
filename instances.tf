
resource "digitalocean_ssh_key" "default" {
    name = "devbox"
    public_key = "${file("id_rsa.pub")}"
}

resource "digitalocean_droplet" "devbox" {
    image = "ubuntu-14-04-x64"
    name = "dev-${count.index}"
    count = "${var.instance_count}"
    region = "nyc2"
    size = "4gb"
    ssh_keys = ["${digitalocean_ssh_key.default.id}"]
}

resource "template_file" "setup" {
    template = "${file("${path.module}/files/setup.sh")}"
}

resource "null_resource" "setup" {
    count = "${var.instance_count}"

    triggers = {
        INSTANCES_IPS = "${join(",", digitalocean_droplet.devbox.*.ipv4_address)}"
        SETUP_SCRIPT = "${template_file.setup.rendered}"
    }

    connection {
        user = "root"
        host = "${element(digitalocean_droplet.devbox.*.ipv4_address, count.index)}"
        key_file = "id_rsa"
        timeout = "10m"
    }

    provisioner "remote-exec" {
        inline = [
            "echo \"${template_file.setup.rendered}\" > /tmp/setup.sh",
            "chmod +x /tmp/setup.sh",
            "/tmp/setup.sh",
        ]
    }

}

resource "null_resource" "ssh" {
    count = "${var.instance_count}"

    triggers = {
        INSTANCES_IPS = "${join(",", digitalocean_droplet.devbox.*.ipv4_address)}"
    }

    connection {
        user = "root"
        host = "${element(digitalocean_droplet.devbox.*.ipv4_address, count.index)}"
        key_file = "id_rsa"
        timeout = "10m"
    }

    provisioner "file" {
        source = "~/.ssh/id_rsa"
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
        user = "root"
        host = "${element(digitalocean_droplet.devbox.*.ipv4_address, count.index)}"
        key_file = "id_rsa"
        timeout = "10m"
    }

    provisioner "remote-exec" {
        inline = [
            "mkdir -p workspace"
        ]
    }

}

output "ips" {
    value = "\n${join("\n", digitalocean_droplet.devbox.*.ipv4_address)}"
}
