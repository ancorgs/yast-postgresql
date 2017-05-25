#!/bin/sh

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
