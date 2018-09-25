#
# Cookbook:: mongo
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.
apt_update('update') do
  action :update
end

apt_repository('mongodb-org') do
  uri 'https://repo.mongodb.org/apt/ubuntu'
  distribution "xenial/mongodb-org/3.2"
  components ["multiverse"]
  keyserver "hkp://keyserver.ubuntu.com:80"
  key "EA312927"
  action :add
end

package "mongodb-org" do
  action :upgrade
end

file "/etc/mongod.conf" do
  action :delete
end

template "/etc/mongod.conf" do
  source 'mongod.conf.erb'
end

template "/lib/systemd/system/mongod.service" do
  source 'mongod.service.erb'
end

service "mongod" do
  action [:enable, :start]
end
