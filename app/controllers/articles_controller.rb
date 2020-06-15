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

  def create
    @article = Article.new(params.require(:article).
      permit(:title, :description))
    #render plain: @article.inspect
    if @article.save
      flash[:notice] = "Article was created successfully"
      redirect_to article_path(@article)
    # redirect_to @article --> tiene el mismo efecto
    # que linea de arriba
    else
      render 'new'
    end
  end
end
