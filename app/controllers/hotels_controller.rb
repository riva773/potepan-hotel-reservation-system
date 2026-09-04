class HotelsController < ApplicationController
  def index
    @hotels = Hotel.all
  end

  def new
    @hotel = Hotel.new
  end

  def create
    
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
