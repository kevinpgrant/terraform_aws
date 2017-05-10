

/*
 * inspired by https://github.com/Praqma/terraform-aws-docker/blob/master/app-instances.tf
 * latest docker setup instructions from https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-16-04
 * and docker-compose from https://github.com/UKCloud/openstack-terraform/blob/docker-swarm/docker-compose.yml
 */

/* Setup our aws provider */
provider "aws" {
  region      = "${var.aws_region}"
}

# resource "aws_route53_record" "ec2_dns" {
#   count = "${var.servers}"

#   name    = "docker_swarm_${count.index}"
#   records = ["${aws_instance.ec2_provisioned.*.private_ip}"]
#   ttl     = "300"
#   type    = "A"
#   zone_id = "Z1X7O3CUKXMV2T"
# }

resource "aws_instance" "master" {
  count = 1

  ami             = "${var.ami}"
  instance_type   = "t2.micro"
  key_name        = "${var.key_name}"
  associate_public_ip_address = false
  subnet_id                   = "${element(var.subnet_ids, count.index)}"
  vpc_security_group_ids      = ["${var.vpc_security_group_ids}"]

  connection {
    user        = "ubuntu"
    private_key = "${file("${var.key_path}")}"
    agent       = false
    bastion_host = "bastion.${var.domain_name}"
  }

  lifecycle {
      create_before_destroy = true
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D",
      "sudo apt-add-repository 'deb https://apt.dockerproject.org/repo ubuntu-xenial main'",
      "sudo apt-get update",
      "apt-cache policy docker-engine", // install from the Docker repo instead of the default Ubuntu 16.04 repo
      "sudo apt-get install -y docker-engine",
      "sudo usermod -aG docker ubuntu",
      "sudo docker swarm init",
      "sudo docker swarm join-token --quiet worker > /home/ubuntu/token"
    ]
  }
  provisioner "file" {
    source = "${path.module}/proj"
    destination = "/home/ubuntu/"
  }

  #Instance tags
  tags {
    Name      = "swarm_master_${count.index}"
    project   = "swarm_master_${count.index}"
    terraform = "true"
  }
}


/* to sdd additional managers, you need to do something similar as for the 'worker' slaves

(manually, on the master, you would do this...)
ubuntu@ip-10-0-13-37:~$ docker swarm join-token manager
To add a manager to this swarm, run the following command:

    docker swarm join \
    --token SWMTKN-1-4grasbqkvppolzd4fehd1w2byjf0oojpgu0htle5th8t2e17ed-snipsnip \
    10.0.13.37:2377

(then manually  run the join command shown on the extra managers)
*/

resource "aws_instance" "slave" {
  count = 2

  ami                         = "${var.ami}"
  instance_type               = "t2.micro"
  key_name                    = "${var.key_name}"
  associate_public_ip_address = false
  subnet_id                   = "${element(var.subnet_ids, count.index)}"
  vpc_security_group_ids      = ["${var.vpc_security_group_ids}"]

  connection {
    user        = "ubuntu"
    private_key = "${file("${var.key_path}")}"
    agent       = false
    bastion_host = "bastion.${var.domain_name}"
  }

  lifecycle {
      create_before_destroy = true
  }

  provisioner "file" {
    source = "${var.key_path}"
    destination = "/home/ubuntu/test.pem"
  }
  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D",
      "sudo apt-add-repository 'deb https://apt.dockerproject.org/repo ubuntu-xenial main'",
      "sudo apt-get update",
      "apt-cache policy docker-engine", // install from the Docker repo instead of the default Ubuntu 16.04 repo
      "sudo apt-get install -y docker-engine",
      "sudo usermod -aG docker ubuntu",
      "sudo chmod 400 /home/ubuntu/test.pem",
      "sudo scp -o StrictHostKeyChecking=no -o NoHostAuthenticationForLocalhost=yes -o UserKnownHostsFile=/dev/null -i test.pem ubuntu@${aws_instance.master.private_ip}:/home/ubuntu/token .",
      "sudo docker swarm join --token $(cat /home/ubuntu/token) ${aws_instance.master.private_ip}:2377"
    ]
  }
  tags = {
    Name      = "swarm_node_${count.index}"
    project   = "swarm_node_${count.index}"
    terraform = "true"
  }
}
