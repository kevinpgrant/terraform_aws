resource "aws_db_subnet_group" "db-subnet-group" {
    name = "db-subnet-group"
    subnet_ids = [ "${aws_subnet.subnets-private.*.id}" ]
    tags {
        Name = "w00t"
        Terraform = "true"
    }
}