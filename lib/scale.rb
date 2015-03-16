class Scale
  attr_reader(:diatonic)

  def initialize
    @mode = "major"
    @diatonic = [-15, -13, -12, -10, -8, -7, -5, -3, -1, 0, 2, 4, 5, 7, 9, 11, 12, 14, 16]
  end

  def get_notes_for_relationship(params = {})
    output = []
    parse_input(params)
    output = check_notes(@note)
    return output
  end

  private

  def parse_input(params)
    @note = params.fetch(:note, 0)
    input = params.fetch(:relationship, 'dissonant').split(" ")
    if ((input[0] != 'up') && (input[0] != 'down') && (input[0] != 'any'))
      @relationship = input[0]
      @direction = params.fetch(:direction, input[1])
    else
      @direction = params.fetch(:direction, input[0])
    end
  end


  def check_notes(note)
    output = []
    @diatonic.each do |diatonic_note|
      if relationship?(note, diatonic_note) && correct_direction?(note, diatonic_note)
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
    (note1 - note2)
  end

  def leap?(note1, note2)
    return (get_interval(note1, note2).abs > 4)
  end

  def relationship?(note1, note2)
    return dissonance?(note1, note2) if @relationship == 'dissonant'
    return leap?(note1, note2) if @relationship == 'leap'
    return !(leap?(note1, note2)) if @relationship == 'step'
    return !(tonic?(note2)) if @relationship == 'all_except_tonic'
    return !(leading_tone?(note2)) if @relationship == 'all_nonleading_tones'
    return major_second?(note1, note2) if @relationship == 'major_second'
    return m_or_M_third?(note1, note2) if @relationship == 'm_or_M_third'
    return range?(note1, note2, 12) if @relationship == 'not_in_octave'
    return range?(note1, note2, 16) if @relationship == 'not_in_tenth'
    return true if @relationship == nil
    return true
  end

  def correct_direction?(note1, note2)
    return (note1 - note2) < 0 if @direction == 'up'
    return (note1 - note2) > 0 if @direction == 'down'
    return true if @direction == nil
    return true if @direction == 'any'
    return true
  end

  def range?(note1, note2, range)
    (note1 - note2).abs > range
  end

  def leading_tone?(note)
    ([-13, -10, -1, 2, 11, 14 ].include?(note))
  end

  def major_second?(note1, note2)
    (get_interval(note1, note2).abs == 2)
  end

  def m_or_M_third?(note1, note2)
    ([3, 4].include?(get_interval(note1, note2).abs))
  end

  def tonic?(note1)
    if [-12, 0, 12].include?(note1)
      within_fourth?(@note, note1)
    end
  end

  def within_fourth?(note1, note2)
    get_interval(note1, note2).abs <= 5
  end

  def up?(note1, note2)
    return ((note1 - note2) <= -1)
  end

  def down?(note1, note2)
    return ((note1 - note2) >= 1)
  end

end
