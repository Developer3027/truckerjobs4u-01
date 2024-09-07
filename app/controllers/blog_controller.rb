class BlogController < ApplicationController
  def index
    @blog = Blog.order("created_at DESC").first
  end
end
