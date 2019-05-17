require './config/environment.rb'
class ApplicationController < Sinatra::Base

  configure do
    enable :sessions
    set :session_secret, "ficusplant"
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  # Homepage -- after this, we switch to the users_controller to have the user sign-up!
  get '/' do
    erb :index
  end

  # This displays the users dashboard once they've logged in
  get '/users/dashboard' do
    @users = User.all
    @user = User.find_by(:email => session[:email])
    erb :"users/dashboard.html"
  end

  # Self explanatory -- logs the user out!
  get '/users/logout' do
    session.clear
    erb :"users/logout.html"
  end

  # Routes to the delete page
  get '/users/delete' do
    erb :"users/delete.html"
  end

  # Creates the ability for the user to delete their account
  delete '/users/delete' do
    delete_user = User.find_by(email: session[:email])
    if delete_user.email == params[:email]
    delete_user.destroy
    erb :"users/new.html"
    else
    redirect '/users/delete'
    end
end

end

# Helper methods
  helpers do
    def logged_in?
      !!current_user
    end

    def current_user
      @current_user ||= User.find_by(:email => session[:email])
    end
  end
