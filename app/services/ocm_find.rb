require 'rest-client'
include RestClient
class OcmFind < ApplicationService
  attr_reader :message
  
  def initialize(account_number)
    @account_number = account_number
    @token = `/root/bin/ocm-token.sh`
  end

  def call
    results = []
    if @account_number.length == 32 || @account_number.length == 36
      response = `/root/id_it.sh #{@account_number}`
      test = JSON.parse(response.to_str)
      if test["size"] == 0
        response = `/root/name_it.sh #{@account_number}`
        results << JSON.parse(response.to_str)
        response = `/root/subname_it.sh #{@account_number}`
        results << JSON.parse(response.to_str)
      else
        results << JSON.parse(response.to_str)
        response =  `/root/sub_it.sh #{@account_number}`
      end  
      test = JSON.parse(response.to_str)
      if test["size"] == 0
        results << "No subscriptions"
      else
        results << JSON.parse(response.to_str)
      end
      unless results.second["size"] == 0
        response = `/root/creator_it.sh #{results.second["items"].first["creator"]["href"]}`
        results << JSON.parse(response.to_str)
      else
        results
      end
    else
      results = [{"size" => 0}]
    end
    results
  end
end
