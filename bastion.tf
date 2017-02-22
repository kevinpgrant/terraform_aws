module "bastion" {
  source = "modules/bastion"

  account_id      = "${data.aws_caller_identity.current.account_id}"
  additional_user_data_script = <<EOF
REGION=$(curl -s http://169.254.169.254/latest/dynamic/instance-identity/document | grep region | awk -F\" '{print $4}')
INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
aws ec2 associate-address --region $REGION --instance-id $INSTANCE_ID --allocation-id ${aws_eip.bastion.id}
EOF
  eip             = "${aws_eip.bastion.public_ip}"
  key_name        = "${var.key_name}"
  myvpc           = "${aws_vpc.main.id}"
  mysubnets       = ["${aws_subnet.subnets-public.0.id}"]
  s3_bucket_name  = "terraform-eu-west-1-${data.aws_caller_identity.current.account_id}-bastion"
}

#If you want to assign EIP and use Route53 to bastion instance add something like this:
resource "aws_eip" "bastion" {
  vpc = true
}

resource "aws_route53_record" "bastion" {
  zone_id = "${var.hosted_zone_id}"
  name    = "bastion.${var.domain_name}"
  type    = "A"
  ttl     = "3600"
  records = ["${aws_eip.bastion.public_ip}"]
}
