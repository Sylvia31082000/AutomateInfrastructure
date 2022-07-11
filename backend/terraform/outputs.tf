output "vpc_id" {
    value = aws_vpc.infa-vpc.id
    description = "VPC id"
}

output "vpc_security_id" {
    value = aws_vpc.infa-vpc.default_security_group_id
    description = "Security group id"
}

output "subnet1_id" {
    value = aws_subnet.public-subnet-1a.id
    description = "Subnet 1a id"
}

output "subnet2_id" {
    value = aws_subnet.public-subnet-1b.id
    description = "Subnet 1b id"
}