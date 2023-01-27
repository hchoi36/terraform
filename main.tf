resource "aws_instance" "ec2" {
  ami = "ami-0b5eea76982371e91"
  instance_type = "t2.micro"
  key_name = "devops_lab"
  #vpc_security_group_ids = [sg-0237c70dcff4cd7f1]

  tags = {
    Name = var.instance_name
  }
}

#resource "aws_s3_bucket" "b" {
  #bucket = "antra-tf-bucket"

  #tags = {
    #Name        = "My bucket"
    #Environment = "Dev"
  #}
#}

#resource "aws_s3_bucket_acl" "example" {
  #bucket = aws_s3_bucket.b.id
  #acl    = "private"
#}







 


