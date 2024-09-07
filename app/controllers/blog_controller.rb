class BlogController < ApplicationController
  def index
    if user_signed_in? && (current_user.role == "admin" || current_user.role == "advisor")
      @blog = Blog.sorted
    else
      @blog = Blog.published.sorted
    end
  end
end
