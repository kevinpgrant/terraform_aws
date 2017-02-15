### these variables should be the same across all environments
# your aws secret key and access key should be in your env variables
provider "aws" {
    region = "eu-west-1"
}

variable "enable_dns_hostnames" { default = "true" }
variable "enable_dns_support" { default = "true" }
variable "ip_range" { default = "172.37.0.0/16" }

variable "region" { default = "eu-west-1" }










# variable "tf_s3_bucket" { default = "hound-terraform-state" }
# variable "master_state_file" { default = "base.tfstate" }
# variable "prod_state_file" { default = "production.tfstate" } # TODO: make init.sh use these variables
# variable "staging_state_file" { default = "staging.tfstate" }
# variable "dogfood_state_file" { default = "dogfood.tfstate" }
# variable "dev_state_file" { default = "dev.tfstate" }

# variable "azs" { default = "us-east-1a,us-east-1b,us-east-1d,us-east-1e" }
# variable "key_name" { default = "charity-keypair" }
# variable "acct_number" { default = "702835727665" } # needed for peering
