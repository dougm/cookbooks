#
# Cookbook Name:: perl
# Recipe:: windows
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

#XXX >> attributes
msi = "ActivePerl-5.10.1.1007-MSWin32-x86-291969.msi"
dir = "C:\\"

tmp = ENV['TMP']
dst = "#{tmp}\\#{msi}"

unless File.exists?("#{dir}/bin/perl.exe")
  unless File.exists?(dst)
    remote_file dst do
      source "http://downloads.activestate.com/ActivePerl/releases/5.10.1.1007/#{msi}"
    end
  end

  #XXX chef execute provider has no chance atm due to popen4
  system "msiexec /qn /i #{dst} TARGETDIR=#{dir} PERL_PATH=Yes"
end


