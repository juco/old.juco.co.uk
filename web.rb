require 'sinatra/base'
require 'sass'
require 'coffee_script'

class Application < Sinatra::Base
  set :views, scss: 'css', default: 'views'
  helpers do
    def find_template(views, name, engine, &block)
      _, folder = views.detect { |k,v| engine == Tilt[k] }
      folder ||= views[:default]
      super(folder, name, engine, &block)
    end
  end

  get '/' do
    erb :index
  end

  get '/css/style.css' do
    scss :style, style: :expanded
  end

  get '/javascripts/*' do
    file = params[:splat].join('/').split('.').first
    coffee "/../javascripts/#{file}".to_sym
  end

  run! if app_file == $0
end
