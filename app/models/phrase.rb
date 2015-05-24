class Phrase
  attr_reader(:notes)

  DIATONIC_NOTES = [-15, -13, -12, -10, -8, -7, -5, -3, -1, 0, 2, 4, 5, 7, 9, 11, 12, 14, 16]

  def initialize(params = {})
    @length = params.fetch(:length, 8)
    @notes = params.fetch(:notes, populate_notes)
    @examples = params.fetch(:examples, [])
    populate_notes
  end

  private

  def populate_notes
    notes = [0]
    (@length - 2).times do
      valid_notes = get_valid_notes(notes)
      notes.push(pick_best(valid_notes, notes, @examples))
    end
    notes.push(0)
    return notes
  end

  def get_valid_notes(notes)
    output = []
    DIATONIC_NOTES.each do |note|
      temp_array = notes.dup
      temp_array.push(note)
      if Validator.valid?(temp_array, @length)
        output.push(note)
      end
    end
    return output
  end

  def pick_best(candidates, notes, examples)
    chosen = Evaluator.get_best_from_examples(candidates, notes, examples)
    return chosen
  end
end
