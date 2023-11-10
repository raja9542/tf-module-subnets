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
    cidr_block = "10.0.1.0/24"
    vpc_peering_connection_id = var.vpc_peering_connection_id
  }

  route {
    ipv6_cidr_block        = "::/0"
    egress_only_gateway_id = aws_egress_only_internet_gateway.example.id
  }

  tags = {
    Name = "example"
  }
}