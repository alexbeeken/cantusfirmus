class ExamplesController < ApplicationController

  def index
    @list = Example.all
  end

  def show
    evaluator = Evaluator.new
    tmp_key = params.fetch('key', '60').to_i
    noteconverter = NoteConverter.new({tonic: tmp_key, evaluator: evaluator})
    @key = noteconverter.get_one_letter_name(params.fetch('key', '60').to_i)
    @example = Example.find(params['id'])
    @cantusfirmus = noteconverter.convert(@example.to_array)
  end

  def new
    @example_notes = Example.pluck(:notes)
    # displays a form for creating a new example
  end

  def create
    # creates an example for the user to save, if desired
    evaluator = Evaluator.new
    cantusfirmus = Builder.build(params)
    @example = Example.new(notes: cantusfirmus.notes.to_s)
    @example.save
    tmp_key = 60
    noteconverter = NoteConverter.new({tonic: tmp_key, evaluator: evaluator})
    @key = noteconverter.get_one_letter_name(params.fetch('key', '60').to_i)
    @cantusfirmus = noteconverter.convert(@example.to_array)
    redirect_to examples_path
  end

  def update
    # saves an existing example
    Example.new(notes: params.fetch('example')).save
    redirect_to self.index
  end

  def destroy
    id = params.fetch(:id).to_i
    Example.find(id).destroy
    redirect_to examples_path
  end

  private

  def example_params
    params.require(:example).permit(:notes, :id)
  end
end
