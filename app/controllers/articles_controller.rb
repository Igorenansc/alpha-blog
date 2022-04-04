class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  
  # GET method for individual article, passing id as paramether. /artiles/:id
  def show
  end

  # GET method for the articles index. | /articles
  def index
    @articles = Article.all
  end

  # GET method for the creation of articles. | /articles/new
  def new
    # That instance is necessary since the view utilizes it to find possible errors.
    @article = Article.new
  end

  # GET method for editing articles. | /articles/:id/edit
  def edit
  end

  # POST method for the articles. | /articles
  def create
    # As we receive the data from the user, we need to whitelist it and the require and permit do that.
    @article = Article.new(article_params)
    if @article.save
      # Send a flash message for the component in the main application.
      flash[:notice] = "Article was created successfully!"
      redirect_to @article
    else
      # In case of error the page is reloaded and the variable keeps the error message, displaying in the view.
      render 'new'
    end
  end

  # PATCH/PUT method for the article edit. | /articles/:id
  def update
    # Updating using the update method whitelisting the params given by the user.
    if @article.update(article_params)
      flash[:notice] = "The article was updated successfully!"
      redirect_to @article
    else
      render 'edit'
    end
  end

  # DELETE method | /articles/:id
  def destroy
    @article.destroy
    flash[:notice] = "The article was destroyed!"
    redirect_to articles_path, status: :see_other
  end

  # Everything bellow it is exclusive to this controller and cannot be used outside of it.
  private
  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :description)
  end

end