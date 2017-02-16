resource "aws_db_subnet_group" "db-subnet-group" {
    name = "db-subnet-group"
    subnet_ids = ["${aws_subnet.subnet-1a-private-with-nat.id}", "${aws_subnet.subnet-1b-private-with-nat.id}"]
    tags {
        Name = "w00t"
        Terraform = "true"
    }
}