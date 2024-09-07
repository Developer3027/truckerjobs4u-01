class AdvisorController < ApplicationController
  # Only allow admins to access the admin dashboard
  before_action :authenticate_staff!

  def index
  end

  private

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
