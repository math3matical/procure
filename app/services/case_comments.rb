require 'rest-client'
include RestClient
class CaseComments < ApplicationService
  attr_reader :message
  
  def initialize(cnum)
    @solution_number = cnum
  end

  def call()
    response = RestClient::Request.new(
      :method => :get,
      url: "https://access.redhat.com/hydra/rest/v1/cases/#{@solution_number}/comments",
#      :url => "https://access.redhat.com/hydra/rest/search/kcs/?q=id:#{@solution_number}",
      user: Rails.application.credentials.rhn[:user],
      password: Rails.application.credentials.rhn[:password],
      headers: {accept: :json, content_type: :json }
    ).execute
    rescue RestClient::ExceptionWithResponse => err
     unless err
       results = JSON.parse(response.to_str)
     else results = {"error": "true"}
     end
     results = JSON.parse(results)
  end
end
