class Formatter

  def self.parse_strings(string, evaluator)
    string = string.split('|')
    phrases = []
    string.each do |partial|
    out_notes = []
      partial = partial.split(" ")
        partial.each do |st_num|
          out_notes.push(st_num.to_i)
        end
      phrases.push(Phrase.new(:notes => out_notes, :evaluator => evaluator))
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
