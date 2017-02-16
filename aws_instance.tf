resource "aws_instance" "web-app" {
  instance_type = "t2.micro"

  # Lookup the correct AMI based on the region
  # we specified
  ami = "${lookup(var.aws_amis, var.region)}"

  # The name of our SSH keypair you've created and downloaded
  # from the AWS console.
  #
  # https://console.aws.amazon.com/ec2/v2/home?region=us-west-2#KeyPairs:
  #
  key_name = "${var.key_name}"

  # Our Security group to allow HTTP and SSH access
  vpc_security_group_ids = ["${aws_security_group.instance-sg.id}"]
  subnet_id              = "${aws_subnet.subnet-1a-public.id}"
  user_data              = "${file("userdata.sh")}"

  #Instance tags

  tags {
    Name = "w00t"
    Terraform = "true"
  }
}
