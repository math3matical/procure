class TagsController < ApplicationController
  def show
    @tag = Tag.find(params[:id]).order(:tag_group_id)
    @coverages = {}
  end

  def maketags
    @tags = Tag.all.order(:tag_group_id)
  end

  def new
    session[:ticketid] = params[:ticketid]
    @tag = Tag.new
    @tag_groups = TagGroup.all
    @tag_items = []
  end

  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      redirect_to "/#{params[:tag][:tag_taggable_type].downcase}s/#{params[:tag][:tag_taggable_id]}"
    else
      render :new, locals: {ticketid: params[:ticketid]}, action: {ticketid: params[:ticketid]},  status: :unprocessable_entity
    end
  end

  def former
    @tags = Tag.all.order(:tag_group_id)
  end

  def edit
    @tag = Tag.find(params[:id])
  end

  def update
    @tag = Tag.find(params[:id])
    if @tag.update(case_params)
      redirect_to @tag
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @tag = Tag.find(params[:id])
    @tag.destroy
    redirect_to cases_path, status: 303
  end

  private
    def tag_params
      params.require(:tag).permit(:name, :tag_taggable_id, :tag_taggable_type, :tag_item_id, :tag_group_id)
    end
end
