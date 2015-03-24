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
  @hash = build_cantusfirmus(params.fetch('key', "60").to_i, params.fetch('length').to_i, stats_array)
  @cantusfirmus = @hash[:cantusfirmus]
  @length = params.fetch('length').to_i
  @key = @hash[:key]
  @raw_notes = Formatter.format_output_phrase_for_reuse(@hash[:phrase])
  @raw_score = Evaluator.get_score(@hash[:phrase])
  @example_scores = []
  puts("PHRASE_ARRAY IS #{phrase_array}")
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

def build_cantusfirmus(tonic, length, examples)

  Evaluator.get_average(examples)
  cantusfirmus = CantusFirmus.new({:length => length})
  noteconv = NoteConverter.new({:tonic => tonic})

  output = []

  output.push(noteconv.convert(cantusfirmus.notes))

  return {:cantusfirmus => output, :key => noteconv.get_one_letter_name(tonic), :phrase => cantusfirmus.notes}
end
