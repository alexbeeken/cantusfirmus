require_relative '../lib/phrase.rb'
require 'pry'

describe 'Phrase class' do

  before :each do
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

  describe('#third_to_last') do
    it 'return the third to last note pushed into the phrase array' do
      @test_phrase.add_note(61)
      @test_phrase.add_note(62)
      expect(@test_phrase.third_to_last).to eq(60)
    end
  end

  describe('#on_first_note?') do
    it 'returns true if there is only one note in the notes array' do
      expect(@test_phrase.on_first_note?).to eq(true)
    end
  end

  describe('#on_second_note?') do
    it 'returns true if there is two notes in the notes array' do
      @test_phrase.add_note(62)
      expect(@test_phrase.on_second_note?).to eq(true)
    end
  end

  describe('#on_second_to_last_note?') do
    it 'returns true if the next note to be added is the second to last note' do
      @test_phrase.add_note(62)
      @test_phrase.add_note(64)
      @test_phrase.add_note(65)
      @test_phrase.add_note(67)
      @test_phrase.add_note(69)
      expect(@test_phrase.on_second_to_last_note?).to eq(true)
    end
  end

  describe('#on_last_note?') do
    it 'returns true if the next note to be added is the last note' do
      @test_phrase.add_note(62)
      @test_phrase.add_note(64)
      @test_phrase.add_note(65)
      @test_phrase.add_note(67)
      @test_phrase.add_note(69)
      @test_phrase.add_note(71)
      expect(@test_phrase.on_last_note?).to eq(true)
    end
  end

  describe('#last_interval_was_a_leap?') do
    it 'returns true if the interval between the last two notes added is a leap' do
      @test_phrase.add_note(72)
      expect(@test_phrase.last_interval_was_a_leap?).to eq(true)
    end
  end

  describe('#second_to_last_interval_was_a_leap?') do
    it 'returns true if the interval between the second to last and third to last was true' do
      @test_phrase.add_note(72)
      @test_phrase.add_note(74)
      expect(@test_phrase.second_to_last_interval_was_a_leap?).to eq(true)
    end
  end

  describe('#last_interval_moved_up?') do
    it 'returns true if the interval between the last two notes added moved up' do
      @test_phrase.add_note(61)
      expect(@test_phrase.last_interval_moved_up?).to eq(true)
    end
  end

  describe('#last_two_intervals_moved_up?') do
    it 'returns true if there were two intervals in the up direction last time' do
      @test_phrase.add_note(61)
      @test_phrase.add_note(62)
      expect(@test_phrase.last_two_intervals_moved_up?).to eq(true)
    end
  end

  describe('#last_two_intervals_M2s?') do
    it 'returns true if the last two intervals were major 2nds' do
      @test_phrase.add_note(62)
      @test_phrase.add_note(64)
      expect(@test_phrase.last_two_intervals_M2s?).to eq(true)
    end
  end

  describe('#last_two_intervals_3s?') do
    it 'returns true if the last two intervals were major or minor 3rds' do
      @test_phrase.add_note(63)
      @test_phrase.add_note(66)
      expect(@test_phrase.last_two_intervals_3s?).to eq(true)
    end
  end

  describe('#return if within octave') do
    it 'returns all the notes within one octave of the most recent note added' do
      @test_phrase.add_notes(62)
      @test_phrase.add_notes(64)
      @test_phrase.add_notes(65)
      @test_phrase.add_notes(67)
      @test_phrase.add_notes(69)
      @test_phrase.add_notes(71)
      @test_phrase.add_notes(72)
      @test_phrase.add_notes(74)
      expect(@test_phrase.return_if_within_octave([72, 45, 50])).to eq([72])
    end
  end

  describe('#return_closest_note_to_last') do
    it 'returns the closest note to the last one added to the phrase' do
      @test_phrase.add_notes(62)
      @test_phrase.add_notes(64)
      @test_phrase.add_notes(65)
      @test_phrase.add_notes(67)
      @test_phrase.add_notes(69)
      @test_phrase.add_notes(71)
      @test_phrase.add_notes(72)
      @test_phrase.add_notes(74)
      expect(@test_phrase.return_closest_to_last([60, 62, 64, 65, 66, 68, 69, 70, 75])).to eq(75)
    end
  end
end
