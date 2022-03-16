class BugsController < ApplicationController

  def index
    session[:bug_sort] ||= 0
    if params[:engineer_id]
      @engineer = Engineer.find(params[:engineer_id])
      @bugs = Bug.search2(params[:search], @engineer)
    else
      @bugs = Bug.search(params[:search])
    end
    if session[:filter].length > 0
      @bugs = @bugs.joins(:tag_items).where("tag_items.id REGEXP '#{session[:filter].join('|')}'")
    end
    @bugs=@bugs.order(:number)
    session[:bug_sort]+=1 if params[:sort]
    @bugs=@bugs.reverse unless session[:bug_sort]%2==0
  end

  def show
    @bug = Bug.find(params[:id])
    @coverages = {}
  end
    
  def new
    session[:ticketid] = params[:ticketid]
    @bug = Bug.new
  end

  def findapi
    session[:ticketid] = params[:ticketid]
  end

  def newapi
    sanitize = params[:bug_number].gsub(/[[:space:]]+/, "")
    @things = BugCaller.call(sanitize)
    unless @things["error"]
      bug = {}
      list = {summary: "summary", number: "id", product: "product", version: "version", assigned_to: "assigned_to", qa_contact: "qa_contact", whiteboard: "whiteboard", target_release: "target_release", creator: "creator", severity: "severity", fixed_in: "cf_fixed_in", release_notes: "cf_release_notes", component: "component", keywords: "keywords", target_milestone: "target_milestone", last_change: "last_change", cc: "cc", cc_detail: "cc_detail"}
      list.each do |key, value|
        bug[key]=@things["bugs"].first[value]
      end
      bug[:url]="https://bugzilla.redhat.com/#{bug[:number]}"
      @bug = Bug.new(bug)
    else
      render :findapi, status: :unprocessable_entity
    end

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
      params.require(:bug).permit(:id, :title, :number, :importance, :notes, :created_at, :updated_at, :status, :search, :product, :summary, :assigned_to, :creator, :severity, :qa_contact, :version, :whiteboard, :taget_releae, :fixed_in, :release_notes, :component, :keywords, :target_milestone, :last_change, :cc, :cc_detaili, :url)
    end
end
