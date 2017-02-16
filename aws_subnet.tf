resource "aws_subnet" "subnet-1a-public" {
    vpc_id                  = "${aws_vpc.main.id}"
    cidr_block              = "172.37.0.0/20"
    availability_zone       = "eu-west-1a"
    map_public_ip_on_launch = true

    tags {
        Name = "w00t"
        Terraform = "true"
    }
}

resource "aws_subnet" "subnet-1a-private-with-nat" {
    vpc_id                  = "${aws_vpc.main.id}"
    cidr_block              = "172.37.16.0/20"
    availability_zone       = "eu-west-1a"
    map_public_ip_on_launch = true

    tags {
        Name = "w00t"
        Terraform = "true"
    }
}

resource "aws_subnet" "subnet-1b-public" {
    vpc_id                  = "${aws_vpc.main.id}"
    cidr_block              = "172.37.128.0/20"
    availability_zone       = "eu-west-1b"
    map_public_ip_on_launch = true

    tags {
        Name = "w00t"
        Terraform = "true"
    }
}

resource "aws_subnet" "subnet-1b-private-with-nat" {
    vpc_id                  = "${aws_vpc.main.id}"
    cidr_block              = "172.37.144.0/20"
    availability_zone       = "eu-west-1b"
    map_public_ip_on_launch = true

    tags {
        Name = "w00t"
        Terraform = "true"
    }
}
