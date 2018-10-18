#
# Cookbook Name:: addmachine
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.
#creating the config xml and creating the domain using the domain utility

include_recipe 'addmachine::commandfilexml'
include_recipe 'addmachine::domainutility'
