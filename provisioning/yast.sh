#!/bin/sh

# Copyright (c) 2017 SUSE LLC.
#  All Rights Reserved.
#
#  This program is free software; you can redistribute it and/or
#  modify it under the terms of version 2 or 3 of the GNU General
#  Public License as published by the Free Software Foundation.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.   See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, contact SUSE LLC.
#
#  To contact Novell about this file by physical or electronic mail,
#  you may find current contact information at www.suse.com

# Enable YaST and Ruby development repositories
zypper ar -f --no-gpgcheck \
     http://download.opensuse.org/repositories/devel:/languages:/ruby:/extensions/openSUSE_Leap_42.1/ \
     devel_languages_ruby_extensions
zypper ar -f --no-gpgcheck \
     http://download.opensuse.org/repositories/devel:/languages:/ruby/openSUSE_Leap_42.1/ \
     devel_languages_ruby
zypper ar -f --no-gpgcheck \
     http://download.opensuse.org/repositories/YaST:/Head/openSUSE_42.1/ \
     yast_head

# Refresh repos
zypper refresh

# Install YaST and Ruby packages
zypper -n in osc yast2-devtools ruby-devel ruby2.1-rubygem-bundler \
     ruby2.1-rubygem-rspec ruby2.1-rubygem-yast-rake ruby2.1-rubygem-byebug \
     ruby2.1-rubygem-simplecov ruby2.1-rubygem-libyui-rake ruby2.1-rubygem-rubocop
zypper -n in -t pattern devel_basis

# Install PostgreSQL
zypper -n in postgresql postgresql-server
