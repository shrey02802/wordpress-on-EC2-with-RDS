# wordpress on EC2 with RDS

Project Aim

Host a WordPress website on an EC2 instance and connect it to a MySQL database managed by Amazon RDS. The goal was to build a simple, secure, and repeatable infrastructure using Terraform and to deploy a working WordPress site.

Architecture (simple flow)
  User → Internet → EC2 (Apache + WordPress) → RDS (MySQL)

Key Learnings

    Configured an Internet Gateway for public access.
    
    Created route tables and associated them with subnets.
    
    Designed security groups for the web and database tiers to control traffic.
    
    Automated WordPress installation using EC2 user data (installed Apache, PHP, and PHP MySQL extension).
    
    Set up an RDS MySQL instance with a DB subnet group for high availability.

Implementation Steps

    VPC and Subnets: Created a VPC with one public subnet and two private subnets (across availability zones).
    
    Networking: Configured the Internet Gateway and route tables, and associated the public subnet to the public route table.
    
    Security Groups: Created separate security groups for EC2 (allowing SSH and HTTP) and RDS (allowing MySQL only from EC2's security group).
    
    EC2 (Web Server): Provisioned an EC2 instance with Apache and added a user-data script to install Apache, PHP, and php-mysqlnd, and to download and place WordPress files.
    
    RDS (Database): Provisioned a MySQL RDS instance with storage, username and password, and attached it to a DB subnet group spanning two private subnets.

Challenges Faced & Solutions

    Resource creation order (dependency issues): Resources sometimes attempted to create before their dependencies were ready.
    Fix: Used Terraform references and depends_on where required so Terraform builds resources in the correct order.
    
    Public IP unreachable (site timed out): The EC2 public IP returned a timeout because HTTP (port 80) was not reachable.
    Fix: Added an inbound rule to the EC2 security group to allow HTTP (port 80) from 0.0.0.0/0, verified the route table had a 0.0.0.0/0 → IGW route, and ensured Apache was running on the instance.
    
    RDS creation requirement (two subnets): RDS requires a DB subnet group with at least two subnets in different AZs. Initial configuration had only one private subnet.
    Fix: Added a second private subnet in a different availability zone and updated the DB subnet group.

Result

A working WordPress website hosted on EC2 with a MySQL RDS backend. The site is suitable as a low-cost showcase platform for small and mid-sized companies to present products and services.
