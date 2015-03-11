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

describe '#build_cantusfirmus' do
  it 'builds a cantusfirmus with 8 notes' do
    test_firmus = build_cantusfirmus(60, 8)
    expect(test_firmus.length).to eq(8)
    expect(test_firmus.first).to eq("C/4")
    expect(["C/3", "C/4", "C/5"].include?(test_firmus.last)).to eq(true)
  end
end

describe '#convert_to_names' do
  it 'converts an array of note numbers to letter names' do
    test_array = [60,62,64,65]
    test_names = convert_to_names(test_array, 60)
    expect(test_names).to eq(["C/4", "D/4", "E/4", "F/4"])
  end
end
