require 'sinatra/base'
require 'sass'
require 'coffee_script'

class Application < Sinatra::Base
  set :views, scss: 'css', default: 'views'
  set :server, :thin
  helpers do
    def find_template(views, name, engine, &block)
      _, folder = views.detect { |k,v| engine == Tilt[k] }
      folder ||= views[:default]
      super(folder, name, engine, &block)
    end
  end

  not_found do
    status 404
    erb :oops
  end

  get '/' do
    erb :index
  end

  get '/css/style.css' do
    scss :style, style: :expanded
  end

  get '/javascripts/*' do
    file = params[:splat].join('/').split('.').first
    prod_file = "dist/#{file}.js"

    if settings.production?
      if File.exists? prod_file
        send_file prod_file
      else
        not_found
      end
    else
      coffee "/../javascripts/#{file}".to_sym
    end
  end

  run! if app_file == $0
end
