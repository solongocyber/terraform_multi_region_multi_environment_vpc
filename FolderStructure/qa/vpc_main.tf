resource "aws_vpc" "multi_region_vpc" {
    cidr_block = var.cidr_block_multi_az_vpc
    
    tags = {
        Name = "${var.env}-main_region"
    }
}

