class Triplet

  def initialize(note1, note2, note3)
    @note1 = note1
    @note2 = note2
    @note3 = note3
    @valid = validate()
    return validate
  end

  private

  def validate
    last_interval_leap_check
    
  end

  def last_interval_leap_check
    if leap?(@first, @second)
      second_to_last_interval_leap_check
    end
  end

  def middle_checks
    if (@current_length > 2) && (@current_length < (@length - 2))
      last_interval_leap_check
      double_major_second_check
      thirds_check
    end
  end

  def second_to_last_interval_leap_check
    if leap?(@second, @third)
      return false if leap?(@note1, @note2)
    else
      second_to_last_interval_up_check
    end
  end

  def second_to_last_interval_up_check
    if up?(@third, @second)
      @return.push('leap up')
    else
      @return.push('leap down')
    end
  end

  def second_to_last_note_check_and_remove
    if @current_length == (@length - 2)
      @return.push('all_nonleading_tones')
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
    
   def tonic?(note1)
    if [0].include?(note1)
      within_fourth?(@note, note1)
    end
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
