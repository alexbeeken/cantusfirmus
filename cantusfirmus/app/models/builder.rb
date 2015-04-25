class Builder

  def self.build(params = {})
    input_array = params.fetch('input', '[0,0,0,0,0]')
    evaluator = Evaluator.new
    phrase_array = Formatter.parse_strings(input_array, evaluator)
    evaluator.set_averages({:examples => phrase_array})
    cantusfirmus = CantusFirmus.new({:length => params.fetch('length', 8).to_i, :evaluator => evaluator})
    @key = params.fetch('key', '60').to_i
    noteconverter = NoteConverter.new({:tonic => @key, :evaluator => evaluator})
    @key = noteconverter.get_one_letter_name(@key)
    @cantusfirmus = noteconverter.convert(cantusfirmus.notes)
    @length = params.fetch('length', 8).to_i
    @raw_notes = Formatter.format_output_phrase_for_reuse(cantusfirmus.notes)
    @raw_score = evaluator.get_score(cantusfirmus.phrase)
    @example_scores = []
    phrase_array.each do |phrase|
      @example_scores.push(evaluator.get_score(phrase))
    end
    return cantusfirmus
  end
end
