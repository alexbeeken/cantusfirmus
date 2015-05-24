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
end
