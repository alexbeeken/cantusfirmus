class ExamplesController < ApplicationController

  def index
    @list = Example.all
  end

  def show
    id = params.fetch(:id).to_i
    key = params.fetch(:key).to_i
    @notes = Example.find(id).showable_for_key(key)
    @key = Converter.get_letter_name(key)
  end

  def new
    @examples = Example.all
  end

  def create
    length = params.fetch(:length).to_i
    examples = params.fetch(:examples)
    phrase = Phrase.new(length: length, examples: examples)
    Example.new(notes: phrase.notes).save
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
