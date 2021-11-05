class ReservationsController < ApplicationController
  rescue_from Exception do |e|
    render json: { error: e.message }, status: :internal_error
  end
  rescue_from ActiveRecord::RecordInvalid do |e|
    render json: { error: e.message }, status: :unprocessable_entity
  end

  def create
    @reservation = Reservation.create!(create_params)
    render json: @reservation, status: :created
  end

  private

  def create_params
    params.require(:reservation).permit(:customer_id, :vehicle_id, :service_id, :start_time, :end_time)
  end
end