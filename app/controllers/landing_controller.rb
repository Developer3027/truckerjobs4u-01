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
          if lead_params[:create_acct] == "1" || lead_params[:create_acct] == true
            # Create a new user using the email field from the contact form
            User.create(email: params[:lead][:lead_email],
                        password: params[:lead][:last_name],
                        first_name: params[:lead][:first_name],
                        last_name: params[:lead][:last_name],
                        phone: params[:lead][:phone])
          end
          LeadMailer.new_lead_email(@lead).deliver_now
          # Send email to driver
          DriverMailer.new_driver_email(@lead).deliver_now
          format.html { redirect_to root_path, notice: "Thank you! We will be in touch soon!" }
        else
          format.html { redirect_to root_path, alert: "Contact failed: #{@lead.errors.full_messages.join(', ')}" }
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
          # Send email to driver
          NewsletterMailer.new_newsletter_email(@newsletter).deliver_now
          format.html { redirect_to root_path, notice: "Thank you! We will be in touch soon!" }
        else
          format.html { redirect_to root_path, alert: "Failed to sign up: #{@newsletter.errors.full_messages.join(', ')}" }
        end
      end
    end
  end

  private

  def lead_params
    params.require(:lead).permit(:first_name,
                                 :last_name,
                                 :lead_email,
                                 :phone,
                                 :location,
                                 :note,
                                 :pp_check,
                                 :create_acct,
                                 :commit)
  end

  def newsletter_params
    params.require(:newsletter).permit( :newsletter_email, :pp_check, :commit)
  end
end
