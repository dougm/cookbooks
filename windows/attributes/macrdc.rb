#
# Cookbook Name:: windows
# Attributes:: macrdc
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

set_unless[:macrdc][:connections_dir] = "#{ENV['HOME']}/Documents/RDC Connections"
set_unless[:macrdc][:desktop_width] = "1280"
set_unless[:macrdc][:desktop_height] = "800"
set_unless[:macrdc][:mirror] = "http://download.microsoft.com/download"
set_unless[:macrdc][:dmg_path] = "C/B/9/CB943CBF-DDA8-4580-A711-88AC23763F0E/RDC201_ALL.dmg"
set_unless[:macrdc][:target] = "/Applications"
