require("bundler/setup")
require('pry')
require('sinatra')
require('sinatra/reloader')

Bundler.require(:default)
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

get '/' do
  erb(:form)
end

get '/form_submit' do
  input_array = params.fetch('input', '[0,0,0,0,0]')
  phrase_array = Formatter.parse_strings(input_array)
  stats_array = Evaluator.get_array_stats(phrase_array)
  Evaluator.get_average(stats_array)
  cantusfirmus = CantusFirmus.new({:length => params.fetch('length').to_i})
  @key = params.fetch('key', '60').to_i
  noteconverter = NoteConverter.new({:tonic => @key})
  @key = noteconverter.get_one_letter_name(@key)
  @cantusfirmus = noteconverter.convert(cantusfirmus.notes)
  @length = params.fetch('length').to_i
  @raw_notes = Formatter.format_output_phrase_for_reuse(cantusfirmus.notes)
  @raw_score = Evaluator.get_score(cantusfirmus.notes)
  @example_scores = []
  phrase_array.each do |phrase|
    @example_scores.push(Evaluator.get_score(phrase.notes))
  end
  erb(:index)
end

get '/evaluator_submit' do
  input_array = params.fetch('input', '[0,0,0,0,0]')
  stats_array = NoteConverter.parse_strings(input_array)
  results = Evaluator.get_average(stats_array)
  erb(:evaluator)
end
