output "vpc_id" {
    value = aws_vpc.infra-vpc.id
    description = "VPC id"
}

output "vpc_security_id" {
    value = aws_vpc.infra-vpc.default_security_group_id
    description = "Security group id"
}

output "subnet1a_id" {
    value = aws_subnet.public-subnet-1a.id
    description = "public subnet 1a id"
}

output "subnet1a_private_id" {
    value = aws_subnet.private-subnet-1a.id
    description = "Private subnet 1a id"
}

output "subnet1b_id" {
    value = aws_subnet.public-subnet-1b.id
    description = "Public subnet 1b id"
}

output "subnet1b_private_id" {
    value = aws_subnet.private-subnet-1b.id
    description = "Private subnet 1b id"
}