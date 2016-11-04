# devbox

Just a repo to setup a development box in the cloud.

Currently the terraform code will spin up a Digital Ocean box, but
it shouldn't take too much to support a number of cloud providers.

This cloud machine is intended to be ephermeral.

## Requirements

 - [Terraform](https://terraform.io/)
 - [Packer](https://packer.io)

## Setup

We need to setup a private key to ssh with:

```bash
$ ssh-keygen -f id_rsa -N=''
```

We build a new snapshot with some software already installed with `packer`:

```bash
packer build packer-templates/digitalocean-basebox.json
```

Now replace the `do_image` variable in `variables.tf with the output from the packer build.

```bash
$ terraform plan
...
$ terraform apply
...
Outputs:

  ips =
XXX.XXX.XXX.XXX
```

Now you can ssh to the machine ip that was output above:

```bash
$ ssh -i id_rsa root@<IP_FROM_ABOVE>
```

