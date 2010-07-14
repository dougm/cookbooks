#
# Author:: Doug MacEachern <dougm@vmware.com>
# Cookbook Name:: windows
# Recipe:: bginfo
#
# Copyright 2010, VMware, Inc.
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

#http://technet.microsoft.com/en-us/sysinternals/bb897557.aspx

dst = "#{node[:bginfo][:dir]}\\BgInfo.zip"
bin = "#{node[:bginfo][:dir]}\\bin"
exe = "#{bin}\\Bginfo.exe"

directory bin do
  action :create
  recursive true
end

remote_file dst do
  source node[:bginfo][:zip]
  not_if { File.exists?(dst) }
end

ruby_block "unzip #{dst} (accepting eula=#{node[:pstools][:accept_eula]})" do
  block do
    unless File.exists?(exe)
      win32_unzip(dst, bin)
    end
    sysinternals_accept_eula(node[:pstools][:accept_eula], bin)
  end
end

execute "bginfo" do
  command "#{exe} /timer:0"
end
