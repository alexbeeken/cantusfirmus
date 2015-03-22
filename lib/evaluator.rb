class Evaluator

  def self.get_statistics(phrase)
    @phrase = phrase.notes
    @length = phrase.notes.length
    @steps = 0
    @leaps = 0
    @range = 0
    @repeated_notes = 0
    @intervals = []
    @consecutive_steps = 0
    @consecutive_steps_up = 0
    @consecutive_steps_down = 0
    @percentage_of_leaps = 0.0
    @percentage_of_steps = 0.0
    find_number_of_steps
    find_range
    find_number_of_repeated_notes
    find_intervals
    find_consecutive_steps
    find_percentage_of_leaps_steps
    return {:steps => @steps,
            :leaps => @leaps,
            :range => @range,
            :repeated_notes => @repeated_notes,
            :intervals => @intervals,
            :consecutive_steps => @consecutive_steps,
            :consecutive_steps_up => @consecutive_steps_up,
            :consecutive_steps_down => @consecutive_steps_down,
            :percentage_of_leaps => @percentage_of_leaps,
            :percentage_of_steps => @percentage_of_steps}
  end

  def self.get_score(phrase)
    statistics = get_statistics(phrase)
    return statistics[:steps]
  end

  def self.get_average(stats_array)
    totals = {:steps => 0,
      :leaps => 0,
      :range => 0,
      :repeated_notes => 0,
      :intervals => [],
      :consecutive_steps => 0,
      :consecutive_steps_up => 0,
      :consecutive_steps_down => 0,
      :percentage_of_leaps => 0,
      :percentage_of_steps => 0}

    stats_array.each do |stats|
      totals[:steps] += stats[:steps]
      totals[:leaps] += stats[:leaps]
      totals[:range] += stats[:range]
      totals[:repeated_notes] += stats[:repeated_notes]
      totals[:intervals].push(stats[:intervals])
      totals[:consecutive_steps] += stats[:consecutive_steps]
      totals[:consecutive_steps_up] += stats[:consecutive_steps_up]
      totals[:consecutive_steps_down] += stats[:consecutive_steps_down]
      totals[:percentage_of_leaps] += stats[:percentage_of_leaps]
      totals[:percentage_of_steps] += stats[:percentage_of_steps]
    end

    totals[:steps] = totals[:steps].to_f / stats_array.length.to_f
    totals[:leaps] = totals[:leaps].to_f / stats_array.length.to_f
    totals[:range] = totals[:range].to_f / stats_array.length.to_f
    totals[:repeated_notes] = totals[:repeated_notes].to_f / stats_array.length.to_f
    totals[:intervals].uniq
    totals[:consecutive_steps] = totals[:consecutive_steps].to_f / stats_array.length.to_f
    totals[:consecutive_steps_up] = totals[:consecutive_steps_up].to_f / stats_array.length.to_f
    totals[:consecutive_steps_down] = totals[:consecutive_steps_down].to_f / stats_array.length.to_f
    totals[:percentage_of_leaps] = totals[:percentage_of_leaps].to_f / stats_array.length.to_f
    totals[:percentage_of_steps] = totals[:percentage_of_steps].to_f / stats_array.length.to_f

    return totals
  end



  private

  def self.find_percentage_of_leaps_steps
    @percentage_of_leaps = @leaps.to_f/(@length - 1).to_f
    @percentage_of_steps = @steps.to_f/(@length - 1).to_f
  end


  def self.find_consecutive_steps
    for index in 2..(@length - 1)
      if self.these_two_not_nil?(@phrase[index], @phrase[index - 1])
        if M2?(@phrase[index], @phrase[index -1])
          if M2?(@phrase[index - 1], @phrase[index - 2])
            @consecutive_steps += 1
            if up?(@phrase[index], @phrase[index -1]) && up?(@phrase[index - 1], @phrase[index - 2])
              @consecutive_steps_up += 1
            elsif (!(up?(@phrase[index], @phrase[index -1])) && !(up?(@phrase[index - 1], @phrase[index - 2])))
              @consecutive_steps_down += 1
            end
          end
        end
      end
    end
  end

  def self.find_intervals
    for index in 1..(@length - 1)
      if self.these_two_not_nil?(@phrase[index], @phrase[index - 1])
        @intervals.push(get_interval(@phrase[index], @phrase[index -1]))
      end
    end
    @intervals = @intervals.uniq
  end


  def self.find_number_of_repeated_notes
    notes = []
    @phrase.each do |note|
      notes.push(note)
      if notes.include?(note)
        @repeated_notes += 1
      end
    end
  end

  def self.find_range
    highest = -100
    lowest = 100
    @phrase.each do |note|
      if note < lowest
        lowest = note
      end
      if note > highest
         highest = note
      end
      @range = (lowest - highest).abs
    end
  end

  def self.find_number_of_steps
    last_note = nil
    count = 0
    for index in 0..(@length - 1)
      if self.these_two_not_nil?(@phrase[index], @phrase[index - 1])
        if M2?(@phrase[index], @phrase[index -1])
          @steps += 1
        else
          @leaps += 1
        end
      end
    end
    @leaps -= 1
  end

  def self.these_two_not_nil?(note1, note2)
    return (!(note1.nil?) && !(note2.nil?))
  end

  def self.up?(note1, note2)
    return (note1 - note2) > 0
  end

  def self.M2?(note1, note2)
    (note1 - note2).abs == 2
  end

  def self.get_interval(note1, note2)
    (note1 - note2).abs
  end
end
