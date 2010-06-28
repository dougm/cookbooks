#
# Cookbook Name:: windows
# Library:: windows
# Author:: Doug MacEachern <dougm@vmware.com>
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

#generic windows stuff

#eat dust zlib/rubyzip/zippy
#but seriously is there a simpler ruby stdlib alternative?
#http://msdn.microsoft.com/en-us/library/ms723207.aspx
def win32_unzip(zip, dir)
  require 'win32ole'
  shell = WIN32OLE.new("Shell.Application")
  source = shell.NameSpace(zip).items
  target = shell.NameSpace(dir)
  target.CopyHere(source, 4|16)
end
