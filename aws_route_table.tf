resource "aws_route_table" "rtb-main" {
    vpc_id     = "${aws_vpc.main.id}"

    # avoid using inline blob of routes - move to separate aws_route thingy, and associate
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.igw-main.id}"
    }

    tags {
        Name = "w00t"
        Terraform = "true"
    }
}


# for each of the private ranges, create a "private" route table.
resource "aws_route_table" "private" {
  vpc_id = "${aws_vpc.main.id}"
  count = "${length(compact(split(",", var.private_ranges)))}"
  
  tags { 
    Name = "w00t"
    Terraform = "true"
    w00t = "private_subnet_route_table_${count.index}"
  }
}