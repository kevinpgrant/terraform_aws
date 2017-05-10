to use this repo, you should have your own AWS account and your user should have an IAM allowing sufficient access to create all the applicable resources.

copy or rename the terraform.tfvars.dist file to terraform.tfvars and update it with your settings

The IAM credentials should be setup similar to the following (use your own access_key and secret, obviously!)

```
  $ cat ~/.aws/config
  [default]
  region = eu-west-1


  $ cat ~/.aws/credentials
  [default]
  aws_access_key_id = ABCDEFGHIJKLMNOPQRST
  aws_secret_access_key = A1B2C3D4E5F6G7H8I9J0k1l2m3n4o5p6q7r8s9t0
```

CHANGES:

2017-05-10

Added module for docker swarm mode

2017-03-27

Added a Modules folder, and added a bastion host, using a community provided module. Its not perfect, yet, but I have managed to get it working... ish. Look for CHANGEME in the variables and bastion files, replacing the obvious placeholders like example.com and 123456789012 with your own values (but don't commit them!)

A few formatting changes and updates for terraform 0.9.x compatibility






:sparkles: thanks to Kofi, Joe, Bobby and charity.wtf :sparkles: 

- https://charity.wtf/2016/03/23/aws-networking-environments-and-you/
- https://charity.wtf/2016/02/23/two-weeks-with-terraform/
- https://charity.wtf/2016/03/30/terraform-vpc-and-why-you-want-a-tfstate-file-per-env/
- https://charity.wtf/2016/04/14/scrapbag-of-useful-terraform-tips/
- https://www.terraform.io/docs/configuration/interpolation.html
- https://www.terraform.io/docs/providers/aws/index.html
- https://blog.gruntwork.io/terraform-tips-tricks-loops-if-statements-and-gotchas-f739bbae55f9
- http://blog.lusis.org/blog/2015/10/12/terraform-modules-for-fun-and-profit/

A few ideas on how to separate your different environments...

- spin up a production VPC, a staging VPC, dev VPC, Travis-CI VPC, ...

- set up one aws account per env, use consolidated billing - see https://segment.com/blog/rebuilding-our-infrastructure/

- one vpc, using separate subnets and security groups to keep things apart


