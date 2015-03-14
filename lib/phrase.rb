class Phrase
  attr_reader(:notes, :length)

  def initialize(params = {})
    @notes = [0]
    @length = params.fetch(:length, 8)
  end

  def add_note(note)
    @notes.push(note)
  end

  def last
    @notes.last
  end

  def second_to_last
    @notes[@notes.length - 2]
  end

  def third_to_last
    @notes[@notes.length - 3]
  end

end
