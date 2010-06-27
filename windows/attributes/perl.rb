#
# Cookbook Name:: windows
# Attributes:: perl
#
# Copyright 2010, VMware, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

set_unless[:perl][:release] = "5.10.1.1007/ActivePerl-5.10.1.1007-MSWin32-x86-291969.msi"
set_unless[:perl][:mirror] = "http://downloads.activestate.com"
set_unless[:perl][:dir] = "C:"

