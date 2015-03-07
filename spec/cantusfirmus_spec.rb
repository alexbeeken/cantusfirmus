require_relative '../lib/cantusfirmus.rb'
require 'pry'

describe 'initialize' do
  it 'creates a new blank array of length 8 and a finished value of false' do
    test = CantusFirmus.new({:melody_length => 8, :tonic => 60})
    expect(test.melody_length).to eq(8)
    expect(test.finished).to eq(false)
    expect(test.tonic).to eq(60)
  end
  
  it 'defaults to melody length 8 and tonic 60 if not specified' do
    test = CantusFirmus.new()
    expect(test.melody_length).to eq(8)
    expect(test.finished).to eq(false)
    expect(test.tonic).to eq(60)
    
    test2 = CantusFirmus.new({:melody_length => 10})
    expect(test.melody_length).to eq(10)
    expect(test.tonic).to eq(60)
    
    test3 = CantusFirmus.new({:tonic => 55})
    expect(test.melody_length).to eq(8)
    expect(test.tonic).to eq(55)
  end
end