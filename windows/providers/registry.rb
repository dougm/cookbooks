#
# Author:: Doug MacEachern <dougm@vmware.com>
# Cookbook Name:: windows
# Provider:: registry
#
# Copyright:: 2010, VMware, Inc.
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

def registry_update(mode)
  require 'win32/registry'

  hive = {
    :LOCAL_MACHINE => Win32::Registry::HKEY_LOCAL_MACHINE,
    :USERS => Win32::Registry::HKEY_USERS,
    :CURRENT_USER => Win32::Registry::HKEY_CURRENT_USER
  }[@new_resource.hkey || :LOCAL_MACHINE]

  hive.send(mode, @new_resource.key_name, Win32::Registry::KEY_ALL_ACCESS) do |reg|
    @new_resource.values.each do |k,val|
      key = "#{k}" #wtf. avoid "can't modify frozen string" in win32/registry.rb
      cur_val = nil
      begin
        cur_val = reg[key]
      rescue
        #subkey does not exist (ok)
      end
      if cur_val != val
        Chef::Log.debug("#{@new_resource}: setting #{key}=#{val}")
        reg[key] = val
        @new_resource.updated = true
      end
    end
  end
end

def action_create
  registry_update(:create)
end

def action_modify
  registry_update(:open)
end
