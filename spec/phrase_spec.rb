require_relative '../lib/phrase.rb'
require 'pry'

describe 'Candidates class' do

  before :each do
    @test_scale = [45, 47, 48, 50, 52, 53, 55, 57, 59, 60, 62, 64, 65, 67, 69, 71, 72, 74, 76]
    @test_candidates = Candidates.new({:scale => @test_scale})
    @test_phrase = Phrase.new()
  end

  describe('#initialize') do
    it 'will save the tonic as the first note in the phrase' do
      expect(@test_phrase.notes).to eq([60])
    end
  end

  describe('#add_note') do
    it 'add a note to the phrase array' do
      @test_phrase.add_note(62)
      expect(@test_phrase.notes).to eq([60, 62])
    end
  end

  describe('#length') do
    it 'returns the number of notes in the phrase' do
      expect(@test_phrase.length).to eq(1)
    end
  end

  describe('#last') do
    it 'returns the last note pushed into the phrase array' do
      expect(@test_phrase.last).to eq(60)
    end
  end

  describe('#second_to_last') do
    it 'return the second to last note pushed into the phrase array' do
      @test_phrase.add_note(61)
      expect(@test_phrase.second_to_last).to eq(60)
    end
  end

  describe('#second_to_last') do
    it 'return the second to last note pushed into the phrase array' do
      @test_phrase.add_note(61)
      @test_phrase.add_note(62)
      expect(@test_phrase.third_to_last).to eq(60)
    end
  end
end
