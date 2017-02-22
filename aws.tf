provider "aws" {
  profile                 = "${var.current_profile}"
  //shared_credentials_file = "${var.shared_creds_file}"
  region                  = "${var.region}"
}
