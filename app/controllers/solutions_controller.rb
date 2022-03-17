class SolutionsController < ApplicationController
  def index
    session[:solution_sort] ||= 0
    session[:filter] ||= []
    if params[:engineer_id]
      @engineer = Engineer.find(params[:engineer_id])
      @solutions = Solution.search2(params[:search], @engineer)
    else
      @solutions = Solution.search(params[:search])
    end
    if session[:filter].length > 0
      @solutions = @solutions.joins(:tag_items).where("tag_items.id REGEXP '#{session[:filter].join('|')}'")
    end
    @solutions=@solutions.order(:number)
    session[:solution_sort]+=1 if params[:sort]=="true"
    @solutions=@solutions.reverse unless session[:solution_sort]%2==0
  end
  
  def new_comment
    @solution = Solution.find(params[:id])
  end

  def new
    @solution = Solution.new
  end

  def create
    @solution = Solution.new(solution_params)
    if @solution.save
      redirect_to @solution
    else
      render :new, status: :unprocessable_entity
    end
  end

  def solutionuser
    sanitize = params[:solution_user].gsub(/[[:space:]]+/, "")
    @things = SolutionUser.call(sanitize)
  end


  def findapi
    session[:ticketid] = params[:ticketid]
  end

  def newapi
    sanitize = params[:solution_number].gsub(/[[:space:]]+/, "")
    @things = SolutionGrabber.call(sanitize)
    unless @things[:error]
      solution = {}
      list = {title: "allTitle", number: "solution.id", abstract: "abstract", notes: "body", author: "authorSSOName", boostProduct: "boostProduct", created: "createdDate", inferred_tag: "inferred_tag", state: "kcsState", url: "view_uri", product: "product", solution_tag: "tag" }
      list.each do |key, value|
        solution[key]=@things["response"]["docs"].first[value]
      end
      
      # Seen cases without an account hash or case_owner hash, e.g. 03147432
      # probably doesn't apply to solutions, but just in case
      solution[:customer_name] = @things["account"]["name"] if @things["account"] 
      solution[:case_owner] = @things["caseOwner"]["name"] if @things["caseOwner"]
      @solution = Solution.new(solution)
    else
      render :findapi, status: :unprocessable_entity
    end
  end

  def update
    @solution = Solution.find(params[:id])
    if @solution.update(solution_params)
      redirect_to @solution
    else
      render :edit, status: :unprocessable_entity
    end
  end
 
  def show
    @solution = Solution.find(params[:id])
    @coverages = {}
  end
  
  def destroy
    @solution = Solution.find(params[:id])
    @solution.destroy
    redirect_to solutions_path, status: 303
  end

  private
    def solution_params
      params.require(:solution).permit(:title, :number, :importance, :notes, :status, :search, :abstract, :author, :boostProduct, :created, :inferred_tag, :state, :url, :solution_tag)
    end
end
