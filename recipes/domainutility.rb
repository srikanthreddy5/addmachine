
# Cookbook Name:: addmachine
# Recipe:: domainutility
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

# Run the domainutility to create domain
#

config_user = node['addmachine-rv']['config']['user']
config_group = node['addmachine-rv']['config']['group']
tibco_instance_dir = node['addmachine-rv']['config']['tibco_instance_dir']
tra_version = node['addmachine-rv']['config']['tra_version']
tra_home_dir = "#{tibco_instance_dir}/tra/#{tra_version}"
tra_bin = "#{tra_home_dir}/bin"
addmachine_cmdfile = node['addmachine-rv']['config']['addmachine_cmdfile']

domain_name = node['addmachine-rv']['config']['domain_name']
tra_domainhome_dir = "#{tibco_instance_dir}/tra/domain"
tra_domain_dir = "#{tra_domainhome_dir}/#{domain_name}"
hawkagent = "#{tra_domain_dir}/hawkagent_#{domain_name}"

# Install the required yum packages for running 32 bit domainutility on a 64 bit OS arch
case node['platform']
when 'redhat', 'centos', 'ubuntu'
  yum_package 'glibc.i686'
  yum_package 'libstdc++.i686'
when 'amazon'
  yum_package 'glibc.i686'
  yum_package 'libstdc++48.i686'
end

# Execute the domain utility
execute 'addmachine-to-domain' do
  command "./domainutilitycmd -cmdFile #{addmachine_cmdfile}"
  cwd tra_bin
  user config_user
  group config_group
  not_if { File.exist? "#{hawkagent}" }
end

# Start the hawkagent
execute 'start_hawkagent' do
  command "nohup #{hawkagent} 2>&1 &"
  cwd tra_domain_dir
  user config_user
  group config_group
end

# domain will be created and hawkagent will started after executing
