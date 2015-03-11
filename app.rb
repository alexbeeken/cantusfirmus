require("bundler/setup")
Bundler.require(:default)
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

get '/' do
  @cantusfirmus = build_cantusfirmus(60, 8)
  @key = get_key
  erb(:index)
end
