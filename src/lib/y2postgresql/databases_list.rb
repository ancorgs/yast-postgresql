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
require "yast2/execute"
require "y2postgresql/database"

module Y2Postgresql
  # Simplistic container of database objects
  class DatabasesList
    include Enumerable
    extend Forwardable

    def_delegators :@databases, :each, :empty?, :length, :size, :last

    def initialize(databases = [])
      @databases = databases.dup
    end

    def self.new_from_system
      new
    end

    def add(database)
      @databases << database
      database
    end

    def delete(name)
      @database.delete_if { |db| db.name == name }
    end
  end
end
