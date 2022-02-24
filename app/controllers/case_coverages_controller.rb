class CaseCoveragesController < ApplicationController
  def index
    @case_coverages = CaseCoverage.all
  end

  def new
    @case_coverage = CaseCoverage.new
    @case = Case.find(params[:case_id])
    tagged_engineers = @case.engineers 
    @engineers = Engineer.all - tagged_engineers
  end
  
  def create
    @case_coverage = CaseCoverage.new(case_coverage_params)
    if @case_coverage.save
      redirect_to @case_coverage.case
    elsif
      render "new", locals: {case_id: @case_coverage[:case_id], case_coverage: @case_coverage} , status: :unprocessable_entity
    end
  end

  def show
    @case_coverages = CaseCoverage.find(params[:id])
  end

  def destroy
    @case_coverage = CaseCoverage.find(params[:id])
    @case_coverage.destroy
    redirect_to case_path(@case_coverage.case_id), status: 303
  end

  private
    def case_coverage_params
      params.require(:case_coverage).permit(:engineer_id, :case_id, :status)
    end

end
