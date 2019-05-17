require 'pry'
class PostsController < ApplicationController


  get '/users/new_posts' do
    @post=Post.find_by(id: params[:id])
    erb :'users/new_posts.html'
  end

  get '/posts/posts' do
    @posts = Post.all
    erb :'posts/posts.html'
  end

  post '/users/new_posts' do
    @post = Post.new
    @post.title = params[:title]
    @post.content = params[:content]
    @post.user_id = User.find_by(email: session[:email]).id
    @post.save
    # binding.pry
    if @post
      redirect '/posts/posts'
    else
      erb :"posts.html"
    end
  end

  get '/posts/:id/edit' do
    @post = Post.find_by(id: params[:id])
    erb :'posts/edit.html'
  end

    patch '/posts/:id/edit' do
      old_post = Post.find_by(id: params[:id])
      old_post[:title] = params[:title]
      old_post[:content] = params[:content]
      old_post.save
      redirect "/posts/posts"
    end

    delete '/posts/:id/delete' do
      @post = Post.find_by(id: params[:id])
      if @post.user.email == session[:email]
      @post.destroy
      redirect '/posts/posts'
      else
      redirect '/users/dashboard'
      end
end
end
