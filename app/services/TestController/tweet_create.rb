module TestController
  class TweetCreator < ApplicationService
    attr_reader :message
   
    def initialize(message)
      @message = message
    end

    def call
#    client = Twitter::REST::Client.new do |config|
#      config.consumer_key        = ENV['TWITTER_CONSUMER_KEY']
#      config.consumer_secret     = ENV['TWITTER_CONSUMER_SECRET']
#      config.access_token        = ENV['TWITTER_ACCESS_TOKEN']
#      config.access_token_secret = ENV['TWITTER_ACCESS_SECRET']
#    end
#    client.update(@message)
      RestClient.get 'http://example.com/resource'
    end
  end
end
