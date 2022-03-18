require 'rest-client'
include RestClient
class TestController < ApplicationController
  def index
    session[:procure_sort] ||=0
    session[:filter] ||= []
    p session
    @bugs = Bug.search(params[:search])
    @cases = Case.search(params[:search])
    @solutions = Solution.search(params[:search])
    @articles = Article.all
    if session[:filter].length > 0
      @bugs = @bugs.joins(:tag_items).where("tag_items.id REGEXP '#{session[:filter].join('|')}'").distinct
      @cases = @cases.joins(:tag_items).where("tag_items.id REGEXP '#{session[:filter].join('|')}'").distinct
      @solutions = @solutions.joins(:tag_items).where("tag_items.id REGEXP '#{session[:filter].join('|')}'").distinct
      @articles = @articles.joins(:tag_items).where("tag_items.id REGEXP '#{session[:filter].join('|')}'").distinct
    end 
    session[:procure_sort]+=1 if params[:sort]
    unless session[:procure_sort]%2==0
      @bugs=@bugs.reverse 
      @cases=@cases.reverse
      @solutions=@solutions.reverse 
    else
      @bugs=@bugs.order(:number)
      @solutions=@solutions.order(:number)
      @cases=@cases.order(:number)
    end
  end

  def bookcall
    @things = CaseFacts.call(params[:message])
  end

  def addfilter
    if params[:tag_item_id] && params[:tag_group_id]
      unless session[:filter].include?(params[:tag_item_id])
        session[:filter] << params[:tag_item_id] if params[:tag_item_id].length > 0
      end
    end
    redirect_back(fallback_location: root_path)
  end
  
  def removefilter
    session[:filter]=[]
    redirect_back(fallback_location: root_path)
  end

  def color_change
    session[:filter]=[]
    unless params[:color_change] == "nothing"
      @thing = ColorChange.call(params[:color_change])
    end
    redirect_to '/test/colorchange'
  end

  def attachment_download
    sanitize = params[:account_number].gsub(/[[:space:]]+/, "")
    sanitize ||="1"
    @thing = AttachmentDownload.call(sanitize)
    render '/test/attachmentdownload', status: :unprocessable_entity if @thing.class==Hash || @thing.length==0
  end

  def case_comments
    sanitize = params[:account_number].gsub(/[[:space:]]+/, "")
    sanitize ||="1"
    @thing = CaseComments.call(sanitize)
  end

  def solution_user
    sanitize = params[:solution_number].gsub(/[[:space:]]+/, "")
    sanitize ||= "1"
    @thing = SolutionUser.call(sanitize, params[:solution_search])
  end
 
  def ocm_find
    sanitize = params[:account_number].gsub(/[[:space:]]+/, "")
    @thing = OcmFind.call(sanitize)
    render '/test/findapi', status: :unprocessable_entity  if (@thing.first["size"] == 0)
  end

  def bugcall
    @things = BugCaller.call(params[:message])
  end

  def newtag
    @bug = Bug.new
    @tag_groups = []
    @tags = []
  end

  private
    def test_params
      params.require(:test).permit(:search)
    end
end
