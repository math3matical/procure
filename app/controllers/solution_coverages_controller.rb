class SolutionCoveragesController < ApplicationController
  def index
    @solution_coverages = SolutionCoverage.all
  end

  def show
    @solution_coverages = SolutionCoverage.find(params[:id])
  end

  def new
    @solution_coverage = SolutionCoverage.new
    @solution = Solution.find(params[:solution_id])
    tagged_engineers = @solution.engineers
    @engineers = Engineer.all - tagged_engineers
  end

  def create
    @solution_coverage = SolutionCoverage.new(solution_coverage_params)
    if @solution_coverage.save
      redirect_to @solution_coverage.solution
    elsif
      render "new", locals: {solution_id: @solution_coverage[:solution_id], solution_coverage: @solution_coverage} , status: :unprocessable_entity
    end
  end


  def destroy 
    @solution_coverage = SolutionCoverage.find(params[:id])
    @solution_coverage.destroy
    redirect_to solution_path(@solution_coverage.solution_id), status: 303
  end

  private
    def solution_coverage_params
      params.require(:solution_coverage).permit(:engineer_id, :solution_id, :status)
    end


end
