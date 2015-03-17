require 'pry'
require_relative '../lib/evaluator.rb'

describe 'Evaluator class' do

  before :each do
    @phrase = Phrase.new()
  end

  it 'finds the number of steps in a given phrase' do
    @phrase.add_note(2)
    @phrase.add_note(4)
    expect(Evaluator.get_statistics(@phrase)[:steps]).to eq(2)
  end
  
  it 'finds the number of leaps in a given phrase' do
    @phrase.add_note(5)
    @phrase.add_note(11)
    expect(Evaluator.get_statistics(@phrase)[:leaps]).to eq(2)
  end
  
  it 'returns the range, as an integer, of the phrase in its current state' do
    @phrase.add_note(5)
    @phrase.add_note(12)
    expect(Evaluator.get_statistics(@phrase)[:range]).to eq(12)
  end
  
  it 'returns the number of repeatd notes of the phrase in its current state' do
    @phrase.add_note(5)
    @phrase.add_note(0)
    @phrase.add_note(5)
    @phrase.add_note(0)
    expect(Evaluator.get_statistics(@phrase)[:repeated_notes]).to eq(5)
  end
  
  it 'returns which intervals and how frequently they appear' do
    @phrase.add_note(1)
    @phrase.add_note(2)
    @phrase.add_note(3)
    @phrase.add_note(4)
    @phrase.add_note(5)
    @phrase.add_note(6)
    @phrase.add_note(7)
    @phrase.add_note(8)
    @phrase.add_note(9)
    @phrase.add_note(10)
    @phrase.add_note(11)
    @phrase.add_note(12)
    expect(Evaluator.get_statistics(@phrase)[:intervals]).to eq([1])
  end
    
  
end
