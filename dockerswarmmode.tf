
module "dockerswarmmode" {
  source = "./modules/dockerswarmmode"

  aws_account            = "${data.aws_caller_identity.current.account_id}"
  key_name               = "${var.key_name}"
  key_path               = "${var.key_path}"
  // ["${split(",", data.terraform_remote_state.vpc.private_subnets)}"]
  subnet_ids             = ["${aws_subnet.subnets-private.*.id}"]
  // ["${data.terraform_remote_state.vpc.aws_security_group_default_id}"]
  vpc_security_group_ids = ["${aws_security_group.instance-sg.id}"]
}
