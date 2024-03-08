# Terraform/OpenTofu Template 

This is a template containing a basic skeleton for Terraform/OpenTofu wrapped in Terragrunt.

## General structure

### Environments

Modules that are holding state are stored in one of the environments. The environments `global`, `staging` and `production` are a good starting point.

## Create own Modules

See `environment/global/state-storage` for an example of an module.


## Hierarchical loading of data

- module loads `inputs.yaml`
- environment loads `environment_inputs.yaml`
- root loads `global_inputs.yaml`

All the loaded data is merged and passed to the called modules. The YAML files are merged with priority to specific data. That means if a value is set on root level and on module level, the module level wins.

## Generic variables

Add this snippet to your `terragrunt.hcl` to load generic variables.

```hcl
include "generic_variables" {
  path = find_in_parent_folders("generic_variables.hcl")
}
```

Variables genreated
- `environment`
- `project`
- `component`
- `region`

## Generated Code

Generated files are named "*_generated.tf", which is already excluded from git.
