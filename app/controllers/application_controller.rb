require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "fwitter_secret"
  end

  helpers do
    def logged_in?
      session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    if session[:user_id]
      redirect "/tweets"
    end
    erb :"users/create_user"
  end

  post '/signup' do
    user = User.create(params)
    session[:user_id] = user.id
    if params.values.include?("")
      redirect "/signup"
    end
    redirect "/tweets"
  end

  get '/login' do
    if session[:user_id]
      redirect "/tweets"
    end
    erb :"users/login"
  end

  post '/login' do #log in user and add user_id to sessions hash
    user=User.find_by(username: params[:username])
    if user
      session[:user_id] = user.id
      redirect "/tweets"
    else
      redirect "/signup"
    end
  end

  get '/logout' do
    session.destroy
    redirect "/login"
  end

end
