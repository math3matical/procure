class CaseCoveragesController < ApplicationController
  def index
    @case_coverages = CaseCoverage.all
  end

  def new
    puts"================================================================================================================"
    puts "new case_coverage"
    puts params
    puts"================================================================================================================"
    @case_coverage = CaseCoverage.new
    @case = Case.find(params[:case_id])
    @engineers = Engineer.all
  end
  
  def create
    puts"================================================================================================================"
    puts "create case_coverage"
    puts params
#    puts "did I get it: #{casse}"
    puts "did I get it: #{@case}"
    puts"================================================================================================================"
#i    @case = Case.find(casse.id)
# case_coverage_params[:case_id]=params[:case_id]
    
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
    puts"================================================================================================================"
    puts "destory case_coverage"
    puts params
    puts"================================================================================================================"

    #@case = Case.find(params[:id])
    @case_coverage = CaseCoverage.find(params[:id])
    @case_coverage.destroy
    redirect_to case_path(@case_coverage.case_id), status: 303
  end

  private
    def case_coverage_params
      params.require(:case_coverage).permit(:engineer_id, :case_id, :status)
    end

end
