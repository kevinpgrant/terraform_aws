# add a nat gateway to each private subnet's route table
resource "aws_route" "private_nat_gateway_route" {
  count = "${length(compact(split(",", var.private_ranges)))}"
  route_table_id = "${element(aws_route_table.private.*.id, count.index)}"
  destination_cidr_block = "0.0.0.0/0"
  depends_on = ["aws_route_table.private"]
  nat_gateway_id = "${element(aws_nat_gateway.nat_gw.*.id, count.index)}"
}