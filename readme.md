to use this repo, you should have your own AWS account and your user should have an IAM allowing sufficient access to create all the applicable resources.

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

:sparkles: thanks to Kofi, Joe and charity.wtf :sparkles: 

- https://charity.wtf/2016/03/23/aws-networking-environments-and-you/
- https://charity.wtf/2016/02/23/two-weeks-with-terraform/
- https://charity.wtf/2016/03/30/terraform-vpc-and-why-you-want-a-tfstate-file-per-env/
- https://charity.wtf/2016/04/14/scrapbag-of-useful-terraform-tips/
- https://www.terraform.io/docs/configuration/interpolation.html
- https://www.terraform.io/docs/providers/aws/index.html


so, how to follow the pauli-exclusion principle:

[best model?] spin up a production VPC, a staging VPC, dev VPC, Travis-CI VPC, ...
[alternative?] set up one aws account per env, use consolidated billing - see https://segment.com/blog/rebuilding-our-infrastructure/
[least good?] one vpc, using separate subnets and security groups to keep things apart