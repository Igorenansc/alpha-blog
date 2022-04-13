# frozen_string_literal: true

# Controller for root routes
class PagesController < ApplicationController
  def home
    redirect_to articles_path if logged_in?
  end

  def about; end
end
