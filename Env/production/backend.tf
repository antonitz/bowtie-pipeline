
#GCS Bucket Terraform State will be stored
terraform {
  backend "gcs" {
    bucket = "antonivpc-tfstate"
    prefix = "env/production"
  }
}

#Terraform CLI version, run "terraform version" to determine local CLI version
terraform {
  required_version = ">= 1.0.0"
}
