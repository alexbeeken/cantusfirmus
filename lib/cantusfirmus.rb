class CantusFirmus
  attr_reader(:melody_length, :finished, :tonic)
  
  def initialize(params = {:melody_length => 8, :tonic => 60})
    @melody_length = params[:melody_length]
    @tonic = params[:tonic]
    @finished = false
  end
 
  
end