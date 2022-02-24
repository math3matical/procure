class BugsController < ApplicationController

  def index
    if params[:engineer_id]
      @engineer = Engineer.find(params[:engineer_id])
      @bugs = Bug.search2(params[:search], @engineer)
#      @bugs = @engineer.bugs
    else
      @bugs = Bug.search(params[:search])
    end
  end

  def show
    @bug = Bug.find(params[:id])
    @coverages = {}
  end
    
  def new
    @bug = Bug.new
  end

  def newapi
    @things = BugCaller.call(params[:bug_number])
    bug = {}
    bug[:summary] = @things["bugs"].first["summary"]
    bug[:number] = @things["bugs"].first["id"]
    bug[:product] = @things["bugs"].first["product"]
    bug[:version] = @things["bugs"].first["version"]
    bug[:assigned_to] = @things["bugs"].first["assigned_to"]
    bug[:qa_contact] = @things["bugs"].first["qa_contact"]
    bug[:whiteboard] = @things["bugs"].first["whiteboard"]
    bug[:target_release] = @things["bugs"].first["target_release"]
    bug[:creator] = @things["bugs"].first["creator"]
    bug[:severity] = @things["bugs"].first["severity"]
    @bug = Bug.new(bug)

  end

  def create
    @bug = Bug.new(bug_params)
    if @bug.save
      redirect_to @bug
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @bug = Bug.find(params[:id])
  end
  
  def update
    @bug = Bug.find(params[:id])
    if @bug.update(bug_params)
      redirect_to @bug
    else
      render :edit, status: :unprocessable_entity
    end
  end
  
  def destroy
    @bug = Bug.find(params[:id])
    @bug.destroy
    redirect_to bugs_path, status: 303
  end

  private
    def bug_params
      params.require(:bug).permit(:id, :title, :number, :importance, :notes, :created_at, :updated_at, :status, :search, :product, :summary, :assigned_to, :creator, :severity, :qa_contact, :version, :whiteboard, :taget_releae)
    end
end
