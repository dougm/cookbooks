#
# Cookbook Name:: windows
# Attributes:: git
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

set_unless[:git][:release] = "1.7.0.2-preview20100309"
set_unless[:git][:mirror] = "http://msysgit.googlecode.com/files"
set_unless[:git][:dir] = "C:\\Git"

#global etc\gitconfig setting of core.autocrlf. gui installer prompts for:
#"Checkout Windows-style, commit Unix-style line endings" -> "input"
#"Checkout as-is, commit Unix-style line endings" -> "true"
#"Checkout as-is, commit as-is" -> "false"
set_unless[:git][:autocrlf] = "true"

#Adjusting your PATH environment
#"Use Git Bash only" -> "bashonly"
#"Run Git from the Windows Command Prompt" -> "cmd"
#"Run Git and included Unix tools from the Windows Command Prompt" -> "cmdtools"
set_unless[:git][:adjust_path] = "cmd"
