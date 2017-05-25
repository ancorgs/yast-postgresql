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
    it "return nil if not port is defined" do
      expect(subject.port).to eq nil
    end
  end

  describe "port=" do
    it "sets port to given value" do
      subject.port = 50
      subject.save

      expect(file.content.lines).to include("port = '50'\n")
    end
  end
end
