require_relative '../lib/candidates.rb'
require 'pry'

describe 'Candidates class' do

  describe '#next_note' do
    it 'chooses a note based on the rules class' do
      @phrase = Phrase.new({})
      @scale = Scale.new({})
      @rules = Rules.new({})
      @test_candidates = Candidates.new({:phrase => @phrase, :scale => @scale, :rules => @rules})
      expect([[-15], [-12], [-10],[-8],[-7],[-5],[-3],[-1],[0],[2],[4],[5],[7],[9],[12],[14],[16]].include?(@test_candidates.next_note)).to eq(true)
    end
  end
end
