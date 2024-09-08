class AdvisorController < ApplicationController
  # Only allow admins to access the admin dashboard
  before_action :authenticate_staff!

  def index
    @blog = Blog.new
    @blogs = Blog.order(created_at: :desc)
  end

  def new_blog
    @blog = Blog.new
    render turbo_stream: turbo_stream.update(:blog_main, template: 'advisor/new_blog', locals: { blog: @blog })
  end

  def list_blogs
    @blogs = Blog.all
  end

  def edit_blog
    @blog = Blog.find(params[:id])
    render turbo_stream: turbo_stream.update(:blog_main, template: 'advisor/new_blog', locals: { blog: @blog })
  end

  def create_blog
    @blog = Blog.new(blog_params)
    @blog.user = current_user
    if @blog.save
      redirect_to advisor_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update_blog
    if @blog.update(blog_params)
      redirect_to advisor_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def blog_params
    params.require(:blog).permit(:cover_image, :title, :content, :published_at, :user_id)
  end

  # Before filter to ensure only staff (admins and advisors) can access the
  # advisor dashboard.
  #
  # If the user is not signed in or the user is not an admin or advisor, redirect
  # to the root path and alert the user that they are not authorized to access
  # the page.
  def authenticate_staff!
    if !user_signed_in? || !["admin", "advisor"].include?(current_user.role)
      flash[:alert] = "You are not authorized to access this page."
      redirect_to root_path
    end
  end
end
