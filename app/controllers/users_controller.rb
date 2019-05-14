class UsersController < ApplicationController
   get '/signup' do
     erb :"users/new.html"
   end

   get '/login' do
     erb :"users/login.html"
   end

   post '/login' do
     @user = User.find_by(:email => email)
       if @user && @user.authenticate(params[:password_digest])
       session[:email] = @user.email
       redirect '/users/users.html'
       else
       redirect '/'
       end
   end

     get '/users' do
       @users = User.all
       erb :"/users.html"
     end

      post '/users' do
        @user = User.new
        @user.name = params[:name]
        @user.profession = params[:profession]
        @user.email = params[:email]
        @user.password_digest = params[:password_digest]
        @user.save
        if @user
          redirect '/login'
        else
          erb :"/users/new.html"
        end
      end

   post '/users/login' do
     @users = User.all
     erb :"users/dashboard.html"
   end

   get '/users/edit' do
     erb :"users/edit.html"
   end

   def logout!
     session.clear
     #Emailing them to let them know they logged out

   end
end
