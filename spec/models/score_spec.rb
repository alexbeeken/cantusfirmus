require_relative "../rails_helper.rb"

describe Score do

  describe "#initialize" do

    it "Generates a score for a phrase based on given examples." do
      score = Score.new([0, 2, 4, 2, 0], [[0, 2, 4, 7, 4, 2, 0])
      expect(score.score.class).to eq(Float)
    end

    it "Generates a score for a phrase based on given examples." do
      score = Score.new([0, 2, 4, 2, 0], [[0, 2, 4, 7, 4, 2, 0])
      expect(score.score.class).to eq(Float)
    end
  end
end
