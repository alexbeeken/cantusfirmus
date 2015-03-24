class CantusFirmus
  attr_reader(:notes)

  def initialize(params = {})
    @phrase = Phrase.new({:length => params.fetch(:length, 8)})
    @candidates = Candidates.new({:phrase => @phrase.dup})
    build
    @notes = @phrase.notes
  end

  private

  def build
    (@phrase.length - 1).times do |counter|
      @candidates = Candidates.new({:phrase => @phrase.dup})
      @phrase.add_note(@candidates.next_note)
    end
  end
end
