require 'sinatra'
require 'sinatra/asset_pipeline'
require 'rdiscount'

register Sinatra::AssetPipeline

CHAPTERS = File.join(File.dirname(__FILE__), 'chapters')

configure :development do
  require 'sinatra/reloader'
  register Sinatra::Reloader
end

get '/' do
  @chapters = []
  erb :home
end

get '/:chapter' do
  path = File.join CHAPTERS, params[:chapter] + '.md'
  return not_found unless File.exists?(path)
  @chapter = RDiscount.new(File.read(path)).to_html
  erb :frame, :layout => false
end

not_found do
  "Whoops!"
end
