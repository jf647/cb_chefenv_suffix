# chefenv_suffix

## Description

A simple library helper to return the suffix of a node's chef
environment.

Assuming that you use suffixed environments like `foo-test` or
`bar-prod`, the helper embedded in this cookbook provides a simple
way to return the `test` or `prod` part of the environment name.

## Usage

Add the following line to your cookbook's metadata

    depends 'chefenv_suffix', '~> 0.1'

In your recipe, when you need to use the suffix somewhere:

    vaultitem = chef_vault_item('mysecrets', chefenv_suffix)

## Attributes

The only attribute is `node['chefenv_suffix']['pattern']`, which
defaults to

    -?(\w+)$

And may be overridden to fix your needs.  The pattern must have a
single capture group, which is the suffix the helper will return.

The default pattern is designed to match against environments
named using underscores, with a dash separator for the lifecycle
(test, prod, etc.):

    foo-test
    bar-prod
    my_important_app-perf

The default pattern also returns \_default if the node's environment
is not set.

## Author

James FitzGibbon

## License

Copyright (c) 2015 James FitzGibbon, All Rights Reserved.

## Template

Generated from chef-gen-flavor 'nadt' v0.2.0
