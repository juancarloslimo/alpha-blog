class ArticlesController < ApplicationController
  
  def index
    @articles = Article.all
  end
  
  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def edit
    @article = Article.find(params[:id])
  end

  def create
    @article = Article.new(params.require(:article).permit(:title, :description))
    #render plain: @article.inspect
    if @article.save
      flash[:notice] = "Article was created successfully"
      redirect_to article_path(@article)
    # redirect_to @article --> tiene el mismo efecto que linea de arriba
    else
      render 'new'
    end
  end

  def update
    @article = Article.find(params[:id])
    if @article = Article.update(params.require(:article).permit(:title, :description))
      flash[:notice] = "Article was updated successfully"
      redirect_to article_path(@article)
    else
      render 'edit'
    end
  end

end
