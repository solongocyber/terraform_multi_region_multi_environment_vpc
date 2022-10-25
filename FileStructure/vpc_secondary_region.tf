resource "aws_vpc" "secondary_vpc" {
    cidr_block = var.cidr_block_multi_az_vpc
    provider = aws.secondary_region
    tags = {
        Name = "${var.env}-secondary_region"
        Name = format("%s-vpc" , var.env)
    }
}