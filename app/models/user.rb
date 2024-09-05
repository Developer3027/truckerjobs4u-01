class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Roles for users in app
  enum role: { user: 0, admin: 1, recruiter: 2, advisor: 3 }

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
end
