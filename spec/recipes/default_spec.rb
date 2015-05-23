RSpec.describe 'tester::default' do
  it 'matches against a -test environment' do
    chef_run = ChefSpec::ServerRunner.new do |node, server|
      server.create_environment('foo-test')
      node.chef_environment = 'foo-test'
      server.create_node(node)
    end.converge(described_recipe)
    expect(chef_run.node['tester']['chefenv_suffix']).to eq 'test'
  end

  it 'matches against a -prod environment' do
    chef_run = ChefSpec::ServerRunner.new do |node, server|
      server.create_environment('foo-prod')
      node.chef_environment = 'foo-prod'
      server.create_node(node)
    end.converge(described_recipe)
    expect(chef_run.node['tester']['chefenv_suffix']).to eq 'prod'
  end

  it 'matches the smallest part of the environment' do
    chef_run = ChefSpec::ServerRunner.new do |node, server|
      server.create_environment('foo-bar-prod')
      node.chef_environment = 'foo-bar-prod'
      server.create_node(node)
    end.converge(described_recipe)
    expect(chef_run.node['tester']['chefenv_suffix']).to eq 'prod'
  end

  it 'matches against the _default environment' do
    chef_run = ChefSpec::ServerRunner.new.converge(described_recipe)
    expect(chef_run.node['tester']['chefenv_suffix']).to eq '_default'
  end

  it "matches against an environment that doesn't match the pattern" do
    chef_run = ChefSpec::ServerRunner.new do |node, server|
      server.create_environment('foo')
      node.chef_environment = 'foo'
      server.create_node(node)
    end.converge(described_recipe)
    expect(chef_run.node['tester']['chefenv_suffix']).to eq 'foo'
  end

  it 'allows the pattern to be overridden' do
    chef_run = ChefSpec::ServerRunner.new do |node, server|
      server.create_environment('foo_prod')
      node.chef_environment = 'foo_prod'
      node.set['chefenv_suffix']['pattern'] = '_(\w+)$'
      server.create_node(node)
    end.converge(described_recipe)
    expect(chef_run.node['tester']['chefenv_suffix']).to eq 'prod'
  end
end
