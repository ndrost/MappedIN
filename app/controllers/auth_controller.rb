class AuthController < ApplicationController
  def index
  # get your api keys at https://www.linkedin.com/secure/developer
    client = LinkedIn::Client.new(ENV['CONSUMER_KEY'], ENV['CONSUMER_SECRET'])
    request_token = client.request_token(:oauth_callback => 
                                      "http://#{request.host_with_port}/auth/callback")
    session[:rtoken] = request_token.token
    session[:rsecret] = request_token.secret

    redirect_to client.request_token.authorize_url
  end

  def callback
     client = LinkedIn::Client.new(ENV['CONSUMER_KEY'], ENV['CONSUMER_SECRET'])
    if session[:atoken].nil?
       pin = params[:oauth_verifier]
       atoken, asecret = client.authorize_from_request(session[:rtoken], session[:rsecret], pin)
       session[:atoken] = atoken
       session[:asecret] = asecret
    else
       client.authorize_from_access(session[:atoken], session[:asecret])
    end
    @connections = client.connections
    @profile = client.profile
    process_connections
  end

#  def show
#     client = LinkedIn::Client.new(ENV['CONSUMER_KEY'], ENV['CONSUMER_SECRET'])
#    if session[:atoken].nil?
#       pin = params[:oauth_verifier]
#       atoken, asecret = client.authorize_from_request(session[:rtoken], session[:rsecret], pin)
#       session[:atoken] = atoken
#       session[:asecret] = asecret
#    else
#       client.authorize_from_access(session[:atoken], session[:asecret])
#    end
#    @connections = client.connections
#    @profile = client.profile
#    process_connections
#  end

  def process_connections
    counter = 0
    @rarr = Array.new(0,Hash.new)
    @connections.each do |con|
      loc_name = con.location.name.sub(/ Area/, '')
      loc_name = loc_name.sub(/ Bay/, '')
      loc_name = loc_name.sub(/Greater /, '')
      results = Geocoder.search loc_name
        if !results.empty?
	@rarr[counter] = 
		{:description => 
		"#{con.first_name} 
		 #{con.last_name} <BR>
		 #{loc_name}<BR> <a href=
		 #{con.site_standard_profile_request}>Profile</a><BR> <img src=
		 #{con.picture_url}>", :lat => results[0].latitude, :lng => results[0].longitude}
        counter+=1
        end
    end
  @process_connections = @rarr
  end
end
