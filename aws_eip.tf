resource "aws_eip" "nat_eip" {
  count = "${length(split(",", var.public_ranges))}"
  vpc   = true
}
