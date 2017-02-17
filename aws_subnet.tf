resource "aws_subnet" "subnets-public" {

    count = "${length(compact(split(",", var.public_ranges)))}"

    vpc_id                  = "${aws_vpc.main.id}"
    cidr_block              = "${element(split(",", var.public_ranges), count.index)}"
    availability_zone       = "${element(split(",", var.azs), count.index)}"

    map_public_ip_on_launch = true

    tags {
        Name = "w00t"
        Terraform = "true"
        w00t = "public_${count.index}"
    }
}

resource "aws_subnet" "subnets-private" {

    count = "${length(compact(split(",", var.private_ranges)))}"

    vpc_id                  = "${aws_vpc.main.id}"
    cidr_block              = "${element(split(",", var.private_ranges), count.index)}"
    availability_zone       = "${element(split(",", var.azs), count.index)}"

    map_public_ip_on_launch = true

    tags {
        Name = "w00t"
        Terraform = "true"
        w00t = "private_${count.index}"
    }
}

