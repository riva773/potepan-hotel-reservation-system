class RoomsController < ApplicationController
  before_action :authenticate_user!, except: [ :index, :show ]
  before_action :set_room, only: [ :edit, :update, :destroy ]
  def index
    @rooms = Room.all

    if params[:address].present?
      @rooms = @rooms.where("address LIKE ?", "%#{params[:address]}%")
    end

    if params[:keyword].present?
      keyword = "%#{params[:keyword]}%"
      @rooms = @rooms.where("name LIKE ? or description LIKE ? or address LIKE ?", keyword, keyword, keyword)
    end
  end

  def new
    @room = Room.new
  end

  def create
    @room = current_user.rooms.build(room_params)
    if @room.save
      redirect_to @room, notice: "施設を作成しました。"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @room = Room.find(params[:id])
    @reservation = Reservation.new
  end

  def edit
  end

  def update
    if @room.update(room_params)
      redirect_to room_path(@room), notice: "施設情報が更新されました。"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @room.destroy
      redirect_to rooms_path, notice: "施設が削除されました。"
    else
      render :own, status: :unprocessable_entity
    end
  end

  def own
    @rooms = current_user.rooms
  end

  def room_params
    params.require(:room).permit(:name, :price, :address, :description, :avatar)
  end

  def set_room
    @room = current_user.rooms.find(params[:id])
  end
end
