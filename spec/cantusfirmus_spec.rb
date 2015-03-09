require_relative '../lib/cantusfirmus.rb'
require 'pry'

describe 'initialize' do
  it 'creates a new blank array of length 8 and a finished value of false' do
    test = CantusFirmus.new({:melody_length => 8, :tonic => 60})
    expect(test.melody_length).to eq(8)
    expect(test.finished).to eq(false)
    expect(test.tonic).to eq(60)
    expect(test.phrase.first).to eq(60)
    expect(test.scale).to eq([45, 47, 48, 50, 52, 53, 55, 57, 59, 60, 62, 64, 65, 67, 69, 71, 72, 74, 76])
  end

  it 'defaults to melody length 8 and tonic 60 if not specified' do
    test = CantusFirmus.new()
    expect(test.melody_length).to eq(8)
    expect(test.finished).to eq(false)
    expect(test.tonic).to eq(60)

    test2 = CantusFirmus.new({:melody_length => 10})
    expect(test2.melody_length).to eq(10)
    expect(test2.tonic).to eq(60)

    test3 = CantusFirmus.new({:tonic => 55})
    expect(test3.melody_length).to eq(8)
    expect(test3.tonic).to eq(55)
  end
end

describe 'find_next_note' do
  it 'picks a random note from the scale and populates the array' do
    test = CantusFirmus.new()
    expect(test.phrase.length).to eq(8)
  end
  

end
