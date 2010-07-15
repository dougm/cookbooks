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

#if user profile (NTUSER.DAT) is in use, the switch to the active profile
#by converting username to sid
def username_to_sid(name, key_name)
  begin
    sid = WMI::Win32_UserAccount.find(:first, :conditions => {:name => name}).sid
    path = key_name.split("\\")
    if path[0] == name
      path[0] = sid
      key_name = path.join("\\")
      Chef::Log.debug("HKEY_USERS: #{name} -> #{sid}")
    end
  rescue
  end
  key_name
end

def registry_update(mode)
  require 'win32/registry'
  require 'ruby-wmi'

  key_name = @new_resource.key_name

  hive = {
    :LOCAL_MACHINE => Win32::Registry::HKEY_LOCAL_MACHINE,
    :USERS => Win32::Registry::HKEY_USERS,
    :CURRENT_USER => Win32::Registry::HKEY_CURRENT_USER
  }[@new_resource.hkey || :LOCAL_MACHINE]

  if @new_resource.load_key
    @priv = Chef::WindowsPrivileged.new
    @new_resource.load_key.each do |name,file|
      Chef::Log.debug("RegLoadKey(#{name}, #{file})")
      unless @priv.reg_load_key(name, file)
        Chef::Log.debug("#{file} is in use (#{name} has active session?)")
        key_name = username_to_sid(name, key_name) if hive == Win32::Registry::HKEY_USERS
      end
    end
  end

  hive.send(mode, key_name, Win32::Registry::KEY_ALL_ACCESS) do |reg|
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

  if @new_resource.load_key
    @new_resource.load_key.keys.each do |name|
      begin
        @priv.reg_unload_key(name)
      rescue
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
