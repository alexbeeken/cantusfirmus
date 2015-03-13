class Scale
  attr_reader(:diatonic)

  def initialize
    @mode = "major"
    @diatonic = [-15, -13, -12, -10, -8, -7, -5, -3, -1, 2, 4, 5, 7, 9, 11, 12, 14, 16]
    @consonant_intervals = [ -15, -14, -13, -12, -9, -8, -7, -6, -5, -4, -3, -2, -1, 1, 2, 3, 4, 5, 6, 7, 8, 9, 12, 13, 14, 15, 16]
  end

  def dissonances(note)
    output = []
    @diatonic.each do |diatonic_note|
      interval = 0 - (note - diatonic_note)
      if !(@consonant_intervals.include?(interval))
        output.push(diatonic_note)
      end
    end
    return output
  end

end
