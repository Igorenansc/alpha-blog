class ArticlesController < ApplicationController
  
  # GET method for individual article, passing id as paramether. /artiles/:id
  def show
    @article = Article.find(params[:id])
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
    @article = Article.find(params[:id])
  end

  # POST method for the articles. | /articles
  def create
    # As we receive the data from the user, we need to whitelist it and the require and permit do that.
    @article = Article.new(params.require(:article).permit(:title, :description))
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
    @article = Article.find(params[:id])
    # Updating using the update method whitelisting the params given by the user.
    if @article.update(params.require(:article).permit(:title, :description))
      flash[:notice] = "Article was updated successfully!"
      redirect_to @article
    else
      render 'edit'
    end
  end

end