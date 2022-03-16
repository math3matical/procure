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
    p "----------------"
    p tag_params
    p "----------------"
    p params
    p "----------------"
    p params[:tag_item_id]
    p "----------------"
    p params[:tag_item_id].class
    p "----------------"

#    if params[:tag_item_id].length > 1
#      p params[:tag_item_id]
#      params[:tag_item_id].each do |tag|
#        @tag=Tag.new(tag_taggable_id: params[:tag_taggable_id] , tag_taggable_type: params[:tag_taggable_type], tag_item_id: params[:tag_item_id], tag_group_id: params[:tag_group_id])
#        if @tag.save
#          redirect_to "/#{params[:tag][:tag_taggable_type].downcase}s/#{params[:tag][:tag_taggable_id]}"
#        else
#          render :new, locals: {tag: @tag, tag_taggable_type: params[:tag][:tag_taggable_type], type: params[:tag][:tag_taggable_type]}, status: :unprocessable_entity
#        end
#      end
#    else
      @tag = Tag.new(tag_params)
#    end
    if @tag.save
      redirect_to "/#{params[:tag][:tag_taggable_type].downcase}s/#{params[:tag][:tag_taggable_id]}"
    else
      render :new, locals: {ticketid: params[:ticketid]}, action: {ticketid: params[:ticketid]},  status: :unprocessable_entity
#      @tag_items = []
# Doesn't render like I would hope.  The taggable_type and taggable_id aren't getting sent to the _form as such.
# They may be getting set as regular local variabls and not as part of the params hash.  I may need to set this
# via a session variable.
#      render :new, locals: {tag: @tag, tag_taggable_type: params[:tag][:tag_taggable_type], type: params[:tag][:tag_taggable_type]}, status: :unprocessable_entity
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
