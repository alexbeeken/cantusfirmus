class Evaluator

  def self.get_statistics(phrase)
    @phrase = phrase.notes
    @length = phrase.notes.length
    @steps = 0
    @leaps = 0
    @range = 0
    @repeated_notes = 0
    @intervals = []
    find_number_of_steps
    find_range
    find_number_of_repeated_notes
    find_intervals
    return {:steps => @steps, 
            :leaps => @leaps, 
            :range => @range, 
            :repeated_notes => @repeated_notes,
            :intervals => @intervals}
  end

  private
  
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

  def self.M2?(note1, note2)
    (note1 - note2).abs == 2
  end
  
  def self.get_interval(note1, note2)
    (note1 - note2).abs
  end
end
