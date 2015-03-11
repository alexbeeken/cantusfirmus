require 'pry'
require_relative '../lib/cantusfirmus.rb'

describe '#get_key' do
  it 'returns the letter name of the key for C' do
    expect(get_key(60)).to eq("C")
  end

  it 'returns the letter name of the key for D' do
    expect(get_key(62)).to eq("D")
  end
end
