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
end
