require_relative('scale.rb')

class NoteConverter
  attr_reader(:scale)

  def initialize(params = {})
    @tonic = params.fetch(:tonic, 60)
    @scale = Scale.new({:tonic => @tonic}).diatonic
  end
end
