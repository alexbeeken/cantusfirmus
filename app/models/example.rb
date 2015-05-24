class Example < ActiveRecord::Base
  attr_reader(:notes)

  def intialize(notes)
    @notes = notes
  end

  def showable_for_key(key = 60)
    names = Converter.convert(@notes, key)
    return names.join(" | ")
  end

end
