class Rules

  def find_rule_breaking_relationships(phrase)
    @phrase = phrase
    @return = []
    exception_checks
    middle_checks
    return @return
  end

  private

  def exception_checks
    first_note_check_and_remove
    if @phrase.second_to_last != nil
      second_note_check_and_remove
      last_note_check_and_remove
      second_to_last_note_check_and_remove
    end
  end

  def first_note_check_and_remove
    if @phrase.notes.length == 1
      @return.push('dissonant')
      @return.push('leaps')
    end
  end

  def last_interval_leap_check
    if (@phrase.notes.last - @phrase.notes[@phrase.notes.length - 1]).abs >= 5
      second_to_last_interval_leap_check
    else
      second_to_last_interval_up_check
    end
  end

  def last_note_check_and_remove
    if (@phrase.length - 1) == (@phrase.notes.length)
      @return.push('all_but_tonic')
    end
  end

  def middle_checks
    if (@phrase.notes.length > 2) && (@phrase.notes.length < (@phrase.length - 2))
      last_interval_leap_check
    end
  end

  def second_note_check_and_remove
    if @phrase.notes.length == 2
      @return.push('dissonant')
    end
  end

  def second_to_last_interval_leap_check
    if (@phrase.notes[@phrase.notes.length - 1] - @phrase.notes[@phrase.notes.length - 2]).abs >= 5
      @return.push('leap')
    end
  end

  def second_to_last_interval_up_check
    if (@phrase.second_to_last - @phrase.third_to_last) > 0
      @return.push(['leap up'])
    else
      @return.push(['leap down'])
    end
  end

  def second_to_last_note_check_and_remove
    if @phrase.length == (@phrase.notes.length - 2)
      @return.push('nonleading')
    end
  end



end
