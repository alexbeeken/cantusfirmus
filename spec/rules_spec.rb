require_relative '../lib/rules.rb'
require 'pry'

describe 'Rules class' do

  before :each do
    @rules = Rules.new()
    @@phrase = Phrase.new({})
  end

  describe '#find_rule_breaking_relationships' do
    it '#returns the string "dissonant" in an array when when given a @phrase of one or two notes' do
      expect(@rules.find_rule_breaking_relationships(@phrase).include?('dissonant')).to eq(true)
      expect(@rules.find_rule_breaking_relationships(@phrase).include?('leap')).to eq(true)
      @phrase.add_note(2)
      expect(@rules.find_rule_breaking_relationships(@phrase).include?('dissonant')).to eq(true)
    end

    it '#returns the string "leap" when the last interval is a leap and the second to last interval is a leap' do
    end
  end
end
