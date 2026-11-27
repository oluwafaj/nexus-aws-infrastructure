terraform {
  backend "s3" {
    bucket       = "nexus-tfstate-s3bucket"
    key          = "ec2/app/terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
  }
}
