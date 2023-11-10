resource "aws_subnet" "main" {
  count = length(var.cidr_block)
  vpc_id     = var.vpc_id
  cidr_block = var.cidr_block[count.index]
  availability_zone = var.availability_zone[count.index]

  tags = merge(
    local.common_tags,
    {Name = "${var.env}-${var.name}-subnet-${count.index+1}"}
  )
}

resource "aws_route_table" "route_table" {
  vpc_id = var.vpc_id

  route {
    cidr_block = data.aws_vpc.default.cidr_block # workstation VPC Cidr block
    vpc_peering_connection_id = var.vpc_peering_connection_id
  }

  tags = merge(
    local.common_tags,
    {Name = "${var.env}-${var.name}-route_table"}
  )
}

resource "aws_route_table_association" "association" {
  count          = length(aws_subnet.main)
  subnet_id      = aws_subnet.main.*.id[count.index]
  route_table_id = aws_route_table.route_table.id
}

resource "aws_route" "internet_gw_route" {
  # if internet gw value is true the condition is to run this 1 time else 0 time
  count                     = var.internet_gw ? 1 : 0
  route_table_id            = aws_route_table.route_table.id
  destination_cidr_block    = "0.0.0.0/0"
  # we are declaring gw id here and getting input from outputs of vpc module
  gateway_id = var.internet_gw_id

}