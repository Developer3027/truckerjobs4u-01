# Code for the Lead model
class Lead < ApplicationRecord
  # Format phone number before saving
  before_save :format_phone_number
  # Validate form fields
  validates :first_name, :last_name, :lead_email, :phone, :location, presence: true

  # ransack
  def self.ransackable_attributes(auth_object = nil)
    %w[created_at updated_at first_name last_name lead_email phone location note pp_check]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end

  private

  # Format phone number for display.
  #
  #   format_phone_number
  #
  # Given a phone number like 5551234567, this method will transform it into
  # (555) 123-4567.
  def format_phone_number
    # Remove any non-digit characters from the phone number
    self.phone = self.phone.gsub(/\D/, '')

    # Format the phone number into (XXX) XXX-XXXX
    self.phone = "(#{self.phone[0,3]}) #{self.phone[3,3]}-#{self.phone[6,4]}"
  end
end
