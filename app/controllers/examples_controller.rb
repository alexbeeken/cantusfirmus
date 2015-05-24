class ExamplesController < ApplicationController

  def index
    @list = Example.all
  end

  def show
    @example = Example.find(params.fetch(:id).to_i)
  end

  def new
    @examples = Example.all
  end

  def create
    length = params.fetch(:length).to_i
    key = params.fetch(:key).to_i
    examples = Formatter.format_examples(params.fetch(:examples))
    phrase = Phrase.new(length: length, examples: examples)
    Example.create(notes: phrase.notes, key: key).save
    redirect_to examples_path
  end

  def update
    # saves an existing example
    Example.new(notes: params.fetch('example').to_i).save
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
