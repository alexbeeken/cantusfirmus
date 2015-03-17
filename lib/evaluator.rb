class Evaluator

  def self.get_statistics(phrase)
    @phrase = phrase.notes
    @length = phrase.notes.length
    @steps = 0
    @leaps = 0
    find_number_of_steps
    return {:steps => @steps, :leaps => @leaps }
  end

  private

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
end
