# Admin dashboard
class AdminController < ApplicationController
  # Bringing in Pagy for pagination
  include Pagy::Backend
  # Only allow admins to access the admin dashboard
  before_action :authenticate_admin!

  # GET /admin
  #
  # Shows the admin dashboard, containing all leads and newsletters.
  def admin
    @q = Lead.ransack(params[:q])
    @pagy_leads, @leads = pagy(@q.result(distinct: true), limit: 20, params: { pagy_leads: true })
    @pagy_newsletters, @newsletters = pagy(Newsletter.order(updated_at: :desc), limit: 20, params: { pagy_newsletters: true })
  end

  # POST /admin/update_lead/:id
  #
  # Update note for lead through admin dashboard
  def update_lead
    #! TODO: Write unit test for this action
    @lead = Lead.find(params[:id])
    respond_to do |format|
      if @lead.update(lead_params)
        format.html { redirect_to admin_path, flash: { admin_notice: "Lead was successfully updated." } }
        format.json { render :show, status: :ok, location: @lead }
      else
        format.html { redirect_to admin_path, alert: "Update failed: #{@lead.errors.full_messages.join(', ')}" }
      end
    end
  end

  # DELETE /admin/destroy_lead/:id
  #
  # Delete a lead through the admin dashboard
  def destroy_lead
    #! TODO: Write unit test for this action
    @lead = Lead.find(params[:id])
    @lead.destroy!

    respond_to do |format|
      format.html { redirect_to admin_path, flash: { admin_alert: "Lead was successfully destroyed." } }
      format.json { head :no_content }
    end
  end

  # DELETE /admin/destroy_newsletter/:id
  #
  # Delete a newsletter through the admin dashboard
  def destroy_newsletter
    # TODO: Write unit test for this action
    @newsletter = Newsletter.find(params[:id])
    @newsletter.destroy!

    respond_to do |format|
      format.html { redirect_to admin_path, flash: { admin_alert: "Newsletter was successfully destroyed." } }
      format.json { head :no_content }
    end
  end

  private

  # Before filter to ensure only admins can access the
  # admin dashboard.
  #
  # If the user is not signed in or the user is not an admin, redirect
  # to the root path and alert the user that they are not authorized to access
  # the page.
  def authenticate_admin!
    if !user_signed_in? || !["admin"].include?(current_user.role)
      flash[:alert] = "You are not authorized to access this page."
      redirect_to root_path
    end
  end

  # Strong parameters for lead update action
  #
  # Whitelist the +note+ attribute of the +lead+ model.
  def lead_params
    params.require(:lead).permit(:note)
  end
end
