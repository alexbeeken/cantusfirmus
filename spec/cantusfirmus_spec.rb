require 'pry'
require_relative '../lib/cantusfirmus.rb'

describe '#build_cantusfirmus' do
  it 'builds a cantusfirmus with 8 notes' do
    test_firmus = build_cantusfirmus(60, 8)
    expect(test_firmus.length).to eq(8)
    expect(test_firmus.first).to eq("C/4")
    expect(["C/3", "C/4", "C/5"].include?(test_firmus.last)).to eq(true)
  end
end
