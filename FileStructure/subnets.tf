resource "aws_subnet" "pub_subnet"{
    vpc_id = aws_vpc.multi_region_vpc.id
    cidr_block = element(var.pub_subnet, count.index)
    count = length(var.pub_subnet)
    tags = {
        Name = "${var.env}-public_subnet-${count.index}"
    }
}

resource "aws_subnet" "pub_subnet_secondary_region"{
    provider = aws.secondary_region
    vpc_id = aws_vpc.secondary_vpc.id
    cidr_block = element(var.pub_subnet, count.index)
    count = length(var.pub_subnet)
    tags = {
        Name = "${var.env}-public_subnet-${count.index}"
    }
}

resource "aws_subnet" "private_subnet" {
    count = length(var.private_subnet)
    vpc_id = aws_vpc.multi_region_vpc.id
    cidr_block = element(var.private_subnet, count.index)
    tags = {
        Name = "${var.env}-private_subnet-${count.index}"
    }
}

resource "aws_subnet" "private_subnet_secondary_region" {
    provider = aws.secondary_region
    count = length(var.private_subnet)
    vpc_id = aws_vpc.secondary_vpc.id
    cidr_block = element(var.private_subnet, count.index)
    tags = {
        Name = "${var.env}-private_subnet-${count.index}"
    }
}
