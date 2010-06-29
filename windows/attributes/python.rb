#
# Cookbook Name:: windows
# Attributes:: python
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

set_unless[:python][:release] = "2.6.5/python-2.6.5.msi"
set_unless[:python][:mirror] = "http://www.python.org/ftp"
set_unless[:python][:dir] = "C:\\python26"

