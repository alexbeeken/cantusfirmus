class Validator

  DIATONIC_NOTES = [-15, -13, -12, -10, -8, -7, -5, -3, -1, 0, 2, 4, 5, 7, 9, 11, 12, 14, 16]
  PENULTIMATE_NOTES = [-1, 2]
  CONSONANT_INTERVALS = [-12, -9, -8, -7, -6, -5, -4, -3, -2, -1, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 12]
  THIRDS = [3, 4]
  MAJOR_SECOND = [2]
  BAD_THREE_NOTE_INTERVALS = [10, 8, -10]

  def self.valid?(notes, length)
    @notes = notes
    @length = length
    return false if !first_or_last_tonic?
    return false if !penultimate_is_leading_tone?
    return false if !middle_notes_valid?
    return true
  end

  private

  def self.consecutive_thirds?
    # checks if the last two intervals were thirds of any kind
    interval1 = get_interval(@notes[-2], @notes[-1])
    interval2 = get_interval(@notes[-3], @notes[-2])
    return false if !THIRDS.include?(interval1.abs)
    return false if !THIRDS.include?(interval2.abs)
    direction1 = up?(@notes[-2], @notes[-1])
    direction2 = up?(@notes[-3], @notes[-2])
    return (direction1 == direction2)
  end

  def self.consecutive_M2s?
    interval1 = get_interval(@notes[-2], @notes[-1])
    interval2 = get_interval(@notes[-3], @notes[-2])
    return false if !MAJOR_SECOND.include?(interval1.abs)
    return false if !MAJOR_SECOND.include?(interval2.abs)
    direction1 = up?(@notes[-2], @notes[-1])
    direction2 = up?(@notes[-3], @notes[-2])
    return (direction1 == direction2)
  end

  def self.dissonance?
    !CONSONANT_INTERVALS.include?(get_interval(@notes[-2], @notes[-1]))
  end

  def self.first_or_last_tonic?
    if @notes.length == 1 || @notes.length == @length
      return true if @notes[-1] != 0
    end
  end

  def self.get_interval(left_note, right_note)
    0 - (left_note - right_note)
  end

  def self.middle_notes_valid?
    if @notes.length > 1
      return false if dissonance?
    elsif @notes.length > 2
      return false if range_too_wide?
      return false if outlines_bad_intervals?
      return false if consecutive_thirds?
      return false if consecutive_seconds?
    end
  end

  def self.outlines_bad_intervals?
    BAD_THREE_NOTE_INTERVALS.include?(get_interval(@notes[-3], @notes[-1]))
  end

  def self.penultimate_is_leading_tone?
    if @notes.length == @length - 1
      return true if PENULTIMATES_NOTES.include?(@notes[-1])
    end
    return false
  end

  def self.range_too_wide?
    # checks if the last two intervals add up to more than an octave
    (get_interval(@notes[-2], @notes[-1]).abs + get_interval(@notes[-3], @notes[-2]).abs > 12)
  end

  def self.up?(note1, note2)
    ((note1 - note2) <= -1)
  end

end
