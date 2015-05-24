class Formatter

  def self.format_notes(notes, tonic)
    @tonic = tonic
    output = []
    notes.each do |note|
      output.push(to_showable_one_note(note))
    end
    return output.join(" ")
  end

  def self.get_letter_name(note)
    scale_number = ((note % 12) + (12 - (@tonic % 12))) % 12
    reference = ["C","C#","D","D#","E","F","F#","G","G#","A","A#","B","C","C#","D","D#","E","F","F#","G","G#","A","A#","B"]
    return reference[scale_number + (@tonic % 12)]
  end

  private

  def self.to_showable_one_note(note)
    letter_name = get_letter_name(note)
    octave_number = get_octave_number(note)
    return "#{letter_name}/#{octave_number}"
  end

  def self.get_octave_number(note)
    note_number = note + @tonic
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

end
