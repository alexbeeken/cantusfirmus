require_relative "../rails_helper.rb"

describe Score do

  describe "#initialize" do

    it "Generates a score for a phrase based on given examples." do
      score = Score.new([0, 2, 4, 2, 0])
      expect(score.steps.class).to eq(Fixnum)
    end

    it "Generates a score for a phrase based on given examples." do
      examples = [[0, 2, 5, 4, 7, 9, 7, 4, 2, 0], [0, 2, 4, 5, 7, 2, 5, 4, 2, 0], [0, 5, 4, 9, 7, 4, 5, 4, 2, 0], [0, 2, 4, 0, -3, 11, 0, 7, 4, 0, 2, 0], [0, 2, 4, 9, 7, 0, 2, 5, 4, 2, 0], [0, 4, 2, 9, 7, 4, 5, 4, 2, 0]]
      score_number = Score.get_score([0, 2, 4, 2, 0], examples)
      expect(score_number.class).to eq(Float)
    end
  end

  describe ".get_score" do

    it "Generates a score for a phrase based on given examples." do
      score1 = Score.get_score([0, 2, 5, 4, 2, -1, 0], [[0, 2, 5, 4, 7, 9, 7, 4, 2, 0], [0, 2, 4, 5, 7, 2, 5, 4, 2, 0], [0, 5, 4, 9, 7, 4, 5, 4, 2, 0], [0, 2, 4, 0, -3, 11, 0, 7, 4, 0, 2, 0], [0, 2, 4, 9, 7, 0, 2, 5, 4, 2, 0], [0, 4, 2, 9, 7, 4, 5, 4, 2, 0]])
      expect(score1.class).to eq(Float)
    end

    it "Generates a unique score for each note combination." do
      score1 = Score.get_score([0, 2, 5, 4, 2, -1, 0], [[0, 2, 5, 4, 7, 9, 7, 4, 2, 0], [0, 2, 4, 5, 7, 2, 5, 4, 2, 0], [0, 5, 4, 9, 7, 4, 5, 4, 2, 0], [0, 2, 4, 0, -3, 11, 0, 7, 4, 0, 2, 0], [0, 2, 4, 9, 7, 0, 2, 5, 4, 2, 0], [0, 4, 2, 9, 7, 4, 5, 4, 2, 0]])
      score2 = Score.get_score([0, 2, 5, 7, 4, 2, 0], [[0, 2, 5, 4, 7, 9, 7, 4, 2, 0], [0, 2, 4, 5, 7, 2, 5, 4, 2, 0], [0, 5, 4, 9, 7, 4, 5, 4, 2, 0], [0, 2, 4, 0, -3, 11, 0, 7, 4, 0, 2, 0], [0, 2, 4, 9, 7, 0, 2, 5, 4, 2, 0], [0, 4, 2, 9, 7, 4, 5, 4, 2, 0]])
      expect(score1 == score2).to eq(false)
    end
  end

  describe "#merge_score" do

    it "Adds another score objects data onto it's own." do
      score1 = Score.new([0, 2, 4, 2, 0])
      score2 = Score.new([0, 2, 7, 2, 0])
      steps_check1 = score1.steps
      steps_check2 = score2.steps
      score1.merge_score(score2)
      expect(score1.steps).to eq(steps_check1 + steps_check2)
    end
  end

  describe "#switch_to_means" do

    it "Converts the stats to means given totals." do
      
    end
  end
end
#
# def initialize(notes = [])
#   @notes = notes
#   @steps = 0
#   @leaps = 0
#   @range = 0
#   @repeated_notes = 0
#   @consecutive_steps = 0
#   @consecutive_steps_up = 0
#   @consecutive_steps_down = 0
#   @percentage_of_leaps = 0.0
#   @percentage_of_steps = 0.0
#   if @notes
#     find_statistics
#   end
# end
#
#
# def switch_to_means(number_of_examples)
#   @steps = @steps/number_of_examples.to_f
#   @leaps = @leaps/number_of_examples.to_f
#   @range = @range/number_of_examples.to_f
#   @repeated_notes += @repeated_notes/number_of_examples.to_f
#   @consecutive_steps += @consecutive_steps/number_of_examples.to_f
#   @consecutive_steps_up += @consecutive_steps_up/number_of_examples.to_f
#   @consecutive_steps_down += @consecutive_steps_down/number_of_examples.to_f
#   @percentage_of_leaps += @percentage_of_leaps/number_of_examples.to_f
#   @percentage_of_steps += @percentage_of_steps/number_of_examples.to_f
#   return self
# end
#
# def switch_to_standard_deviations(means)
#   @steps = (@steps - means.steps)**2
#   @leaps = (@leaps - means.leaps)**2
#   @range = (@range - means.range)**2
#   @repeated_notes = (@repeated_notes - means.repeated_notes)**2
#   @consecutive_steps = (@consecutive_steps - means.consecutive_steps)**2
#   @consecutive_steps_up = (@consecutive_steps_up - means.consecutive_steps_up)**2
#   @consecutive_steps_down = (@consecutive_steps_down - means.consecutive_steps_down)**2
#   @percentage_of_leaps = (@percentage_of_leaps - means.percentage_of_leaps)**2
#   @percentage_of_steps = (@percentage_of_steps - means.percentage_of_steps)**2
# end
#
# def squash_into_score
#   @steps + @leaps + @range + @repeated_notes + @consecutive_steps + @consecutive_steps_up + @consecutive_steps_down + @percentage_of_leaps + @percentage_of_steps
# end
#
# def self.get_score(notes, examples_array)
#   # it's returning the same score for every single possible note
#   if examples_array
#     scores_array = get_scores(examples_array)
#     totals = get_totals(scores_array)
#     means = totals.switch_to_means(scores_array.length)
#     standard_deviations = get_standard_deviation(scores_array, means)
#     return standard_deviations.squash_into_score
#   else
#     return 0
#   end
# end
