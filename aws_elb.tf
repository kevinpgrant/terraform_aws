
resource "aws_elb" "web-app-elb" {
  name = "web-app-elb-w00t"

  # The same availability zone as our instance
  subnets = ["${aws_subnet.subnets-public.*.id}"]

  security_groups = ["${aws_security_group.elb-sg.id}"]

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/"
    interval            = 30
  }

  # The instance is registered automatically

  instances                   = ["${aws_instance.web-app.id}"]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

    tags {
        Name = "w00t"
        Terraform = "true"
    }
}
