class CustomersController < ApplicationController
  def index
    @customers = Customer.all.includes(:vehicles)
    if params[:email].present?
      @customers = @customers.where(email: params[:email])
    end
    render json: @customers, include: :vehicles, status: :ok
  end

  def show
    @customer = Customer.find(params[:id])
    render json: @customer, status: :ok
  end
end