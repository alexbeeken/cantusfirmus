class Score
  attr_accessor(:steps, :leaps, :range, :repeated_notes, :consecutive_steps, :consecutive_steps_up, :consecutive_steps_down, :percentage_of_leaps, :percentage_of_steps, :report)

  def initialize(notes = [])
    @notes = notes
    @steps = 0
    @leaps = 0
    @range = 0
    @repeated_notes = 0
    @consecutive_steps = 0
    @consecutive_steps_up = 0
    @consecutive_steps_down = 0
    @percentage_of_leaps = 0.0
    @percentage_of_steps = 0.0
    if @notes
      find_statistics
    end
  end

  def merge_score(score)
    @steps += score.steps
    @leaps += score.leaps
    @range += score.range
    @repeated_notes += score.repeated_notes
    @consecutive_steps += score.consecutive_steps
    @consecutive_steps_up += score.consecutive_steps_up
    @consecutive_steps_down += score.consecutive_steps_down
    @percentage_of_leaps += score.percentage_of_leaps
    @percentage_of_steps += score.percentage_of_steps
  end

  def switch_to_means(number_of_examples)
    @steps = @steps/number_of_examples.to_f
    @leaps = @leaps/number_of_examples.to_f
    @range = @range/number_of_examples.to_f
    @repeated_notes += @repeated_notes/number_of_examples.to_f
    @consecutive_steps += @consecutive_steps/number_of_examples.to_f
    @consecutive_steps_up += @consecutive_steps_up/number_of_examples.to_f
    @consecutive_steps_down += @consecutive_steps_down/number_of_examples.to_f
    @percentage_of_leaps += @percentage_of_leaps/number_of_examples.to_f
    @percentage_of_steps += @percentage_of_steps/number_of_examples.to_f
    return self
  end

  def switch_to_standard_deviations(means)
    @steps = (@steps - means.steps)**2
    @leaps = (@leaps - means.leaps)**2
    @range = (@range - means.range)**2
    @repeated_notes = (@repeated_notes - means.repeated_notes)**2
    @consecutive_steps = (@consecutive_steps - means.consecutive_steps)**2
    @consecutive_steps_up = (@consecutive_steps_up - means.consecutive_steps_up)**2
    @consecutive_steps_down = (@consecutive_steps_down - means.consecutive_steps_down)**2
    @percentage_of_leaps = (@percentage_of_leaps - means.percentage_of_leaps)**2
    @percentage_of_steps = (@percentage_of_steps - means.percentage_of_steps)**2
  end

  def squash_into_score
    @steps + @leaps + @range + @repeated_notes + @consecutive_steps + @consecutive_steps_up + @consecutive_steps_down + @percentage_of_leaps + @percentage_of_steps
  end

  def self.get_score(notes, examples_array)
    if examples_array
      scores_array = get_scores(examples_array)
      totals = get_totals(scores_array)
      means = totals.switch_to_means(scores_array.length)
      standard_deviations = get_standard_deviation(scores_array, means)
      return standard_deviations.squash_into_score
    else
      return 0
    end
  end

  private

  def self.get_scores(examples_array)
    scores_array = []
    examples_array.each do |example|
      scores_array.push(new(example))
    end
    return scores_array
  end

  def self.get_standard_deviation(scores_array, means)
    deviations = new
    scores_array.each do |score|
      score.switch_to_standard_deviations(means)
      deviations.merge_score(score)
    end
    return deviations
  end

  def self.get_totals(scores_array)
    totals = new
    scores_array.each do |score|
        totals.merge_score(score)
    end
    return totals
  end

  def find_statistics
    find_steps_and_leaps
    find_percentage_of_leaps_steps
    find_range
    find_number_of_repeated_notes
    find_consecutive_steps
  end

  def find_percentage_of_leaps_steps
    @percentage_of_leaps = @leaps.to_f/(@notes.length - 1).to_f
    @percentage_of_steps = @steps.to_f/(@notes.length - 1).to_f
  end

  def find_steps_and_leaps
    last_note = nil
    count = 0
    for index in 0..(@notes.length - 1)
      if (@notes[index - 1] && @notes[index])
        if [1, 2, -1, -2].include?(get_interval(@notes[index - 1], @notes[index]))
          @steps += 1
        else
          @leaps += 1
        end
      end
    end
    @leaps -= 1
  end

  def find_consecutive_steps
    for index in 2..(@notes.length - 1)
      if (@notes[index] && @notes[index - 1] && @notes[index - 2])
        if [1, 2, -1, -2].include?(get_interval(@notes[index - 1], @notes[index]))
          if [1, 2, -1, -2].include?(get_interval(@notes[index - 2], @notes[index - 1]))
            @consecutive_steps += 1
            if up?(@notes[index - 1], @notes[index]) && up?(@notes[index - 2], @notes[index - 1])
              @consecutive_steps_up += 1
            else
              @consecutive_steps_down += 1
            end
          end
        end
      end
    end
  end

  def find_range
    highest = -100
    lowest = 100
    if @notes.length > 1
      @notes.each do |note|
        if note < lowest
          lowest = note
        end
        if note > highest
           highest = note
        end
        return (lowest - highest).abs
      end
    end
    return 0
  end

  def find_number_of_repeated_notes
    notes = []
    repeated_notes = 0
    @notes.each do |note|
      notes.push(note)
      if notes.include?(note)
        repeated_notes += 1
      end
    end
    return repeated_notes
  end

  def get_interval(left_note, right_note)
    0 - (left_note - right_note)
  end

  def up?(note1, note2)
    ((note1 - note2) <= -1)
  end
end
