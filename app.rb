# app.rb

gem 'json', '~> 1.6'

require 'sinatra'
require 'sinatra/reloader'
require './model.rb'

# Wellcome sinatra study
# 1th.. we will use auto reload
# 2th.. if someone access to '/' we will send 'index.html'
# 3th.. if someone access to '/lunch' we will show 'lunch.erb' page

# gem install sinatra
# gem install sinatra-contrib
# gem install sinatra-reloader

get '/' do
    send_file 'index.html'
end

get '/lunch' do
    @lunch = ["김밥", "샌드위치", "피자", "치킨", "삼겹살", "국밥", "국수", "냉면", "돈까스", "햄버거", "웰스토리"].sample
	erb :lunch
end

get '/posts' do
    @posts = Post.all.reverse
    erb :posts
end

get '/posts/new' do
    erb :new
end

get '/posts/create' do
    @title = params[:title]
    @body = params[:body]
    Post.create(title: @title, body: @body )
    erb :create
end

# CRUD - Read
# Using variable routing for searching
get '/posts/:id' do
    @id = params[:id]
    @post = Post.get(@id)
    erb :show
end

# Delete post
get '/posts/destroy/:id' do
    @id = params[:id]
    Post.get(@id).destroy
    erb :destroy
end

# Edit post
get '/posts/edit/:id' do
    @id = params[:id]
    @post = Post.get(@id)
    erb :edit
end

# Post Update
get '/posts/update/:id' do
    @id = params[:id]
    @post = Post.get(@id)
    @post.update(title: params[:title], body: params[:body])
    erb :update
end

# Regist
get '/member/regist' do
    erb :regist
end

# Member Insert
get '/member/insert' do
    @name = params[:name]
    @email = params[:email]
    Member.create(name: @name, email: @email, password: params[:password])
    erb :joinsucceed
end