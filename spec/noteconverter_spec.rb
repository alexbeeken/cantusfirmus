require 'pry'
require_relative '../lib/NoteConverter.rb'

describe 'NoteConverter class' do

  describe '#initialize' do
    it 'creates a reference scale based on the tonic' do
      noteconv = NoteConverter.new({:tonic => 60})
      expect(noteconv.scale).to eq([60, 62, 64, 65, 67, 69, 71])
    end
  end

  before :each do
    @noteconv = NoteConverter.new({:tonic => 60})
  end

  describe '#convert' do
    it 'converts 60 into C/4' do
      output = @noteconv.convert(60)
      expect(output).to eq("C/4")
      expect(@noteconv.convert(61)).to eq("C#/4")
      expect(@noteconv.convert(62)).to eq("D/4")
    end
  end
end
