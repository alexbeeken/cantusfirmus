require_relative '../lib/candidates.rb'
require 'pry'

describe 'Candidates class' do

  before :each do
    @phrase = Phrase.new()
    @scale = Scale.new()
    @rules = Rules.new()
  end

  describe '#next_note' do
    it 'correctly finds the next possible notes for any second note (2)' do
      puts("-------------------------------------")
      @test_candidates = Candidates.new({:phrase => @phrase, :scale => @scale, :rules => @rules})
      @phrase.add_note(@test_candidates.next_note)
      puts("Position: #{@phrase.current_length}")
      puts("Note Looked At: #{@phrase.second_to_last}")
      puts("Selection Pool: #{@test_candidates.last_selection}")
      puts("Number of candidates #{@test_candidates.last_selection.length}")
      puts("Rule breakers: #{@test_candidates.last_rules}")
      puts("-------------------------------------")
      expect(@test_candidates.last_selection).to eq([-3,-1,2,4])
    end

    it 'correctly finds the next possible notes for [0, -3] (3)' do
      @phrase.add_note(-3)
      puts("-------------------------------------")
      @test_candidates = Candidates.new({:phrase => @phrase, :scale => @scale, :rules => @rules})
      @phrase.add_note(@test_candidates.next_note)
      puts("Position: #{@phrase.current_length}")
      puts("Note Looked At: #{@phrase.second_to_last}")
      puts("Selection Pool: #{@test_candidates.last_selection}")
      puts("Number of candidates #{@test_candidates.last_selection.length}")
      puts("Rule breakers: #{@test_candidates.last_rules}")
      puts("-------------------------------------")
      expect(@test_candidates.last_selection).to eq([-15,-12,-10,-8,-7,-5,-1,0,2,4,5,9])
    end

    it 'correctly finds the next possible notes for [0, -3, -15] (4)' do
      @phrase.add_note(-3)
      @phrase.add_note(-15)
      puts("-------------------------------------")
      @test_candidates = Candidates.new({:phrase => @phrase, :scale => @scale, :rules => @rules})
      @phrase.add_note(@test_candidates.next_note)
      puts("Position: #{@phrase.current_length}")
      puts("Note Looked At: #{@phrase.second_to_last}")
      puts("Selection Pool: #{@test_candidates.last_selection}")
      puts("Number of candidates #{@test_candidates.last_selection.length}")
      puts("Rule breakers: #{@test_candidates.last_rules}")
      puts("-------------------------------------")
      expect(@test_candidates.last_selection).to eq([-13,-12,-10,-8,-7,-3])
    end

    it 'correctly finds the next possible notes for [0, -3, -15, -13] (5)' do
      @phrase.add_note(-3)
      @phrase.add_note(-15)
      @phrase.add_note(-13)
      puts("-------------------------------------")
      @test_candidates = Candidates.new({:phrase => @phrase, :scale => @scale, :rules => @rules})
      @phrase.add_note(@test_candidates.next_note)
      puts("Position: #{@phrase.current_length}")
      puts("Note Looked At: #{@phrase.second_to_last}")
      puts("Selection Pool: #{@test_candidates.last_selection}")
      puts("Number of candidates #{@test_candidates.last_selection.length}")
      puts("Rule breakers: #{@test_candidates.last_rules}")
      puts("-------------------------------------")
      expect(@test_candidates.last_selection).to eq([-15,-12,-10,-8,-7,-5,-1])
    end

    it 'correctly finds the next possible notes for [0, -3, -15, -13, -15] (6)' do
      @phrase.add_note(-3)
      @phrase.add_note(-15)
      @phrase.add_note(-13)
      @phrase.add_note(-15)
      puts("-------------------------------------")
      @test_candidates = Candidates.new({:phrase => @phrase, :scale => @scale, :rules => @rules})
      @phrase.add_note(@test_candidates.next_note)
      puts("Position: #{@phrase.current_length}")
      puts("Note Looked At: #{@phrase.second_to_last}")
      puts("Selection Pool: #{@test_candidates.last_selection}")
      puts("Number of candidates #{@test_candidates.last_selection.length}")
      puts("Rule breakers: #{@test_candidates.last_rules}")
      puts("-------------------------------------")
      expect(@test_candidates.last_selection).to eq([-13,-12,-10,-8,-7,-3])
    end

    it 'correctly finds the next possible notes for [0, -3, -15, -13, -15, -13] (7)' do
      @phrase.add_note(-3)
      @phrase.add_note(-15)
      @phrase.add_note(-13)
      @phrase.add_note(-15)
      @phrase.add_note(-13)
    puts("-------------------------------------")
      @test_candidates = Candidates.new({:phrase => @phrase, :scale => @scale, :rules => @rules})
      @phrase.add_note(@test_candidates.next_note)
      puts("Position: #{@phrase.current_length}")
      puts("Note Looked At: #{@phrase.second_to_last}")
      puts("Selection Pool: #{@test_candidates.last_selection}")
      puts("Number of candidates #{@test_candidates.last_selection.length}")
      puts("Rule breakers: #{@test_candidates.last_rules}")
      puts("-------------------------------------")
      expect(@test_candidates.last_selection).to eq([-10])
    end

    it 'correctly finds the next possible notes for [0, -3, -15, -13, -15, -13, -10] (8)' do
      @phrase.add_note(-3)
      @phrase.add_note(-15)
      @phrase.add_note(-13)
      @phrase.add_note(-15)
      @phrase.add_note(-13)
      @phrase.add_note(-10)
    puts("-------------------------------------")
      @test_candidates = Candidates.new({:phrase => @phrase, :scale => @scale, :rules => @rules})
      @phrase.add_note(@test_candidates.next_note)
      puts("Position: #{@phrase.current_length}")
      puts("Note Looked At: #{@phrase.second_to_last}")
      puts("Selection Pool: #{@test_candidates.last_selection}")
      puts("Number of candidates #{@test_candidates.last_selection.length}")
      puts("Rule breakers: #{@test_candidates.last_rules}")
      puts("-------------------------------------")
      expect(@test_candidates.last_selection).to eq([-12])
    end
  end
end
