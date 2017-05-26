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
    include Yast::Logger

    def_delegators :@databases, :each, :empty?, :length, :size, :last

    def initialize(databases = [])
      @databases = []
      databases.each { |db| add(db) } if databases
    end

    # Reads the system databases into a new list
    #
    # @return [DatabasesList] list containing a database object for each
    #   database in the system
    def self.new_from_system
      list = new
      list.read
      list
    end

    # Adds a given database to the list
    #
    # @param database [Database]
    def add(database)
      return if @databases.any? { |db| db.name == database.name }
      @databases << database
      database
    end

    # Removes a database from the list
    #
    # @param [String] name of the database to delete
    def delete(name)
      @databases.delete_if { |db| db.name == name }
    end

    # Adds an entry to the list for every database in the local PostgreSQL system
    def read
      list = Yast::Execute.on_target(
        "sudo", "-u", "postgres", "/usr/bin/psql", "--list", stdout: :capture
      )
      return unless list

      # Stripping the first 3 and last 3 lines is obviously a too simplistic
      # approach. We want to focus on the Yast::Execute (Cheetah) usage, not
      # on parsing stuff with Ruby.
      list.lines[3..-3].each do |line|
        name, owner = line.split("|")
        name.strip!
        next if name.empty?
        add(Database.new(name, owner.strip, exists: true))
      end
    end

    def write_to_system
      log.error "Not implemented yet"
    end
  end
end
