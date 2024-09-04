locals {
  root_inputs = yamldecode(file(find_in_parent_folders("root_inputs.yaml")))

  # Search the file 'environment_inputs.yaml' in parent folders and add it's content to the inputs.
  # The search is done from the perspective of the calling module.
  #
  # If there is no such file, `find_in_parent_folders` will use the second parameter. This is 'NONE' to silently
  # ignore the error terragrunt will throw if there is no file.
  #
  environment_inputs_path = find_in_parent_folders("environment_inputs.yaml", "NONE")
  environment_inputs      = yamldecode(local.environment_inputs_path != "NONE" ? file(local.environment_inputs_path) : "{}")
}

# Merge all gathered data into the inputs Hash
inputs = merge(
  {
    module = basename(get_terragrunt_dir())
  },
  local.root_inputs,
  local.environment_inputs
)

# Use ~/.cache/terraform/plugin-cache for storing providers. This can be overriden by setting TF_PLUGIN_CACHE_DIR before calling terragrunt.
# The directory is created if not existent
terraform {
  extra_arguments "set environment variable for cache directory" {
    commands = ["init"]
    env_vars = {
      TF_PLUGIN_CACHE_DIR = get_env("TF_PLUGIN_CACHE_DIR", "${get_env("HOME")}/.cache/terraform/plugin-cache")
    }
  }

  before_hook "create plugin cache directory if absent" {
    commands = ["init"]
    execute  = ["bash", "-c", "test -d \"$TF_PLUGIN_CACHE_DIR\" || mkdir -p \"$TF_PLUGIN_CACHE_DIR\""]
  }
}

generate "root_variables" {
  path      = "root_variables_generated.tf"
  if_exists = "overwrite_terragrunt"
  contents  = file("${get_repo_root()}/code_snippets/root_variables.tf")
}

generate "provider" {
  path      = "provider_generated.tf"
  if_exists = "overwrite_terragrunt"
  contents  = file("${get_repo_root()}/code_snippets/provider_aws.tf")
}
