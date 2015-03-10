require_relative '../lib/candidates.rb'
require 'pry'

describe 'Candidates class' do

  before :each do
    @test_scale = [45, 47, 48, 50, 52, 53, 55, 57, 59, 60, 62, 64, 65, 67, 69, 71, 72, 74, 76]
    @test_candidates = Candidates.new({:scale => @test_scale})
  end

  describe '#initialize' do
    it 'creates a new array of candidates for the next note of the phrase' do
      expect(@test_candidates.notes).to eq(@test_scale)
      expect(@test_candidates.scale).to eq(@test_scale)
      expect(@test_candidates.tonic).to eq(60)
    end
  end

  describe '#reset' do
    it 'resets the scale within the phrase to be the initialized scale' do
      @test_candidates.remove_leaps(60)
      expect(@test_candidates.notes).to eq([57, 59, 62, 64])
      @test_candidates.reset
      expect(@test_candidates.notes).to eq(@test_scale)
    end
  end

  describe '#remove_dissonances' do
    it 'removes all dissonant intervals for a given note' do
      @test_candidates.remove_dissonances(60)
      expect(@test_candidates.notes).to eq([45, 47, 48, 52, 53, 55, 57, 59, 62, 64, 65, 67, 69, 72, 74, 76])
    end
  end

  describe '#remove_leaps' do
    it 'removes all intervals greater than a third' do
      @test_candidates.remove_leaps(60)
      expect(@test_candidates.notes).to eq([57, 59, 62, 64])
    end
  end

  describe '#remove_leaps_in_direction' do
    it 'removes all leaps in a given direction' do
      @test_candidates.remove_leaps_in_direction(60, true)
      expect(@test_candidates.notes).to eq([62, 64])
    end
  end

  describe '#remove_all_nonleading_tones' do
    it 'removes all notes that are not leading tones' do
      @test_candidates.remove_all_nonleading_tones
      expect(@test_candidates.notes).to eq([62, 59])
    end
  end

  describe '#remove_steps' do
    it 'removes all intervals less than a fourth' do
      @test_candidates.remove_steps(60)
      expect(@test_candidates.notes).to eq([45, 47, 48, 50, 52, 53, 55, 65, 67, 69, 71, 72, 74, 76])
    end
  end

  describe '#remove_intervals' do
    it 'removes all intervals passed into it' do
      @test_candidates.remove_intervals(60, [15, 13, 12, 10, 8, 7, 5, -11, -12, -14, -16])
      expect(@test_candidates.notes).to eq([57, 59,60, 62, 64, 65, 67, 69])
    end
  end

  describe '#pick_one' do
    it 'picks a note randomly from the candidates, favoring steps over leaps' do
      picked_one = @test_candidates.pick_one(60)
      expect([45, 47, 48, 50, 52, 53, 55, 57, 59, 60, 62, 64, 65, 67, 69, 71, 72, 74, 76].include?(picked_one)).to eq(true)
    end
  end

  describe '#remove_all_except_tonic' do
    it 'removes all notes except the tonic' do
      @test_candidates.remove_all_except_tonic
      expect(@test_candidates.notes).to eq([60])
    end
  end

  describe '#delete' do
    it 'removes the specified candidate from the notes array' do
      @test_candidates.delete(62)
      expect([45, 47, 48, 50, 52, 53, 55, 57, 59, 60, 64, 65, 67, 69, 71, 72, 74, 76])
    end
  end
end
