class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable, :validatable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable

  after_update :check_password_change

  # Associations of user to leads
  has_one :lead, dependent: :nullify

  # Associations of user to blog posts
  has_many :blogs, dependent: :destroy
  # Roles for users in app
  enum role: { user: 0, admin: 1, recruiter: 2, advisor: 3 }

  #Format phone number for display on update.
  before_update :format_phone_number

  # The `set_default_role` method is called automatically by the `after_initialize` callback
  after_initialize :set_default_role, if: :new_record?

  # Sets the default role for a user if it has not been set.
  #
  # This method is called automatically by the `after_initialize` callback
  # when a new user record is created. It assigns the `:user` role to the
  # `role` attribute if it is currently `nil`.
  #
  # @return [void]
  def set_default_role
    self.role ||= :user
  end

  # Format phone number for display.
  #
  #   format_phone_number
  #
  # Given a phone number like 5551234567, this method will transform it into
  # (555) 123-4567.
  def format_phone_number
    return if phone.nil?
    # Remove any non-digit characters from the phone number
    self.phone = self.phone.gsub(/\D/, '')

    # Format the phone number into (XXX) XXX-XXXX
    self.phone = "(#{self.phone[0,3]}) #{self.phone[3,3]}-#{self.phone[6,4]}"
  end

  private
  def check_password_change
    puts "Checking password change"
    lead = Lead.find_by(user: self)
    puts "lead: #{lead.inspect}"
    if lead && lead.delete_account_date && lead.passel
      puts "Lead exists, checking password change"
      if valid_password?(lead.passel)
        # User has not changed their password yet, so do nothing
        puts "User has not changed their password yet, so do nothing"
      else
        # User has changed their password, so clear the delete date and temp password
        puts "User has changed their password, so clear the delete date and temp password"
        lead.update(delete_account_date: nil, passel: nil)
      end
    end
  end
end
