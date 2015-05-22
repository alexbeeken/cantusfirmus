require_relative "../rails_helper.rb"

describe Validator do

  describe "#valid?" do

    it "Checks if a given phrase and length would be valid for the rules of Cantus Firmi." do
      expect(Validator.valid?([0, 2, 4, 7], 8)).to eq(true)
      expect(Validator.valid?([0, 2, 4, 7], 4)).to eq(false)
    end

    it "Returns valid only if the first note is the tonic." do
      expect(Validator.valid?([1], 4)).to eq(false)
    end

    it "Returns valid only if the last note is the tonic." do
      expect(Validator.valid?([0, 2, 4, 5], 4)).to eq(false)
    end

    it "Returns valid if any of the intervals are dissonant." do
      expect(Validator.valid?([0, 2, 4, 7], 4)).to eq(false)
    end

    it "Returns valid if there are no augmented fourths outlined by three notes." do
      # augmented fourth is an interval with value 8
      expect(Validator.valid?([0, 2, 8, 2], 8)).to eq(false)
    end

  end
end