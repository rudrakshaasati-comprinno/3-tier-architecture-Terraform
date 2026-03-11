variable "aws_vpc_cidr_block" {
description = "Define the CIDR of VPC"
type = string
}

variable "aws_vpc_public_subnet_cidr_1" {
description = "Define the CIDR of public az 1"
type = string
}

variable "aws_vpc_private_subnet_cidr_1" {
description = "Define the CIDR of private az 1"
type = string
}

variable "aws_vpc_private_db_subnet_cidr_1" {
description = "Define the CIDR of private db in az 1"
type= string
}

variable "aws_vpc_public_subnet_cidr_2" {
description = "Define the CIDR of public az 2"
type= string
}

variable "aws_vpc_private_subnet_cidr_2" {
description = "Define the CIDR of private az 2"
type = string
}

variable "aws_vpc_private_db_subnet_cidr_2" {
description = "Define the CIDR of private db in az 2"
type = string
}

variable "aws_vpc_public_subnet_cidr_3" {
description = "Define the CIDR of public in az 3"
type = string
}

variable "aws_vpc_private_subnet_cidr_3" {
description = "Define the CIDR of private in az 3"
type = string
}

variable "aws_vpc_private_db_subnet_cidr_3" {
description = "Define the CIDR of private db in az 3"
type = string
}