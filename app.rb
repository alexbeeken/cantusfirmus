require("bundler/setup")
require('pry')
Bundler.require(:default)
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

get '/' do
  erb(:form)
end

get '/form_submit' do
  binding.pry
  @cantusfirmus = build_cantusfirmus(params.fetch('key').to_i, params.fetch('length').to_i)
  @key = get_key(params.fetch('key').to_i)
  @length = params.fetch('length').to_i
  erb(:index)
end
