terraform {
  backend "local" {
    path = prod/terraform.tfstate
  }
}