
data "aws_ami" "ubuntu-test" {
  most_recent = true
  owners = ["099720109477"]

  filter {
        name = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

}

data "terraform_remote_state" "vpc" {
  backend = "local"

}


resource "aws_instance" "ubuntu" {
  ami           = data.aws_ami.ubuntu-test.id
  instance_type           = "t2.micro"
  key_name                = "work-pc-ubuntu"
  #vpc_security_group_ids  = aws_security_group.default.id
  #subnet_id               = aws_subnet.Subnet_1[each.key].id

tags = {
  Name = "data.terrform_remote_state.vpc.outputs.vpc_id-test"
}
}