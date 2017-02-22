# This is an example of how to put public keys into S3 bucket and manage them in Terraform
variable "ssh_public_key_names" {
  # csv list of usernames
  # CHANGEME
  default = "example_id_rsa"
}

resource "aws_s3_bucket" "ssh_public_keys" {
  region = "eu-west-1"
  bucket = "terraform-eu-west-1-${data.aws_caller_identity.current.account_id}-bastion"
  acl    = "private"

  # CHANGEME
  policy = <<EOF
{
	"Version": "2012-10-17",
	"Statement": [
		{
			"Sid": "AddPerm",
			"Effect": "Allow",
			"Principal": {"AWS": "arn:aws:iam::123456789012:root"},
			"Action": [
				"s3:List*",
				"s3:Get*"
			],
			"Resource": [
				"arn:aws:s3:::terraform-eu-west-1-123456789012-bastion/*"
			]
		}
	]
}
EOF
}

resource "aws_s3_bucket_object" "ssh_public_keys" {
  bucket = "${aws_s3_bucket.ssh_public_keys.bucket}"
  key    = "${element(split(",", var.ssh_public_key_names), count.index)}.pub"

  # Make sure that you put files into correct location and name them accordingly (`public_keys/{keyname}.pub`)
  content = "${file("public_keys/${element(split(",", var.ssh_public_key_names), count.index)}.pub")}"
  count   = "${length(split(",", var.ssh_public_key_names))}"

  depends_on = ["aws_s3_bucket.ssh_public_keys"]
}
