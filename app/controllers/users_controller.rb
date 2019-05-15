class UsersController < ApplicationController


  # The user can sign-up here!
   get '/signup' do
     erb :"users/new.html"
   end

  # After the user signs up, they can login using this route/form
   get '/login' do
     erb :"users/login.html"
   end

  # This post route authenticates the user as they login. If they are not authenticated, they'll be redirected to start the process over
   post '/login' do
     @user = User.find_by(:email => email)
       if @user && @user.authenticate(params[:password_digest])
       session[:email] = @user.email
       redirect '/users/users.html'
       else
       redirect '/'
       end
   end

   # This creates the users route
     get '/users' do
       @users = User.all
       erb :"/users.html"
     end

    # This post will gather all of the information supplied by the user and save it to the database.
      post '/users' do
        @user = User.new
        @user.name = params[:name]
        @user.email = params[:email]
        @user.password = params[:password]
        @user.profession = params[:profession]
        @user.save
        if @user
          redirect '/login'
        else
          erb :"users/new.html"
        end
      end

    # After supplying all of your information to the database that's required, the user will be required to login.
    # if your login information matches (email and password) you'll be granted access to your dashboard!
      post '/users/login' do
        @users = User.all
        @user = User.find_by(:email => params[:email])
        if @user && @user.authenticate(params[:password])
          session[:email] = @user.email
          erb :'/users/dashboard.html'
        else
          redirect '/'
        end
    end

    # Accesses a users accoount
    get '/users/:id/edit' do
      @user = User.find(params[:id])
      erb :'users/edit.html'
    end

    # Actually edits the users information within the database and redirects them to their dashboard
    patch '/users/:id' do
      @users = User.find(params[:id])
      updates = {profession: params[:profession], name: params[:name], email: params[:email]}
      @users.update(updates)
      redirect to('/users/dashboard')
    end

  # Will clear the session and log the user out
   def logout!
     session.clear
   end
end
