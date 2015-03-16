require_relative('candidates.rb')
require_relative('phrase.rb')
require_relative('scale.rb')
require_relative('NoteConverter.rb')

def build_cantusfirmus(length)

  phrase = Phrase.new({:length => length})
  scale = Scale.new()
  rules = Rules.new()
  noteconv = NoteConverter.new()

  (length-1).times do |counter|
    candidates = Candidates.new({:phrase => phrase, :scale => scale, :rules => rules})
    phrase.add_note(candidates.next_note)
  end

  output = []

  output.push(noteconv.convert(phrase.notes))

  return output
end
