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

You will also need to make sure the account numbers in the bastion_s3_public_keys.tf policy are correct, or your bastion will not allow access.

Do NOT commit your ssh keys, or AWS credentials!! (symlinks outside the folder work well, as git will ignore them but terraform won't)


## CHANGES:

2017-05-10

Added module for docker swarm mode

2017-03-27

Added a Modules folder, and added a bastion host, using a community provided module. Its not perfect, yet, but I have managed to get it working... ish. Look for CHANGEME in the variables and bastion files, replacing the obvious placeholders like example.com and 123456789012 with your own values (but don't commit them!)

A few formatting changes and updates for terraform 0.9.x compatibility


## NOTES

Whilst there are a great number of examples of using terraform for setting up specific resources, it was not easy to come across something that quickly summarised how to approach TF for the first time, from the ground up - ironically, given it's purpose as a bootstrapping tool :D

However I have included links to all the most useful resources that I read and re-read as I worked on my own code, until I felt I understood every dilemma and every decision made by the authors. I have summarised the learnings I got from this just below. 


## LINKS

* https://charity.wtf/2016/03/23/aws-networking-environments-and-you/
* https://charity.wtf/2016/02/23/two-weeks-with-terraform/
* https://charity.wtf/2016/03/30/terraform-vpc-and-why-you-want-a-tfstate-file-per-env/
* https://charity.wtf/2016/04/14/scrapbag-of-useful-terraform-tips/
* https://www.terraform.io/docs/configuration/interpolation.html
* https://www.terraform.io/docs/providers/aws/index.html
* https://blog.gruntwork.io/terraform-tips-tricks-loops-if-statements-and-gotchas-f739bbae55f9
* http://blog.lusis.org/blog/2015/10/12/terraform-modules-for-fun-and-profit/

:sparkles: thanks to Kofi, Joe, Bobby and charity.wtf :sparkles:

## SUMMARY APPROACH

A good way to approach your own TF projects is to start by setting up your shared credentials / AWS profile (see AWS docs), and getting the terraform plugin for Sublime Text installed to make.

* If you are working as a group, setup an S3 bucket for your remote shared state terraform.tfstate file(s)  and a dynamodb for your state lock (google is your friend)

  * use `terraform init` to start work whenever you create or checkout a TF repo to use the state and locking.

  * use `terraform validate .` and `terraform fmt .` to check your *.tf files for errors before committing, it can help catch errors before you attempt a `terraform plan`

  * Note that `terraform fmt .` will modify your vendor'ed .terraform/modules/ *.tf files. This will cause a problem with `terraform get --update`. Just `rm -rf .terraform/modules/*` to fix, and re-get.

* Then setup your VPC, internet gateway and subnets (AWS scenario two is a good starting point, separating public and private resources)

* Consider setting up your subnets across multiple availability zones

* Your subnets will require a routing table, and a routing table association. (avoid using inline route blobs like I have done here if you can)

* You will then want a Nat Gateway (This goes in the PUBLIC network, the private network instances point to it as their route to the internet.)

* You might want a VPN (if your location has the facilities) so you can setup a security group that allows you to go onto the private nodes without using a jump host / bastion

* Alternatively, you can use a bastion host as in this example repo.

* You can setup a database in RDS to keep state between your apps, and add other AWS goodness like elasticache, elastic search, etc etc

* note the way I have used a module to group my resources for bastion, docker swarm mode, etc. Don't use remote state inside a module, but instead pass vars in and outputs back out. Nested modules require wiring up with nested vars and outputs

* You then can deploy a few ec2 instances and provision with Ansible or your config mgmt tool of preference, or setup a consul cluster and some elasticbeanstalk apps and go mental with docker containers!


## EXERCISES FOR THE READER:

Sadly I haven't set up examples here for the last couple of points, these are left as an exercise for the reader, but the internet has plenty of examples to help here onwards.

A few ideas on how to separate your different environments...

* spin up a production VPC, a staging VPC, dev VPC, Travis-CI VPC, ...

* set up one aws account per env, use consolidated billing - see https://segment.com/blog/rebuilding-our-infrastructure/

* one vpc, using separate subnets and security groups to keep things apart


