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
    if @phrase.length == 1 || @phrase.lenth == 2
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
          # NEEDS TO BE IN THE SAME DIRECTION
          candidates = remove_steps(candidates, @current)
        end
      else
        # if same directions?
          # M2?
            # remove minor 2nds
          # m3 or M3?
            # remove m3s and M3s

      return candidates.sample()
    end
  end

  def remove_dissonances(candidates, note)
    candidates.each do |candidate|
      interval = distance(candidate, note)
      consonant_intervals = [-16, -15,-14,-13,-12, -8, -7, -6, -5, -4, -3, -2, -1, 1, 2, 3, 4, 5, 6, 7, 8, 12, 13, 14, 15, 16]
      if (!consonant_intervals.include?(interval))
        candidates.delete(candidate)
      end
    end
    return candidates
  end

  def remove_leaps(candidates, note)
    candidates.each do |candidate|
      interval = distance(candidate, note)
      leap_intervals = [-4, -3, -2, -1, 1, 2, 3, 4]
      if (!leap_intervals.include?(interval))
        candidates.delete(candidate)
      end
    end
    return candidates
  end

  def remove_steps(cndidates, note)
    candidates.each do |candidate|
      interval = distance(candidate, note)
      leap_intervals = [-16, -15, -14, -13, -12, -8, -7, -6, -5, 5, 6, 7, 8, 12, 13, 14, 15, 16]
      if (!leap_intervals.include?(interval))
        candidates.delete(candidate)
      end
    end
    return candidates
  end

  def leap?(one, second)
    return (one - second).abs >= 5
  end


  # def phrase_add_second_note
  #   @phrase.push(random())
  # end

  private :draw_major_scale, :find_next_note, :remove_dissonances, :distance_between

end
