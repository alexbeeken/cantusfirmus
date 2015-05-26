class Example < ActiveRecord::Base

  def intialize(notes, tonic)
    @notes = notes
    @tonic = tonic
  end

  def showable_notes
    names = Formatter.format_notes(self.notes, self.tonic)
    return names.join(" | ")
  end

  def showable_tonic
    Formatter.get_letter_name(self.tonic, 0)
  end

end
