class CantusFirmus
  attr_reader(:melody_length, :finished)
  
  def initialize(params = {})
    @melody_length = params[:melody_length]
    @finished = false
  end
end