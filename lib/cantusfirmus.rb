class CantusFirmus
  attr_reader(:melody_length, :finished, :tonic, :phrase, :scale)

  def initialize(params ={})
      @melody_length = params.fetch(:melody_length, 8)
      @tonic = params.fetch(:tonic, 60)
      @finished = false
      @phrase = [@tonic]
      @scale = draw_major_scale
      (@melody_length - 1).times do
        @phrase.push(find_next_note())
      end
    @leaps_left = (@melody_length / 4).floor
  end

  def draw_major_scale
    output = []
    output.push(@tonic-15)
    output.push(@tonic-13)
    output.push(@tonic-12)
    output.push(@tonic-10)
    output.push(@tonic-8)
    output.push(@tonic-7)
    output.push(@tonic-5)
    output.push(@tonic-3)
    output.push(@tonic-1)
    output.push(@tonic)
    output.push(@tonic+2)
    output.push(@tonic+4)
    output.push(@tonic+5)
    output.push(@tonic+7)
    output.push(@tonic+9)
    output.push(@tonic+11)
    output.push(@tonic+12)
    output.push(@tonic+14)
    output.push(@tonic+16)
    return output
  end

  def find_next_note
    candidates = @scale
    if @phrase.length == 1 || @phrase.length == 2
      candidates = remove_dissonances(candidates, @tonic)
      return candidates.sample()
    else
      @current = @phrase.last
      @second = @phrase[@phrase.length - 2]
      @third = @phrase[@phrase.length - 3]
      if leap?(@current, @second)
        if leap?(@second, @third)
          candidates = remove_leaps(candidates, @current)
        else
          moved_up = moved_up?(@current, @second)
          candidates = remove_leaps_in_direction(candidates, @current, moved_up)
        end
      else
        if moved_up?(@current, @second) == moved_up?(@second, @third)
          if (((@current - @second).abs == 2) && ((@second - @third).abs == 2))
            if moved_up?(@current, @second)
              candidates = remove_intervals(candidates, @current, [1, 2])
            else
              candidates = remove_intervals(candidates, @current, [-1, -2])
            end
          elsif (((@current - @second).abs == 3) || ((@current - @second).abs == 4)) && (((@second - @third).abs == 3) || ((@second - @third).abs == 4))
            if moved_up?(@current, @second)
              candidates = remove_intervals(candidates, @current, [3, 4])
            else
              candidates = remove_intervals(candidates, @current, [-3, -4])
            end
          end
        end
      end
      return candidates.sample()
    end
  end

  def remove_dissonances(candidates, note)
    candidates.each do |candidate|
      interval = 0 - (note - candidate)
      consonant_intervals = [-16, -15,-14,-13,-12, -8, -7, -6, -5, -4, -3, -2, -1, 1, 2, 3, 4, 5, 6, 7, 8, 12, 13, 14, 15, 16]
      if (!consonant_intervals.include?(interval))
        candidates.delete(candidate)
      end
    end
    return candidates
  end

  def remove_leaps(candidates, note)
    candidates.each do |candidate|
      interval = 0 - (note - candidate)
      leap_intervals = [-4, -3, -2, -1, 1, 2, 3, 4]
      if (!leap_intervals.include?(interval))
        candidates.delete(candidate)
      end
    end
    return candidates
  end

  def remove_leaps_in_direction(candidates, note, direction)
    candidates.each do |candidate|
      interval = 0 - (note - candidate)
      if direction == true
        leap_intervals = [1, 2, 3, 4]
      else
        leap_intervals = [-1, -2, -3, -4]
      end
      if (!leap_intervals.include?(interval))
        candidates.delete(candidate)
      end
    end
    return candidates
  end

  def remove_steps(candidates, note)
    candidates.each do |candidate|
      interval = distance(candidate, note)
      leap_intervals = [-16, -15, -14, -13, -12, -8, -7, -6, -5, 5, 6, 7, 8, 12, 13, 14, 15, 16]
      if (!leap_intervals.include?(interval))
        candidates.delete(candidate)
      end
    end
    return candidates
  end

  def remove_steps(candidates, note, intervals)
    candidates.each do |candidate|
      interval = distance(candidate, note)
      if (!intervals.include?(interval))
        candidates.delete(candidate)
      end
    end
    return candidates
  end

  def leap?(one, second)
    return (one - second).abs >= 5
  end

  def moved_up?(one, second)
    return (one - second) > 0
  end


  # def phrase_add_second_note
  #   @phrase.push(random())
  # end

  private :draw_major_scale, :find_next_note, :remove_dissonances, :leap?, :moved_up?

end
