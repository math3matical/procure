require 'rest-client'
include RestClient
class TestController < ApplicationController
  def index
    @bugs = Bug.search(params[:search])
    @cases = Case.search(params[:search])
    @solutions = Solution.search(params[:search])
    @articles = Article.all
  end

  def bookcall
    @things = TweetCreator.call(params[:message])
  end

  def bugcall
    @things = BugCaller.call(params[:message])
  end

  def engineerapi
    params[:lastName]='Yoder'
    @things = EngineerGrabber.call('Yoder')
  end

  private
    def test_params
      params.require(:test).permit(:search)
    end
end
