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
  @cantusfirmus = build_cantusfirmus(params.fetch('length').to_i)
  @length = params.fetch('length').to_i
  erb(:index)
end
