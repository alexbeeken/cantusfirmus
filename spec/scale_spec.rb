require_relative '../lib/scale.rb'
require 'pry'

describe 'Scale class' do

  before :each do
    @test_scale = Scale.new()
  end

  describe '#get_notes_for_relationship' do
    it 'returns notes based on the given relationship to given note with defaults 0 and dissonant' do
      expect(@test_scale.get_notes_for_relationship()).to eq([-10, 11])
    end

    it 'returns leaps when given the leaps relationship' do
      expect(@test_scale.get_notes_for_relationship({:relationship => 'leap'})).to eq([-15, -13, -12, -10, -8, -7, -5, 5, 7, 9, 11, 12, 14, 16])
    end

    it 'returns steps when given the steps relationship' do
      expect(@test_scale.get_notes_for_relationship({:relationship => 'step'})).to eq([-3, -1, 0, 2, 4])
    end

    it 'returns steps from a given note when given a note and relationship' do
      expect(@test_scale.get_notes_for_relationship({:relationship => 'step', :note => 2})).to eq([-1, 0, 2, 4, 5])
    end

    it 'returns notes above the given note' do
      expect(@test_scale.get_notes_for_relationship({:relationship => 'up', :note => 12})).to eq([14, 16])
    end

    it 'returns notes below the given note' do
      expect(@test_scale.get_notes_for_relationship({:relationship => 'down', :note => -10})).to eq([-15, -13, -12])
    end

    it 'returns notes with two parameters given' do
      expect(@test_scale.get_notes_for_relationship({:relationship => 'step down', :note => 2})).to eq([-1, 0])
      expect(@test_scale.get_notes_for_relationship({:relationship => 'leap up', :note => 9})).to eq([14, 16])
    end
  end
end
