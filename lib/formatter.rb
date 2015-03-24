class Formatter

  def self.parse_strings(string)
    string = string.split('|')
    phrases = []
    string.each do |partial|
      partial = partial.split(" ")
      out_phrase = Phrase.new({:length => partial.length})
        partial.each do |st_num|
          out_phrase.add_note(st_num.to_i)
        end
      phrases.push(out_phrase)
      end
    return phrases
  end

  def self.format_output_phrase_for_reuse(array)
    output = ""
    array.each do |note|
      output.concat("#{note} ")
    end
    return output
  end

end
