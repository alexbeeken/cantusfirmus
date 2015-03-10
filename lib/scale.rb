class Scale
  attr_reader(:notes, :tonic)

  def initialize(params = {})
    @tonic = params.fetch(:tonic, 60)
    @notes = draw_major_scale
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

  private :draw_major_scale
end
