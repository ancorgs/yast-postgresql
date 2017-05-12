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
  # Yes, we could use Enumerator but this is not a Ruby workshop :-)
  class DatabasesList
    include Enumerable
    extend Forwardable

    def_delegators :@databases, :each, :empty?, :length, :size, :last

    def initialize(databases = [])
      @databases = []
      @deleted = []

      databases.each { |db| add(db) } if databases
    end

    def self.new_from_system
      list = new
      list.read
      list
    end

    def add(database)
      return if @databases.any? { |db| db.name == database.name }
      @databases << database
      database
    end

    def delete(name)
      database = @databases.detect { |db| db.name == name }
      return nil unless database

      @databases.delete(database)
      @deleted << database if database.exists?
      database
    end

    def write_to_system
      @deleted.each(&:dropdb)

      @databases.each do |db|
        db.createdb unless db.exists?
      end
    end

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
  end
end
