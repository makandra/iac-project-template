# load the basic functionality
include "root" {
  path = find_in_parent_folders("root.hcl")
}

inputs = merge(
  yamldecode(file("inputs.yaml"))
)
