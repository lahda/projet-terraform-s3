data "aws_availability_zones" "available" {
    state = "available"
  
}

locals {
  azs = slice(data.aws_availability_zones.available.names, 0, var.az_count)

  az_map = { 
    for idx, az in local.azs : idx + 1 => az }
}

resource "aws_vpc" "main" {
    cidr_block = var.vpc_cidr
    enable_dns_support   = true
    enable_dns_hostnames = true
    tags = {
        Name = "${var.environment}-vpc"
    }
  
}

resource "aws_internet_gateway" "main" {
    vpc_id = aws_vpc.main.id
    tags = {
        Name = "${var.environment}-igw"
    }
  
}

resource "aws_subnet" "public" {
    for_each = local.az_map
    vpc_id            = aws_vpc.main.id
    cidr_block        = cidrsubnet(var.vpc_cidr, 8, count.index)
    availability_zone = each.key
    map_public_ip_on_launch = true
    tags = {
        Name = "${var.environment}-public-subnet-${count.index + 1}"
    }
  
}

resource "aws_subnet" "private" {
    for_each = local.az_map
    vpc_id            = aws_vpc.main.id
    cidr_block        = cidrsubnet(var.vpc_cidr, 8, count.index + var.az_count)
    availability_zone = each.key
    tags = {
        Name = "${var.environment}-private-subnet-${count.index + 1}"
    }
  
}

resource "aws_eip" "nat" {
    for_each = local.az_map
    domain = "vpc"
    tags = {
        Name = "${var.environment}-nat-eip"
    }
  
}

resource "aws_nat_gateway" "main" {
    for_each = local.az_map
    subnet_id = aws_subnet.public[each.key].id
    allocation_id = aws_eip.nat[each.key].id
    tags = {
        Name = "${var.environment}-nat-gateway"
    }
    depends_on = [ aws_internet_gateway.main ]
}

resource "aws_route_table" "public" {
    vpc_id = aws_vpc.main.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.main.id
    }
    tags = {
        Name = "${var.environment}-public-route-table"
    }
}

resource "aws_route_table_association" "public" {
    for_each = local.az_map
    route_table_id = aws_route_table.public.id
    subnet_id = aws_subnet.public[each.key].id
}

resource "aws_route_table" "private" {
    for_each = local.az_map
    vpc_id = aws_vpc.main.id
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.main[each.key].id
    }
    tags = {
        Name = "${var.environment}-private-route-table"
    }
}

resource "aws_route_table_association" "private" {
    for_each = local.az_map
    route_table_id = aws_route_table.private[each.key].id
    subnet_id = aws_subnet.private[each.key].id
}

resource "aws_security_group" "alb" {
    name        = "${var.environment}-alb-sg"
    description = "Security group for ALB"
    vpc_id      = aws_vpc.main.id

    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress = {
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }


    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "${var.environment}-alb-sg"
    }

}