resource "aws_instance" "app_server" {
  ami           = "ami-0f559c3642608c138"   # Amazon Linux (ap-south-1 example)
  instance_type = "t2.micro"

  subnet_id = var.subnet_id

  vpc_security_group_ids = [var.sg_id]

  user_data = <<-EOF
#!/bin/bash
exec > /var/log/user-data.log 2>&1
set -x

dnf update -y
dnf install -y httpd

systemctl enable httpd
systemctl start httpd

echo "<h1>Hello from Terraform EC2</h1>" > /var/www/html/index.html

systemctl restart httpd
EOF

  tags = {
    Name = "private-app-ec2"
  }
}