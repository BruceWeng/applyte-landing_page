class AdminsController < ApplicationController
  before_action :authenticate_user!, :only=>[:index]
  before_action :check_email, :only=>[:index]

  def index
    @admins = Admin.all
  end

  def landing_page
    @admin = Admin.new
    respond_to do |format|
      format.html{
      }
      format.js
    end
  end

  def create
    @admin = Admin.new(admin_params)

    if @admin.save
      redirect_to :back
    else
      render "landing_page"
    end
  end

  def admin_params
    params.require(:admin).permit(:email)
  end


private

  def check_email
    admin_email_list = ['bruce@applyte.io']
    result = false
    if current_user && admin_email_list.include?(current_user.email)
      result = true
    end

    if result == false
      redirect_to root_path
    end
  end
end
