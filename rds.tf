
resource "aws_db_instance" "default" {
    allocated_storage=20
    storage_type="gp2"
    engine               = "mysql"
    engine_version       = "5.7"
    instance_class = "db.t2.micro"
    name = "awsdb"
    username = "give your username"
    password = var.password
    #identifier = var.id
    skip_final_snapshot = true
    #Allowing Public Access
    publicly_accessible = true
    #Attaching VPC Security Group
    vpc_security_group_ids = [aws_security_group.access_to_all.id]
    apply_immediately = true
    tags = {
    Name = "wp-aws-db"
    }
}


#Creating Security Group 
resource "aws_security_group" "access_to_all" {
  name        = "access_to_localhost"
  description = "Allow all inbound traffic "

  ingress {
    description = "Allow all inbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "access_to_all"
  }
}

#Give  DNS Name of RDS Instance on terminal
output "dns" {
value = aws_db_instance.default.address
}
