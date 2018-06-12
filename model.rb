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

# Members must have email, password and emial is used to login
class Member
  include DataMapper::Resource
  property :id, Serial
  property :name, String
  property :email, String
  property :password, String
  property :created_at, DateTime
end
  
# Perform basic sanity checks and initialize all relationships
# Call this when you've defined all your models
DataMapper.finalize

# automatically create the post table
Post.auto_upgrade!
Member.auto_upgrade!