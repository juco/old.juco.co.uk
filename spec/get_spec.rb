require 'spec_helper'

describe 'Accessing', type: :feature do
  include Rack::Test::Methods

  def app
    Application
  end

  it 'Homepage: should boot' do
    get '/'
    expect(last_response).to be_ok
  end

  it 'CSS should return css' do
    get '/css/style.css'
    expect(last_response).to be_ok
  end

  it 'javascript should return javascript' do
    get '/javascripts/app.js'
    expect(last_response).to be_ok
  end
end
