class ApplicationController < Sinatra::Base
  configure do
    set :views, 'app/views'
    set :public_folder, 'public' 
    enable :sessions
    set :session_secret, ENV['SESSION_SECRET']
    use Rack::Flash, :sweep => true
  end

  get '/' do
    erb :index
  end
end