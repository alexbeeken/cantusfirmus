class Validator

  DIATONIC_NOTES = [-15, -13, -12, -10, -8, -7, -5, -3, -1, 0, 2, 4, 5, 7, 9, 11, 12, 14, 16]
  PENULTIMATE_NOTES = [-1, 2]
  CONSONANT_INTERVALS = [-12, -9, -8, -7, -6, -5, -4, -3, -2, -1, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 12]

  def self.valid?(notes, length)
    @notes = notes
    @length = length
    return false if !first_or_last_tonic?
    return false if !penultimate_is_leading_tone?
    return false if !middle_notes_valid?
    return true
  end

  private

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
      return false if outlines_augmented_fourth?
    end
  end

  def self.outlines_augmented_fourth?
    get_interval(@notes[-3], @notes[-1]) == 8
  end

  def self.penultimate_is_leading_tone?
    if @notes.length == @length - 1
      return true if PENULTIMATES_NOTES.include?(@notes[-1])
    end
  end

  def self.range_too_wide?
    # checks if the last two intervals add up to more than an octave
    (get_interval(@notes[-2], @notes[-1]).abs + get_interval(@notes[-3], @notes[-2]).abs > 12)
  end

end
