enable_dns_hostnames = "true"
enable_dns_support = "true"
region  = "eu-west-1"
azs = "eu-west-1a,eu-west-1b"
key_name = "example-keypair"
aws_amis = {
    "eu-west-1" = "ami-d8f4deab" # ubuntu-16.04 ebs ssd (x64)
}
current_profile = "default"
shared_creds_file = "/Users/nevyn/.aws/credentials"
vpc_cidr = "172.37.0.0/16"
public_ranges = "172.37.0.0/20,172.37.128.0/20"
private_ranges = "172.37.16.0/20,172.37.144.0/20"
db_name = "mydb1"
db_username = "testuser"
db_password = "testpassword"
engine_version = {
    mysql    = "5.6.22"
    postgres = "9.4.1"
}
storage = "10"
engine = "mysql"
identifier     = "mydb-rds"
instance_class     = "db.t2.micro"