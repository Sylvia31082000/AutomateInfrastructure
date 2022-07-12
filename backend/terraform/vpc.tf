resource "aws_vpc" "infra-vpc" {
  cidr_block           = "172.31.0.0/16"
  enable_dns_hostnames = true
  tags = {
    Name = "infra-vpc"
  }
}

# Public Subnet for Availablity Zone 1a
resource "aws_subnet" "public-subnet-1a" {
  vpc_id                  = aws_vpc.infra-vpc.id
  cidr_block              = "172.31.0.0/18"
  availability_zone       = "ap-southeast-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "public-ap-southeast-1a"
  }
}

# Private Subnet for Availablity Zone 1a
resource "aws_subnet" "private-subnet-1a" {
  vpc_id                  = aws_vpc.infra-vpc.id
  cidr_block              = "172.31.64.0/18"
  availability_zone       = "ap-southeast-1a"
  map_public_ip_on_launch = false
  tags = {
    Name = "private-ap-southeast-1a"
  }
}

# Associate VPC to Internet Gateway
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.infra-vpc.id

  tags = {
    Name = "infra-internet-gateway"
  }
}

# Route public subnet 1a to Internet Gateway
resource "aws_route_table" "a_route_table_public" {
  vpc_id = aws_vpc.infra-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }

  tags = {
    Name = "a-infra-route-table-public"
  }
}

resource "aws_route_table_association" "a_route_table_association_public" {
  subnet_id      = aws_subnet.public-subnet-1a.id
  route_table_id = aws_route_table.a_route_table_public.id
}

resource "aws_eip" "a_eip" {
  vpc        = true
  depends_on = [aws_internet_gateway.internet_gateway]
  tags = {
    Name = "a-infra-eip"
  }
}

# Enables outbound connectivity for devices in the private network
resource "aws_nat_gateway" "a_nat_gateway" {
  allocation_id = aws_eip.a_eip.id
  subnet_id     = aws_subnet.public-subnet-1a.id

  tags = {
    Name = "a-infra-nat-gateway"
  }
}

# Route table with a route to direct traffic from the subnet to the NAT gateway
resource "aws_route_table" "a_route_table_private" {
  vpc_id = aws_vpc.infra-vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.a_nat_gateway.id
  }

  tags = {
    Name = "a-infra-route-table-private"
  }
}

resource "aws_route_table_association" "a_route_table_association_private" {
  subnet_id      = aws_subnet.private-subnet-1a.id
  route_table_id = aws_route_table.a_route_table_private.id
}

# resource "aws_default_network_acl" "default_network_acl" {
#   default_network_acl_id = aws_vpc.infra-vpc.default_network_acl_id
#   subnet_ids             = [aws_subnet.public-subnet-1a.id, aws_subnet.private-subnet-1a.id]

#   ingress {
#     protocol   = -1
#     rule_no    = 100
#     action     = "allow"
#     cidr_block = "0.0.0.0/0"
#     from_port  = 0
#     to_port    = 0
#   }

#   egress {
#     protocol   = -1
#     rule_no    = 100
#     action     = "allow"
#     cidr_block = "0.0.0.0/0"
#     from_port  = 0
#     to_port    = 0
#   }

#   tags = {
#     Name = "a-infra-default-network-acl"
#   }
# }

resource "aws_default_security_group" "default_security_group" {
  vpc_id = aws_vpc.infra-vpc.id

  ingress {
    protocol  = -1
    self      = true
    from_port = 0
    to_port   = 0
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    # cidr_blocks = ["127.0.0.1/32"]
  }

  tags = {
    Name = "infra-default-security-group"
  }
}

# Public Subnet for Availablity Zone 1b
resource "aws_subnet" "public-subnet-1b" {
  vpc_id                  = aws_vpc.infra-vpc.id
  cidr_block              = "172.31.128.0/18"
  availability_zone       = "ap-southeast-1b"
  map_public_ip_on_launch = true
  tags = {
    Name = "public-ap-southeast-1b"
  }
}

# Private Subnet for Availablity Zone 1b
resource "aws_subnet" "private-subnet-1b" {
  vpc_id                  = aws_vpc.infra-vpc.id
  cidr_block              = "172.31.192.0/18"
  availability_zone       = "ap-southeast-1b"
  map_public_ip_on_launch = false
  tags = {
    Name = "private-ap-southeast-1b"
  }
}

# Route public subnet 1b to Internet Gateway
resource "aws_route_table" "b_route_table_public" {
  vpc_id = aws_vpc.infra-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }

  tags = {
    Name = "1b_infra-route-table-public"
  }
}

resource "aws_route_table_association" "b_route_table_association_public" {
  subnet_id      = aws_subnet.public-subnet-1b.id
  route_table_id = aws_route_table.b_route_table_public.id
}

resource "aws_eip" "b_eip" {
  vpc        = true
  depends_on = [aws_internet_gateway.internet_gateway]
  tags = {
    Name = "b-infra-eip"
  }
}

# Enables outbound connectivity for devices in the private network
resource "aws_nat_gateway" "b_nat_gateway" {
  allocation_id = aws_eip.b_eip.id
  subnet_id     = aws_subnet.public-subnet-1b.id

  tags = {
    Name = "b-infra-nat-gateway"
  }
}

# Route table with a route to direct traffic from the subnet to the NAT gateway
resource "aws_route_table" "b_route_table_private" {
  vpc_id = aws_vpc.infra-vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.b_nat_gateway.id
  }

  tags = {
    Name = "b-infra-route-table-private"
  }
}

resource "aws_route_table_association" "b_route_table_association_private" {
  subnet_id      = aws_subnet.private-subnet-1b.id
  route_table_id = aws_route_table.b_route_table_private.id
}

resource "aws_default_network_acl" "default_network_acl" {
  default_network_acl_id = aws_vpc.infra-vpc.default_network_acl_id
  subnet_ids             = [aws_subnet.public-subnet-1a.id, aws_subnet.private-subnet-1a.id, aws_subnet.public-subnet-1b.id, aws_subnet.private-subnet-1b.id]

  ingress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  egress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags = {
    Name = "infra-default-network-acl"
  }
}