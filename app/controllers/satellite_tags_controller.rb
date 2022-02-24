class SatelliteTagsController < ApplicationController
  def index
    @satellite_tags = SatelliteTag.all
  end

  def show
    @satellite_tags = SatelliteTag.find(params[:id])
  end 

  def new
    @satellite_tag = SatelliteTag.new
  end

  def create
    @satellite_tag = SatelliteTag.new(satellite_tag_params)
    if @satellite_tag.save
      case @satellite_tag.satellite_taggable_type
      when "Solution"
        @solution = Solution.find(@satellite_tag.satellite_taggable_id)
        redirect_to @solution
      when "Case"
        @case = Case.find(@satellite_tag.satellite_taggable_id)
        redirect_to @case
      when "Bug"
        @bug = Bug.find(@satellite_tag.satellite_taggable_id)
        redirect_to @bug
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @satellite_tag = SatelliteTag.find(params[:satellite_tag])
  end

  def update
    @satellite_tag = SatelliteTag.find(params[:id])

    if @satellite_tag.update(satellite_tag_params)
      case @satellite_tag.satellite_taggable_type
      when "Solution"
        @solution = Solution.find(@satellite_tag.satellite_taggable_id)
        redirect_to @solution
      when "Case"
        @case = Case.find(@satellite_tag.satellite_taggable_id)
        redirect_to @case
      when "Bug"
        @bug = Bug.find(@satellite_tag.satellite_taggable_id)
        redirect_to @bug
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @satellite_tag = SatelliteTag.find(params[:id])
    @satellite_tag.destroy
    redirect_to case_path(@satellite_tag.satellite_taggable_id), status: 303
  end

  private
    def satellite_tag_params
      params.require(:satellite_tag).permit(:version, :pulp, :postgres, :foreman_proxy, :installer, :publish, :promote, :contentview, :capsule, :sync, :repository, :metadata, :mongo, :redis, :puma, :http, :reports, :ui, :satellite_taggable_id, :satellite_taggable_type)
    end


end
