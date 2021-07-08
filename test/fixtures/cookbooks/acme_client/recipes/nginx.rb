#
# Author:: Thijs Houtenbos <thoutenbos@schubergphilis.com>
# Cookbook:: acme_client
# Recipe:: nginx
#
# Copyright 2015-2018 Schuberg Philis
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

yum_package 'epel-release' do
  only_if { platform_family?('rhel') }
end

if platform_family?('debian')
  apt_update
  apt_package 'apt-transport-https'
end

# Install a webserver
nginx_install 'nginx'

nginx_config 'nginx'

nginx_service 'nginx' do
  action :start
end

nginx_site 'test' do
  cookbook cookbook_name
  template 'nginx-test.conf'

  notifies :reload, 'nginx_service[nginx]', :immediately
end
