class Evaluator

  def self.get_best_from_examples(candidates, notes, examples)
    temp_array = notes.dup
    temp_array.push(candidates.first)
    candidates.delete_at(0)
    best_score = get_score(temp_array, examples)
    current_best = temp_array.last
    candidates.each do |candidate|
      temp_array = notes.dup
      temp_array.push(candidate)
      score = get_score(temp_array, examples)
      if score > best_score
        best_score = score
        current_best = temp_array.last
      end
    end
    return current_best
  end

  private

  def self.get_score(array, examples)
    # get each example statistics
    examples.push
    examples.each do
      totals = get_totals
    end
    get_standard_deviation(array, totals)
    # get array statistics
    # find standard deviations of array
    # return all of them added together as the score
    return array[0]
  end

  def self.get_totals
    
  end
end
