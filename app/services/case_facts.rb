require 'rest-client'
include RestClient
class TweetCreator < ApplicationService
  attr_reader :message
  
  def initialize(caseid)
    @caseid = caseid
  end

  def call
    response = RestClient::Request.new(
      method: :get,
      url: "https://access.redhat.com/hydra/rest/cases/#{case_id}",
      user: Rails.application.credentials.rhn[:user],
      password: Rails.application.credentials.rhn[:password],
      headers: {accept: :json, content_type: :json }
    ).execute
    results = JSON.parse(response.to_str)
  end
end
