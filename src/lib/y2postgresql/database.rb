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

require "yast"

module Y2Postgresql
  # Simplistic model to represent a PostgreSQL database (may be present in the
  # system already or not).
  class Database
    # @return name [String] name of the database
    attr_accessor :name

    # @return owner [String] name of the PostgreSQL role owning the database
    attr_accessor :owner

    def initialize(name, owner, exists: false)
      @name = name
      @owner = owner
      @exists = exists
    end

    # Creates the database in the local PostgreSQL system
    def createdb
    end

    # Removes the database from the local PostgreSQL system
    def dropdb
    end

    # Whether the database exists already in the system
    #
    # @return [Boolean]
    def exists?
      @exists
    end
  end
end
