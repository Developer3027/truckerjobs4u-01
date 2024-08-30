class LandingController < ApplicationController
  def index
  end

  # POST /landing/lead
  # Create a lead from the landing page
  def create_lead
    @lead = Lead.new(lead_params)

    if lead_params[:pp_check] == "0" || lead_params[:pp_check] == false
      redirect_to root_path, alert: "Please check the privacy policy"
    else
      respond_to do |format|
        if @lead.save
          format.html { redirect_to root_path, notice: "Thank you! We will be in touch soon!" }
        else
          format.html { render :new, status: :unprocessable_entity }
        end
      end
    end
  end

  # POST /landing/newsletter
  # Create a newsletter from the landing page
  def create_newsletter
    @newsletter = Newsletter.new(newsletter_params)

    if newsletter_params[:pp_check] == "0" || newsletter_params[:pp_check] == false
      redirect_to root_path, alert: "Please check the privacy policy"
    else
      respond_to do |format|
        if @newsletter.save
          format.html { redirect_to root_path, notice: "Thank you! We will be in touch soon!" }
        else
          format.html { render :new, status: :unprocessable_entity }
        end
      end
    end
  end

  private

  def lead_params
    params.require(:lead).permit(:first_name, :last_name, :email, :phone, :location, :note, :pp_check, :commit)
  end

  def newsletter_params
    params.require(:newsletter).permit( :email, :pp_check, :commit)
  end
end
