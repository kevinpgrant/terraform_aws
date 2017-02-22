### these variables should be the same across all environments
# your aws secret key and access key should be in your env variables

variable "enable_dns_hostnames" { default = "true" }
variable "enable_dns_support" { default = "true" }

variable "region" {
  default = "eu-west-1"
}

variable "azs" {
  default = "eu-west-1a,eu-west-1b"
}

variable "key_name" {
    default = "example-keypair"
    description = "the name of the key file"
}

# ubuntu-16.04 ebs ssd (x64)
variable "aws_amis" {
  default = {
    "eu-west-1" = "ami-d8f4deab"
  }
}

variable "current_profile" {
  default = "default"
}

variable "shared_creds_file" {
  default = "/Users/nevyn/.aws/credentials"
}

variable "vpc_cidr" {
  default = "172.37.0.0/16"
}

variable "public_ranges" {
  default = "172.37.0.0/20,172.37.128.0/20"
}

variable "private_ranges" {
  default = "172.37.16.0/20,172.37.144.0/20"
}

variable "db_name" {
  default = "mydb1"
}

variable "db_username" {
  default = "testuser"
}

variable "db_password" {
  default = "testpassword"
}

variable "engine_version" {
  description = "Engine version"

  default = {
    mysql    = "5.6.22"
    postgres = "9.4.1"
  }
}

variable "storage" {
  default     = "10"
  description = "Storage size in GB"
}

variable "engine" {
  description = "Engine type, example values mysql, postgres"
  default     = "mysql"
}

variable "identifier" {
  default     = "mydb-rds"
  description = "Identifier for your DB"
}

variable "instance_class" {
  default     = "db.t2.micro"
  description = "Instance class"
}