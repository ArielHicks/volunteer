class PostsController < ApplicationController

  get '/posts' do
    "A list of publically available #popscope volunteer names."
  end

  #Checking if they are logged in
    get '/posts/new' do
      if !logged_in?
        redirect "/login"  #redirecting if they aren't
      else
        "A new volunteer form." #rendering if they are
      end
     end

     #Checking if they are logged in
    get '/posts/:id/edit' do
      if !logged_in?
      redirect "/login" #redirecting if they aren't
      else
      # how do I find the post that only tthe author user is allowed to edit
      if  post = current_user.posts.find(params[:id])
        "An edit volunteer form #{current_user.id} is editing #{post.id}" #rendering if they are
      else
        redirect '/posts'
      end
      end
  end
end
