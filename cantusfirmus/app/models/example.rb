class Example < ActiveRecord::Base

  def to_array
    output = []
    self.notes.gsub("[", "").gsub("]", "").split(",").each do |char|
      output.push(char.to_i)
    end
    return output
  end
  
end
