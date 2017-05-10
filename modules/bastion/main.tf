data "terraform_remote_state" "bastion" {
  backend = "s3"

  config {
    encrypt = "true"

    bucket = "terraform-eu-west-1-${var.account_id}"
    key    = "eu-west-1/bastion/terraform.tfstate"
    region = "eu-west-1"
  }
}

module "bastion" {
  source                      = "github.com/terraform-community-modules/tf_aws_bastion_s3_keys"
  instance_type               = "t2.micro"
  ami                         = "ami-d8f4deab"
  region                      = "eu-west-1"
  iam_instance_profile        = "s3-readonly"
  s3_bucket_name              = "${var.s3_bucket_name}"                                     # for storing ssh keys, not for state!
  vpc_id                      = "${var.myvpc}"
  enable_hourly_cron_updates  = true
  associate_public_ip_address = "${var.associate_public_ip_address}"
  key_name                    = "${var.key_name}"
  eip                          = "${var.eip}"

  # subnet_ids                  = ["subnet-123456", "subnet-6789123", "subnet-321321"]
  subnet_ids = ["${var.mysubnets}"]

  #keys_update_frequency       = "5,20,35,50 * * * *"
  keys_update_frequency       = "5,20,35,50 * * * *"
  additional_user_data_script = "date"
}

variable "account_id" {}
variable "additional_user_data_script" {}
variable "associate_public_ip_address" {}
variable "eip" {}
variable "key_name" {}
variable "myvpc" {
  #  default = "vpc-deadbeef"
}
variable "mysubnets" {
  default = ["subnet-123456", "subnet-6789123", "subnet-321321"]
}
variable "s3_bucket_name" {}
variable "ssh_user" {
  default = "ubuntu"
}
variable "security_group_ids" {
  description = "Comma seperated list of security groups to apply to the bastion."
  default     = ""
}