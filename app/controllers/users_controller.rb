class UsersController < ApplicationController
  before_action :load_and_authorize_company
  before_action :set_user_params, only: [:create, :update]
  before_action :check_params_password, only: :update
  load_and_authorize_resource :user, through: :company

  def index
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    if @company.users << @user
      redirect_to [@company, @user]
    else
      render :new
    end
  end

  def update
    if @user.update(params[:user])
      redirect_to [@company, @user]
    else
      render :edit
    end
  end

  private
    def load_and_authorize_company
      if params[:contractor_id]
        @company = Contractor.find(params[:contractor_id])
      elsif params[:sub_contractor_id]
        @company = SubContractor.find(params[:sub_contractor_id])
      end
      authorize! :read, @company
    end

    def set_user_params
      params[:user] = if current_user.admin?
        params.require(:user).permit!
      else
        params.require(:user).permit(:first_name, :last_name, :phone, :email,
          :password, :password_confirmation)
      end
    end

    def check_params_password
      if params[:user][:password].blank?
        params[:user].delete(:password)
        if params[:user][:password_confirmation].blank?
          params[:user].delete(:password_confirmation)
        end
      end
    end
end