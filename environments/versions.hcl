# Use override files to enable merging terraform blocks:
# https://www.terraform.io/language/files/override#merging-terraform-blocks
generate "versions" {
  path      = "versions_generated_override.tf"
  if_exists = "overwrite_terragrunt"
  contents  = file("${get_repo_root()}/code_snippets/versions.tf")
}
