class Newsletter < ApplicationRecord
  validates :newsletter_email, presence: true
end
