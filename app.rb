require 'sinatra'
require 'ims/lti'
require 'haml'

get '/' do
  haml :index
  params[:ra]
end

post '/test' do
  params[:custom_canvas_user_login_id]
end



