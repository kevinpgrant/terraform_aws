resource "aws_nat_gateway" "nat_gw" {
  count         = "${length(split(",", var.public_ranges))}"
  allocation_id = "${element(aws_eip.nat_eip.*.id, count.index)}"
  subnet_id     = "${element(aws_subnet.subnets-public.*.id, count.index)}"
  depends_on    = ["aws_internet_gateway.igw-main"]
}
