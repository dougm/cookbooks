#
# Author:: Doug MacEachern <dougm@vmware.com>
# Cookbook Name:: windows
# Provider:: unzip
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

def action_run
  Chef::Log.debug("unzip #{@new_resource.source} -> #{@new_resource.path} (force=#{@new_resource.force})")
  win32_unzip(@new_resource.source, @new_resource.path, @new_resource.force)
end
