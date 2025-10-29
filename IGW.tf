resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  depends_on = [ aws_vpc.vpc ]
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  depends_on = [ aws_internet_gateway.igw ]
}

resource "aws_route_table_association" "public_table" {
  route_table_id = aws_route_table.public.id
  subnet_id = aws_subnet.public.id
  depends_on = [ aws_route_table.public ]
}

