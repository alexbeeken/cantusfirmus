class Rules

  def initialize

  end

  def get_rule_breakers(phrase)
    @phrase = phrase
    @return = []
    exception_checks
    middle_checks
  end

  private

  def exception_checks
    first_note_check_and_remove
    second_note_check_and_remove
    last_note_check_and_remove
    second_to_last_note_check_and_remove
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
    last_interval_leap_check
  end

  def second_note_check_and_remove
    if @phrase.notes.length == 2
      @return.push('dissonant')
    end
  end

  def second_to_last_interval_leap_check(phrase)
    if (phrase.notes[phrase.notes.length - 1] - phrase.notes[phrase.notes.length - 2]).abs >= 5
      @return.push('leap')
    end
  end

  def second_to_last_interval_up_check(phrase)
    if (phrase.second_to_last - phrase.third_to_last) > 0
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
