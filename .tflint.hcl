rule "terraform_required_version" {
  enabled = false

}
rule "terraform_required_providers" {
  enabled = false

  # defaults
  source  = false
  version = false
}
