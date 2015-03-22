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
  @hash = build_cantusfirmus(params.fetch('key', "60").to_i, params.fetch('length').to_i)
  @cantusfirmus = @hash[:cantusfirmus]
  @length = params.fetch('length').to_i
  @key = @hash[:key]
  erb(:index)
end

get '/evaluator_submit' do
  input_array = params.fetch('input', '[0,0,0,0,0]')
  stats_array = NoteConverter.parse_strings(input_array)
  @averages = Evaluator.get_average(stats_array)
  erb(:evaluator)
end
