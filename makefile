
apply:
	terraform apply

roll:
	terraform destroy --force
	terraform apply
