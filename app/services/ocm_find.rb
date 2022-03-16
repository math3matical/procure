require 'rest-client'
include RestClient
class OcmFind < ApplicationService
  attr_reader :message
  
  def initialize(account_number)
    @account_number = account_number
    @token = `/root/bin/ocm-token.sh`
  end

  def api(url)
    response = RestClient::Request.new(
      method: :get,
      url: "#{url}",
      headers: {accept: :json, content_type: :json, Authorization: "Bearer #{@token}"},
      verify_ssl: false
    ).execute
  end

  def call
    results = []
#    render '/test/findapi', status: :unprocessable_entity if @account_number == ""
    if @account_number.length == 32 || @account_number.length == 36
      response = `/root/id_it.sh #{@account_number}`
      puts response
      puts "========================="
  #    response = api("https://api.openshift.com/api/clusters_mgmt/v1/clusters/#{@account_number}")
      test = JSON.parse(response.to_str)
      if test["size"] == 0
#      response = api("https://api.openshift.com/api/clusters_mgmt/v1/clusters/?name=#{@account_number}")
        response = `/root/name_it.sh #{@account_number}`
        results << JSON.parse(response.to_str)
#      response = api("https://api.openshift.com/api/accounts_mgmt/v1/subscriptions/?display_name=#{@account_number}")
        response = `/root/subname_it.sh #{@account_number}`
        results << JSON.parse(response.to_str)
      else
        results << JSON.parse(response.to_str)
        response =  `/root/sub_it.sh #{@account_number}`
  #     esponse = api("https://api.openshift.com/api/accounts_mgmt/v1/subscriptions/?cluster_id=#{@account_number}")
      end  
      test = JSON.parse(response.to_str)
      if test["size"] == 0
        results << "No subscriptions"
      else
        results << JSON.parse(response.to_str)
      end
      unless results.second["size"] == 0
   #    response = api("https://api.openshift.com#{results.second["items"].first["creator"]["href"]}")
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
