class UsersController < ApplicationController
  before_action :get_company

  def index
    @users = @company.users
  end

  def edit
  end

  def new
  end

  def show
  end

  private
    def get_company
      if params[:contractor_id]
        @company = Contractor.find(params[:contractor_id])
      elsif params[:sub_contractor_id]
        @company = SubContractor.find(params[:sub_contractor_id])
      end
    end
end
