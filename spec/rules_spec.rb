require_relative '../lib/rules.rb'
require_relative '../lib/phrase.rb'
require 'pry'

describe 'Rules class' do

  before :each do
    @rules = Rules.new()
    @phrase = Phrase.new({})
  end

  describe '#find_rule_breaking_relationships' do

    it '#returns the string "dissonant" in an array when when given a @phrase of one note' do
      expect(@rules.find_rule_breaking_relationships(@phrase).include?('dissonant')).to eq(true)
      expect(@rules.find_rule_breaking_relationships(@phrase).include?('leap')).to eq(true)
    end

    it 'returns the string "dissonant" in an array when given a @phrase of two notes' do
      @phrase.add_note(2)
      expect(@rules.find_rule_breaking_relationships(@phrase).include?('dissonant')).to eq(true)
    end

    it '#returns the string "all_except_tonic" when the note is the last note' do
      @phrase.add_note(2)
      @phrase.add_note(4)
      @phrase.add_note(5)
      @phrase.add_note(7)
      @phrase.add_note(9)
      @phrase.add_note(11)
      expect(@rules.find_rule_breaking_relationships(@phrase).include?(["dissonant", "not_in_octave",  "all_except_tonic"]))
    end

    it 'returns the string "all_nonleading_tones" when the note is second to last note' do
      @phrase.add_note(2)
      @phrase.add_note(4)
      @phrase.add_note(5)
      @phrase.add_note(7)
      @phrase.add_note(9)
      expect(@rules.find_rule_breaking_relationships(@phrase).include?(["dissonant", "not_in_octave",  "all_nonleading_tones"]))
    end

    it 'returns "leap down" when the second to last interval of an unfinished phrase is a leap and the last interval is in the down direction' do
      @phrase.add_note(2)
      @phrase.add_note(10)
      @phrase.add_note(12)
      expect(@rules.find_rule_breaking_relationships(@phrase).include?(["dissonant", "not_in_octave", "leap down"]))
    end

    it 'returns "leap up" when the second to last interval of an unfinished phrase is a leap and the last interval is in the up direction' do
      @phrase.add_note(-2)
      @phrase.add_note(-10)
      @phrase.add_note(-12)
      expect(@rules.find_rule_breaking_relationships(@phrase).include?(["dissonant", "not_in_octave", "leap up"]))
    end

    it 'returns "major_second down" when the last two intervals are major seconds down' do
      @phrase.add_note(-3)
      @phrase.add_note(-5)
      @phrase.add_note(-7)
      expect(@rules.find_rule_breaking_relationships(@phrase)).to eq(["dissonant", "not_in_octave", "major_second down"])
    end

    it 'returns "major_second up" when the last two intervals are major seconds up' do
      @phrase.add_note(2)
      @phrase.add_note(4)
      expect(@rules.find_rule_breaking_relationships(@phrase)).to eq(["dissonant", "not_in_octave", "major_second up"])
    end
  end
end
