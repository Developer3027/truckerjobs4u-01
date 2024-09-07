class BlogController < ApplicationController
  def index
    if current_user&.role&.in?(["admin", "advisor"])
      @blog = Blog.sorted
    else
      @blog = Blog.published.sorted
    end
  end
end
