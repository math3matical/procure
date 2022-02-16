class ProvisionTagsController < ApplicationController
  def new
    @provision_tag = ProvisionTag.new
  end

  def create
    @provision_tag = ProvisionTag.new(provision_tag_params)
    if @provision_tag.save
      case @provision_tag.provision_taggable_type
      when "Case"
        @case = Case.find(@provision_tag.provision_taggable_id)
        redirect_to @case
      when "Solution"
        @solution = Solution.find(@provision_tag.provision_taggable_id)
        redirect_to @solution
      when "Bug"
        @bug = Bug.find(@provision_tag.provision_taggable_id)
        redirect_to @bug
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @provision_tags = ProvisionTag.find(params[:id])
  end

  def edit
    @provision_tag = ProvisionTag.find(params[:provision_tag])
  end

  def update
    @provision_tag = ProvisionTag.find(params[:id])

    if @provision_tag.update(provision_tag_params)
      case @provision_tag.provision_taggable_type
      when "Case"
        @case = Case.find(@provision_tag.provision_taggable_id)
        redirect_to @case
      when "Solution"
        @solution = Solution.find(@provision_tag.provision_taggable_id)
        redirect_to @solution
      when "Bug"
        @bug = Bug.find(@provision_tag.provision_taggable_id)
        redirect_to @bug
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @provision_tag = ProvisionTag.find(params[:id])
    @provision_tag.destroy
    redirect_to case_path(@provision_tag.provision_taggable_id), status: 303
  end

  private
    def provision_tag_params
      params.require(:provision_tag).permit(:version, :contentview, :capsule, :http, :ui, :pxe, :bootstrap, :kickstart, :discover, :image, :compute, :notes, :bootdisk, :ipxe, :provision_taggable_id, :provision_taggable_type)
    end

end
