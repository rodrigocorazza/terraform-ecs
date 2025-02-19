# Criação da VPC
resource "aws_vpc" "main" {
  cidr_block           = "172.0.0.0/16"
  enable_dns_hostnames = true
  tags = {
    Name = "EAD"
  }
}

#Criação da Subnet
resource "aws_subnet" "subnet1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "172.0.1.0/24"
  availability_zone = "us-west-2a"
  map_public_ip_on_launch = true 
  tags = {
    Name = "private-us-west-2a"
  }
}

#Criação da Subnet 2
resource "aws_subnet" "subnet2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "172.0.2.0/24"
  availability_zone = "us-west-2b"
  map_public_ip_on_launch = true 
  tags = {
    Name = "private-us-west-2b"
  }
}

#Criação do internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "IGW-EAD"
  }
}

resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "subnet1_route" {
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.route_table.id
}

resource "aws_route_table_association" "subnet2_route" {
  subnet_id      = aws_subnet.subnet2.id
  route_table_id = aws_route_table.route_table.id
}

resource "aws_security_group" "security_group" {
  name   = "EAD"
  vpc_id = aws_vpc.main.id
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
