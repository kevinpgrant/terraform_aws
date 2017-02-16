resource "aws_route_table_association" "rta-1a" {
    route_table_id = "${aws_route_table.rtb-main.id}"
    subnet_id = "${aws_subnet.subnet-public.id}"
}

resource "aws_route_table_association" "rta-1b" {
    route_table_id = "${aws_route_table.rtb-main.id}"
    subnet_id = "${aws_subnet.subnet-private-with-nat.id}"
}
