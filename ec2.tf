resource "aws_instance" "web1" {
  ami           = lookup(var.AMI, var.AWS_REGION)
  instance_type = "t2.micro"

  # VPC
  subnet_id = aws_subnet.gnpass-subnet-public-1.id

  # Security Group
  vpc_security_group_ids = ["${aws_security_group.allow-ssh.id}", "${aws_security_group.allow-http.id}"]

  # the public SSH key
  key_name = aws_key_pair.seoul-region-key-pair.id

  # nginx installation
  # provisioner "file" {
  #   source      = "nginx.sh"
  #   destination = "/tmp/nginx.sh"
  # }

  # provisioner "remote-exec" {
  #   inline = [
  #     "chmod +x /tmp/nginx.sh",
  #     "sudo /tmp/nginx.sh"
  #   ]
  # }

  # connection {
  #   type        = "ssh"
  #   user        = var.EC2_USER
  #   private_key = file(var.PRIVATE_KEY_PATH)
  # }

  # root_block_device {
  #   device_name = "/dev/xvda"
  #   encrypted   = true
  #   volume_type = "gp3"
  #   kms_key_arn = aws_kms_key.gnpass-ec2-volume-kms-key.arn
  #   # kms_key_id  = aws_kms_key.
  #   iops        = 3000
  #   throughput  = 125
  #   volume_size = 10
  # }

  tags = {
    Name = "gnpass-web1"
  }
}

resource "null_resource" "web1" {
  provisioner "file" {
    source      = "nginx.sh"
    destination = "/tmp/nginx.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/nginx.sh",
      "sudo /tmp/nginx.sh"
    ]
  }

  connection {
    type        = "ssh"
    user        = var.EC2_USER
    private_key = file(var.PRIVATE_KEY_PATH)
    host        = element(aws_instance.web1.*.public_ip, 0)
  }

}

resource "aws_key_pair" "seoul-region-key-pair" {
  key_name   = "seoul-region-key-pair"
  public_key = file(var.PUBLIC_KEY_PATH)
}
