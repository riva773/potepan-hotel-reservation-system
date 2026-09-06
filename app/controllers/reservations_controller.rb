class ReservationsController < ApplicationController
  def index
    @reservations = Reservation.all
    Rails.logger.debug "[DEBUG] created_at.class=#{@reservations.first.created_at.class}"
  end

  def create
    @hotel = Hotel.find(reservation_params[:hotel_id])
    @reservation = current_user.reservations.build(reservation_params)
    @reservation.hotel = @hotel
    if @reservation.save
      redirect_to reservations_path, notice: "施設の予約が完了しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def confirm
    @reservation = Reservation.new(reservation_params)
    @hotel = Hotel.find(reservation_params[:hotel_id])
    @reservation.hotel = @hotel
    @duration = (@reservation.check_out - @reservation.check_in).to_i
    @sum_price = @hotel.price * @reservation.attendance * @duration
    render :confirm
  end

  def reservation_params
    params.require(:reservation).permit(:check_in, :check_out, :attendance, :hotel_id, :sum_price)
  end
end
