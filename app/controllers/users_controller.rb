class UsersController < ApplicationController
  #before_action :set_user
  # Only allow user to access the user dashboard
  before_action :authenticate_user!
  def dashboard
    @user = current_user
  end

  def address
    @user = current_user
    @address = Address.new
  end

  def create_address
    @address = Address.new(address_params)
    @address.user = current_user
    if @address.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def license
    @user = current_user
    @address = current_user.address
    @license = License.new
  end

  def create_license
    @license = License.new(license_params)
    @license.user = current_user
    #@license.lic_endorsements = params[:license][:lic_endorsements]
    if @license.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def address_params
    params.require(:address).permit(:address_1, :address_2, :city, :state, :zip, :country, :current, :user_id)
  end

  def license_params
    params.require(:license).permit(:dob, :lic_class, :lic_exp, :military, :veteran, :user_id, lic_endorsements: [])
  end

  def authenticate_staff!
    if !user_signed_in? || !["user"].include?(current_user.role)
      flash[:alert] = "You are not authorized to access this page."
      redirect_to root_path
    end
  end
end
