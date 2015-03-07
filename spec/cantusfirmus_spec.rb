require_relative '../lib/cantusfirmus.rb'
require 'pry'

describe 'initialize' do
  it 'creates a new blank array of length 8 and a finished value of false' do
    test = CantusFirmus.new({:melody_length => 8})
    expect(test.melody_length).to eq(8)
    expect(test.finished).to eq(false)
  end
end