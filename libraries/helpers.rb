def chefenv_suffix
  node.chef_environment.match(node['chefenv_suffix']['pattern'])[1]
end
