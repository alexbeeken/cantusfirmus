require_relative('scale.rb')

class NoteConverter
  attr_reader(:scale)

  # def initialize(params = {})
  #   @tonic = params.fetch(:tonic, 60)
  #   @scale = Scale.new().diatonic
  # end
  #
  # def convert(note_number)
  #   output = []
  #   if note_number.class == [].class
  #     note_number.each do |note|
  #       temp = []
  #       temp.push(get_one_letter_name(note))
  #       temp.push("/")
  #       temp.push(get_octave_number(note))
  #       temp = temp.join("")
  #       output.push(temp)
  #     end
  #   else
  #     output.push(get_one_letter_name(note_number))
  #     output.push("/")
  #     output.push(get_octave_number(note_number))
  #     output = output.join("")
  #   end
  #   return output
  # end
  #
  # def get_octave_number(note_number)
  #   if (note_number > 23) && (note_number < 36)
  #     return "1"
  #   end
  #   if (note_number > 35) && (note_number < 48)
  #     return "2"
  #   end
  #   if (note_number > 47) && (note_number < 60)
  #     return "3"
  #   end
  #   if (note_number > 59) && (note_number < 72)
  #     return "4"
  #   end
  #   if (note_number > 71) && (note_number < 84)
  #     return "5"
  #   end
  #   if (note_number > 83) && (note_number < 85)
  #     return "6"
  #   end
  # end
  #
  # def get_one_letter_name(note_number)
  #   scale_number = ((note_number % 12) + (12 - (@tonic % 12))) % 12
  #   reference = ["C","C#","D","D#","E","F","F#","G","G#","A","A#","B","C","C#","D","D#","E","F","F#","G","G#","A","A#","B"]
  #   return reference[scale_number + (@tonic % 12)]
  # end
  #
  # def get_key
  #   return get_one_letter_name(@tonic)
  # end
end
