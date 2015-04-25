class Evaluator

  def initialize
    @averages = nil
  end

  def set_averages(params = {})
    @averages = get_average(get_array_stats(params.fetch(:examples, [[0]])))
  end

  def get_score(phrase)
    score = 0
    stats = phrase.stats
    std_dev = get_standard_deviation(stats)
    score += score_dev(std_dev[:steps])
    score += score_dev(std_dev[:leaps])
    score += score_dev(std_dev[:range])
    score += score_dev(std_dev[:repeated_notes])
    score += score_dev(std_dev[:consecutive_steps])
    score += score_dev(std_dev[:consecutive_steps_up])
    score += score_dev(std_dev[:consecutive_steps_down])
    score += score_dev(std_dev[:percentage_of_leaps])
    score += score_dev(std_dev[:percentage_of_steps])
    return score
  end

  def score_dev(number)
    score_mod = number.abs
    return score_mod
  end

  def get_average(stats_array)
    totals = {:steps => 0,
      :leaps => 0,
      :range => 0,
      :repeated_notes => 0,
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
    totals[:consecutive_steps] = totals[:consecutive_steps].to_f / stats_array.length.to_f
    totals[:consecutive_steps_up] = totals[:consecutive_steps_up].to_f / stats_array.length.to_f
    totals[:consecutive_steps_down] = totals[:consecutive_steps_down].to_f / stats_array.length.to_f
    totals[:percentage_of_leaps] = totals[:percentage_of_leaps].to_f / stats_array.length.to_f
    totals[:percentage_of_steps] = totals[:percentage_of_steps].to_f / stats_array.length.to_f

    return totals
  end

  def get_array_stats(phrases)
    stats_array = []

    phrases.each do |phrase|
      stats_array.push(phrase.stats)
    end

    return stats_array
  end

  def get_standard_deviation(stats)
    totals = @averages
    standard_deviation = {:steps => 0,
      :leaps => 0,
      :range => 0,
      :repeated_notes => 0,
      :consecutive_steps => 0,
      :consecutive_steps_up => 0,
      :consecutive_steps_down => 0,
      :percentage_of_leaps => 0,
      :percentage_of_steps => 0}

      standard_deviation[:steps] = (stats[:steps] - totals[:steps])**2
      standard_deviation[:leaps] = (stats[:leaps] - totals[:leaps])**2
      standard_deviation[:range] = (stats[:range] - totals[:range])**2
      standard_deviation[:repeated_notes] = (stats[:repeated_notes] - totals[:repeated_notes])**2
      standard_deviation[:consecutive_steps] = (stats[:consecutive_steps] - totals[:consecutive_steps])**2
      standard_deviation[:consecutive_steps_up] = (stats[:consecutive_steps_up] - totals[:consecutive_steps_up])**2
      standard_deviation[:consecutive_steps_down] = (stats[:consecutive_steps_down] - totals[:consecutive_steps_down])**2
      standard_deviation[:percentage_of_leaps] = (stats[:percentage_of_leaps] - totals[:percentage_of_leaps])**2
      standard_deviation[:percentage_of_steps] = (stats[:percentage_of_steps] - totals[:percentage_of_steps])**2

    return standard_deviation
  end

  private



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
