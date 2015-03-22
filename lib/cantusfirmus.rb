require_relative('candidates.rb')
require_relative('phrase.rb')
require_relative('scale.rb')
require_relative('NoteConverter.rb')

def build_cantusfirmus(tonic, length, examples)

  Evaluator.get_average(examples)
  phrase = Phrase.new({:length => length})
  scale = Scale.new()
  rules = Rules.new()
  noteconv = NoteConverter.new({:tonic => tonic})



  (length-1).times do |counter|
    candidates = Candidates.new({:phrase => phrase.dup, :scale => scale, :rules => rules})
    phrase.add_note(candidates.next_note)
  end

  output = []

  output.push(noteconv.convert(phrase.notes))

  return {:cantusfirmus => output, :key => noteconv.get_one_letter_name(tonic), :phrase => phrase}
end
