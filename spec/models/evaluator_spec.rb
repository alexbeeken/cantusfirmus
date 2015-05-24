require_relative "../rails_helper.rb"

describe Evaluator do

  describe ".get_score" do

    it "Returns a single note." do
      result = Evaluator.get_best_from_examples([-1, 2, 4, 5, 7, 9], [0,2,4], [[0, 2, 4, 5, 7, 2, 5, 4, 2, 0], [0, 5, 4, 9, 7, 4, 5, 4, 2, 0]])
      expect(result.class).to eq(Fixnum)
    end
  end
end
