class UsersController < ApplicationController
  before_action :get_company
  before_action :get_user, except: [:index, :new, :create]
  before_action :check_params_password, only: :update

  def index
    @users = @company.users
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    if @company.users << @user
      redirect_to [@company, @user]
    else
      render :new
    end
  end

  def update
    if @user.update(user_params)
      redirect_to [@company, @user]
    else
      render :edit
    end
  end

  private

    def user_params
      if current_user.admin?
        params.require(:user).permit!
      else
        params.require(:user).permit(:first_name, :last_name, :phone, :email,
          :password, :password_confirmation)
      end
    end

    def get_user
      @user = @company.users.find(params[:id])
    end

    def get_company
      if params[:contractor_id]
        @company = Contractor.find(params[:contractor_id])
      elsif params[:sub_contractor_id]
        @company = SubContractor.find(params[:sub_contractor_id])
      end
    end

    def check_params_password
      if params[:usuario][:password].blank?
        params[:usuario].delete(:password)
        if params[:usuario][:password_confirmation].blank?
          params[:usuario].delete(:password_confirmation)
        end
      end
    end
end
