resource "aws_route_table" "public" {
  vpc_id                  = aws_vpc.main.id

  route {
    gateway_id            = aws_internet_gateway.igw.id
    cidr_block            = "0.0.0.0/0"
  }

  tags                    = {
    Name                  = "${var.ENV}-public-rt"
  }
}


resource "aws_route_table" "private" {
  vpc_id                  = aws_vpc.main.id

  route {
    nat_gateway_id        = aws_nat_gateway.ngw.id
    cidr_block            = "0.0.0.0/0"
  }

  tags                    = {
    Name                  = "${var.ENV}-private-rt"
  }
}


//resource "aws_route" "private-igw" {
//  route_table_id              = aws_route_table.private.id
//  destination_cidr_block      = "0.0.0.0/0"
//  gateway_id                  = aws_nat_gateway.ngw.id
//  //depends_on                  = [aws_internet_gateway.igw.id, aws_route_table.public.id]
//}
