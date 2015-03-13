require_relative('candidates.rb')
require_relative('phrase.rb')
require_relative('scale.rb')
require_relative('NoteConverter.rb')

def build_cantusfirmus(tonic, length)

  phrase = Phrase.new({:length => length})
  candidates = Candidates.new()
  scale = Scale.new()
  noteconv = NoteConverter.new()

  (length-1).times do |counter|
    phrase.add_note(candidates.next_note(phrase))
  end

  return {:cantusfirmus => noteconv.convert(phrase.notes), :key => noteconv.get_key}
end
