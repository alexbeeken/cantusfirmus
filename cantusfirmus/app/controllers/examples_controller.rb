class ExamplesController < ApplicationController

  def index
    @list = Example.all
  end

  def show
    evaluator = Evaluator.new
    @key = params.fetch('key', '60').to_i
    noteconverter = NoteConverter.new({tonic: @key, evaluator: evaluator})
    @example = Example.find(params.fetch('id', '1').to_i)
    @cantusfirmus = noteconverter.convert(@example.to_array)
  end
end
