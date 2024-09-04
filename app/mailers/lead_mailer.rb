class LeadMailer < ApplicationMailer
  def new_lead_email(lead)
    @lead = lead
    admins = User.where(role: 1)
    puts "admin emails: #{admins.pluck(:email)}"
    mail to: admins.pluck(:email), subject: 'TruckerJobs4U - New Lead Generated'
  end
end
