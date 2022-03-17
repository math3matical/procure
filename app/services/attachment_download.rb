require 'rest-client'
include RestClient
class AttachmentDownload < ApplicationService
  attr_reader :message
  
  def initialize(cnum)
    @solution_number = cnum
  end

  def call()
    begin
      response = RestClient::Request.new(
        method: :get,
        url: "https://access.redhat.com/hydra/rest/cases/#{@solution_number}/attachments",
        user: Rails.application.credentials.rhn[:user],
        password: Rails.application.credentials.rhn[:password],
        headers: {accept: :json, content_type: :json }
      ).execute
    rescue RestClient::ExceptionWithResponse => err
    end
    unless err
       results = JSON.parse(response.to_str)
    else 
      results = {"error": "true"}
    end
  end
end
