resource "aws_route_table" "public_rt" {
    vpc_id = aws_vpc.multi_region_vpc.id
    
    route {
        cidr_block = var.rt_cidr
        gateway_id = aws_internet_gateway.internet_gateway.id
    }
    tags = {
        Name = "${var.env}-public_rt"
    }
}

resource "aws_route_table_association" "pub_rt" {
    count = length(var.pub_subnet)
    subnet_id = element(aws_subnet.pub_subnet.*.id, count.index)
    route_table_id = aws_route_table.public_rt.id

}

resource "aws_eip" "eip"{
    vpc = true
}

resource "aws_nat_gateway" "nat_gateway" {
  subnet_id         = aws_subnet.pub_subnet[0].id
  allocation_id = aws_eip.eip.id
  tags = {
    Name = "${var.env}-nat_gateway"
  }
}
resource "aws_route_table" "private_rt" {
    vpc_id = aws_vpc.multi_region_vpc.id
    
    route {
        cidr_block = var.rt_cidr
        nat_gateway_id = aws_nat_gateway.nat_gateway.id
    }
    tags = {
        Name = "${var.env}-private_rt"
    }
}

resource "aws_route_table_association" "private_rt" {
    count = length(var.private_subnet)
    subnet_id = element(aws_subnet.private_subnet.*.id, count.index)
    route_table_id = aws_route_table.private_rt.id

}


resource "aws_route_table" "public_rt_secondary_region" {
    provider = aws.secondary_region
    vpc_id = aws_vpc.secondary_vpc.id
    
    route {
        cidr_block = var.rt_cidr
        gateway_id = aws_internet_gateway.internet_gateway_secondary_region.id
    }
    tags = {
        Name = "${var.env}-public_rt"
    }
}

resource "aws_route_table_association" "public_rt_secondary_region" {
    provider = aws.secondary_region
    count = length(var.pub_subnet)
    subnet_id = element(aws_subnet.pub_subnet_secondary_region.*.id, count.index)
    route_table_id = aws_route_table.public_rt_secondary_region.id

}

resource "aws_route_table" "private_rt_secondary_region" {
    provider = aws.secondary_region
    vpc_id = aws_vpc.secondary_vpc.id
    
    route {
        cidr_block = var.rt_cidr
        nat_gateway_id = aws_nat_gateway.nat.id
    }
    tags = {
        Name = "${var.env}-private_rt"
    }
}

resource "aws_route_table_association" "private_rt_secondary_region" {
    provider = aws.secondary_region
    count = length(var.private_subnet)
    subnet_id = element(aws_subnet.private_subnet_secondary_region.*.id, count.index)
    route_table_id = aws_route_table.private_rt_secondary_region.id

}

resource "aws_eip" "eip_secondary_region"{
    provider = aws.secondary_region
    vpc = true
}

resource "aws_nat_gateway" "nat" {
  provider = aws.secondary_region
  subnet_id         = aws_subnet.pub_subnet_secondary_region[0].id
  allocation_id = aws_eip.eip_secondary_region.id
  tags = {
    Name = "${var.env}-nat_gateway"
  }
}

