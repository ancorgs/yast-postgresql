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

require_relative "../test_helper"

require "cfa/memory_file"
require "cfa/postgresql"

describe CFA::Postgresql do
  let(:data_file_path) { File.expand_path("../../data/postgresql.conf", __FILE__) }
  let(:file) { CFA::MemoryFile.new(File.read(data_file_path)) }
  subject { described_class.new(file_handler: file) }

  before do
    subject.load
  end

  describe "port" do
    it "return nil if not port is defined"
  end

  describe "port=" do
    it "sets port to given value"
  end
end
