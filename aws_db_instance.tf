resource "aws_db_instance" "db" {
  depends_on             = ["aws_security_group.db-sg"]

  identifier             = "${var.identifier}"
  allocated_storage      = "${var.storage}"
  engine                 = "${var.engine}"
  engine_version         = "${lookup(var.engine_version, var.engine)}"
  instance_class         = "${var.instance_class}"
  name                   = "${var.db_name}"
  username               = "${var.db_username}"
  password               = "${var.db_password}"

  vpc_security_group_ids = ["${aws_security_group.db-sg.id}"]

  db_subnet_group_name   = "${aws_db_subnet_group.db-subnet-group.id}"

  tags {
      Name = "w00t"
      Terraform = "true"
  }
}
