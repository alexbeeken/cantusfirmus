require_relative '../lib/scale.rb'
require 'pry'

describe 'Scale class' do

  before :each do
    @test_scale = Scale.new()
  end

  describe '#dissonances' do
    it 'returns only the dissonant intervals for a given note' do
      expect(@test_scale.dissonances(0)).to eq(-10, 0, 11)
    end
  end
end
