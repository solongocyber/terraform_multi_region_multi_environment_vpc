

variable "cidr_block_multi_az_vpc" {
    type = string
    default = "10.0.0.0/16"
}

variable "env" {
    type = string
    default = "dev"
    
}

variable "pub_subnet"{
    type = list(string)
    default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "private_subnet" {
    type = list(string)
    default = ["10.0.11.0/24", "10.0.12.0/24", "10.0.13.0/24"]
}

variable "rt_cidr" {
    type = string
    default = "0.0.0.0/0"
}