require 'sinatra'
require 'sinatra/asset_pipeline'

register Sinatra::AssetPipeline

configure :development do
  require 'sinatra/reloader'
  register Sinatra::Reloader
end

get '/' do
  erb :home
end

get '/:chapter' do

end
