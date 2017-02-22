resource "aws_internet_gateway" "igw-main" {
  vpc_id = "${aws_vpc.main.id}"

  tags {
    Name      = "w00t"
    Terraform = "true"
  }
}
