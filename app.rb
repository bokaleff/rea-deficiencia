require 'sinatra'
require 'ims/lti'
require 'haml'
require 'base64'

get '/' do
  @ra = Base64.decode64(params[:r]) if params[:r]
  haml :index
end
