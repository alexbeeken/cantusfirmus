class Note

  def initialize(params = {})
    @number = params.fetch(:note, 0)
    @score = nil
  end

  def valid?(note2, note3)
    exception_checks && normal_checks
  end

  def get_diatonics_within_octave
    output = []
    [-15, -13, -12, -10, -8, -7, -5, -3, -1, 0, 2, 4, 5, 7, 9, 11, 12, 14, 16].each do |diatonic|
      if abs_distance(self.number, diatonic) <= 12
        output.push(diatonic)
      end
    end
    return instantiate(output)
  end

  private

  def exception_checks
  end

  def normal_checks
  end

  def instantiate(array)
    output = []
    array.each do |number|
      output.push(Note.new(:number => number))
    end
    return output
  end

end
