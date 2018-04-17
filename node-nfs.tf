resource "aws_instance" "icp-nfs" {
  ami           = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type = "t2.large"

  root_block_device {
    volume_size = 30
  }

  # the VPC subnet
  subnet_id = "${aws_subnet.main-public-1.id}"

  # the security group
  vpc_security_group_ids = ["${aws_security_group.allow-all.id}"]

  # the public SSH key
  key_name = "irvnet01"

  # user data
  user_data = "${data.template_cloudinit_config.cloudinit-example.rendered}"

  tags {
    Name = "nfs server"
  }
}
