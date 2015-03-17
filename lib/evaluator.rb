class Evaluator

  def self.get_statistics(phrase)
    @phrase = phrase.notes
    @length = phrase.notes.length
    number_of_steps = find_number_of_steps()
    return {:steps => number_of_steps}
  end

  private

  def self.find_number_of_steps
    last_note = nil
    count = 0
    for index in 0..(@length - 1)
      if !(@phrase[index].nil?) && !(@phrase[index - 1].nil?)
        if (@phrase[index] - @phrase[index -1]).abs == 2
          count += 1
        end
      end
    end
    return count
  end

end
