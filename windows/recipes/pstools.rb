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

bin = "#{node[:pstools][:dir]}\\bin"

directory bin do
  action :create
  recursive true
end

pkg_exists = {
  "PsTools" => "PsExec.exe",
  "ProcessExplorer" => "procexp.exe",
  "Handle" => "handle.exe",
  "DebugView" => "Dbgview.exe"
}

#collate various sysinternals packages
node[:pstools][:packages].each do |pkg|
  dst = "#{node[:pstools][:dir]}\\#{pkg}.zip"

  remote_file dst do
    source "#{node[:pstools][:mirror]}/Files/#{pkg.zip}.zip"
    not_if { File.exists?(dst) }
  end

  ruby_block "unzip #{dst} (accepting eula=#{node[:pstools][:accept_eula]})" do
    block do
      unless File.exists?("#{bin}\\#{pkg_exists[pkg]}")
        win32_unzip(dst, bin)
      end
      sysinternals_accept_eula(node[:pstools][:accept_eula], bin)
    end
  end
end

env "PATH" do
  action :modify
  delim File::PATH_SEPARATOR
  value bin
end
