require 'sinatra'
require 'sinatra/reloader' if development?
require 'pg'
require 'bcrypt'
require 'cloudinary'
require 'pry' if development?
require 'sinatra/flash'

require_relative 'helpers/helpers.rb'
require_relative 'helpers/cloudinary_configure.rb'

require_relative 'helpers/sessions_helpers.rb'


require_relative 'controllers/users_controller'
require_relative 'controllers/tracks_controller'
require_relative 'controllers/tips_controller'
require_relative 'controllers/sessions_controller'

enable :sessions

########################

# routes

########################

get '/' do
  tracks = run_sql("Select * from tracks ORDER by id desc")
  erb :index, locals: {
    tracks: tracks
  }
end

get '/about' do
  erb :about
end

