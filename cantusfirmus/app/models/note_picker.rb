class Note_Picker

  def initialize(params = {})
    @evaluator = params.fetch(:evaluator)
    @phrase = params.fetch(:phrase, nil)
    @candidates = params.fetch(:candidates, nil)
  end

  def pick_note
    test_phrase = nil
    phrases = []
    @candidates.each do |candidate|
      test_phrase = Phrase.new({:notes => @phrase.notes.dup, :length => @phrase.length, :evaluator => @evaluator})
      test_phrase.add_note(candidate)
      phrases.push(test_phrase)
    end

    top = Phrase.new({:score => 30000, :evaluator => @evaluator})
    runner_up = Phrase.new({:score => 30000, :evaluator => @evaluator})
    phrases.each do |phrase|
      if phrase.score < top.score
        top = phrase
      elsif phrase.score < runner_up.score
        runner_up = phrase
      end
    end

    return([top.last, runner_up.last].sample)
  end
end
