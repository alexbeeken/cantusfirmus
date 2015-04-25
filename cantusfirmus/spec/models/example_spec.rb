require 'rails_helper.rb'
require 'pry'

describe Example do

  describe "#to_array" do

    before :each do
      @example = Example.new(notes: "[1,2,3,4]")
    end

    it 'returns the notes in the example as an array' do
      expect(@example.to_array.class).to eq(Array)
      expect(@example.to_array.length).to eq(4)
      expect(@example.to_array.first).to eq(1)
      expect(@example.to_array.last).to eq(4)
    end
  end
end
