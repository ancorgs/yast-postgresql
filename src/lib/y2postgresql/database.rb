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
    attr_accessor :name
    attr_accessor :owner

    def initialize(name, owner, exists: false)
      @name = name
      @owner = owner
      @exists = exists
    end

    def createdb
      run_as_postgres("/usr/bin/createdb", name, "-O", owner) unless exists?
      @exists = true
    end

    def dropdb
      run_as_postgres("/usr/bin/dropdb", name) if exists?
      @exists = false
    end

    def exists?
      @exists
    end

  private

    def run_as_postgres(*cmd_parts)
      Yast::Execute.on_target("sudo", "-u", "postgres", *cmd_parts)
    end
  end
end
