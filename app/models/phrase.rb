class Phrase
  attr_reader(:notes)

  def initialize(params = {})
    @notes = params.fetch(:notes, [])
    @length = params.fetch(:length, 8)
  end

end
