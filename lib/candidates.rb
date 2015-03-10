class Candidates
  attr_reader(:tonic, :notes)

  def initialize(params = {})
    @tonic = params.fetch(:tonic, 60)
    @scale = params.fetch(:scale, [])
    @notes = params.fetch(@scale, [])
  end

  def reset
    @notes = @scale.dup
  end

  def remove_dissonances(note)
    @notes.each do |candidate|
      interval = 0 - (note - candidate)
      consonant_intervals = [-16, -15,-14,-13,-12, -8, -7, -6, -5, -4, -3, -2, -1, 1, 2, 3, 4, 5, 6, 7, 8, 12, 13, 14, 15, 16]
      if (!consonant_intervals.include?(interval))
        @notes.delete(candidate)
      end
    end
    return @notes
  end

  def remove_leaps(note)
    @notes.each do |candidate|
      interval = 0 - (note - candidate)
      leap_intervals = [-4, -3, -2, -1, 1, 2, 3, 4]
      if (!leap_intervals.include?(interval))
        @notes.delete(candidate)
      end
    end
    return @notes
  end

  def remove_leaps_in_direction(note, direction)
    @notes.each do |candidate|
      interval = 0 - (note - candidate)
      if direction == true
        leap_intervals = [1, 2, 3, 4]
      else
        leap_intervals = [-1, -2, -3, -4]
      end
      if (!leap_intervals.include?(interval))
        @notes.delete(candidate)
      end
    end
    return @notes
  end

  def remove_all_nonleading_tones
    @notes = [@tonic+2, @tonic-1]
  end

  def remove_steps(note)
    @notes.each do |candidate|
      interval = (note - candidate)
      leap_intervals = [-16, -15, -14, -13, -12, -8, -7, -6, -5, 5, 6, 7, 8, 12, 13, 14, 15, 16]
      if (!leap_intervals.include?(interval))
        @notes.delete(candidate)
      end
    end
    return @notes
  end

  def remove_intervals(note, intervals)
    @notes.each do |candidate|
      interval = (note - candidate)
      if (!intervals.include?(interval))
        @notes.delete(candidate)
      end
    end
    return @notes
  end

  def pick_one(note)
    if @notes.length > 2
      roll = rand(6) + 1
      if (roll <= 4)
        @notes = remove_leaps(note)
      elsif (roll >= 5) && (remove_leaps(note) != [])
        @notes = remove_steps(note)
      end
      return (@notes.sample())
    else
      return (@notes.sample())
    end
  end

  def remove_all_except_tonic
    @notes = [@tonic]
  end

  def delete(candidate)
    @notes.delete(candidate)
  end

end
