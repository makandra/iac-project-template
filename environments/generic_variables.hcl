generate "global_variables" {
  path      = "global_variables_generated.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
variable "module" {
  type = string
}

variable "environment" {
  type = string
}

variable "project" {
  type = string
}

variable "region" {
  type = string
}
EOF

}
