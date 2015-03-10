require('pry')
require('./lib/candidates.rb')
require('./lib/phrase.rb')
require('./lib/scale.rb')

def leap?(one, second)
  return (one - second).abs >= 5
end

def moved_up?(one, second)
  return (one - second) > 0
end

tonic = 60
length = 8

scale = Scale.new({:tonic => tonic})
phrase = Phrase.new({:tonic => tonic})
candidates = Candidates.new({:tonic => tonic, :scale => scale.notes})

length.times do
  candidates.reset
  current = phrase.last
  if phrase.length == 1
    candidates.remove_dissonances(tonic)
    candidates.remove_leaps(tonic)
  elsif phrase.length == 2
    second = tonic
    candidates.remove_dissonances(current)
  elsif phrase.length == (length - 2)
    candidates.remove_all_nonleading_tones
  elsif phrase.length == (length - 1)
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

  loop_candidates = candidates.notes.dup
  loop_candidates.each() do |candidate|
    if ((current - candidate)).abs >= 12
      candidates.delete(candidate)
    end
  end

  phrase.add_note(candidates.pick_one(current))
end

puts(phrase.notes)
