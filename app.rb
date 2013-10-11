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
  erb :home
end

get '/:chapter' do
  erb params[:chapter].to_sym
end
