class BugCoveragesController < ApplicationController
  def show
    @bug_coverages = BugCoverage.find(params[:id])
  end

  def index
    @bug_coverages = BugCoverage.all
  end
    
  def new
    @bug_coverage = BugCoverage.new
    @bug = Bug.find(params[:bug_id])
    tagged_engineers = @bug.engineers
    @engineers = Engineer.all - tagged_engineers
    
  end

  def create
    @bug_coverage = BugCoverage.new(bug_coverage_params)
    if @bug_coverage.save
      redirect_to @bug_coverage.bug
    elsif
      render "new", locals: {bug_id: @bug_coverage[:bug_id], bug_coverage: @bug_coverage} , status: :unprocessable_entity
    end
  end


  def destroy
    @bug_coverage = BugCoverage.find(params[:id])
    @bug_coverage.destroy
    redirect_to bug_path(@bug_coverage.bug_id), status: 303
  end

  private
    def bug_coverage_params
      params.require(:bug_coverage).permit(:engineer_id, :bug_id, :status)
    end

end
