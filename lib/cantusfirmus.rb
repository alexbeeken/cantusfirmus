require_relative('candidates.rb')
require_relative('phrase.rb')
require_relative('scale.rb')
require_relative('NoteConverter.rb')

def build_cantusfirmus(tonic, length)

scale = Scale.new({:tonic => tonic})
phrase = Phrase.new({:tonic => tonic})
candidates = Candidates.new({:tonic => tonic, :scale => scale.notes})
noteconv = NoteConverter.new({:tonic => tonic})

def leap?(one, second)
  return (one - second).abs >= 5
end






(length-1).times do |counter|
  candidates.reset
  current = phrase.last
  last_two = false
  if phrase.on_first_note?
    candidates.remove_dissonances(tonic)
    candidates.remove_leaps(tonic)
  elsif phrase.on_second_note?
    second = tonic
    candidates.remove_dissonances(current)
  elsif phrase.on_second_to_last_note?
    last_two = true
    candidates.remove_all_nonleading_tones
  elsif phrase.on_last_note?
    last_two = true
    candidates.remove_all_except_tonic
  else
    second = phrase.second_to_last
    third = phrase.third_to_last
    if phrase.last_interval_was_a_leap?
      if phrase.second_to_last_interval_was_a_leap?
        candidates.remove_leaps(current)
      else
        up = phrase.last_interval_moved_up?
        candidates.remove_leaps_in_direction(current, up)
      end
    else
      if phrase.last_two_intervals_moved_up?
        if phrase.last_two_intervals_M2s?
          if phrase.last_interval_moved_up?
            candidates.remove_intervals(current, [1, 2])
          else
            candidates.remove_intervals(current, [-1, -2])
          end
        elsif phrase.last_two_intervals_3s?
          if phrase.last_interval_moved_up?
            candidates.remove_intervals(current, [3, 4])
          else
            candidates.remove_intervals(current, [-3, -4])
          end
        end
      end
    end
  end

  if !last_two
    phrase.return_if_within_octave(candidates.notes)
  else
    phrase.return_closest_note_to_last(candidates.notes)
    candidates.remove_all_except(closest)
  end
end
  phrase.add_note(candidates.pick_one(current))
end

  return {:cantusfirmus => noteconv.convert(phrase.notes), :key => noteconv.get_key}
end
