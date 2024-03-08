# load the basic functionality
include "root" {
  path = find_in_parent_folders("root.hcl")
}

# load generic variables
include "generic_variables" {
  path = find_in_parent_folders("generic_variables.hcl")
}

inputs = merge(
  yamldecode(file("inputs.yaml"))
)
