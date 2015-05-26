class Formatter

  def self.format_notes(notes, tonic)
    if notes.class == String
      notes = string_to_array(notes)
    end
    output = []
    notes.each do |note|
      output.push(to_showable_one_note(note, tonic))
    end
    return output
  end

  def self.get_letter_name(note, tonic)
    scale_number = get_scale_number(note, tonic)
    reference = ["C","C#","D","D#","E","F","F#","G","G#","A","A#","B","C","C#","D","D#","E","F","F#","G","G#","A","A#","B"]
    return reference[scale_number]
  end

  def self.format_examples(string)
    output_all = []
    examples = string.split("|")
    examples.each do |example|
      output_each = []
      example.split(" ").each do |note|
        output_each.push(note.to_i)
      end
      output_all.push(output_each)
    end
    return output_all
  end

  def self.string_to_array(string)
    output = []
    string.gsub((/[\]\[,]/), " ")
    string.split(" ").each do |char|
      output.push(char.to_i)
    end
    return output
  end

  private

  def self.to_showable_one_note(note, tonic)
    letter_name = get_letter_name(note, tonic)
    octave_number = get_octave_number(note, tonic)
    return "#{letter_name}/#{octave_number}"
  end

  def self.get_octave_number(note, tonic)
    note_number = note + tonic
    if (note_number > 23) && (note_number < 36)
     return "1"
    end
    if (note_number > 35) && (note_number < 48)
     return "2"
    end
    if (note_number > 47) && (note_number < 60)
     return "3"
    end
    if (note_number > 59) && (note_number < 72)
     return "4"
    end
    if (note_number > 71) && (note_number < 84)
     return "5"
    end
    if (note_number > 83) && (note_number < 85)
     return "6"
    end
  end

  def self.get_scale_number(note, tonic)
    ((note % 12) + (12 - (tonic % 12))) % 12
  end

end
