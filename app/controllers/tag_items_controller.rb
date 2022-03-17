class TagItemsController < ApplicationController
  before_action :get_tag_group
  before_action :set_tag_item, only: [:show, :edit, :update, :destroy]

  def index
    @tag_items = @tag_group.tag_items
    render json: @tag_items
  end

  def show
  end

  def maketags
    @tag_items = TagItem.all
  end

  def new
    session[:ticketid] = params[:ticketid]
    @tag_item = @tag_group.tag_items.build
  end

  def create
    @tag_item = @tag_group.tag_item.build(comment_params)

    respond_to do |format|
      if @tag_Item.save
        format.html { redirect_to tag_group_tag_items_path(@tag_group), notice: 'Tag Item was created successfully.'}
        format.json { render :show, status: :created, location: @tag_item }
      else
        format.html { render :new }
        format.json { render json: @tag_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def former
    @tag_items = TagItem.all
  end

  def edit
    @tag_item = TagItem.find(params[:id])
  end

  def update
    @tag_item = TagItem.find(params[:id])
    if @tag_item.update(case_params)
      redirect_to @tag_item
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @tag_item.destroy
    redirect_to cases_path, status: 303
  end

  private
    def get_tag_group
      @tag_group = TagGroup.find(params[:tag_group_id])
    end

    def set_tag_item
      @tag_item = @tag_group.tag_items.find(params[:id])
    end
end
