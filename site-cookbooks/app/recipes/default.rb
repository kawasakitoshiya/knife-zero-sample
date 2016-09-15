#
# Cookbook Name:: app
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
include_recipe 'postgresql::client'
include_recipe 'postgresql::server'
include_recipe 'postgresql::contrib'
include_recipe 'rbenv::default'
include_recipe 'rbenv::ruby_build'
include_recipe 'imagemagick::default'

include_recipe "database::postgresql"

postgresql_connection_info = {
  :host     => '127.0.0.1',
  :port     => node['postgresql']['config']['port'],
  :username => 'postgres',
  :password => node['postgresql']['password']['postgres']
}

postgresql_database_user 'sample-user' do
  connection postgresql_connection_info
  password   'ultra_secret'
  action     :create
end

rbenv_ruby "2.3.1"

rbenv_gem "bundler" do
  ruby_version "2.3.1"
end
