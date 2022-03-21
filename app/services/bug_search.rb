require 'rest-client'
include RestClient
class BugCaller < ApplicationService
  attr_reader :message
  
  def initialize(bnum, search)
    @bug_number = bnum
    @search = search
  end

  def call
    begin
      response = RestClient::Request.new(
        method: :get,
        url: "https://bugzilla.redhat.com/rest/bug/?creator=#{@bug_number}",
        headers: {accept: :json, content_type: :json, Authorization: "Bearer #{Rails.application.credentials.bug[:key]}"}
      ).execute
    rescue RestClient::ExceptionWithResponse => err
    end
    unless err
      results = JSON.parse(response.to_str)
    else
      results = {"error": "true"}
    end
    results
  end
end
