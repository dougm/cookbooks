#
# Author:: Doug MacEachern (<dougm@vmware.com>)
# Cookbook Name:: java
# Attributes:: windows
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

set_unless[:java][:release] = "6u20"
if node[:kernel][:machine] == "x86_64"
  set_unless[:java][:jdk_arch] = "x64"
else
  set_unless[:java][:jdk_arch] = "i586"
end
set_unless[:java][:jdk_dir] = "C:\\jdk"
set_unless[:java][:jre_dir] = "C:\\jre"

set[:java][:checksum]["jdk-6u20-windows-x64.exe"] = "ef317ae81689c1f33994b81bf8c98beb3996d572"
set[:java][:checksum]["jdk-6u20-windows-i586.exe"] = "ca690354bda417579961d404ff62eee6baf4c3ab"
