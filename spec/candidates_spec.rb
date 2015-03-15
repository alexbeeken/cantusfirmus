require_relative '../lib/candidates.rb'
require 'pry'

describe 'Candidates class' do

  describe '#next_note' do
    it 'chooses a note based on the rules class' do
      @phrase = Phrase.new()
      @scale = Scale.new()
      @rules = Rules.new()
      @test_candidates = Candidates.new({:phrase => @phrase, :scale => @scale, :rules => @rules})
      @phrase.add_note(@test_candidates.next_note)
      puts("got #{@phrase.last} on test 1.1")
      expect([-3,-1,2,4].include?(@phrase.last)).to eq(true)
      @test_candidates = Candidates.new({:phrase => @phrase, :scale => @scale, :rules => @rules})
      @phrase.add_note(@test_candidates.next_note)
      puts("got #{@phrase.last} on test 1.2")
      puts("phrase looks like #{@phrase.notes}")
    end
  end
end
