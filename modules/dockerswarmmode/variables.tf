variable "ami" {
	default = "ami-a8d2d7ce" // "ami-ed82e39e" // "ami-b4a79dd2"
}
variable "aws_account" {}
variable "aws_region" {
	default = "eu-west-1"
}
variable "key_name" {}
variable "key_path" {}
variable "subnet_ids" {
	type = "list"
}
variable "ubuntu_release" {
	default = "xenial"
}
variable "vpc_security_group_ids" {
	type = "list"
}