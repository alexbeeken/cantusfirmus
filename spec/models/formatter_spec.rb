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

  describe ".format_examples" do

    it "Return an array from inputted examples formats" do
      expect(Formatter.format_examples("0 2 4 7 4 2 0 | 0 -1 -3 -1 2 0")).to eq([[0, 2, 4, 7, 4, 2, 0],[0, -1, -3, -1, 2, 0]])
    end
  end
end
