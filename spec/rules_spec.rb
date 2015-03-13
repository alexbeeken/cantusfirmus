require_relative '../lib/rules.rb'
require 'pry'

describe 'Rules class' do

  before :each do
    @rules = Rules.new()
  end

  describe '#find_rule_breaking_relationships' do
    it '#returns the string "dissonant" in an array when when given a phrase of one or two notes' do
      phrase = Phrase.new({})
      expect(@rules.find_rule_breaking_relationships(phrase).include?('dissonant')).to eq(true)
    end
  end
end
