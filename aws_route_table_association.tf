resource "aws_route_table_association" "rta-pub" {
    count = "${length(compact(split(",", var.public_ranges)))}"

    route_table_id = "${aws_route_table.rtb-main.id}"
    subnet_id = "${element(aws_subnet.subnets-public.*.id, count.index)}"
}

resource "aws_route_table_association" "rta-priv" {
    count = "${length(compact(split(",", var.private_ranges)))}"

    route_table_id = "${element(aws_route_table.private.*.id, count.index)}"
    subnet_id = "${element(aws_subnet.subnets-private.*.id, count.index)}"
}
