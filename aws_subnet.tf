resource "aws_subnet" "subnet-public" {
    vpc_id                  = "${aws_vpc.main.id}"
    cidr_block              = "172.37.0.0/20"
    availability_zone       = "eu-west-1a"
    map_public_ip_on_launch = true

    tags {
        Name = "w00t"
        Terraform = "true"
    }
}

resource "aws_subnet" "subnet-private-with-nat" {
    vpc_id                  = "${aws_vpc.main.id}"
    cidr_block              = "172.37.16.0/20"
    availability_zone       = "eu-west-1a"
    map_public_ip_on_launch = true

    tags {
        Name = "w00t"
        Terraform = "true"
    }
}

