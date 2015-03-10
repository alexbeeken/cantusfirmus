require_relative '../lib/scale.rb'
require 'pry'

describe 'Scale class' do

  before :each do
    @test_scale = Scale.new()
  end

  describe '#initialize' do
    it 'Initializes a new scale given a tonic with the private method draw_major_scale' do
      expect(@test_scale.notes).to eq([45, 47, 48, 50, 52, 53, 55, 57, 59, 60, 62, 64, 65, 67, 69, 71, 72, 74, 76])
    end
  end
end
