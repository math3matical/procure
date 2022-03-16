require 'rest-client'
include RestClient
class TestController < ApplicationController
  def index
    session[:procure_sort] ||=0
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
    unless session[:filter].include?(params[:tag_item_id])
      session[:filter] << params[:tag_item_id] if params[:tag_item_id]
    end
    p session[:filter]
    redirect_back(fallback_location: root_path)
  end
  
  def removefilter
    session[:filter]=[]
#    session[:case_sort]=0
#    session[:solution_sort]=0
#    session[:bug_sort]=0
#    session[:engineer_sort]=0
#    session[:article_sort]=0
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
#    response = JSON.parse(@thing.to_str)
#    @thing = response
    puts "=========="
    p "whats that thing?"
    puts @thing
    p "whats that class?"
    puts @thing.class
    puts "=========="
    puts "=========="
    @thing
    render '/test/attachmentdownload', status: :unprocessable_entity if @thing.class==Hash || @thing.length==0
  end

  def case_comments
    sanitize = params[:account_number].gsub(/[[:space:]]+/, "")
    sanitize ||="1"
    @thing = CaseComments.call(sanitize)
    response = JSON.parse(@thing.to_str)
    @thing = response
    puts "=========="
    puts @thing
    puts @thing.class
    puts @thing.first["commentBody"]
    puts "=========="
    @thing
  end

  def solution_user
    sanitize = params[:solution_number].gsub(/[[:space:]]+/, "")
    sanitize ||= "1"
  #  sanitize2 = params[:solution_search].gsub(/[[:space:]]+/, "")
    @thing = SolutionUser.call(sanitize, params[:solution_search])
  #  response = JSON.parse(@thing.to_str)
  #  @thing = response
  #  sanitize=@thing["response"]["numFound"]
  #  @thing = SolutionUser.call(sanitize)
    
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
