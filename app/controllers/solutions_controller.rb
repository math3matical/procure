class SolutionsController < ApplicationController
  def index
    if params[:engineer_id]
      @engineer = Engineer.find(params[:engineer_id])
      @solutions = @engineer.solutions
    else
      @solutions = Solution.search(params[:search])
    end
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


  def edit
    @solution = Solution.find(params[:id])
  end
 
  def create
    @solution = Solution.new(solution_params)
    if @solution.save
      redirect_to @solution
    else
      render :new, status: :unprocessable_entity
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
    @solutions = Solution.find(params[:id])
  end
  
  def destroy
    @solution = Solution.find(params[:id])
    @solution.destroy
    redirect_to solutions_path, status: 303
  end

  private
    def solution_params
      params.require(:solution).permit(:title, :number, :importance, :notes, :status, :search)
    end
end
