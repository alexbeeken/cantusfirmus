class Score

  def initialize(notes)
    @steps = get_steps
    @leaps = get_leaps
    @range = get_range
     score += score_dev(std_dev[:steps])
    score += score_dev(std_dev[:leaps])
    score += score_dev(std_dev[:range])
    score += score_dev(std_dev[:repeated_notes])
    score += score_dev(std_dev[:consecutive_steps])
    score += score_dev(std_dev[:consecutive_steps_up])
    score += score_dev(std_dev[:consecutive_steps_down])
    score += score_dev(std_dev[:percentage_of_leaps])
    score += score_dev(std_dev[:percentage_of_steps])
  end
end
