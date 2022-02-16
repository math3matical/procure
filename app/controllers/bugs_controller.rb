class BugsController < ApplicationController

  def index
    puts "================================================================================================================"
    puts "bugs index"
    puts params
    puts "================================================================================================================"
    if params[:engineer_id]
      @engineer = Engineer.find(params[:engineer_id])
      @bugs = @engineer.bugs
    else
      @bugs = Bug.search(params[:search])
    end
  end

  def show
    @bugs = Bug.find(params[:id])
  end
    
  def new
    @bug = Bug.new
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
      params.require(:bug).permit(:id, :title, :number, :importance, :notes, :created_at, :updated_at, :status, :search)
    end


end
