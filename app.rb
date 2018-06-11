# app.rb

gem 'json', '~> 1.6'

require 'sinatra'
require 'sinatra/reloader'

require 'data_mapper' # metagem, requires common plugins too.

# print datamapper log
DataMapper::Logger.new($stdout, :debug)

DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/blog.db")

class Post
  include DataMapper::Resource
  property :id, Serial
  property :title, String
  property :body, Text
  property :created_at, DateTime
end

# Perform basic sanity checks and initialize all relationships
# Call this when you've defined all your models
DataMapper.finalize

# automatically create the post table
Post.auto_upgrade!

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

