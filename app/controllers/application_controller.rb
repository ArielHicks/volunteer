require './config/environment.rb'
class ApplicationController < Sinatra::Base

  configure do
    enable :sessions
    set :session_secret, "ficusplant"
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :index
  end

  get '/users/dashboard' do
    @users = User.all
    erb :"users/dashboard.html"
  end

  get '/users/logout' do
    erb :"users/logout.html"
  end

  get '/users/delete' do
    erb :"users/delete.html"
  end

  post '/users/delete' do
    delete_user = User.find_by(email: params[:email])
    delete_user.destroy
    redirect '/'
  end
end

  helpers do
    def logged_in?
      !!current_user
    end

    def current_user
      @current_user ||= User.find_by(:email => session[:email])
    end
  end
