class EngineersController < ApplicationController
  def index
    session[:engineer_sort] ||= 0
    session[:filter] ||= []
    @engineers = Engineer.search(params[:search]).order(:last_name)
    session[:engineer_sort]+=1 if params[:sort]
    @engineers=@engineers.reverse unless session[:engineer_sort]%2==0
  end

  def show
    @engineer = Engineer.find(params[:id])
  end

  def edit
    @engineer = Engineer.find(params[:id])
  end

  def create
    @engineer = Engineer.new(engineer_params)
    if @engineer.save
      redirect_to @engineer
    else
      render :new, status: :unprocessable_entity
    end
  end


  def update
    @engineer = Engineer.find(params[:id])
    if @engineer.update(engineer_params)
      redirect_to @engineer
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def new
    session[:engineer_id] = params[:id]
    @engineer = Engineer.new
  end

  def newapi
    first = params[:engineer_first].gsub(/[[:space:]]+/, "")
    last = params[:engineer_last].gsub(/[[:space:]]+/, "")
    @things = EngineerGrabber.call(first, last)
    unless @things[:error] 
      engineer = {}
      engineer[:first_name] = @things["items"].first["firstName"]
      engineer[:last_name] = @things["items"].first["lastName"]
      engineer[:irc] = @things["items"].first["ircNick"]
      engineer[:position] = @things["items"].first["title"]
      params2 = {}
      params2[:engineer] = engineer
      @engineer = Engineer.new(engineer)
    else
      render :findapi, status: :unprocessable_entity
    end
  end

  def findapi   
    session[:engineer_id] = params[:id]
  end

  def bugs
    @engineer = Engineer.find(params[:id])
    @engineer.bugs
  end

  def destroy
    @engineer = Engineer.find(params[:id])
    @engineer.destroy
    redirect_to engineers_path, status: :see_other
  end

  private
    def engineer_params
      params.require(:engineer).permit(:first_name, :last_name, :irc, :position, :status, :search)
    end
end
