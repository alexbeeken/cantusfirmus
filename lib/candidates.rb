class Candidates
  attr_reader(:phrase, :notes, :scale)

  def initialize(params = {})
    @notes = [-16, -15, -14, -13, -12, -11, -10, -9, -8, -7, -6, -5, -4, -3, -2, -1, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]
    @phrase = params.fetch(:phrase, Phrase.new())
    @scale = params.fetch(:scale, Scale.new())
  end

  def next_note
    @to_remove = []
    exception_checks
    remove_relationships
    picked_note = [0]
    self.reset
    return picked_note
  end

  def reset
    @notes = [-16, -15, -14, -13, -12, -11, -10, -9, -8, -7, -6, -5, -4, -3, -2, -1, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]
  end

  def remove_relationships
    @to_remove.uniq
    @to_remove.each do |relationship|
      notes_to_remove = scale.get_notes_for_relationship({:relationship => relationship, :note => @phrase.last})
    end
    self.remove(notes_to_remove.uniq)
  end

  def exceptions_checks
    first_note_check_and_remove
    second_note_check_and_remove
    last_note_check_and_remove
    second_to_last_note_check_and_remove
  end

  def first_note_check_and_remove(phrase)
    if phrase.notes.length == 1
        @to_remove.push('dissonant')
        @to_remove.push('leaps')
      end
    end

    def remove_dissonances(note)
      @notes.each do |candidate|
      interval = (note - candidate)
      consonant_intervals = [ -15, -14, -13, -12, -9, -8, -7, -6, -5, -4, -3, -2, -1, 1, 2, 3, 4, 5, 6, 7, 8, 9, 12, 13, 14, 15, 16]
       if (!consonant_intervals.include?(interval)) && (@notes.length > 2)
           @notes.delete(candidate)
       end
     end
   return @notes
   end
end

    def end_of_phrase_checks(phrase)
      if ([1, 2].include?(phrase.length - phrase.notes.length))
        self.just_closest_note_check(phrase.last)
      else
        self.octave_check(phrase.last)
      end
    end

    def just_closest_note_check(note)
      closest = 600
      closest_compare = 2500000
      @notes.each() do |candidate|
        if (note - candidate).abs < closest_compare
          closest = candidate
          closest_compare = (note - candidate).abs
        end
      end
      self.remove_all_except(closest)
    end

    def octave_check(note)
      loop_notes = @notes.dup
        loop_notes.each() do |candidate|
          if !((note - candidate).abs <= 12)
            self.delete(note)
          end
        end
    end


    def normal_checks(phrase)
      if last_three_not_nil?(phrase)
        last_interval_leap_check(phrase)
        last_interval_step_check(phrase)
      end
    end

    def last_three_not_nil?(phrase)
      return ((phrase.last != nil) && (phrase.second_to_last != nil) && (phrase.third_to_last != nil))
    end

    def last_interval_leap_check(phrase)
      if (phrase.notes.last - phrase.notes[phrase.notes.length - 1]).abs >= 5
        second_to_last_interval_leap_check(phrase)
      else
        second_to_last_interval_up_check(phrase)
      end
    end

    def last_interval_step_check(phrase)
      if ((phrase.last - phrase.second_to_last) > 0) && ((phrase.second_to_last - phrase.third_to_last) > 0)
        double_major_second_check(phrase)
      end
    end

    def last_interval_thirds_check(phrase)
      if [3, 4].include?(phrase.last - phrase.notes[phrase.notes.length - 2]).abs && [3, 4].include?(phrase.notes[phrase.notes.length - 2], phrase.notes[phrase.notes.lenth - 3]).abs
        if (phrase.last - phrase.notes[phrase.notes.length - 2] < 0)
          self.remove_intervals(phrase.last, [3, 4])
        else
          self.remove_intervals(phrase.last, [-3, -4])
        end
      end
    end

    def second_to_last_interval_leap_check(phrase)
      if (phrase.notes[phrase.notes.length - 1] - phrase.notes[phrase.notes.length - 2]).abs >= 5
        self.remove_leaps(phrase.last)
      end
    end

    def second_to_last_interval_up_check(phrase)
      if (phrase.second_to_last - phrase.third_to_last) > 0
        self.remove_leaps_in_direction(phrase.last, ((phrase.second_to_last - phrase.third_to_last) > 0))
      end
    end

    def last_interval_after_leap_check(phrase)
      if (phrase.last - phrase.second_to_last) > 0
        self.remove_leaps_in_direction(phrase.last, ((phrase.last - phrase.second_to_last) > 0))
      end
    end

    def double_major_second_check(phrase)
      if ((self.last - self.second_to_last).abs == 2) && ((self.second_to_last - self.third_to_last).abs == 2)
        remove_M2s_in_direction(phrase, ((phrase.last - phrase.second_to_last) > 0))
      end
    end

    def exceptions_checks(phrase)
      first_note_check_and_remove(phrase)
      second_note_check_and_remove(phrase)
      last_note_check_and_remove(phrase)
      second_to_last_note_check_and_remove(phrase)
    end

    def remove_M2s_in_direction(phrase, is_up)
      if is_up
        remove_intervals(phrase, [1,2])
      else
        remove_intervals(phrase, [-1, -2])
      end
    end

    def second_to_last_note_check_and_remove(phrase)
      if phrase.length == (phrase.notes.length - 2)
        self.remove_all_nonleading_tones
      end
    end

    def last_note_check_and_remove(phrase)
      if (phrase.length - 1) == (phrase.notes.length)
        @to_remove.push('all_but_tonic')
      end
    end

    def second_note_check_and_remove
      if phrase.notes.length == 2
        @to_remove.push('dissonant')
      end
    end

    def first_note_check_and_remove(phrase)
      if phrase.notes.length == 1
        self.remove_dissonances(tonic)
        self.remove_leaps(tonic)
      end
    end

    def remove_dissonances(note)
      @notes.each do |candidate|
        interval = 0 - (note - candidate)
        consonant_intervals = [ -15, -14, -13, -12, -9, -8, -7, -6, -5, -4, -3, -2, -1, 1, 2, 3, 4, 5, 6, 7, 8, 9, 12, 13, 14, 15, 16]
        if (!consonant_intervals.include?(interval)) && (@notes.length > 2)
            @notes.delete(candidate)
        end
      end
      return @notes
    end

    def remove_leaps(note)
      loop_notes = @notes.dup
      loop_notes.each do |candidate|
        interval = (note - candidate).abs
        if (interval > 4)
            @notes.delete(candidate)
        end
      end
      return @notes
    end

    def remove_leaps_in_direction(note, is_up)
      loop_notes = @notes.dup
      loop_notes.each do |candidate|
        interval = 0 - (note - candidate)
        if is_up == true
          leap_intervals = [1, 2, 3, 4]
        else
          leap_intervals = [-1, -2, -3, -4]
        end
        if (!leap_intervals.include?(interval)) && (@notes.length > 2)
            @notes.delete(candidate)
        end
      end
      return @notes
    end

    def remove_steps_in_direction(note, is_up)
      loop_notes = @notes.dup
      loop_notes.each do |candidate|
        interval = 0 - (note - candidate)
        if is_up == true
          leap_intervals = [1, 2, 3, 4]
        else
          leap_intervals = [-1, -2, -3, -4]
        end
        if (leap_intervals.include?(interval)) && (@notes.length > 2)
            @notes.delete(candidate)
        end
      end
      return @notes
    end

    def remove_all_nonleading_tones
      @notes = [@tonic-13, @tonic-10, @tonic+2, @tonic-1, @tonic+11, @tonic+14]
    end

    def remove_steps(note)
      puts(" ")
      puts("STARTING REMOVE STEPS------------")
      puts(" ")
      loop_notes = @notes.dup
      puts("NOTES = #{@notes}, LOOP_NOTES = #{loop_notes}")
      puts("NOTE = #{note}")
      loop_notes.each do |candidate|
        puts(" ")
        puts("--------------beginning of loop")
        puts("CURRENT CANDIDATE = #{candidate}")
        interval = (note - candidate).abs
        puts("INTERVAL = #{interval}")
        if (interval < 5)
            puts("INTERVAL IS LESS THAN 5, DELETE IT FROM #{@notes}")
            @notes.delete(candidate)
            puts("NOW NOTES LOOKS LIKE #{@notes}")
        else
          puts("INTERVAL IS NOT LESS THAN 5, KEEP IT!!")
        end
        puts("-------------end of loop")
        puts(" ")
      end
      puts("END OF LOOPS")
      puts(" ")
      if @notes == []
        puts("NOTHING LEFT IN NOTES, RETURNING ORIGINAL")
        @notes = loop_notes
        return @notes
      else
        puts("RETURNING ALTERED VERSION OF NOTES")
        return @notes
        puts("THE END")
      end

    end

    def remove_intervals(note, intervals)
      loop_intervals = @notes.dup
      loop_intervals.each do |candidate|
        interval = (note - candidate)
        if (intervals.include?(interval)) && (@notes.length > 2)
            @notes.delete(candidate)
        end
      end
      return @notes
    end

    def pick_one
      @notes.sample()
    end

    def remove_all_except(note)
      @notes = [note]
    end

    def remove_all_except_tonic
      @notes = [@tonic-12, @tonic, @tonic+12]
    end

    def delete(candidate)
      @notes.delete(candidate)
    end

end
