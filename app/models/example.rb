class Example < ActiveRecord::Base

  DEFAULT_EXAMPLES = [
    [0, 2, 5, 4, 7, 9, 7, 4, 2, 0],
    [0, 2, 4, 5, 7, 2, 5, 4, 2, 0],
    [0, 5, 4, 9, 7, 4, 5, 4, 2, 0],
    [0, 2, 4, 0, -3, 11, 0, 7, 4, 0, 2, 0],
    [0, 2, 4, 9, 7, 0, 2, 5, 4, 2, 0],
    [0, 4, 2, 9, 7, 4, 5, 4, 2, 0]]

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

  def self.reset

    self.all.each do |example|
      example.destroy
    end

    DEFAULT_EXAMPLES.each do |notes|
      new(notes: notes, tonic: 60).save
    end

  end

  def self.all_format
    output = []
    self.all.each do |example|
      preformat = []
      array = Formatter.string_to_array(example.notes)
      array.each do |note|
        preformat.push(note.to_s)
      end
      output.push(preformat.join(" "))
    end
    return output.join(" | ")
  end

end
