class ReservationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_reservation, only: [ :edit, :update, :destroy ]
  def index
    @reservations = current_user.reservations.includes(
      room: { avatar_attachment: :blob }
    )
  end

  def create
    @room = Room.find(reservation_params[:room_id])
    @reservation = current_user.reservations.build(reservation_params)
    @reservation.room = @room
    @reservation.sum_price = @reservation.room.price * @reservation.attendance * (@reservation.check_out - @reservation.check_in).to_i
    if @reservation.save
      redirect_to reservations_path, notice: "施設の予約が完了しました"
    else
      render template: "rooms/show", status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    @reservation.assign_attributes(update_reservation_params)
    @reservation.sum_price = @reservation.room.price * @reservation.attendance * (@reservation.check_out - @reservation.check_in).to_i
    if @reservation.save
      redirect_to reservations_path, notice: "予約を更新しました。"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @reservation.destroy
      redirect_to reservations_path, notice: "施設の予約情報を削除しました"
    else
      redirect_to reservations_path, alert: "予約の削除に失敗しました。"
    end
  end

  def confirm
    if params[:reservation][:id].present?
      @reservation = current_user.reservations.find(params[:reservation][:id])
      @reservation.check_in = params[:reservation][:check_in]
      @reservation.check_out = params[:reservation][:check_out]
      @reservation.attendance = params[:reservation][:attendance]
      @room = @reservation.room
    else
      @reservation = current_user.reservations.build(reservation_params)
      @room = Room.find(reservation_params[:room_id])
      @reservation.room = @room
    end
    if @reservation.check_in.blank? ||
    @reservation.check_out.blank? ||
    @reservation.attendance.blank? || @reservation.check_in < Date.today || @reservation.check_in >= @reservation.check_out || @reservation.attendance <= 0
      @reservation.valid?
      flash.now[:alert]="予約情報が不足しています。"
      if params[:reservation][:id].present?
        render "edit", status: :unprocessable_entity
      else
        render "rooms/show", status: :unprocessable_entity
      end
      return
    end
    @duration = (@reservation.check_out - @reservation.check_in).to_i
    @sum_price = @room.price * @reservation.attendance * @duration
    render :confirm
  end

  def reservation_params
    params.require(:reservation).permit(:check_in, :check_out, :attendance, :room_id)
  end

  def update_reservation_params
    params.require(:reservation).permit(:check_in, :check_out, :attendance)
  end

  def set_reservation
    @reservation = current_user.reservations.find(params[:id])
  end
end
