require 'rest-client'
include RestClient
class BugCaller < ApplicationService
  attr_reader :message
  
  def initialize(bnum)
    @bug_number = bnum
  end

  def call
#    client = Twitter::REST::Client.new do |config|
#      config.consumer_key        = ENV['TWITTER_CONSUMER_KEY']
#      config.consumer_secret     = ENV['TWITTER_CONSUMER_SECRET']
#      config.access_token        = ENV['TWITTER_ACCESS_TOKEN']
#      config.access_token_secret = ENV['TWITTER_ACCESS_SECRET']
#    end
#    client.update(@message)
    RestClient.get 'https://google.com'
    response = RestClient::Request.new(
      method: :get,
      url: "https://bugzilla.redhat.com/rest/bug/#{@bug_number}",
     # url: "https://bugzilla.redhat.com/rest/bug/2050100",
     # url: "https://bugzilla.redhat.com/show_bug.cgi?id=2024778#c1",
     # url: "https://bugzilla.redhat.com/rest/user/1?include_fields=id,name",

#      user: Rails.application.credentials.bug[:user],
#      password: Rails.application.credentials.bug[:password],
#      headers: {accept: :json, content_type: :json, Authorization: "Bearer qYSyO0mLLfXakCUWbwhPvnQWrEos52yOnlLa4LwZ"}
      headers: {accept: :json, content_type: :json, Authorization: "Bearer #{Rails.application.credentials.bug[:key]}"}
    ).execute
    results = JSON.parse(response.to_str)
  end
end
