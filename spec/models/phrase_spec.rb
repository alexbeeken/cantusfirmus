require_relative "../rails_helper.rb"

describe Phrase do

  describe "#initialize" do

    it "Creates a valid phrase of 8 notes if given no examples" do
      phrase = Phrase.new
      expect(phrase.notes.length).to eq(8)
      expect(phrase.notes.last.class).to eq(Fixnum)
    end

    it "Creates a valid phrase of 10 notes if given no examples" do
      phrase = Phrase.new(length: 10)
      expect(phrase.notes.length).to eq(10)
      expect(phrase.notes.last.class).to eq(Fixnum)
    end
  end
end
