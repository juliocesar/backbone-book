require 'sinatra'
require 'sinatra/asset_pipeline'
require 'rdiscount'

register Sinatra::AssetPipeline

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


helpers do
  def partial name, locals={}
    erb name, layout: false, locals: locals
  end
end
