class Phrase
  attr_reader(:notes, :length)

  def initialize
    @candidates = [-3, -1, 0, 2, 4]
    @state = [0]
    @score = 0
  end

  def add_note(note)
    @state.push(note)
    update_candidates(@state)
    update_score(@state)
  end

  private

  def update_candidates(candidates)

  end

  def update_score(notes)

  end

end
