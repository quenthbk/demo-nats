#
# Can be refacto with terragrunt
#
terraform {
  backend "local" {
    path = ".terraform/state.json"
  }
}
