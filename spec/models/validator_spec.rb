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

    it "Returns valid if there are no augmented fourths, major 7ths or minor 7ths outlined by three notes." do
      # augmented fourth is an interval with value 8
      expect(Validator.valid?([0, 2, 8, 2], 8)).to eq(false)
      expect(Validator.valid?([0, 2, 0, 11], 8)).to eq(false)
      expect(Validator.valid?([0, 2, 12, 2], 8)).to eq(false)
    end

    it "Returns valid if the last three notes are within an octave." do
      expect(Validator.valid?([0, 2, 11, 16], 8)).to eq(false)
    end

    it "Returns valid if the last three intervals are not M2s in the same direction." do
      expect(Validator.valid?([0, 2, 5, 7, 9, 11], 8)).to eq(false)
    end

    it "Returns valid if the last three intervals are not 3rds of any kind in the same direction." do
      expect(Validator.valid?([0, 2, 5, 9, 12], 8)).to eq(false)
    end

  end
end
