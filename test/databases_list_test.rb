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

#  To contact SUSE about this file by physical or electronic mail,
#  you may find current contact information at www.suse.com

require_relative "test_helper.rb"

describe Y2Postgresql::DatabasesList do
  describe ".new" do
    context "with no arguments" do
      it "returns an empty list" do
        list = described_class.new
        expect(list).to be_a Y2Postgresql::DatabasesList
        expect(list).to be_empty
      end
    end

    context "receiving an array of Database objects" do
      let(:databases) { [database1, database2] }
      let(:database1) { Y2Postgresql::Database.new(name1, "owner") }
      let(:database2) { Y2Postgresql::Database.new(name2, "owner") }

      subject(:list) { described_class.new(databases) }

      context "if all the names are different" do
        let(:name1) { "name1" }
        let(:name2) { "name2" }

        it "returns a list populated with the provided databases" do
          expect(list).to be_a described_class
          expect(list).to contain_exactly(database1, database2)
        end
      end

      context "if some name is duplicated" do
        let(:name1) { "name" }
        let(:name2) { "name" }

        it "discards the duplicates" do
          expect(list).to be_a described_class
          expect(list.size).to eq 1
          expect([database1, database2]).to include list.first
        end
      end
    end
  end

  describe ".new_from_system" do
    subject(:list) { described_class.new_from_system }

    let(:psql_output) do
      <<-eos
                                           List of databases
      Name       |  Owner   | Encoding |   Collate   |    Ctype    |   Access privileges
-----------------+----------+----------+-------------+-------------+-----------------------
 db1             | user1    | UTF8     | en_US.UTF-8 | en_US.UTF-8 |
 postgres        | postgres | UTF8     | en_US.UTF-8 | en_US.UTF-8 |
 template0       | postgres | UTF8     | en_US.UTF-8 | en_US.UTF-8 | =c/postgres
 db2             | user2    | UTF8     | en_US.UTF-8 | en_US.UTF-8 |
(7 rows)

      eos
    end

    it "returns a populated list" do
      skip "left as an exercise"
    end

    it "creates a database object for each database returned by 'psql --list'" do
      skip "left as an exercise"
    end

    it "sets #exists? to true for all the created database objects" do
      skip "left as an exercise"
    end

    context "if the psql output displays databases in multiple lines" do

      let(:psql_output) do
        <<-eos
                                           List of databases
      Name       |  Owner   | Encoding |   Collate   |    Ctype    |   Access privileges
-----------------+----------+----------+-------------+-------------+-----------------------
 postgres        | postgres | UTF8     | en_US.UTF-8 | en_US.UTF-8 |
 template0       | postgres | UTF8     | en_US.UTF-8 | en_US.UTF-8 | =c/postgres          +
                 |          |          |             |             | postgres=CTc/postgres
 template1       | postgres | UTF8     | en_US.UTF-8 | en_US.UTF-8 | =c/postgres          +
                 |          |          |             |             | postgres=CTc/postgres
(7 rows)

        eos
      end

      it "handles the situation properly" do
        skip "left as an exercise"
      end
    end
  end

  describe "#add" do
    let(:initial_database) { Y2Postgresql::Database.new("name1", "user1") }
    let(:new_database) { Y2Postgresql::Database.new(new_name, "user2") }

    subject(:list) { described_class.new([initial_database]) }

    context "if there is already a database with that name" do
      let(:new_name) { "name1" }

      it "does nothing" do
        list.add(new_database)
        expect(list).to contain_exactly(initial_database)
      end
    end

    context "if there is no database with that name in the list" do
      let(:new_name) { "name2" }

      it "adds the database" do
        list.add(new_database)
        expect(list).to contain_exactly(initial_database, new_database)
      end
    end
  end

  describe "#delete" do
    context "if there is a database with that name" do
      it "removes the database from the list" do
        skip "left as an exercise"
      end

      it "returns the deleted database object" do
        skip "left as an exercise"
      end
    end

    context "if there is no database with that name in the list" do
      it "does not alter the collection" do
        skip "left as an exercise"
      end

      it "returns nil" do
        skip "left as an exercise"
      end
    end
  end

  describe "#write_to_system" do
    context "if a new database was added" do
      context "and the new database was deleted afterwards" do
        it "does nothing" do
          skip "left as an exercise"
        end
      end

      context "and the new database is still in the list" do
        it "creates the database in the system" do
          skip "left as an exercise"
        end
      end
    end

    context "if one of the databases in the system was deleted" do
      it "drops the database from the system" do
        skip "left as an exercise"
      end

      context "and a database with the same name was added" do
        it "drops the database before creating the new one" do
          skip "left as an exercise"
        end
      end
    end
  end
end
