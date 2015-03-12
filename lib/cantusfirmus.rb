require_relative('candidates.rb')
require_relative('phrase.rb')
require_relative('scale.rb')
require_relative('NoteConverter.rb')

def build_cantusfirmus(tonic, length)

  phrase = Phrase.new({:length => length})
  candidates = Candidates.new({:tonic => tonic, :scale => scale.notes})
  scale = Scale.new({:tonic => tonic})
  noteconv = NoteConverter.new({:tonic => tonic})

  (length-1).times do |counter|
    candidates.give_next_note_to(phrase)
  end

  return {:cantusfirmus => noteconv.convert(phrase.notes), :key => noteconv.get_key}
end
