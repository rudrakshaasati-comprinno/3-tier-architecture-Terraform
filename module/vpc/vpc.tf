resource "aws_vpc" "myvpc" {
  cidr_block           = var.aws_vpc_cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "main"
  }
}

# ---------------- PUBLIC SUBNETS ----------------

resource "aws_subnet" "public_subnet_1" {
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = var.aws_vpc_public_subnet_cidr_1
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "public_subnet_1"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = var.aws_vpc_public_subnet_cidr_2
  availability_zone       = "ap-south-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "public_subnet_2"
  }
}

resource "aws_subnet" "public_subnet_3" {
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = var.aws_vpc_public_subnet_cidr_3
  availability_zone       = "ap-south-1c"
  map_public_ip_on_launch = true

  tags = {
    Name = "public_subnet_3"
  }
}

# ---------------- PRIVATE APP SUBNETS ----------------

resource "aws_subnet" "private_app_subnet_1" {
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = var.aws_vpc_private_subnet_cidr_1
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = false

  tags = {
    Name = "private_app_subnet_1"
  }
}

resource "aws_subnet" "private_app_subnet_2" {
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = var.aws_vpc_private_subnet_cidr_2
  availability_zone       = "ap-south-1b"
  map_public_ip_on_launch = false

  tags = {
    Name = "private_app_subnet_2"
  }
}

resource "aws_subnet" "private_app_subnet_3" {
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = var.aws_vpc_private_subnet_cidr_3
  availability_zone       = "ap-south-1c"
  map_public_ip_on_launch = false

  tags = {
    Name = "private_app_subnet_3"
  }
}

# ---------------- PRIVATE DB SUBNETS ----------------

resource "aws_subnet" "private_db_subnet_1" {
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = var.aws_vpc_private_db_subnet_cidr_1
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = false

  tags = {
    Name = "private_db_subnet_1"
  }
}

resource "aws_subnet" "private_db_subnet_2" {
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = var.aws_vpc_private_db_subnet_cidr_2
  availability_zone       = "ap-south-1b"
  map_public_ip_on_launch = false

  tags = {
    Name = "private_db_subnet_2"
  }
}

resource "aws_subnet" "private_db_subnet_3" {
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = var.aws_vpc_private_db_subnet_cidr_3
  availability_zone       = "ap-south-1c"
  map_public_ip_on_launch = false

  tags = {
    Name = "private_db_subnet_3"
  }
}


# ---------------- INTERNET GATEWAY ----------------

resource "aws_internet_gateway" "igw" {
vpc_id = aws_vpc.myvpc.id

tags = {
Name = "main-igw"
}
}

# ---------------- ELASTIC IP FOR NAT GATEWAY ----------------

resource "aws_eip" "nat_eip" {
  domain = "vpc"

  tags = {
    Name = "nat-eip"
  }

  depends_on = [aws_internet_gateway.igw]
}

# ---------------- NAT GATEWAY ----------------

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet_1.id

  tags = {
    Name = "main-nat"
  }

  depends_on = [aws_internet_gateway.igw]
}

# ---------------- ROUTE TABLES ----------------

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public-route-table"
  }
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "private-route-table"
  }
}

# ---------------- ROUTE TABLE ASSOCIATIONS ----------------

# Public Subnet Associations
resource "aws_route_table_association" "public_1" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public_2" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public_3" {
  subnet_id      = aws_subnet.public_subnet_3.id
  route_table_id = aws_route_table.public_rt.id
}

# Private App Subnet Associations
resource "aws_route_table_association" "private_app_1" {
  subnet_id      = aws_subnet.private_app_subnet_1.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "private_app_2" {
  subnet_id      = aws_subnet.private_app_subnet_2.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "private_app_3" {
  subnet_id      = aws_subnet.private_app_subnet_3.id
  route_table_id = aws_route_table.private_rt.id
}

# Private DB Subnet Associations
resource "aws_route_table_association" "private_db_1" {
  subnet_id      = aws_subnet.private_db_subnet_1.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "private_db_2" {
  subnet_id      = aws_subnet.private_db_subnet_2.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "private_db_3" {
  subnet_id      = aws_subnet.private_db_subnet_3.id
  route_table_id = aws_route_table.private_rt.id
}