require 'sinatra'
require 'sass'
require 'compass'


#configure do
#  Compass.configuration do |config|
#    config.sass_dir = 'css'
#  end
#  set :scss, Compass.sass_engine_options
#end

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
