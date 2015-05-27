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
end
