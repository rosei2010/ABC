# My VPC
resource "aws_vpc" "Kane-vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "Kane-vpc"
  }
}

# Public subnet
resource "aws_subnet" "public-sub1" {
  vpc_id     = aws_vpc.Kane-vpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "public-sub1"
  }
}


# Public subnet
resource "aws_subnet" "public-sub2" {
  vpc_id     = aws_vpc.Kane-vpc.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "public-sub2"
  }
}


# Private subnet
resource "aws_subnet" "private-sub1" {
  vpc_id     = aws_vpc.Kane-vpc.id
  cidr_block = "10.0.3.0/24"

  tags = {
    Name = "private-sub1"
  }
}


# Public route table
resource "aws_route_table" "public-route-table" {
  vpc_id = aws_vpc.Kane-vpc.id

  route = []

  tags = {
    Name = "public-route-table"
  }
}


# Private route table
resource "aws_route_table" "private-route-table" {
  vpc_id = aws_vpc.Kane-vpc.id

  route = []

  tags = {
    Name = "private-route-table"
  }
}


# Route association public
resource "aws_route_table_association" "public-route-association-1" {
  subnet_id      = aws_subnet.public-sub1.id
  route_table_id = aws_route_table.public-route-table.id
}


# Route association private 
resource "aws_route_table_association" "private-route-association-1" {
  subnet_id      = aws_subnet.private-sub1.id
  route_table_id = aws_route_table.private-route-table.id
}


#Internet gateway
resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.Kane-vpc.id

  tags = {
    Name = "IGW"
  }
}


# aws route 
resource "aws_route" "Public-igw-route" {
  route_table_id            = aws_route_table.public-route-table.id
  gateway_id                = aws_internet_gateway.IGW.id
  destination_cidr_block    = "0.0.0.0/0"
}

