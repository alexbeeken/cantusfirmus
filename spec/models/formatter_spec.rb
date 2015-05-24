require_relative "../rails_helper.rb"

describe Formatter do

  describe ".format_notes" do

    it "Returns a string" do
      expect(Formatter.format_notes([0,2,4], 60).class).to eq(String)
    end

    it "Returns the given array into VexFlow compatiable letter names and octaves." do
      expect(Formatter.format_notes([0,2,4], 60)).to eq("C/4 D/4 E/4")
    end
  end
end
