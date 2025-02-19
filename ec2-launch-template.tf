resource "aws_launch_template" "ec2_lt" {
  name                   = "lt-ead"
  image_id               = "ami-09d62954d1713e4b9"
  instance_type          = "t3.micro"
  key_name               = "ead"
  vpc_security_group_ids = [aws_security_group.security_group.id]

  iam_instance_profile {
    name = "ecsInstanceRole"
  }
  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "ecs-instance-ead"
    }
  }

  user_data = filebase64("${path.module}/ecs.sh")
}

