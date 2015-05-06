class ExamplesController < ApplicationController

  def index
    @list = Example.all
  end

  def show
    evaluator = Evaluator.new
    @key = params.fetch('key', '60').to_i
    noteconverter = NoteConverter.new({tonic: @key, evaluator: evaluator})
    @example = Example.find(params['id'])
    @cantusfirmus = noteconverter.convert(@example.to_array)
  end

  def new
    # displays a form for creating a new example
  end

  def create
    # creates an example for the user to save, if desired
    evaluator = Evaluator.new
    cantusfirmus = Builder.build(params)
    example = Example.new(notes: cantusfirmus.notes.to_s)
    @key = params.fetch('key', '60').to_i
    noteconverter = NoteConverter.new({tonic: @key, evaluator: evaluator})
    @cantusfirmus = noteconverter.convert(example.to_array)
  end

  def update
    # saves an existing example
    Example.new(notes: params.fetch('example')).save
    redirect_to self.index
  end

  private

  def example_params
    params.require(:example).permit(:notes, :id)
  end
end
