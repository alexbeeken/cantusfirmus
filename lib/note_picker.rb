class Note_Picker

  def initialize(params = {})
    @phrase = params.fetch(:phrase, nil)
    @candidates = params.fetch(:candidates, nil)
  end

  def pick_note
    test_phrase = nil
    phrases = []
    @candidates.each do |candidate|
      test_phrase = Phrase.new({:notes => @phrase.notes.dup, :length => @phrase.length})
      test_phrase.add_note(candidate)
      test_phrase.set_score(Evaluator.get_score(test_phrase.notes))
      phrases.push(test_phrase)
    end

    top = Phrase.new({:score => 30000})
    runner_up = Phrase.new({:score => 30000})
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
