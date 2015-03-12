require_relative '../lib/candidates.rb'
require 'pry'

describe 'Candidates class' do

  before :each do
    @test_candidates = Candidates.new({})
    @test_phrase = Phrase.new({})
  end

  describe '#next_note' do
    it 'returns a second note and puts it into the given phrase' do
      @test_phrase.add_note(@test_candidates.next_note(@test_phrase))
      expect(@test_phrase.notes.length).to eq(2)
    end
  end
end
