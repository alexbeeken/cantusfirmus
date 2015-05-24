class Example < ActiveRecord::Base
  attr_reader(:notes)

  def intialize(notes, key)
    @notes = notes
    @key = key
  end

  def showable_notes
    names = Formatter.format_notes(@notes, @key)
    return names.join(" | ")
  end

  def showable_key
    Formatter.get_letter_name(@key)
  end

end
