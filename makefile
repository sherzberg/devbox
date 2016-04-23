apply:
	terraform apply

roll:
	terraform destroy --force
	terraform apply

destroy:
	terraform destroy --force

buildbase:
	packer validate packer-templates/digitalocean-basebox.json
	packer build packer-templates/digitalocean-basebox.json
