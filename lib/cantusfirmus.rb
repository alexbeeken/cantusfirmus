class CantusFirmus
  attr_reader(:melody_length, :finished, :tonic, :notes)
  
  def initialize(params ={})
      @melody_length = params[:melody_length]
      @tonic = params[:tonic]
      @finished = false
    if @melody_length == nil
      @melody_length = 8
    end
    if @tonic == nil
      @tonic = 60
    end
      @notes = [@tonic]
  end
  
  def add_note
    @notes
  end
  
end