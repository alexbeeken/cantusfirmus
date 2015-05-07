class CantusFirmus
  attr_reader(:notes, :phrase, :example)

  def initialize(params = {})
    @evaluator = params.fetch(:evaluator, Evaluator.new)
    @phrase = Phrase.new({:length => params.fetch(:length, 8), :evaluator => @evaluator})
    @candidates = Candidates.new({:phrase => @phrase.dup, :evaluator => @evaluator})
    build
    @notes = @phrase.notes
    @example = Example.new({notes: @notes.to_s})
  end

  private

  def build
    (@phrase.length - 1).times do |counter|
      @candidates = Candidates.new({:phrase => @phrase.dup, :evaluator => @evaluator})
      @phrase.add_note(@candidates.next_note)
    end
  end
end
