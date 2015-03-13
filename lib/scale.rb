class Scale
  attr_reader(:diatonic)

  def initialize
    @mode = "major"
    @diatonic = [-15, -13, -12, -10, -8, -7, -5, -3, -1, 0, 2, 4, 5, 7, 9, 11, 12, 14, 16]
  end

  def get_notes_for_relationship(params = {})
    @pool = [-15, -13, -12, -10, -8, -7, -5, -3, -1, 0, 2, 4, 5, 7, 9, 11, 12, 14, 16]
    output = []
    parse_input(params)
    output = check_notes(@note, @relationship)
    output = check_notes(@note, @direction)
    return output
  end

  private

  def parse_input(params)
    @note = params.fetch(:note, 0)
    input = params.fetch(:relationship, 'dissonant').split(" ")
    @relationship = input[0]
    if input[1] != nil
      @direction = input[1]
    else
      @direction = params.fetch(:direction, nil)
    end
  end


  def check_notes(note, relationship)
    output = []
    @diatonic.each do |diatonic_note|
      if relationship?(note, diatonic_note, relationship)
        output.push(diatonic_note)
      end
    end
    return output
  end

  def dissonance?(note1, note2)
    consonant_intervals = [-15, -14, -13, -12, -9, -8, -7, -6, -5, -4, -3, -2, -1, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 12, 13, 14, 15, 16]
    interval = (0 - get_interval(note1, note2))
    return !(consonant_intervals.include?(interval))
  end

  def get_interval(note1, note2)
    return (note1 - note2)
  end

  def leap?(note1, note2)
    return (get_interval(note1, note2).abs > 4)
  end

  def relationship?(note1, note2, relationship)
    return dissonance?(note1, note2) if relationship == 'dissonant'
    return leap?(note1, note2) if relationship == 'leap'
    return !(leap?(note1, note2)) if relationship == 'step'
    return up?(note1, note2) if relationship == 'up'
    return down?(note1, note2) if relationship == 'down'
    return tonic?(note2) if relationship == 'tonic'
    return false if relationship == nil
    return false
  end

  def tonic?(note2)
    return note1 == 0
  end

  def up?(note1, note2)
    return ((note1 - note2) <= -1)
  end

  def down?(note1, note2)
    return ((note1 - note2) >= 1)
  end

end
