class Phrase
  attr_reader(:notes, :length, :score)

  def initialize(params = {})
    @notes = params.fetch(:notes, [0])
    @length = params.fetch(:length, 8)
    @score = 0
  end

  def add_note(note)
    @notes.push(note)
  end

  def set_score(score)
    @score = score
  end

  def last
    @notes.last
  end

  def current_length
    @notes.length
  end

  def second_to_last
    @notes[@notes.length - 2]
  end

  def third_to_last
    @notes[@notes.length - 3]
  end

end
