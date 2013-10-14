require 'sinatra'
require 'sinatra/asset_pipeline'
require 'rdiscount'

register Sinatra::AssetPipeline

configure :development do
  require 'sinatra/reloader'
  register Sinatra::Reloader
end

set :assets_precompile, %w(prism.js manifest.css)
set :assets_prefix, 'assets'
set :digest_assets, false

get '/' do
  erb :home
end

get '/:chapter' do
  erb params[:chapter].to_sym
end


helpers do
  include Sprockets::Helpers

  def partial name, locals={}
    erb name, layout: false, locals: locals
  end
end
