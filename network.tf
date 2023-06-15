# VPC
resource "aws_vpc" "ex_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true

  tags = {
    Name = "ex-vpc"
  }
}

# パブリックサブネット
resource "aws_subnet" "ex_subnet_a" {
  vpc_id = aws_vpc.ex_vpc.id
  cidr_block = "10.0.0.0/24"
  availability_zone = "ap-northeast-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "ex-subnet-a"
  }
}

# インターネットゲートウェイ
resource "aws_internet_gateway" "ex_igw" {
    vpc_id = aws_vpc.ex_vpc.id

    tags = {
      Name = "ex-igw"
    }
}

# ルートテーブル
resource "aws_route_table" "ex_route_table" {
    vpc_id = aws_vpc.ex_vpc.id

    tags = {
      Name = "ex-route-table"
    }
  
}

# ルート
resource "aws_route" "ex_route_table" {
  route_table_id = aws_route_table.ex_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.ex_igw.id
}

#ルートテーブルとの関連付け
resource "aws_route_table_association" "ex_route_table_a" {
    route_table_id = aws_route.ex_route_table.id
    subnet_id = aws_subnet.ex_subnet_a.id
  
}