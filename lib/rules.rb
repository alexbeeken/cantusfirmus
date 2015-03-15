class Rules

  def find_rule_breaking_relationships(phrase)
    @phrase = phrase
    parse_input
    exception_checks
    middle_checks
    return @return
  end

  private

  def parse_input
    @first = @phrase.last
    @second = @phrase.second_to_last
    @third = @phrase.third_to_last
    @current_length = @phrase.notes.length
    @length = @phrase.length
    @return = []
    @notes = @phrase.notes
  end

  def exception_checks
    first_note_check_and_remove
    second_note_check_and_remove
    last_note_check_and_remove
    second_to_last_note_check_and_remove
  end

  def first_note_check_and_remove
    if @phrase.notes.length == 1
      @return.push('dissonant')
      @return.push('leap')
    end
  end

  def last_interval_leap_check
    if leap?(@first, @second)
      second_to_last_interval_leap_check
    end
  end

  def last_note_check_and_remove
    if (@length - 1) == (@current_length)
      @return.push('all_but_tonic')
    end
  end

  def middle_checks
    if (@current_length > 2) && (@current_length < (@length - 2))
      last_interval_leap_check
      double_major_second_check
      thirds_check
    end
  end

  def second_note_check_and_remove
    if (@current_length == 2) && (@second != nil)
      @return.push('dissonant')
    end
  end

  def second_to_last_interval_leap_check
    if leap?(@second, @third)
      @return.push('leap')
    else
      second_to_last_interval_up_check
    end
  end

  def second_to_last_interval_up_check
    if up?(@second, @third)
      @return.push('leap up')
    else
      @return.push('leap down')
    end
  end

  def second_to_last_note_check_and_remove
    if @current_length == (@length - 2)
      @return.push('nonleading')
    end
  end

  def thirds_check
    if double_third_in_same_direction?(@first, @second, @third)
      if up?(@second, @first)
        @return.push('m_or_M_third up')
      else
        @return.push('m_or_M_third down')
      end
    end
  end

  def double_major_second_check
    if double_major_second_in_same_direction?(@first, @second, @third)
      if up?(@second, @first)
        @return.push('major_second up')
      else
        @return.push('major_second down')
      end
    end
  end

  def major_second?(note1, note2)
    (note1 - note2).abs == 2
  end

  def third?(note1, note2)
    [3, 4].include?((note1 - note2).abs)
  end

  def up?(note1, note2)
    (note1 - note2) < 0
  end

  def leap?(note1, note2)
    (note1 - note2).abs >= 5
  end

  def double_major_second_in_same_direction?(note1, note2, note3)
    (major_second?(note1, note2) && major_second?(note2, note3)) && (up?(note1, note2) == up?(note2, note3))
  end

  def double_third_in_same_direction?(note1, note2, note3)
    (third?(note1, note2) && third?(note2, note3)) && (up?(note1, note2) == up?(note2, note3))
  end
end
