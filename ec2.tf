resource "aws_instance" "ec2" {
  ami = "ami-07860a2d7eb515d9a"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  key_name = "sec_pt"

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd php php-mysqlnd wget
              cd /var/www/html
              wget https://wordpress.org/latest.tar.gz
              tar -xzf latest.tar.gz
              cp -r wordpress/* /var/www/html/
              chown -R apache:apache /var/www/html
              systemctl enable httpd
              systemctl start httpd
              EOF

    tags = {
        name = "Wordpress_ec2"
    }
    depends_on = [ aws_security_group.ec2_sg , aws_route_table.public, aws_internet_gateway.igw, aws_subnet.public  ]
}