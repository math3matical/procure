require 'rest-client'
include RestClient
class BugCaller < ApplicationService
  attr_reader :message
  
  def initialize(bnum)
    @bug_number = bnum
  end

  def call
    RestClient.get 'https://google.com'
    response = RestClient::Request.new(
      method: :get,
      url: "https://bugzilla.redhat.com/rest/bug/#{@bug_number}",
      headers: {accept: :json, content_type: :json, Authorization: "Bearer #{Rails.application.credentials.bug[:key]}"}
    ).execute
    results = JSON.parse(response.to_str)
  end
end
