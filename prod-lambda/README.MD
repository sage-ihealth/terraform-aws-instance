
# Deploy Lambda 

## terraform init

## terraform apply
To set lots of variables, it is more convenient to specify their values in a variable definitions file (with a filename ending in either .tfvars or .tfvars.json) and then specify that file on the command line with -var-file:
terraform apply -var-file="terraform.tfvars"

variables.tf connects terraform.tfvars to main.tf

