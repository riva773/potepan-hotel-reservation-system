class ReservationsController < ApplicationController
  def index
    @reservations = Reservation.all
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
    @reservation = Reservation.find(params[:id])
  end

  def update
    @reservation = Reservation.find(params[:reservation][:id])
    if @reservation.update(reservation_params)
      redirect_to reservations_path, notice: "予約を更新しました。"
    else
      render :confirm, status: :unprocessable_entity
    end
  end

  def destroy
    @reservation = Reservation.find(params[:id])
    if @reservation.destroy
      redirect_to reservations_path, notice: "施設の予約情報を削除しました"
    else
      render :reservations, status: :unprocessable_entity
    end
  end

  def confirm
    if params[:reservation][:id]
      @reservation = Reservation.find(params[:reservation][:id])
      @reservation.check_in = params[:reservation][:check_in]
      @reservation.check_out = params[:reservation][:check_out]
      @reservation.attendance = params[:reservation][:attendance]
      @hotel = @reservation.hotel
    else
      @reservation = Reservation.new(reservation_params)
      @hotel = Hotel.find(reservation_params[:hotel_id])
      @reservation.hotel = @hotel
    end
    @duration = (@reservation.check_out - @reservation.check_in).to_i
    @sum_price = @hotel.price * @reservation.attendance * @duration
    render :confirm
  end

  def reservation_params
    params.require(:reservation).permit(:check_in, :check_out, :attendance, :hotel_id, :sum_price, :id)
  end
end
