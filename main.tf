module "vpc" {
  source = "./module/vpc"

  aws_vpc_cidr_block              = var.aws_vpc_cidr_block
  aws_vpc_public_subnet_cidr_1    = var.aws_vpc_public_subnet_cidr_1
  aws_vpc_private_subnet_cidr_1   = var.aws_vpc_private_subnet_cidr_1
  aws_vpc_private_db_subnet_cidr_1 = var.aws_vpc_private_db_subnet_cidr_1
  aws_vpc_public_subnet_cidr_2    = var.aws_vpc_public_subnet_cidr_2
  aws_vpc_private_subnet_cidr_2   = var.aws_vpc_private_subnet_cidr_2
  aws_vpc_private_db_subnet_cidr_2 = var.aws_vpc_private_db_subnet_cidr_2
  aws_vpc_public_subnet_cidr_3    = var.aws_vpc_public_subnet_cidr_3
  aws_vpc_private_subnet_cidr_3   = var.aws_vpc_private_subnet_cidr_3
  aws_vpc_private_db_subnet_cidr_3 = var.aws_vpc_private_db_subnet_cidr_3
}



#---------------security group ---------------------

resource "aws_security_group" "app_sg" {
  name   = "app-sg"
  vpc_id = module.vpc.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#-------------call EC2 module-------------------------
module "ec2" {
  source = "./module/EC2"

  subnet_id = module.vpc.private_app_subnet_ids[0]

  sg_id = aws_security_group.app_sg.id
}

module "rds" {
   source = "./module/RDS"

  vpc_id = module.vpc.vpc_id

  private_db_subnet_ids = module.vpc.private_db_subnet_ids

  db_username = var.db_username
  db_password = var.db_password
}