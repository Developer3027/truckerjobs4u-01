class BlogController < ApplicationController
  # GET /blog
  #
  # Shows all blogs if user is an admin or advisor, otherwise only published blogs.
  def index
    if current_user&.role&.in?(["admin", "advisor"])
      @blog = Blog.sorted
    else
      @blog = Blog.published.sorted
    end
  end
end
