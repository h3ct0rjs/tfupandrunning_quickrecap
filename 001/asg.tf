resource "aws_launch_configuration" "asg_lt" {
  #name                        = "cluster_ltconfig" #there is a well know bug https://github.com/hashicorp/terraform/issues/3665
  image_id                    = data.aws_ami.ubuntu.id
  instance_type               = "t2.micro"
  user_data                   = <<-EOF
            #!/bin/bash
            
            echo "Hello from DevOps Colombia" >index.html
            ip addr show eth0 | grep inet | awk '{print $2}' >>index.html
            nohup busybox httpd -f -p 8080 &
            EOF
  security_groups             = [aws_security_group.http-sg-instance.id]
  associate_public_ip_address = true
  iam_instance_profile        = data.aws_iam_role.ssmrole.name
  lifecycle {
    create_before_destroy = true
  }

}
resource "aws_autoscaling_group" "asg-web-cluster" {
  name                 = "asg-web-cluster"
  launch_configuration = aws_launch_configuration.asg_lt.name
  min_size             = 8
  max_size             = 10
  vpc_zone_identifier  = data.aws_subnet_ids.defaultsubnets.ids
  target_group_arns    = [aws_lb_target_group.tg-web-farm.arn]
  health_check_type    = "ELB"

  tag {
    key                 = "Name"
    value               = "asg-web-cluster-servers"
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }
}
