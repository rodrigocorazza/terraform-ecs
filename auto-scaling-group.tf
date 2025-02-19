resource "aws_autoscaling_group" "ecs_asg" {
  name                = "foobar3-terraform-test"
  max_size            = 1
  min_size            = 1
  desired_capacity    = 1
  vpc_zone_identifier = [aws_subnet.subnet1.id, aws_subnet.subnet2.id]

  launch_template {
    id      = aws_launch_template.ec2_lt.id
    version = "$Latest"
  }

  tag {
    key                 = "AmazonECSManaged"
    value               = true
    propagate_at_launch = true
  }
}