class NetworkTagsController < ApplicationController
  def show
    @network_tags = NetworkTag.find(params[:id])
  end

  def new
    @network_tag = NetworkTag.new
  end

  def create
    @network_tag = NetworkTag.new(network_tag_params)
    if @network_tag.save
      case @network_tag.network_taggable_type
      when "Solution"
        @solution = Solution.find(@network_tag.network_taggable_id)
        redirect_to @solution
      when "Case"
        @case = Case.find(@network_tag.network_taggable_id)
        redirect_to @case
      when "Bug"
        @bug = Bug.find(@network_tag.network_taggable_id)
        redirect_to @bug
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @network_tag = NetworkTag.find(params[:id])
    if @network_tag.update(network_tag_params)
      case @network_tag.network_taggable_type
      when "Solution"
        @solution = Solution.find(@network_tag.network_taggable_id)
        redirect_to @solution
      when "Case"
        @case = Case.find(@network_tag.network_taggable_id)
        redirect_to @case
      when "Bug"
        @bug = Bug.find(@network_tag.network_taggable_id)
        redirect_to @bug
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @network_tag = NetworkTag.find(params[:network_tag])
  end

  def destroy
    @network_tag = NetworkTag.find(params[:id])
    @network_tag.destroy
    redirect_to case_path(@network_tag.network_taggable_id), status: 303
  end

  private
    def network_tag_params
      params.require(:network_tag).permit(:ipv4, :ipv6, :bond, :vlan, :bridge, :proxy, :firewall, :network_taggable_type, :network_taggable_id)
    end
end
