class Evaluator

  def self.get_best_from_examples(candidates, notes, examples)
    # puts(" ")
    # puts(" PICKING BEST SCORE BELOW")
    temp_array = notes.dup
    temp_array.push(candidates.first)
    candidates.delete_at(0)
    best_score = get_score(temp_array, examples)
    current_best = temp_array.last
    second_best_score = 10000
    current_second_best = -100
    # puts("FIRST NOTE IS #{temp_array.last}")
    candidates.each do |candidate|
      temp_array = notes.dup
      temp_array.push(candidate)
      score = get_score(temp_array, examples)
      # puts("NEXT ONE IS #{candidate} and it scored: #{score}. Current best is #{current_best} with a score of #{best_score}.")
      if score < best_score
        best_score = score
        current_best = temp_array.last
      elsif score < second_best_score
        second_best_score = score
        current_second_best = temp_array.last
      end
      if second_best_score < best_score
        tmp_score = best_score
        tmp_note = current_best
        best_score = second_best_score
        current_best = current_second_best
        second_best_score = tmp_score
        current_second_best = tmp_note
      end
    end
    # puts(" ")
    # puts(" ")
    if current_second_best != -100
      roll = rand(2)
      if roll == 1
        return current_best
      else
        return current_second_best
      end
    end
    return current_best
  end

  private

  def self.get_score(array, examples)
    Score.get_score(array, examples)
  end
end
