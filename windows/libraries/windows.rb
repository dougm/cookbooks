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

#gem rubyzip; is there a ruby stdlib alternative?
def win32_unzip(file, dest, force=true)
  require 'zip/zip'
  Zip::ZipFile.open(file) do |zip|
    zip.each do |entry|
      path = File.join(dest, entry.name)
      FileUtils.mkdir_p(File.dirname(path))
      if force && File.exists?(path)
        FileUtils.rm(path)
      end
      zip.extract(entry, path)
    end
  end
end
