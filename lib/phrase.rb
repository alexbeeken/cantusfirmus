class Phrase
  attr_reader(:state, :length, :candidates, :score)

  def initialize(params = {})
    @candidates = [-3, -1, 0, 2, 4]
    @state = [0]
    @score = 0
    @length = params.fetch(:length, 8)
    @score = 0
  end

  def add_note(note)
    (@length - 1).times do
    @state.push(@candidates.sample())
    update_candidates(@state)
    update_score(@state)
  end

  def set_score(score)
    @score = score
  end

  def last
    @notes.last
  end

  def update_candidates(candidates)
    candidates = @state.last.get_diatonics_within_octave
    check_for_validity
    get_top_two
  end

  def update_score(notes)
    #evaluate
  end

  def check_for_validity
    output = []
    @candidates.each do |candidate|
      if candidate.valid?(@state[-1], @state[-2])
        output.push(candidate)
      end
    end
    @candidates = output
  end

  def get_top_two
    test_state = @state
    @candidates.each do |candidate|
      candidate.score = test_state.push(candidates)
      #get evaluation score for test_state
    end
  end
end
