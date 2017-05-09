output "master_ip" {
  value = "${aws_instance.master.private_ip}"
}