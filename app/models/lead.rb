class Lead < ApplicationRecord
  validates :first_name, :last_name, :lead_email, :phone, :location, presence: true
end
