class HotelsController < ApplicationController
  before_action :authenticate_user!, except: [ :index, :show ]
  def index
    @hotels = Hotel.all
  end

  def new
    @hotel = Hotel.new
  end

  def create
    @hotel = current_user.hotels.build(hotel_params)
    if @hotel.save
      redirect_to @hotel, notice: "施設を作成しました。"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @hotel = Hotel.find(params[:id])
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def own
    @hotels = current_user.hotels
  end

  def hotel_params
    params.require(:hotel).permit(:name, :price, :address, :description)
  end
end
