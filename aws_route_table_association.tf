resource "aws_route_table_association" "rta-1a-pub" {
    route_table_id = "${aws_route_table.rtb-main.id}"
    subnet_id = "${aws_subnet.subnet-1a-public.id}"
}

resource "aws_route_table_association" "rta-1a-priv" {
    route_table_id = "${aws_route_table.rtb-main.id}"
    subnet_id = "${aws_subnet.subnet-1a-private-with-nat.id}"
}

resource "aws_route_table_association" "rta-1b-pub" {
    route_table_id = "${aws_route_table.rtb-main.id}"
    subnet_id = "${aws_subnet.subnet-1b-public.id}"
}

resource "aws_route_table_association" "rta-1b-priv" {
    route_table_id = "${aws_route_table.rtb-main.id}"
    subnet_id = "${aws_subnet.subnet-1b-private-with-nat.id}"
}
