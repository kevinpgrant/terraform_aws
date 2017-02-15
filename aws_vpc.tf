resource "aws_vpc" "main" {
    cidr_block = "172.37.0.0/16"

    tags {
        Name = "w00t"
        Terraform = "true"
    }
}
