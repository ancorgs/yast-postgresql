# Copyright (c) 2017 SUSE LLC.
#  All Rights Reserved.

#  This program is free software; you can redistribute it and/or
#  modify it under the terms of version 2 or 3 of the GNU General
#  Public License as published by the Free Software Foundation.

#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.   See the
#  GNU General Public License for more details.

#  You should have received a copy of the GNU General Public License
#  along with this program; if not, contact SUSE LLC.

#  To contact Novell about this file by physical or electronic mail,
#  you may find current contact information at www.suse.com


require "cfa/augeas_parser"
require "cfa/base_model"
require "cfa/matcher"

module CFA
  # Will work if postgresql augeas lense do not use
  # subtrees for comments. Will work in future version of
  # CFA.
  class PostgresqlEasy < BaseModel
    PARSER = AugeasParser.new("sysctl.lns")
    PATH = "/var/lib/pgsql/data/postgresql.conf".freeze

    def initialize(file_handler: nil)
      super(PARSER, PATH, file_handler: file_handler)
    end

    attributes(
      port:            "port",
      max_connections: "max_connections"
    )
  end

  # Really working example
  class Postgresql < BaseModel
    PARSER = AugeasParser.new("postgresql.lns")
    PATH = "/var/lib/pgsql/data/postgresql.conf".freeze

    def initialize(file_handler: nil)
      super(PARSER, PATH, file_handler: file_handler)
    end

    def port
      res = value("port")
      res.to_i if res
    end

    def port=(value)
      change_value("port", value.to_s)
    end

    def max_connections
      res = value("max_connections")
      res.to_i if res
    end

    def max_connections=(value)
      change_value("max_connections", value.to_s)
    end

  private

    def value(key)
      res = data[key]
      return unless res

      if res.is_a?(AugeasTreeValue)
        res.value
      else
        res
      end
    end

    def change_value(key, value)
      res = data[key]

      if res.is_a?(AugeasTreeValue)
        res.value = value
      else
        generic_set(key, value)
      end
    end
  end
end
