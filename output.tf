output "aws_db_instance.db endpoint" {
    value = "${aws_db_instance.db.endpoint}"
}

output "web-server-ip" {
  value = "${aws_instance.web-app.public_ip}"
}