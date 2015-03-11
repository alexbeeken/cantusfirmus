require_relative('candidates.rb')
require_relative('phrase.rb')
require_relative('scale.rb')
require_relative('NoteConverter.rb')

def build_cantusfirmus(tonic, length)

def leap?(one, second)
  return (one - second).abs >= 5
end

def moved_up?(one, second)
  return (one - second) > 0
end

def distance(one, second)
  return (one - second).abs
end

scale = Scale.new({:tonic => tonic})
phrase = Phrase.new({:tonic => tonic})
candidates = Candidates.new({:tonic => tonic, :scale => scale.notes})
noteconv = NoteConverter.new({:tonic => tonic})

(length-1).times do |counter|
  candidates.reset
  current = phrase.last
  last_two = false
  if phrase.length == 1
    candidates.remove_dissonances(tonic)
    candidates.remove_leaps(tonic)
  elsif phrase.length == 2
    second = tonic
    candidates.remove_dissonances(current)
  elsif phrase.length == (length - 2)
    last_two = true
    candidates.remove_all_nonleading_tones
  elsif phrase.length == (length - 1)
    last_two = true
    candidates.remove_all_except_tonic
  else
    second = phrase.second_to_last
    third = phrase.third_to_last
    if leap?(current, second)
      if leap?(second, third)
        candidates.remove_leaps(current)
      else
        up = moved_up?(current, second)
        candidates.remove_leaps_in_direction(current, up)
      end
    else
      if moved_up?(current, second) == moved_up?(second, third)
        if (((current - second).abs == 2) && ((second - third).abs == 2))
          if moved_up?(current, second)
            candidates.remove_intervals(current, [1, 2])
          else
            candidates.remove_intervals(current, [-1, -2])
          end
        elsif (((current - second).abs == 3) || ((current - second).abs == 4)) && (((second - third).abs == 3) || ((second - third).abs == 4))
          if moved_up?(current, second)
            candidates.remove_intervals(current, [3, 4])
          else
            candidates.remove_intervals(current, [-3, -4])
          end
        end
      end
    end
  end

  if !last_two
    loop_candidates = candidates.notes.dup
    loop_candidates.each() do |candidate|
      if (current - candidate).abs > 12
        candidates.delete(candidate)
      end
    end
  else
    closest = 60
    closest_compare = 25
    loop_candidates = candidates.notes.dup
    loop_candidates.each() do |candidate|
      if (current - candidate).abs < closest_compare
        closest = candidate
        closest_compare = (current - candidate).abs
      end
    candidates.remove_all_except(closest)
  end
end
  phrase.add_note(candidates.pick_one(current))
end

return noteconv.convert(phrase.notes)
end
