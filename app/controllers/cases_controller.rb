class CasesController < ApplicationController
  def index
    session[:case_sort] ||= 0
    session[:filter] ||= []
    if params[:engineer_id]
      @engineer = Engineer.find(params[:engineer_id])
      @cases = Case.search2(params[:search], @engineer)
    else
      @cases = Case.search(params[:search])
    end
    if session[:filter].length > 0
      @cases = @cases.joins(:tag_items).where("tag_items.id REGEXP '#{session[:filter].join('|')}'").distinct
    end
    @cases=@cases.order(:number)
    session[:case_sort]+=1 if params[:sort]=="true"
    @cases=@cases.order(:number).reverse unless session[:case_sort]%2==0
  end

  def reverse
    @cases=@cases.reverse_order
    redirect_back(fallback_location: root_path)  
  end

  def show
    @case = Case.find(params[:id])
    @engineers = @case.engineers
    @tag_items = @case.tag_items
    @coverages = {}
  end

  def new
    session[:ticketid] = params[:ticketid]
    @case = Case.new
  end

  def findapi
    session[:ticketid] = params[:ticketid]
  end

  def newapi
    sanitize = params[:case_number].gsub(/[[:space:]]+/, "")
    @things = CaseGrabber.call(sanitize)
    unless @things[:error]
      casse = {}
      list = {sbr: "sbrGroup", product: "product", version: "version", issue: "issue", summary: "summary", number: "caseNumber", bug_number: "bugzillaNumber", bug_summary: "bugzillaSummary", customer_contact: "caseContact", account_number: "accountNumber", fts: "fts", link: "caseLink", description: "description", ownerIRC: "ownerITCNickname", handover: "ftsHandoverReady", closed: "isClosed", escalated: "isEscalated", breaches: "numberOfBreaches", state: "status", strategic: "strategic", case_tag: "tags", region: "caseOwnerSuperRegion"}
      list.each do |key, value|
        casse[key]=@things[value]
      end
      casse[:url]="https://gss--c.visualforce.com/apex/Case_View?id=#{casse[:link].split(' ')[1][7..21]}&sfdc.override=1"
      # Seen cases without an account hash or case_owner hash, e.g. 03147432
      casse[:customer_name] = @things["account"]["name"] if @things["account"] 
      casse[:case_owner] = @things["caseOwner"]["name"] if @things["caseOwner"]
      @case = Case.new(casse)
    else
      render :findapi, status: :unprocessable_entity
    end
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
      params.require(:case).permit(:title, :version, :number, :comments, :importance, :notes, :status, :search, :sbr, :product, :issue, :summary, :bug_number, :bug_summary, :customer_contact, :customer_name, :case_owner, :link, :url, :region, :handover, :closed, :escalated, :breaches, :ownerIRC, :state, :strategic, :case_tag, :description)
    end
end
