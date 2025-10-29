resource "aws_db_subnet_group" "rds_subnet" {
  name = "rds-subnet"
  subnet_ids = [aws_subnet.private.id, aws_subnet.private2.id]
}

resource "aws_db_instance" "wordpress_db" {
  allocated_storage = 20
  engine = "mysql"
  engine_version = "8.0"
  instance_class = "db.t3.micro"
  username = "admin"
  password = "admin123"
  db_name = "wordpressdb"
  db_subnet_group_name = aws_db_subnet_group.rds_subnet.name
  vpc_security_group_ids =[aws_security_group.rds_sg.id]
  publicly_accessible = false
  skip_final_snapshot  = true
  depends_on = [ aws_vpc.vpc, aws_subnet.private,aws_security_group.rds_sg ]
}