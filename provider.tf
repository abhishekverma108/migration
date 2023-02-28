provider "aws" {
    region = "ap-south-1"
    profile = "default"
}
resource "aws_instance" "MyInstance1" {
      ami = "ami-0e07dcaca348a0e68"
      instance_type = "t2.micro"      
      key_name = "verma108" 
      availability_zone="ap-south-1a"
      security_groups=["launch-wizard-3"]
      tags = {
           Name = "master"
      }
}