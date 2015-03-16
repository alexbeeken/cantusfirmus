require_relative '../lib/candidates.rb'
require 'pry'

describe 'Candidates class' do

  before :each do
    @phrase = Phrase.new()
    @scale = Scale.new()
    @rules = Rules.new()
  end

  describe '#next_note' do

    # Example #1 always taking the leftmost note

    it 'correctly finds the next possible notes for any second note (2)' do
      @test_candidates = Candidates.new({:phrase => @phrase, :scale => @scale, :rules => @rules})
      @phrase.add_note(@test_candidates.next_note)
      expect(@test_candidates.last_selection).to eq([-3,-1,2,4])
    end

    it 'correctly finds the next possible notes for [0, -3] (3)' do
      @phrase.add_note(-3)
      @test_candidates = Candidates.new({:phrase => @phrase, :scale => @scale, :rules => @rules})
      @phrase.add_note(@test_candidates.next_note)
      expect(@test_candidates.last_selection).to eq([-15,-12,-10,-8,-7,-5,-1,0,2,4,5,9])
    end

    it 'correctly finds the next possible notes for [0, -3, -15] (4)' do
      @phrase.add_note(-3)
      @phrase.add_note(-15)
      @test_candidates = Candidates.new({:phrase => @phrase, :scale => @scale, :rules => @rules})
      @phrase.add_note(@test_candidates.next_note)
      expect(@test_candidates.last_selection).to eq([-13,-12,-10,-8,-7,-3])
    end

    it 'correctly finds the next possible notes for [0, -3, -15, -13] (5)' do
      @phrase.add_note(-3)
      @phrase.add_note(-15)
      @phrase.add_note(-13)
      @test_candidates = Candidates.new({:phrase => @phrase, :scale => @scale, :rules => @rules})
      @phrase.add_note(@test_candidates.next_note)
      expect(@test_candidates.last_selection).to eq([-15,-12,-10,-8,-7,-5,-1])
    end

    it 'correctly finds the next possible notes for [0, -3, -15, -13, -15] (6)' do
      @phrase.add_note(-3)
      @phrase.add_note(-15)
      @phrase.add_note(-13)
      @phrase.add_note(-15)
      @test_candidates = Candidates.new({:phrase => @phrase, :scale => @scale, :rules => @rules})
      @phrase.add_note(@test_candidates.next_note)
      expect(@test_candidates.last_selection).to eq([-13,-12,-10,-8,-7,-3])
    end

    it 'correctly finds the next possible notes for [0, -3, -15, -13, -15, -13] (7)' do
      @phrase.add_note(-3)
      @phrase.add_note(-15)
      @phrase.add_note(-13)
      @phrase.add_note(-15)
      @phrase.add_note(-13)
      @test_candidates = Candidates.new({:phrase => @phrase, :scale => @scale, :rules => @rules})
      @phrase.add_note(@test_candidates.next_note)
      expect(@test_candidates.last_selection).to eq([-10, -1])
    end

    it 'correctly finds the next possible notes for [0, -3, -15, -13, -15, -13, -10] (8)' do
      @phrase.add_note(-3)
      @phrase.add_note(-15)
      @phrase.add_note(-13)
      @phrase.add_note(-15)
      @phrase.add_note(-13)
      @phrase.add_note(-10)
      @test_candidates = Candidates.new({:phrase => @phrase, :scale => @scale, :rules => @rules})
      @phrase.add_note(@test_candidates.next_note)
      expect(@test_candidates.last_selection).to eq([-12])
    end

    # Example #2, always choosing the rightmost note

    it 'correctly finds the next possible notes for [0, 4] (3)' do
      @phrase.add_note(4)
      @test_candidates = Candidates.new({:phrase => @phrase, :scale => @scale, :rules => @rules})
      @phrase.add_note(@test_candidates.next_note)
      expect(@test_candidates.last_selection).to eq([-8,-5,-3,-1,0,2,5,7,9,11,12,16])
    end

    it 'correctly finds the next possible notes for [0, 4, 16] (4)' do
      @phrase.add_note(4)
      @phrase.add_note(16)
      @test_candidates = Candidates.new({:phrase => @phrase, :scale => @scale, :rules => @rules})
      @phrase.add_note(@test_candidates.next_note)
      expect(@test_candidates.last_selection).to eq([4, 7, 9, 11, 12, 14])
    end

    it 'correctly finds the next possible notes for [0, 4, 16, 14] (5)' do
      @phrase.add_note(4)
      @phrase.add_note(16)
      @phrase.add_note(14)
      @test_candidates = Candidates.new({:phrase => @phrase, :scale => @scale, :rules => @rules})
      @phrase.add_note(@test_candidates.next_note)
      expect(@test_candidates.last_selection).to eq([2,5, 7, 9, 11, 12, 16])
    end

    it 'correctly finds the next possible notes for [0, 4, 16, 14, 16] (6)' do
      @phrase.add_note(4)
      @phrase.add_note(16)
      @phrase.add_note(14)
      @phrase.add_note(16)
      @test_candidates = Candidates.new({:phrase => @phrase, :scale => @scale, :rules => @rules})
      @phrase.add_note(@test_candidates.next_note)
      expect(@test_candidates.last_selection).to eq([4, 7, 9, 11, 12, 14])
    end

    it 'correctly finds the next possible notes for [0, 4, 16, 14, 16, 14] (7)' do
      @phrase.add_note(4)
      @phrase.add_note(16)
      @phrase.add_note(14)
      @phrase.add_note(16)
      @phrase.add_note(14)
      @test_candidates = Candidates.new({:phrase => @phrase, :scale => @scale, :rules => @rules})
      @phrase.add_note(@test_candidates.next_note)
      expect(@test_candidates.last_selection).to eq([2, 11])
    end


    it 'correctly finds the next possible notes for [0, 4, 16, 14, 16, 14, 11] (8)' do
      @phrase.add_note(4)
      @phrase.add_note(16)
      @phrase.add_note(14)
      @phrase.add_note(16)
      @phrase.add_note(14)
      @phrase.add_note(11)
      @test_candidates = Candidates.new({:phrase => @phrase, :scale => @scale, :rules => @rules})
      @phrase.add_note(@test_candidates.next_note)
      expect(@test_candidates.last_selection).to eq([12])
    end
  end
end
