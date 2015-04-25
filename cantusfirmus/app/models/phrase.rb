class Phrase
  attr_reader(:notes, :length, :score, :stats)

  def initialize(params = {})
    @notes = params.fetch(:notes, [0])
    @length = params.fetch(:length, 8)
    @evaluator = params.fetch(:evaluator, Evaluator.new)
    @score = params.fetch(:score, 0)
    get_stats
  end

  def get_stats
    @steps = 0
    @leaps = 0
    @range = find_range
    @repeated_notes = find_number_of_repeated_notes
    self.find_number_of_steps
    @consecutive_steps = 0
    @consecutive_steps_up = 0
    @consecutive_steps_down = 0
    self.find_consecutive_steps
    @percentage_of_leaps = 0.0
    @percentage_of_steps = 0.0
    self.find_percentage_of_leaps_steps
    @stats = {:steps => @steps,
            :leaps => @leaps,
            :range => @range,
            :repeated_notes => @repeated_notes,
            :consecutive_steps => @consecutive_steps,
            :consecutive_steps_up => @consecutive_steps_up,
            :consecutive_steps_down => @consecutive_steps_down,
            :percentage_of_leaps => @percentage_of_leaps,
            :percentage_of_steps => @percentage_of_steps}
  end

  def calculate_score
    @evaluation.get_score(@notes)
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

  def find_number_of_steps
    last_note = nil
    count = 0
    for index in 0..(@length - 1)
      if self.these_two_not_nil?(@notes[index], @notes[index - 1])
        if self.M2?(@notes[index], @notes[index -1])
          @steps += 1
        else
          @leaps += 1
        end
      end
    end
    @leaps -= 1
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

  def find_consecutive_steps
    for index in 2..(@length - 1)
      if these_two_not_nil?(@notes[index], @notes[index - 1])
        if self.M2?(@notes[index], @notes[index -1])
          if self.M2?(@notes[index - 1], @notes[index - 2])
            @consecutive_steps += 1
            if self.up?(@notes[index], @notes[index -1]) && self.up?(@notes[index - 1], @notes[index - 2])
              @consecutive_steps_up += 1
            elsif (!(self.up?(@notes[index], @notes[index -1])) && !(self.up?(@notes[index - 1], @notes[index - 2])))
              @consecutive_steps_down += 1
            end
          end
        end
      end
    end
  end

  def these_two_not_nil?(note1, note2)
    return (!(note1.nil?) && !(note2.nil?))
  end

  def find_percentage_of_leaps_steps
    @percentage_of_leaps = @leaps.to_f/(@length - 1).to_f
    @percentage_of_steps = @steps.to_f/(@length - 1).to_f
  end

  def up?(note1, note2)
    return (note1 - note2) > 0
  end

  def M2?(note1, note2)
    (note1 - note2).abs == 2
  end

  def get_interval(note1, note2)
    (note1 - note2).abs
  end

end
