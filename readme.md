

to use this repo, you should have your own AWS account and your user should have an IAM allowing sufficient access to create all the applicable resources.

The IAM credentials should be setup similar to the following (use your own access_key and secret, obviously!)

  $ cat ~/.aws/config
  [default]
  region = eu-west-1


  $ cat ~/.aws/credentials
  [default]
  aws_access_key_id = ABCDEFGHIJKLMNOPQRST
  aws_secret_access_key = A1B2C3D4E5F6G7H8I9J0k1l2m3n4o5p6q7r8s9t0


