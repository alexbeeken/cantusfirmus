class CantusFirmus
  attr_reader(:notes, :phrase)

  def initialize(params = {})
    @evaluator = params.fetch(:evaluator)
    @phrase = Phrase.new({:length => params.fetch(:length, 8), :evaluator => @evaluator})
    @candidates = Candidates.new({:phrase => @phrase.dup, :evaluator => @evaluator})
    build
    @notes = @phrase.notes
  end

  private

  def build
    (@phrase.length - 1).times do |counter|
      @candidates = Candidates.new({:phrase => @phrase.dup, :evaluator => @evaluator})
      @phrase.add_note(@candidates.next_note)
    end
  end
end
