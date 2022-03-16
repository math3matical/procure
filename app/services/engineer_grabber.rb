require 'rest-client'
include RestClient
class EngineerGrabber < ApplicationService
  attr_reader :message
  
  def initialize(fname, lname)
    @fname = fname
    @lname = lname 
  end

  def call()
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
