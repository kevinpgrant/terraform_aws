output "aws_db_instance.db endpoint" {
  value = "${aws_db_instance.db.endpoint}"
}

output "web-server-ip" {
  value = "${aws_instance.web-app.public_ip}"
}

data "aws_caller_identity" "current" {}

output "aws_account_id" {
  value = "${var.account_id}"
}