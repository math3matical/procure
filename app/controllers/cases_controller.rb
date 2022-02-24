class CasesController < ApplicationController
  def index
    if params[:engineer_id]
      @engineer = Engineer.find(params[:engineer_id])
      @cases = Case.search2(params[:search], @engineer)
#      @cases = @engineer.cases
#      @cases2 = Case.search(params[:search])
#      @name = @engineer.first_name
    else
      @cases = Case.search(params[:search])
    end
  end

  def show
    @case = Case.find(params[:id])
    @coverages = {}
  end

  def new
    @case = Case.new
  end

  def newapi
    @things = CaseGrabber.call(params[:case_number])
    casse = {}
    casse[:sbr] = @things["sbrGroup"]
    casse[:product] = @things["product"]
    casse[:version] = @things["version"]
    casse[:issue] = @things["issue"]
    casse[:summary] = @things["summary"]
    casse[:number] = @things["caseNumber"]
    casse[:bug_number] = @things["bugzillaNumber"]
    casse[:bug_summary] = @things["bugzillaSummary"]
    casse[:customer_contact] = @things["caseContact"]
    casse[:customer_name] = @things["account"]["name"]
    @case = Case.new(casse)
  end

  def create
    @case = Case.new(case_params)
    if @case.save
      redirect_to @case
    else
      render :new, locals: {ticketid: params[:ticketid]}, action: {ticketid: params[:ticketid]},  status: :unprocessable_entity
    end
  end

  def edit
    @case = Case.find(params[:id])
  end

  def update
    @case = Case.find(params[:id])
    if @case.update(case_params)
      redirect_to @case
    else
      render :edit, status: :unprocessable_entity
    end
  end
  
  def destroy
    @case = Case.find(params[:id])
    @case.destroy
    redirect_to cases_path, status: 303
  end

  private
    def case_params
      params.require(:case).permit(:title, :version, :number, :comments, :importance, :notes, :status, :search, :sbr, :product, :issue, :summary, :bug_number, :bug_summary, :customer_contact, :customer_name)
    end
end
