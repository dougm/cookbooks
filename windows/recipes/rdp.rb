#
# Cookbook Name:: windows
# Recipe:: rdp
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

#enable Remote Desktop and poke the firewall hole
#XXX make this a provider
require 'win32/registry'

TERM_SERVICE = 'SYSTEM\CurrentControlSet\Control\Terminal Server'

Win32::Registry::HKEY_LOCAL_MACHINE.open(TERM_SERVICE, Win32::Registry::KEY_ALL_ACCESS) do |reg|
  if reg['FdenyTSConnections'] == 0
    Chef::Log.debug("Remote desktop already enabled")
  else
    reg['FdenyTSConnections'] = 0
    Chef::Log.info("Remote desktop is now enabled")
  end
end

execute "rdp enable" do
  command "netsh firewall set service remotedesktop enable"
end
