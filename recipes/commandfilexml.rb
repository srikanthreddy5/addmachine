#
# Cookbook Name:: addmachine
# Recipe:: commandfilexml
#
# Copyright (c) 2016 The Authors, All Rights Reserved.
#
# Generate the AddMachine.xml from the template

addmachine_cmdfile = node['addmachine-rv']['config']['addmachine_cmdfile']
rv_port = node['addmachine-rv']['config']['rv_port'].to_i
rv_network = node['addmachine-rv']['config']['rv_network']
application_hawk_daemonport = rv_port + 74

application_rv_daemon = "tcp:#{rv_port}"
application_rv_network = rv_network
application_rv_service = rv_port
application_hawk_daemon = "tcp:#{application_hawk_daemonport}"
application_hawk_network = rv_network
application_hawk_service = application_hawk_daemonport

tibco_instance_dir = node['addmachine-rv']['config']['tibco_instance_dir']
tra_domainhome_dir = "#{tibco_instance_dir}/tra/domain"

template 'AddMachine.xml' do
  source 'AddMachine.xml.erb'
  mode '0755'
  path addmachine_cmdfile
  variables(
    var_application_rv_daemon:  application_rv_daemon,
    var_application_rv_network:  application_rv_network,
    var_application_rv_service:  application_rv_service,
    var_application_hawk_daemon:  application_hawk_daemon,
    var_application_hawk_network:  application_hawk_network,
    var_application_hawk_service:  application_hawk_service,
    var_tra_domainhome_dir: tra_domainhome_dir
  )
end
