#
# Cookbook Name:: windows
# Recipe:: pstools
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

#install pstools and add to PATH
#optionally accept eula for all programs

require 'win32/registry'

dst = "#{node[:pstools][:dir]}\\PsTools.zip"
bin = "#{node[:pstools][:dir]}\\bin"

if node[:pstools][:accept_eula] == true
  #avoid eula dialog box on first run of *.exe
  key = Win32::Registry::HKEY_CURRENT_USER.create('Software\Sysinternals')

  Dir.glob("#{bin}\\*.exe").each do |file|
    file = File.basename(file).gsub("\.exe", "")
    key.create(file).write_i("EulaAccepted", 1)
  end
end

directory bin do
  action :create
  recursive true
end

remote_file dst do
  source node[:pstools][:zip]
  not_if { File.exists?(dst) }
end

ruby_block "unzip #{dst}" do
  block do
    unless File.exists?("#{bin}\\PsExec.exe")
      win32_unzip(dst, bin)
    end
  end
end

env "PATH" do
  action :modify
  delim File::PATH_SEPARATOR
  value bin
end
