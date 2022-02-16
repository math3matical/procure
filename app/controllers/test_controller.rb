class TestController < ApplicationController
  def index
    @bugs = Bug.search(params[:search])
    @cases = Case.search(params[:search])
    @solutions = Solution.search(params[:search])
#    @articles = Article.search(params[:search])
    @articles = Article.all
  end

  def show
  
  end

  private
    def test_params
      params.require(:test).permit(:search)
    end
end
