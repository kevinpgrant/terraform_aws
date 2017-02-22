# Our elb security group to access
# the ELB over HTTP
resource "aws_security_group" "elb-sg" {
  name        = "elb_sg"
  description = "Security Group for web app ELB ingress"

  vpc_id = "${aws_vpc.main.id}"

  # HTTP access from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # ensure the VPC has an Internet gateway or this step will fail
  depends_on = ["aws_internet_gateway.igw-main"]
}

# Our default security group to access
# the instances over SSH and HTTP
resource "aws_security_group" "instance-sg" {
  name        = "instance_sg"
  description = "Security Group for direct web app instance ingress"
  vpc_id      = "${aws_vpc.main.id}"

  # SSH access from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTP access from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

/*
  Database Servers
*/
resource "aws_security_group" "db-sg" {
  name        = "sg_db"
  description = "Allow incoming database connections."

  ingress {
    from_port       = 3306                                     # MySQL
    to_port         = 3306
    protocol        = "tcp"
    security_groups = ["${aws_security_group.instance-sg.id}"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.vpc_cidr}"]
  }

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["${var.vpc_cidr}"]
  }

  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id = "${aws_vpc.main.id}"

  tags {
    Name      = "w00t"
    Terraform = "true"
  }
}
