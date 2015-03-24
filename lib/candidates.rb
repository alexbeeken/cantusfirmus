class Candidates
  attr_reader(:phrase, :notes, :scale, :last_selection, :last_rules)

  def initialize(params = {})
    @notes = [-15, -13, -12, -10, -8, -7, -5, -3, -1, 0, 2, 4, 5, 7, 9, 11, 12, 14, 16]
    @phrase = params.fetch(:phrase, Phrase.new())
    @scale = params.fetch(:scale, Scale.new())
    @rules = params.fetch(:rules, Rules.new())
    @last_selection = []
    @last_rules = []
  end

  def next_note
    @to_remove = []
    find_and_remove_rule_breakers
    remove_starting_note
    picked_note = (Note_Picker.new({:phrase => @phrase, :candidates => @notes.dup})).pick_note
    @last_selection = @notes
    return picked_note
  end

  private

  def remove_starting_note
    @notes.delete(@phrase.last)
  end

  def find_and_remove_rule_breakers
    remove_rule_breakers(find_rule_breakers)
  end

  def find_rule_breakers
    rule_breakers = []
    @rules.find_rule_breaking_relationships(@phrase).each do |relationship|
      @last_rules.push(relationship)
      rule_breakers.push(@scale.get_notes_for_relationship({:note => @phrase.last, :relationship => relationship}))
    end
    #checks for rule that 'no two intervals should exceed an octave in any direction'
    rule_breakers.push(@scale.get_notes_for_relationship({:note => @phrase.second_to_last, :relationship => 'not_in_octave'}))

    #checks for rule for the whole phrase not traversing more than a tenth, highest to lowest note
    @phrase.notes.each do |note|
      rule_breakers.push(@scale.get_notes_for_relationship({:note => note, :relationship => 'not_in_tenth'}))
    end
    rule_breakers = munge_rule_breakers(rule_breakers)
    return rule_breakers.uniq
  end

  def munge_rule_breakers(rule_breakers)
    rule_breakers = rule_breakers.join(" ")
    rule_breakers = rule_breakers.split(" ")
    rule_breakers.uniq
    output = []
    rule_breakers.each do |note|
      output.push(note.to_i)
    end
    return output
  end

  def remove_rule_breakers(rule_breakers)
    loop_notes = @notes.dup
    loop_notes.each() do |note|
      if rule_breakers.include?(note)
        @notes.delete(note)
      end
    end
  end

end
