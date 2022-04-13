class PagesController < ApplicationController
  
  def home
    redirect_to articles_page if logged_in?
  end

  def about
  end
  
end
