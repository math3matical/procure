class CommentsController < ApplicationController
  def create
    unless params[:article_id].nil?
      @article = Article.find(params[:article_id])
      @comment = @article.comments.create(comment_params)
      redirect_to article_path(@article)
    end
    unless params[:engineer_id].nil?  
      @engineer = Engineer.find(params[:engineer_id])
      @comment = @engineer.comments.create(comment_params)
      redirect_to engineer_path(@engineer)
    end
    unless params[:solution_id].nil?  
      @solution = Solution.find(params[:solution_id])
      @comment = @solution.comments.create(comment_params)
      redirect_to solution_path(@solution)
    end
    unless params[:bug_id].nil?  
      @bug = Bug.find(params[:bug_id])
      @comment = @bug.comments.create(comment_params)
      redirect_to bug_path(@bug)
    end
    unless params[:case_id].nil?  
      @case = Case.find(params[:case_id])
      @comment = @case.comments.create(comment_params)
      redirect_to case_path(@case)
    end
  end

  def edit
    unless params[:solution_id].nil?
      @comment = Comment.find(params[:id])
    end 
  end

  def update
    @comment = Comment.find(params[:id])
    case @comment.commentable_type
    when 'Solution'
      @solution = Solution.find_by(id: @comment.commentable_id)
      @generic = @solution
    when 'Case'
      @case = Case.find_by(id: @comment.commentable_id)
      @generic = @case
    when 'Bug'
      @bug = Bug.find_by(id: @comment.commentable_id)
      @generic = @bug 
    when 'Article'
      @article = Article.find_by(id: @comment.commentable_id)
      @generic = @article
    when 'Engineer'
      @engineer = Engineer.find_by(id: @comment.commentable_id)
      @generic = @engineer
    end
    if @comment.update(comment_params)
      redirect_to @generic
    end
  end

  def new
    if params[:solution_id]
      @generic = Solution.find(params[:solution_id])
    elsif params[:bug_id]
     @generic = Bug.find(params[:bug_id])
    elsif params[:case_id]
      @generic = Case.find(params[:case_id])
    elsif params[:engineer_id]
      @generic = Engineer.find(params[:engineer_id])
    elsif params[:article_id]
      @generic = Article.find(params[:article_id])
    end
  end

  def destroy
    unless params[:article_id].nil?
      @article = Article.find(params[:article_id])
      @comment = @article.comments.find(params[:id])
      @comment.destroy
      redirect_to article_path(@article), status: 303
    end
    unless params[:engineer_id].nil? 
      @engineer = Engineer.find(params[:engineer_id])
      @comment = @engineer.comments.find(params[:id])
      @comment.destroy
      redirect_to engineer_path(@engineer), status: 303
    end 
    unless params[:solution_id].nil? 
      @solution = Solution.find(params[:solution_id])
      @comment = @solution.comments.find(params[:id])
      @comment.destroy
      redirect_to solution_path(@solution), status: 303
    end 
    unless params[:bug_id].nil? 
      @bug = Bug.find(params[:bug_id])
      @comment = @bug.comments.find(params[:id])
      @comment.destroy
      redirect_to bug_path(@bug), status: 303
    end 
    unless params[:case_id].nil? 
      @case = Case.find(params[:case_id])
      @comment = @case.comments.find(params[:id])
      @comment.destroy
      redirect_to case_path(@case), status: 303
    end 
  end

  private
    def comment_params
      params.require(:comment).permit(:commenter, :body, :status)
    end
end
