terraform {
  backend "s3" {
    bucket         = "siddharth-terraform-state"
    key            = "terraform-assignment/terraform.tfstate"
    region         = "ap-south-1"
    encrypt        = true
  }
}