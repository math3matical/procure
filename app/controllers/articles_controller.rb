class ArticlesController < ApplicationController
  def index
    session[:article_sort] ||=0
    @articles = Article.search(params[:search])
    if session[:filter].length > 0
      @articles = @articles.joins(:tag_items).where("tag_items.id REGEXP '#{session[:filter].join('|')}'")
    end
    @articles=@articles.order(:title)
    session[:article_sort]+=1 if params[:sort]
    @articles=@articles.reverse unless session[:article_sort]%2==0
  end

  def show
    @article = Article.find(params[:id])
  end
    
  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to articles_path, status: :see_other
  end

  private
    def article_params
      params.require(:article).permit(:title, :body, :status, :search)
    end
end
