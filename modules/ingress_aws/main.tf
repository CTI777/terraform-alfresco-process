resource "helm_release" "nginx-ingress" {
  name    = "nginx-ingress"
  chart   = "stable/nginx-ingress"
  version = "1.7.0"

  values = [
    <<EOF
controller:
  config:
    generate-request-id: "true"
    PROXY-READ-TIMEOUT: "3600"
    proxy-send-timeout: "3600"
    ssl-redirect: "false"
    server-tokens: "false"
    use-forwarded-headers: "true"
  service:
    type: "NodePort"
    externalTrafficPolicy: "Cluster"
    nodePorts:
      http: "30245"
      https: "32433"
    targetPorts:
      http: http
      https: http
EOF
  ]
}
resource "aws_security_group" "elb_security_group" {
  name        = "elb-security-group"
  description = "Allow TLS inbound traffic"
  vpc_id      = var.vpc_id

  lifecycle {
    ignore_changes = all
  }
}

resource "aws_elb" "elb" {
  name = "${var.cluster_name}-elb"

  subnets         = data.aws_subnet_ids.my_vpc.ids
  security_groups = [aws_security_group.elb_security_group.id]

  listener {
    instance_port     = 30245
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  listener {
    instance_port      = 32433
    instance_protocol  = "http"
    lb_port            = 443
    lb_protocol        = "https"
    ssl_certificate_id = aws_acm_certificate_validation.cert.certificate_arn
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 6
    timeout             = 5
    target              = "TCP:30245"
    interval            = 10
  }

  instances                   = data.aws_instances.my_instances_id.ids
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags = {
    Name = "${var.cluster_name}-nginx-ingress"
  }

  depends_on = [var.helm_service_account]

}
resource "aws_security_group_rule" "allow_http" {
  type      = "ingress"
  from_port = 80
  to_port   = 80
  protocol  = "tcp"

  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.elb_security_group.id

}

resource "aws_security_group_rule" "allow_https" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.elb_security_group.id

}

resource "aws_security_group_rule" "allow_outflow" {
  type              = "egress"
  from_port         = 0
  to_port           = 65535
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.elb_security_group.id

}

data "aws_subnet_ids" "my_vpc" {
  vpc_id = var.vpc_id

}

data "aws_instances" "my_instances_id" {
  filter {
    name   = "tag:Name"
    values = ["${var.cluster_name}-${var.cluster_name}-node-group-Node"]
  }
}

data "aws_security_groups" "eks-worker-nodes" {
  filter {
    name = "vpc-id"

    values = [
      var.vpc_id,
    ]
  }

  filter {
    name   = "group-name"
    values = ["${var.cluster_name}-eks-worker-nodes-NodeSecurityGroup*"]
  }
}

resource "aws_security_group_rule" "allow_ebl_to_node_sg" {

  type                     = "ingress"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.elb_security_group.id
  security_group_id        = element(data.aws_security_groups.eks-worker-nodes.ids, 2)

}

