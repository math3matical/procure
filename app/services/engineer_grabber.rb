require 'rest-client'
include RestClient
class EngineerGrabber < ApplicationService
  attr_reader :message
  
  def initialize(fname, lname)
    @fname = fname
    @lname = lname 
  end

  def call()
    begin
      response = RestClient::Request.new(
        method: :get,
        url: "https://access.redhat.com/hydra/rest/users/?lastName=#{@lname}&firstName=#{@fname}",
        user: Rails.application.credentials.rhn[:user],
        password: Rails.application.credentials.rhn[:password],
        headers: {accept: :json, content_type: :json }
      ).execute
    rescue RestClient::ExceptionWithResponse => err
    end
    if err
      results = {"error": "true", "message": "Error.  Could not find engineer"}
    elsif response.net_http_res.code == '204'
      results = {"error": "true", "message": "204: No Content. Could not find engineer"}
    else 
      results = JSON.parse(response.to_str)
    end
    results
  end
end
