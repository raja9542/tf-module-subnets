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