class TagGroupsController < ApplicationController

  def index
    @tag_groups = TagGroup.all
  end

  def show
    @tag_group = TagGroup.find(params[:id])
    @coverages = {}
  end

  def former
    @tag_group = TagGroup.all
    @tag = []
    
  end

  def new
    session[:ticketid] = params[:ticketid]
    tag_group = TagGroup.new
    @tag_group = TagGroup.all
    @tag = []
  end

  def create
    @tag_group = TagGroup.new(case_params)
    if @tag_group.save
      redirect_to @tag_group
    else
      render :new, locals: {ticketid: params[:ticketid]}, action: {ticketid: params[:ticketid]},  status: :unprocessable_entity
    end
  end



  def edit
    @tag_group = TagGroup.find(params[:id])
  end

  def update
    @tag_group = TagGroup.find(params[:id])
    if @tag_group.update(case_params)
      redirect_to @tag_group
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @tag_group = TagGroup.find(params[:id])
    @tag_group.destroy
    redirect_to cases_path, status: 303
  end

  private
    def tag_group_params
      params.require(:tag_group).permit(:name)
    end
end
