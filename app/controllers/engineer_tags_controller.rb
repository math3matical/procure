class EngineerTagsController < ApplicationController
  def index
    @engineer_tags = EngineerTag.all
  end

  def show
    @engineer_tags = EngineerTag.find(params[:id])
  end

  def new
    @engineer_tag = EngineerTag.new
    case params[:engineer_taggable_type]
    when 'Solution'
      @solution = Solution.find(params[:engineer_taggable_id])
      tagged_engineers = @solution.engineers
    when 'Bug'
      @bug = Bug.find(params[:engineer_taggable_id])
      tagged_engineers = @bug.engineers
    when 'Case'
      @case = Case.find(params[:engineer_taggable_id])
      tagged_engineers = @case.engineers
    end
    @engineers = Engineer.all - tagged_engineers
  end

  def create
    @engineer_tag = EngineerTag.new(engineer_tag_params)
    if @engineer_tag.save
      case @engineer_tag.engineer_taggable_type
      when 'Solution'
        redirect_to "/solutions/#{@engineer_tag.engineer_taggable_id}"
      when 'Bug'
        redirect_to "/bugs/#{@engineer_tag.engineer_taggable_id}"
      when 'Case'
        redirect_to "/cases/#{@engineer_tag.engineer_taggable_id}"
      end
    elsif
    #  redirect_to "/engineer_tags/new?#{@engineer_tag.engineer_taggable_type.downcase}_id=#{@engineer_tag.engineer_taggable_id}&engineer_taggable_type=#{@engineer_tag.engineer_taggable_type}&engineer_taggable_id=#{@engineer_tag.engineer_taggable_id}" 

  render  "new", locals: {engineer_taggable_id: @engineer_tag.engineer_taggable_id, engineer_tag: @engineer_tag, engineer_taggable_type: @engineer_tag.engineer_taggable_type} , action: {engineer_taggable_type: @engineer_tag.engineer_taggable_type, engineer_taggable_id: 8} , status: :unprocessable_entity
    end
  end


  def destroy 
    @engineer_tag = EngineerTag.find(params[:id])
    @engineer_tag.destroy
    redirect_to "/#{@engineer_tag.engineer_taggable_type.downcase}s/#{@engineer_tag.engineer_taggable_id}", status: 303
  end

  private
    def engineer_tag_params
      params.require(:engineer_tag).permit(:engineer_id, :engineer_taggable_type, :engineer_taggable_id, :status)
    end


end
