class CantusFirmus
  attr_reader(:melody_length, :finished, :tonic, :notes)

  def initialize(params ={})
      @melody_length = params.fetch(:melody_length, 8)
      @tonic = params.fetch(:tonic, 60)
      @finished = false
      @notes = [@tonic]
  end

  def add_note
    @notes
  end

end
