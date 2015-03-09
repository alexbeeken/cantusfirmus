class CantusFirmus
  attr_reader(:melody_length, :finished, :tonic, :phrase, :scale)

  def initialize(params ={})
      @melody_length = params.fetch(:melody_length, 8)
      @tonic = params.fetch(:tonic, 60)
      @finished = false
      @phrase = [@tonic]
      @scale = draw_major_scale
      (@melody_length - 1).times do
        @phrase.push(find_next_note())
      end
  end

  def draw_major_scale
    output = []
    output.push(@tonic-15)
    output.push(@tonic-13)
    output.push(@tonic-12)
    output.push(@tonic-10)
    output.push(@tonic-8)
    output.push(@tonic-7)
    output.push(@tonic-5)
    output.push(@tonic-3)
    output.push(@tonic-1)
    output.push(@tonic)
    output.push(@tonic+2)
    output.push(@tonic+4)
    output.push(@tonic+5)
    output.push(@tonic+7)
    output.push(@tonic+9)
    output.push(@tonic+11)
    output.push(@tonic+12)
    output.push(@tonic+14)
    output.push(@tonic+16)
    return output
  end

  def find_next_note
    candidates = @scale
    return candidates.sample()
  end

  # def phrase_add_second_note
  #   @phrase.push(random())
  # end

  private :draw_major_scale, :find_next_note

end
