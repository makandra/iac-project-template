# load the basic functionality
include "root" {
  path = find_in_parent_folders("root.hcl")
}

# create a globally managed versions.tf
include "versions" {
  path = find_in_parent_folders("versions.hcl")
}

inputs = merge(
  yamldecode(file("inputs.yaml"))
)
