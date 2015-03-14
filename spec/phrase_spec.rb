require_relative '../lib/phrase.rb'
require 'pry'

describe 'Phrase class' do

  before :each do
    @test_phrase = Phrase.new()
  end

  describe('#initialize') do
    it 'will save the tonic as the first note in the phrase' do
      expect(@test_phrase.notes).to eq([0])
    end
  end

  describe('#add_note') do
    it 'add a note to the phrase array' do
      @test_phrase.add_note(2)
      expect(@test_phrase.notes).to eq([0, 2])
    end
  end

  describe('#length') do
    it 'returns the expected length of the phrase when it is done' do
      expect(@test_phrase.length).to eq(8)
    end
  end

  describe('#last') do
    it 'returns the last note pushed into the phrase array' do
      expect(@test_phrase.last).to eq(0)
    end
  end

  describe('#second_to_last') do
    it 'return the second to last note pushed into the phrase array' do
      @test_phrase.add_note(1)
      expect(@test_phrase.second_to_last).to eq(0)
    end
  end

  describe('#third_to_last') do
    it 'return the third to last note pushed into the phrase array' do
      @test_phrase.add_note(1)
      @test_phrase.add_note(2)
      expect(@test_phrase.third_to_last).to eq(0)
    end
  end
end
