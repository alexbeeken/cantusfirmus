class Phrase
  attr_reader(:notes)

  def initialize(params = {})
    @notes = [params.fetch(:tonic, 60)]
  end

  def add_note(note)
    @notes.push(note)
  end

  def length
    @notes.length
  end

  def last
    @notes.last
  end

  def second_to_last
    @notes[@notes.length - 2]
  end

  def third_to_last
    @notes[@notes.length - 3]
  end

  def on_first_note?
    @notes.length == 1
  end

  def on_second_note?
    @notes.length == 2
  end

  def on_second_to_last_note?
    @notes.length == (@notes.length - 2)
  end

  def on_last_note?
    @notes.length == (@notes.length - 1)
  end

  def last_interval_was_a_leap?
    leap?(self.last, self.second_to_last)
  end

  def second_to_last_interval_was_a_leap?
    leap?(self.second_to_last, self.third_to_last)
  end

  def last_interval_moved_up?
    return moved_up?(self.last, self.second_to_last)
  end

  def last_two_intervals_moved_up?
    return (moved_up?(self.last, self.second_to_last) && moved_up?(self.second_to_last, self.third_to_last))
  end

  def last_two_intervals_M2s?
    (M2?(self.last, self.second_to_last)) && (M2?(self.second_to_last, self.third_to_last))
  end

  def last_two_intervals_3s?
    m3_or_M3?(self.last, self.second_to_last) && m3_or_M3?(self.second_to_last, self.third_to_last)
  end

  def m3_or_M3?(one, second)
    m3?(one, second) || M3?(one, second)
  end

  def leap?(one, second)
    return (one - second).abs >= 5
  end

  def moved_up?(one, second)
    return (one - second) > 0
  end

  def distance(one, second)
    return (one - second).abs
  end

  def M2?(one, second)
    return distance(one, second) == 2
  end

  def m3?(one, second)
    return distance(one, second) == 3
  end

  def M3?(one, second)
    return distance(one, second) == 4
  end

  def within_octave?(one, second)
    return distance(self.last, second) <= 12
  end

  def return_if_within_octave(candidates)
  loop_candidates = candidates.dup
    loop_candidates.each() do |candidate|
      if !(within_octave?(self.last, candidate))
        candidates.delete(candidate)
      end
    end
  end

  def return_closest_note_to_last(candidates)
    closest = 600
    closest_compare = 2500000
    candidates.each() do |candidate|
      if (current - candidate).abs < closest_compare
        closest = candidate
        closest_compare = (current - candidate).abs
      end
    end
    return closest
  end

end
