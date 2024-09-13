class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable, :validatable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable

  # Add Avatar to User
  has_one_attached :avatar

  # Checks if password was changed
  after_update :check_password_change

  # Associations of user to leads
  has_one :lead, dependent: :nullify

  # Association of user to addresses
  has_many :address, dependent: :destroy

  # Association of user to license
  has_one :license, dependent: :destroy

  # Associations of user to blog posts
  has_many :blogs, dependent: :destroy

  # Roles for users in app
  enum role: { user: 0, admin: 1, recruiter: 2, advisor: 3 }

  # The `set_default_role` method is called automatically by the `after_initialize` callback
  #
  # Gives a new user the default role of `:user`.
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

  #Format phone number for display on update.
  #
  #When the contact form is completed, the phone number is formatted
  before_update :format_phone_number
  before_save :full_name

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

  # Create a full name for users
  def full_name
    self.full_name = "#{first_name.capitalize unless first_name.nil?} #{last_name.capitalize unless last_name.nil?}"
  end

  private
  def check_password_change
    lead = Lead.find_by(user: self)
    puts "lead: #{lead.inspect}"
    if lead && lead.delete_account_date && lead.passel
      if valid_password?(lead.passel)
        # User has not changed their password yet, check delete account date
        # Send internal mail to user - feature coming soon
      else
        # User has changed their password, so clear the delete date and temp password
        lead.update(delete_account_date: nil, passel: nil)
      end
    end
  end
end
