require 'rest-client'
include RestClient
class EngineerGrabber < ApplicationService
  attr_reader :message
  
  def initialize(fname, lname)
    @fname = fname
    @lname = lname 
  end

  def call()
#    client = Twitter::REST::Client.new do |config|
#      config.consumer_key        = ENV['TWITTER_CONSUMER_KEY']
#      config.consumer_secret     = ENV['TWITTER_CONSUMER_SECRET']
#      config.access_token        = ENV['TWITTER_ACCESS_TOKEN']
#      config.access_token_secret = ENV['TWITTER_ACCESS_SECRET']
#    end
#    client.update(@message)
#    iRestClient.get 'https://google.com'
    response = RestClient::Request.new(
      :method => :get,
      :url => "https://access.redhat.com/hydra/rest/users/?lastName=#{@lname}&firstName=#{@fname}",
      user: Rails.application.credentials.rhn[:user],
      password: Rails.application.credentials.rhn[:password],
      headers: {accept: :json, content_type: :json }
    ).execute
     response
     results = JSON.parse(response.to_str)
  end
end
