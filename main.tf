#
#
#resource "aws_route" "internet_gw_route" {
#  # if internet gw value is true the condition is to run this 1 time else 0 time
#  count                     = var.internet_gw ? 1 : 0
#  route_table_id            = aws_route_table.route_table.id
#  destination_cidr_block    = "0.0.0.0/0"
#  # we are declaring gw id here and getting input from outputs of vpc module
#  gateway_id = var.internet_gw_id
#
#}
#
#
#resource "aws_internet_gateway" "igw" {
#  count   = var.internet_gw ? 1 : 0
#  vpc_id  = var.vpc_id
#
#  tags = merge(
#    local.common_tags,
#    {Name = "${var.env}-igw"}
#  )
#}
#
#resource "aws_eip" "ngw-eip" {
#  domain   = "vpc"
#}
#
#resource "aws_nat_gateway" "ngw" {
#  count   = var.nat_gw ? 1 : 0
#  allocation_id = aws_eip.ngw-eip.id
#  subnet_id     = var.public_subnet_ids[0]
#
#  tags = merge(
#    local.common_tags,
#    {Name = "${var.env}-ngw"}
#  )
#}
