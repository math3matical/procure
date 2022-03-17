require 'rest-client'
include RestClient
class SolutionUser < ApplicationService
  attr_reader :message
  
  def initialize(cnum, search)
    @solution_number = cnum
    @solution_search = search.split(" ")
    @search=""
    @solution_search.each do |search|
      @search+="+#{search}"
    end
  end

  def call()
    begin
      response = RestClient::Request.new(
        method: :get,
        url: "https://access.redhat.com/hydra/rest/search/kcs/?q=authorSSOName:#{@solution_number}#{@search}&fq=documentKind:Solution&rows=1&sort=score+desc,id+desc&f1=id+name",
        user: Rails.application.credentials.rhn[:user],
        password: Rails.application.credentials.rhn[:password],
        headers: {accept: :json, content_type: :json }
      ).execute
    rescue RestClient::ExceptionWithResponse => err
    else
      results = JSON.parse(response.to_str)
      @num = results["response"]["numFound"]
    end
    begin
      response = RestClient::Request.new(
        method: :get,
        url: "https://access.redhat.com/hydra/rest/search/kcs/?q=authorSSOName:#{@solution_number}#{@search}&fq=documentKind:Solution&rows=#{@num}&sort=score+desc,id+desc&f1=id+name",
        user: Rails.application.credentials.rhn[:user],
        password: Rails.application.credentials.rhn[:password],
        headers: {accept: :json, content_type: :json }
      ).execute
    rescue RestClient::ExceptionWithResponse => err
    else
      results = JSON.parse(response.to_str)
    end
  end
end
