resource "aws_internet_gateway" "internet_gateway"{
    vpc_id = aws_vpc.multi_region_vpc.id
    tags = {
        Name = "${var.env}-internet_gw"
    }
}

resource "aws_internet_gateway" "internet_gateway_secondary_region"{
    provider = aws.secondary_region
    vpc_id = aws_vpc.secondary_vpc.id
    tags = {
        Name = "${var.env}-internet_gw"
    }
}