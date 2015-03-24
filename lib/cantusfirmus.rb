require_relative('candidates.rb')
require_relative('phrase.rb')
require_relative('scale.rb')
require_relative('NoteConverter.rb')

def build_cantusfirmus(tonic, length, examples)

  Evaluator.get_average(examples)
  cantusfirmus = CantusFirmus.new({:length => length})
  noteconv = NoteConverter.new({:tonic => tonic})

  output = []

  output.push(noteconv.convert(cantusfirmus.notes))

  return {:cantusfirmus => output, :key => noteconv.get_one_letter_name(tonic), :phrase => cantusfirmus.notes}
end

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
